import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app_flutter/src/models/category_model.dart';
import 'package:news_app_flutter/src/models/news_models.dart';
import 'package:http/http.dart' as http;

class NewsService extends ChangeNotifier {
  NewsService() {
    getTopHeadlines();
    for (var element in categories) {
      articlesByCategory.addAll({element.name: []});
    }
    getTopHeadlinesByCategory(_selectedCategory);
  }

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String value) {
    _selectedCategory = value;
    getTopHeadlinesByCategory(value);
    notifyListeners();
  }

  Map<String, List<Article>> articlesByCategory = {};

  List<Article> get getArticlesBySelectedCategory =>
      articlesByCategory[_selectedCategory] ?? [];

  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business'),
    Category(icon: FontAwesomeIcons.tv, name: 'entertainment'),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general'),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health'),
    Category(icon: FontAwesomeIcons.vials, name: 'science'),
    Category(icon: FontAwesomeIcons.volleyball, name: 'sports'),
    Category(icon: FontAwesomeIcons.memory, name: 'technology'),
  ];

  final String _apiKey = '';
  final String _baseUrl = 'newsapi.org';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getTopHeadlines() async {
    _isLoading = true;
    notifyListeners();
    final url = Uri.https(
        _baseUrl, '/v2/top-headlines', {'country': 'mx', 'apiKey': _apiKey});
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final newsResponse = newsResponseFromJson(resp.body);
      headlines.addAll(newsResponse.articles);
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<List<Article>> getTopHeadlinesByCategory(String category) async {
    if (articlesByCategory.containsKey(category) &&
        articlesByCategory[category]!.isNotEmpty) {
      _isLoading = false;
      notifyListeners();
      return articlesByCategory[category]!;
    }
    _isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, '/v2/top-headlines', {
      'country': 'mx',
      'apiKey': _apiKey,
      'category': category,
    });
    final resp = await http.get(url);
    if (resp.statusCode == 200) {
      final newsResponse = newsResponseFromJson(resp.body);
      articlesByCategory[category]?.addAll(newsResponse.articles);
    }
    _isLoading = false;
    notifyListeners();
    return [];
  }
}
