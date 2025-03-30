import 'package:cached_network_image/cached_network_image.dart';
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
        body: ClipOval(
          child: CachedNetworkImage(
            imageUrl:
                "https://tripleenableapi.triplecyber.com/api/v1/Profile/UserPhoto/velvetlullaby2044@tripleenableanonymous.com?height=300&width=300",
            cacheManager: MyCustomCacheManager(),
            width: 60,
            height: 60,
            fit: BoxFit.cover, // Para que la imagen cubra el círculo
          ),
        ),
      ),
    );
  }
}
