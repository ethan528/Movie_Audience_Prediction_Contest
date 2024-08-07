import 'package:flutter/material.dart';

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

  var postList = [
    {
      "title": "Simple Title 1",
      "color": Colors.green,
    },
    {
      "title": "Simple Title 2",
      "color": Colors.redAccent,
    },
    {
      "title": "Simple Title 3",
      "color": Colors.amber,
    },
    {
      "title": "Simple Title 4",
      "color": Colors.purpleAccent,
    },
    {
      "title": "Simple Title 5",
      "color": Colors.teal,
    },
    {
      "title": "Simple Title 6",
      "color": Colors.blueAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Title"),
      ),
      body: ListView.builder(
        itemCount: postList.length,
        itemBuilder: (BuildContext con, int index) {
          return postContainer(
            title: postList[index]["title"] as String,
            colorData: postList[index]["color"] as Color,
          );
        },
      )
    );
  }

  Widget postContainer({String title = '', Color colorData = Colors.blue}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          color: colorData,
        ),
      ],
    );
  }
}
