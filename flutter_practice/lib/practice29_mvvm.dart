import 'package:flutter/material.dart';
import 'package:flutter_practice/mvvm/viewModel/albumViewModel.dart';
import 'package:provider/provider.dart';

import 'mvvm/view/albumView.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<AlbumViewModel>(
        create: (context) => AlbumViewModel(),
        child: const AlbumView(),
      )
    );
  }
}