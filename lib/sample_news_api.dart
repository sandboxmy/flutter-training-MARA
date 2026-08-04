import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const Color _deepBlue = Color(0xFF6C72C9);
const Color _sky = Color(0xFFE8EAF6);

class NewsAPI extends StatefulWidget {
  const NewsAPI({super.key});

  @override
  State<NewsAPI> createState() => _NewsAPIState();
}

class _NewsAPIState extends State<NewsAPI> {
  List<dynamic> _articles = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    // 1) Show loading state and clear old error
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // 2) Build API URL
    const apiKey = '70e0f9273d6845e4b76419502ab592c8';
    final url =
        'https://newsapi.org/v2/top-headlines?country=us&category=technology&apiKey=$apiKey';

    try {
      // 3) Call API
      final response = await http.get(Uri.parse(url));
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      // 4) If success, save articles; otherwise show API error message
      if (response.statusCode == 200 && data['status'] == 'ok') {
        setState(() {
          _articles = data['articles'] as List<dynamic>? ?? [];
        });
      } else {
        setState(() {
          _articles = [];
          _errorMessage = data['message']?.toString() ?? 'Failed to load news.';
        });
      }
    } catch (e) {
      // 5) If network/parsing fails, show error message
      setState(() {
        _articles = [];
        _errorMessage = 'Network error: $e';
      });
    } finally {
      // 6) Stop loading in all cases
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Tech News'),
        actions: [
          IconButton(
            onPressed: fetchNews,
            tooltip: 'Refresh',
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline_rounded, color: _deepBlue),
                    const SizedBox(height: 8),
                    Text(_errorMessage!, textAlign: TextAlign.center),
                    const SizedBox(height: 12),
                    FilledButton(
                      onPressed: fetchNews,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            )
          : _articles.isEmpty
          ? Center(
              child: FilledButton(
                onPressed: fetchNews,
                child: const Text('No news found. Refresh'),
              ),
            )
          : RefreshIndicator(
              onRefresh: fetchNews,
              child: ListView.builder(
                itemCount: _articles.length,
                itemBuilder: (context, index) {
                  final article = _articles[index] as Map<String, dynamic>;
                  final title = article['title']?.toString() ?? 'No title';
                  final author =
                      article['author']?.toString() ?? 'Unknown author';
                  final description =
                      article['description']?.toString() ?? 'No description';
                  final imageUrl = article['urlToImage']?.toString();
                  final publishedAt = article['publishedAt']?.toString() ?? '';

                  return Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: imageUrl != null && imageUrl.isNotEmpty
                            ? Image.network(
                                imageUrl,
                                width: 56,
                                height: 56,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => Container(
                                  width: 56,
                                  height: 56,
                                  color: _sky,
                                  alignment: Alignment.center,
                                  child: const Icon(
                                    Icons.broken_image_outlined,
                                    color: _deepBlue,
                                  ),
                                ),
                              )
                            : Container(
                                width: 56,
                                height: 56,
                                color: _sky,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported_outlined,
                                  color: _deepBlue,
                                ),
                              ),
                      ),
                      title: Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '$author\n$description',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            publishedAt,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ),
    );
  }
}
