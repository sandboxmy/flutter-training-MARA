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

  Map<String, String> _authHeaders({required String token}) => {
    'Authorization': 'Bearer $token',
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
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode != 200) {
      _throwForStatus(response: response, action: 'login');
    }

    return AuthResult.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  /// GET `/api/todos` — pass the token from login/register (in memory).
  Future<List<TodoTask>> fetchTodos({required String token}) async {
    if (token.isEmpty) {
      throw const TaskServiceException(
        'Missing auth token. Please login again.',
      );
    }

    final response = await _client.get(
      Uri.parse('$baseUrl/todos'), //url
      headers: _authHeaders(token: token), // auth token
    );

    if (response.statusCode != 200) {
      _throwForStatus(response: response, action: 'fetch todos');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final data = decoded['data'];
    final list = (data is List) ? data : <dynamic>[];

    return list
        .map((e) => TodoTask.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// POST `/api/todos` — multipart/form-data (title required).
  Future<TodoTask> createTodo({
    required String token,
    required String title,
    String? description,
    DateTime? dueDate,
  }) async {
    if (token.isEmpty) {
      throw const TaskServiceException(
        'Missing auth token. Please login again.',
      );
    }

    final trimmedTitle = title.trim();
    if (trimmedTitle.isEmpty) {
      throw const TaskServiceException('Title is required.');
    }

    final request = http.MultipartRequest(
      'POST',
      Uri.parse('$baseUrl/todos'),
    );
    request.headers.addAll(_authHeaders(token: token));
    request.fields['title'] = trimmedTitle;

    final trimmedDescription = description?.trim();
    if (trimmedDescription != null && trimmedDescription.isNotEmpty) {
      request.fields['description'] = trimmedDescription;
    }

    if (dueDate != null) {
      final y = dueDate.year.toString().padLeft(4, '0');
      final m = dueDate.month.toString().padLeft(2, '0');
      final d = dueDate.day.toString().padLeft(2, '0');
      request.fields['due_date'] = '$y-$m-$d';
    }

    final streamed = await _client.send(request);
    final response = await http.Response.fromStream(streamed);

    if (response.statusCode != 201 && response.statusCode != 200) {
      _throwForStatus(response: response, action: 'create todo');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final data = decoded['data'];
    if (data is! Map<String, dynamic>) {
      throw const TaskServiceException('Missing todo data in create response.');
    }

    return TodoTask.fromJson(data);
  }
}

/// Response from login / register: `{ token, user }`
class AuthResult {
  const AuthResult({required this.token, required this.user});

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

    return AuthResult(token: token, user: ApiUser.fromJson(userRaw));
  }
}

class ApiUser {
  const ApiUser({required this.id, required this.name, required this.email});

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

class TodoTask {
  const TodoTask({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.dueDate,
    this.mediaUrl,
    this.createdAt,
    this.updatedAt,
  });

  final int id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime? dueDate;
  final String? mediaUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  static bool _parseBool(dynamic v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.trim().toLowerCase();
      return s == '1' || s == 'true' || s == 'yes';
    }
    return false;
  }

  static DateTime? _tryParseDateTime(dynamic v) {
    if (v is! String || v.isEmpty) return null;
    return DateTime.tryParse(v);
  }

  factory TodoTask.fromJson(Map<String, dynamic> json) {
    final idRaw = json['id'];
    final id = idRaw is int
        ? idRaw
        : int.tryParse(idRaw?.toString() ?? '') ??
              (throw const TaskServiceException('Invalid todo id.'));

    return TodoTask(
      id: id,
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isCompleted: _parseBool(json['is_completed']),
      dueDate: _tryParseDateTime(json['due_date']),
      mediaUrl: json['media_url']?.toString(),
      createdAt: _tryParseDateTime(json['created_at']),
      updatedAt: _tryParseDateTime(json['updated_at']),
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
