// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:news_app_flutter/src/screens/tab1_screen.dart';
import 'package:news_app_flutter/src/screens/tab2_screen.dart';
import 'package:provider/provider.dart';

class TabsScreen extends StatelessWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavModel(),
      child: const Scaffold(
        body: const _Pages(),
        bottomNavigationBar: _Navbar(),
      ),
    );
  }
}

class _Navbar extends StatelessWidget {
  const _Navbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navModel = Provider.of<_NavModel>(context);
    return BottomNavigationBar(
      currentIndex: navModel.paginaActual,
      onTap: (value) => navModel.paginaActual = value,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Para ti'),
        BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Encabezados'),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  const _Pages({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController =
        Provider.of<_NavModel>(context, listen: false).pageController;
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Screen(),
        Tab2Screen(),
      ],
    );
  }
}

class _NavModel extends ChangeNotifier {
  int _paginaActual = 0;
  final _pageController = PageController();

  PageController get pageController => _pageController;

  int get paginaActual => _paginaActual;

  set paginaActual(int value) {
    _paginaActual = value;
    _pageController.animateToPage(_paginaActual,
        duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    notifyListeners();
  }
}
