import 'package:flutter/material.dart';
import 'package:img_caching/screens/custom_cache_manager.dart';
import 'package:img_caching/screens/img_screen.dart';
//import 'package:img_caching/screens/img_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: Center(child: Text('Image caching'))),
        body:
        CustomCacheManager()
      ),
    );
  }
}
