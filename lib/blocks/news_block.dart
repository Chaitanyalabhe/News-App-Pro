import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import '../models/article.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitialState()) {
    // Register the event handler for FetchNewsEvent
    on<FetchNewsEvent>((event, emit) async {
      emit(NewsLoadingState()); // Emit loading state
      try {
        final articles = await _fetchNews();
        emit(NewsLoadedState(articles)); // Emit loaded state with articles
      } catch (e) {
        emit(NewsErrorState(message: e.toString())); // Emit error state with the message
      }
    });
  }

  Future<List<Article>> _fetchNews() async {
    const url =
        'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fa1d0f9021fa4984a9c48866aaa318ee';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['articles'] as List)
          .map((json) => Article.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }
}