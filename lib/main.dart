import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/screens/screns.dart';
import 'package:news_app_flutter/src/services/news_services.dart';
import 'package:news_app_flutter/src/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NewsService()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'News App',
          theme: AppTheme.theme,
          home: const TabsScreen()),
    );
  }
}
