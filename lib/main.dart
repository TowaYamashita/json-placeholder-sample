import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_placeholder_sample/users/users_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final StreamController<int> controller;
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    controller = StreamController();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const pages = [
      UsersPage(),
      Placeholder(),
    ];

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
          controller: pageController,
          itemBuilder: (_, index) => Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: pages.elementAt(index),
          ),
          itemCount: pages.length,
        ),
        StreamBuilder(
            stream: controller.stream,
            builder: (_, snapshot) {
              return BottomNavigationBar(
                currentIndex: snapshot.hasData ? snapshot.data! : 0,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_outlined,
                    ),
                    activeIcon: Icon(
                      Icons.account_circle,
                    ),
                    label: 'ユーザ一覧',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.photo_album_outlined),
                    activeIcon: Icon(
                      Icons.photo_album,
                    ),
                    label: '写真一覧',
                  ),
                ],
                onTap: (index) {
                  pageController.jumpToPage(index);
                  controller.add(index);
                },
              );
            })
      ],
    );
  }
}
