import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/services/news_services.dart';
import 'package:news_app_flutter/src/widgets/loading_placeholder.dart';
import 'package:news_app_flutter/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab1Screen extends StatefulWidget {
  const Tab1Screen({Key? key}) : super(key: key);

  @override
  State<Tab1Screen> createState() => _Tab1ScreenState();
}

class _Tab1ScreenState extends State<Tab1Screen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return Scaffold(
      body: newsService.isLoading
          ? const LoadingPlaceholder()
          : newsService.headlines.isEmpty
              ? const Center(
                  child: Text('No se lograron cargar las noticias'),
                )
              : NewsList(
                  news: newsService.headlines,
                ),
    );
  }
}
