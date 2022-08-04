import 'package:news_app_flutter/src/models/news_models.dart';
import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/theme/app_theme.dart';
import 'package:url_launcher/url_launcher_string.dart';

class NewsList extends StatelessWidget {
  const NewsList({Key? key, required this.news}) : super(key: key);
  final List<Article> news;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) => _NewItem(
        article: news[index],
        index: index,
      ),
    );
  }
}

class _NewItem extends StatelessWidget {
  const _NewItem({Key? key, required this.article, required this.index})
      : super(key: key);
  final Article article;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopbarCard(article: article, index: index),
        _CardTitle(article: article),
        _CardImage(article: article),
        _CardBody(article: article),
        _CardButtons(article: article),
        const SizedBox(height: 10),
        const Divider(),
      ],
    );
  }
}

class _CardButtons extends StatelessWidget {
  const _CardButtons({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
            child: const Icon(Icons.open_in_new_rounded)),
        const SizedBox(width: 40),
        ElevatedButton(
            onPressed: () => launchUrlString(article.url),
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: const StadiumBorder(),
            ),
            child: const Icon(Icons.open_in_browser_rounded)),
      ],
    );
  }
}

class _CardBody extends StatelessWidget {
  const _CardBody({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(article.description ?? ''));
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ),
        child: article.urlToImage == null
            ? Image.asset('assets/img/no-image.png')
            : FadeInImage(
                placeholder: const AssetImage('assets/img/giphy.gif'),
                image: NetworkImage(article.urlToImage ?? ''),
              ),
      ),
    );
  }
}

class _CardTitle extends StatelessWidget {
  const _CardTitle({
    Key? key,
    required this.article,
  }) : super(key: key);
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        article.title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _TopbarCard extends StatelessWidget {
  const _TopbarCard({
    Key? key,
    required this.article,
    required this.index,
  }) : super(key: key);
  final Article article;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Text(
          '${index + 1}. ',
          style: TextStyle(color: AppTheme.theme.colorScheme.primary),
        ),
        Text('${article.source.name}. ')
      ]),
    );
  }
}
