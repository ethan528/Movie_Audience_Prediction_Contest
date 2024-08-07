import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
  final _url = 'https://jsonplaceholder.typicode.com/albums';
  int _page = 1;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;
  List _albumList = [];
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _initLoad();
    _controller = ScrollController()..addListener(_nextLoad);
  }

  void _initLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.get(Uri.parse('$_url?_page=$_page&_limit=$_limit'));
      setState(() {
        _albumList = jsonDecode(res.body);
      });
    } catch (e) {
      print(e.toString());
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void _nextLoad() async {
    if (_hasNextPage &&
        !_isFirstLoadRunning &&
        !_isLoadMoreRunning &&
        _controller.position.extentAfter < 100) {
      setState(() {
        _isLoadMoreRunning = true;
      });
      _page += 1;
      try {
        final res =
            await http.get(Uri.parse('$_url?_page=$_page&_limit=$_limit'));
        final List fetchedAlbums = jsonDecode(res.body);
        if (fetchedAlbums.isNotEmpty) {
          setState(() {
            _albumList.addAll(fetchedAlbums);
          });
        } else {
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (e) {
        print(e.toString());
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_nextLoad);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ListView Pagination"),
      ),
      body: _isFirstLoadRunning
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _controller,
                    itemCount: _albumList.length,
                    itemBuilder: (context, index) => Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 10),
                      child: ListTile(
                        title: Text(_albumList[index]['id'].toString()),
                        subtitle: Text(_albumList[index]['title']),
                      ),
                    ),
                  ),
                ),
                if (_isLoadMoreRunning == true)
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: const CircularProgressIndicator(),
                  ),
                if (_hasNextPage == false)
                  Container(
                    padding: const EdgeInsets.all(20),
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        'No more data to be fetched.',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }
}
