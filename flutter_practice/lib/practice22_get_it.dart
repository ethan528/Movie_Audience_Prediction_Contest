import 'package:flutter/material.dart';
import 'package:flutter_practice/get_it/locator/locator.dart';
import 'package:flutter_practice/get_it/service/album_service.dart';

import 'get_it/model/album.dart';

void main() {
  initLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GetIt 테스트',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final AlbumService _service = locator<AlbumService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get It 에제"),
      ),
      body: FutureBuilder(
        future: _service.fetchAlbums(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Album>? list = snapshot.data;
            return ListView.builder(
              itemCount: list?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  child: Text('${list?[index].id}: ${list?[index].title}'),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('error'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          }
        },
      ),
    );
  }
}