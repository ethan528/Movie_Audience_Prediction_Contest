import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: const MainPage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> friendList = [
    "Andrew",
    "Brian",
    "Catherine",
    "Wilson",
    "Raul",
    "Daniel",
    "John",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Material 3 Design"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: friendList.length,
          itemBuilder: (context, index) {
            return cardContainer(name: friendList[index], number: index + 1);
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showFloatingDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget cardContainer({String name = "", int number = 0}) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          child: Text("$number. $name", style: const TextStyle(fontSize: 20)),
        ),
        subtitle: Row(
          children: [
            TextButton(
              onPressed: () {},
              child: const Text("Details"),
            ),
            FilledButton.tonal(
              onPressed: () {},
              child: const Text("Follow"),
            ),
          ],
        ),
      ),
    );
  }

  void showFloatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(child: Text("Do you want to add a friend?")),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("No"),
            ),
            FilledButton(onPressed: () {}, child: const Text("Yes")),
          ],
        );
      },
    );
  }
}
