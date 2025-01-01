import '../models/article.dart';

abstract class NewsState {}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Article> news;

  NewsLoadedState(this.news);
}

class NewsErrorState extends NewsState {
  final String message;

  NewsErrorState({required this.message});
}