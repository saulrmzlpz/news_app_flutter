import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/models/category_model.dart';
import 'package:news_app_flutter/src/services/news_services.dart';
import 'package:news_app_flutter/src/widgets/loading_placeholder.dart';
import 'package:news_app_flutter/src/widgets/news_list.dart';
import 'package:provider/provider.dart';

class Tab2Screen extends StatelessWidget {
  const Tab2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          const Flexible(flex: 1, child: _CategoryList()),
          Expanded(
              flex: 6,
              child: newsService.isLoading
                  ? const LoadingPlaceholder()
                  : newsService.getArticlesBySelectedCategory.isEmpty
                      ? const Center(
                          child: Text('No se lograron cargar las noticias'),
                        )
                      : NewsList(
                          news: newsService.getArticlesBySelectedCategory,
                        )),
        ],
      )),
    );
  }
}

class _CategoryList extends StatelessWidget {
  const _CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: categories.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _CategoryButton(category: categories[index]),
            const SizedBox(height: 5),
            Text(categories[index].name),
          ],
        ),
      ),
    );
  }
}

class _CategoryButton extends StatelessWidget {
  const _CategoryButton({
    Key? key,
    required this.category,
  }) : super(key: key);

  final Category category;

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return GestureDetector(
      onTap: () {
        newsService.selectedCategory = category.name;
      },
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Icon(
            category.icon,
            color: newsService.selectedCategory.contains(category.name)
                ? Theme.of(context).colorScheme.primary
                : Colors.black54,
          )),
    );
  }
}
