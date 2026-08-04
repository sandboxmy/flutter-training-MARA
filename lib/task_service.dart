import 'dart:convert';

import 'package:http/http.dart' as http;

/// Client for the Laravel To-Do API.
///
/// Currently: POST `/api/register` and POST `/api/login`.
/// Fetch todos comes later.
class TaskService {
  TaskService({
    http.Client? client,
    this.baseUrl = 'http://todo.ai.tarsoft.my/api',
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Map<String, String> get _jsonHeaders => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  Never _throwForStatus({
    required http.Response response,
    required String action,
  }) {
    final body = response.body;
    String detail = body;
    try {
      final decoded = jsonDecode(body);
      if (decoded is Map<String, dynamic>) {
        final message = decoded['message'];
        if (message is String && message.isNotEmpty) {
          detail = message;
        } else {
          final errors = decoded['errors'];
          if (errors is Map<String, dynamic>) {
            final parts = <String>[];
            for (final value in errors.values) {
              if (value is List) {
                parts.addAll(value.map((e) => e.toString()));
              } else {
                parts.add(value.toString());
              }
            }
            if (parts.isNotEmpty) detail = parts.join('\n');
          }
        }
      }
    } catch (_) {
      // keep raw body
    }

    throw TaskServiceException(
      'Failed to $action (HTTP ${response.statusCode}). $detail',
      statusCode: response.statusCode,
    );
  }

  /// POST `/api/register`
  Future<AuthResult> register({
    required String name,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/register'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      }),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      _throwForStatus(response: response, action: 'register');
    }

    return AuthResult.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  /// POST `/api/login`
  Future<AuthResult> login({
    required String email,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/login'),
      headers: _jsonHeaders,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      _throwForStatus(response: response, action: 'login');
    }

    return AuthResult.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

/// Response from login / register: `{ token, user }`
class AuthResult {
  const AuthResult({
    required this.token,
    required this.user,
  });

  final String token;
  final ApiUser user;

  factory AuthResult.fromJson(Map<String, dynamic> json) {
    final token = json['token']?.toString() ?? '';
    if (token.isEmpty) {
      throw const TaskServiceException('Missing token in auth response.');
    }

    final userRaw = json['user'];
    if (userRaw is! Map<String, dynamic>) {
      throw const TaskServiceException('Missing user in auth response.');
    }

    return AuthResult(
      token: token,
      user: ApiUser.fromJson(userRaw),
    );
  }
}

class ApiUser {
  const ApiUser({
    required this.id,
    required this.name,
    required this.email,
  });

  final int id;
  final String name;
  final String email;

  factory ApiUser.fromJson(Map<String, dynamic> json) {
    final idRaw = json['id'];
    final id = idRaw is int
        ? idRaw
        : int.tryParse(idRaw?.toString() ?? '') ?? 0;

    return ApiUser(
      id: id,
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
    );
  }
}

class TaskServiceException implements Exception {
  const TaskServiceException(this.message, {this.statusCode});

  final String message;
  final int? statusCode;

  @override
  String toString() => message;
}
