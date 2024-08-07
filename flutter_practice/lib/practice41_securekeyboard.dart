import 'package:flutter/material.dart';
import 'package:flutter_secure_keyboard/flutter_secure_keyboard.dart';

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
  final _secureKeyboardController = SecureKeyboardController();

  final _passwordEditor = TextEditingController();
  final _passwordTextFieldFocusNode = FocusNode();

  final _pinCodeEditor = TextEditingController();
  final _pinCodeTextFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return WithSecureKeyboard(
      controller: _secureKeyboardController,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Secure Keyboard Test"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                _buildPasswordTextField(),
                SizedBox(height: 15.0,),
                _buildPinCodeTextField(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Password'),
        TextFormField(
          controller: _passwordEditor,
          focusNode: _passwordTextFieldFocusNode,
          enableInteractiveSelection: false,
          obscureText: true,
          onTap: () {
            _secureKeyboardController.show(
              type: SecureKeyboardType.ALPHA_NUMERIC,
              focusNode: _passwordTextFieldFocusNode,
              initText: _passwordEditor.text,
              hintText: 'password',
              onCharCodesChanged: (List<int> charCodes) {
                _passwordEditor.text = String.fromCharCodes(charCodes);
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildPinCodeTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('PinCode'),
        TextFormField(
          controller: _pinCodeEditor,
          focusNode: _pinCodeTextFieldFocusNode,
          enableInteractiveSelection: false,
          obscureText: true,
          onTap: () {
            _secureKeyboardController.show(
              type: SecureKeyboardType.NUMERIC,
              focusNode: _pinCodeTextFieldFocusNode,
              initText: _pinCodeEditor.text,
              hintText: 'pinCode',
              onDoneKeyPressed: (List<int> charCodes) {
                _pinCodeEditor.text = String.fromCharCodes(charCodes);
              },
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _secureKeyboardController.dispose();
    _passwordEditor.dispose();
    _pinCodeEditor.dispose();
  }
}
