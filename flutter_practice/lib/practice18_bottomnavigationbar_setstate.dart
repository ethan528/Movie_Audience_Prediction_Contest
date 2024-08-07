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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(
        () => setState(() => _selectedIndex = _tabController.index));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Test Title"),
        ),
        body: _selectedIndex == 0
            ? tabContainer(context, Colors.indigo, 'Friends Tab')
            : _selectedIndex == 1
                ? tabContainer(context, Colors.amber[600] as Color, 'Chats Tab')
                : tabContainer(context, Colors.blueGrey, 'Settings Tab'),
        bottomNavigationBar: SizedBox(
          height: 80,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            tabs: [
              Tab(
                icon: Icon(
                    _selectedIndex == 0 ? Icons.person : Icons.person_2_outlined,
                ),
                text: 'Friends',
              ),
              Tab(
                icon: Icon(
                  _selectedIndex == 1 ? Icons.chat : Icons.chat_outlined,
                ),
                text: 'Chats',
              ),
              Tab(
                icon: Icon(
                  _selectedIndex == 2 ? Icons.settings : Icons.settings_outlined,
                ),
                text: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tabContainer(BuildContext con, Color tabColor, String tabText) {
    return Container(
      width: MediaQuery
          .of(con)
          .size
          .width,
      height: MediaQuery
          .of(con)
          .size
          .height,
      color: tabColor,
      child: Center(
        child: Text(
          tabText,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}