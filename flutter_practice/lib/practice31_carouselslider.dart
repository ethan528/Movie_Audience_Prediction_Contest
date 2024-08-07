import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
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
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List imageList = [
    'https://cdn.pixabay.com/photo/2014/04/14/20/11/pink-324175_1280.jpg',
    'https://cdn.pixabay.com/photo/2014/02/27/16/10/flowers-276014_1280.jpg',
    'https://cdn.pixabay.com/photo/2012/03/01/00/55/flowers-19830_1280.jpg',
    'https://cdn.pixabay.com/photo/2015/06/19/20/13/sunset-815270_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/01/08/05/24/sunflower-1127174_1280.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carousel Slider"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                sliderWidget(),
                sliderIndicator(),
              ]
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text('Welcome to the carousel slider app'),
          )
        ],
      ),
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
      carouselController: _controller,
      items: imageList.map((imgLink) {
        return Builder(
          builder: (context) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                fit: BoxFit.fill,
                image: NetworkImage(
                  imgLink,
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 300,
        viewportFraction: 1.0,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        onPageChanged: (index, reason) {
          setState(() {
            _current = index;
          });
        },
      ),
    );
  }

  Widget sliderIndicator() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: imageList.asMap().entries.map((entry) {
          return GestureDetector(
            onTap: () => _controller.animateToPage(entry.key),
            child: Container(
              width: 12,
              height: 12,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
