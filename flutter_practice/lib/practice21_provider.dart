import 'package:flutter/material.dart';
import 'package:flutter_practice/bloc/view/album_view.dart';
import 'package:flutter_practice/provider/provider/album_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<AlbumProvider>(
        create: (context) => AlbumProvider(),
        child: const AlbumView(),
      ),
    );
  }
}
