import 'package:flutter/material.dart';
import 'package:flutter_practice/getx/countController.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var a = Get.put(CountController());
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("GetX Example"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GetBuilder<CountController>(
                init: CountController(),
                builder: (_) => Text('Current Count: ${Get.find<CountController>().counter}'),
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () => Get.find<CountController>().increase(),
                    child: const Text('증가'),
                  ),
                  TextButton(
                    onPressed: () => Get.find<CountController>().decrease(),
                    child: const Text('감소'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
