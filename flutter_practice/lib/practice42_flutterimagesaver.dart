import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_saver/flutter_image_saver.dart';

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
  final repaintBoundary = GlobalKey();

  void save() async {
    final boundary = repaintBoundary.currentContext!.findRenderObject()!
        as RenderRepaintBoundary;
    final image = await boundary.toImage(pixelRatio: 2);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    final path = await saveImage(byteData!.buffer.asUint8List(), 'flutter.png');
    final message = path.isEmpty ? 'Saved' : 'Saved to $path';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Title"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: save,
        child: const Icon(Icons.download),
      ),
      body: RepaintBoundary(
        key: repaintBoundary,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                const Text(
                  '제목 1',
                  style: TextStyle(fontSize: 24),
                ),
                const Text('내용 1-1'),
                const Text('내용 1-2'),
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.green,
                ),
                const Text(
                  '제목 2',
                  style: TextStyle(fontSize: 24),
                ),
                const Text('내용 2-1'),
                const Text('내용 2-2'),
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.purple,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
