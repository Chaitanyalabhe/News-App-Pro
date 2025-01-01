import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_state.dart';
import '../widgets/news_card.dart';
import 'news_detail_screen.dart';
import 'user_form_screen.dart';
import 'audio_player_screen.dart';

class NewsListScreen extends StatelessWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'News App Pro',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        actions: [

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UserFormScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              textStyle: const TextStyle(fontSize: 12),
            ),
            child: const Text('Fill Form'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AudioPlayerScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              textStyle: const TextStyle(fontSize: 12),
            ),
            child: const Text('Audio Player'),
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
            return const Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}