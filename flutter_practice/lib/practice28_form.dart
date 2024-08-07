import 'package:flutter/material.dart';
import 'package:flutter_practice/form/successPage.dart';

import 'form/user.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
        '/success': (context) => const SuccessPage()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _key = GlobalKey<FormState>();
  late String _username, _email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test Title"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _key,
          child: Column(
            children: [
              usernameInput(),
              const SizedBox(
                height: 13,
              ),
              emailInput(),
              const SizedBox(
                height: 13,
              ),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget usernameInput() {
    return TextFormField(
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'The input is empty.';
        } else {
          return null;
        }
      },
      onSaved: (username) => _username = username as String,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input your username.',
          labelText: 'Username',
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget emailInput() {
    return TextFormField(
      autofocus: true,
      validator: (val) {
        if (val!.isEmpty) {
          return 'The input is empty.';
        } else {
          return null;
        }
      },
      onSaved: (email) => _email = email as String,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Input your email address.',
          labelText: 'Email Address',
          labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }

  Widget submitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_key.currentState!.validate()) {
          _key.currentState!.save();
          Navigator.pushNamed(context, '/success',
              arguments: User(_username, _email));
        }
      },
      child: Container(
        padding: const EdgeInsets.all(15),
        child: const Text(
          '제출',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
