import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_state.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';
import 'user_form_screen.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News App Pro'),
        actions: [
          ElevatedButton(
            onPressed: () {
              // Navigate to the UserFormScreen when the button is clicked
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserFormScreen()),
              );
            },
            child: const Text('Fill Form'),
          ),
        ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoadedState) {
            return ListView.builder(
              itemCount: state.news.length,
              itemBuilder: (context, index) {
                final article = state.news[index];
                return NewsCard(
                  article: article,
                  onTap: () {
                    // Navigate to NewsDetailScreen when tapping on an article
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NewsDetailScreen(article: article),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is NewsErrorState) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No data available.'));
          }
        },
      ),
    );
  }
}