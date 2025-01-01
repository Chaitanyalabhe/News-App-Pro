import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'bloc/news_bloc.dart';
import 'bloc/news_event.dart';
import 'screens/news_list_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc()..add(FetchNewsEvent()),
        ),
      ],
      child: const NewsApp(),
    ),
  );
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsListScreen(),
    );
  }
}