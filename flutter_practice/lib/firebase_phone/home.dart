import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice/firebase_phone/login_phone.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext con, AsyncSnapshot<User?> user) {
        if (!user.hasData) {
          return const LoginPhonePage();
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Firebase App"),
              actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () async => await FirebaseAuth.instance
                      .signOut()
                      .then((_) => Navigator.pushNamed(context, "/")),
                ),
              ],
            ),
            body: const Center(
              child: Text("Successfully logged in!"),
            ),
          );
        }
      },
    );
  }
}