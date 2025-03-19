import 'package:flutter/material.dart';
import 'dart:io';

import 'package:img_caching/config/helpers/get_user_img.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//import 'package:path_provider/path_provider.dart';

class ImgScreen extends StatefulWidget {
  const ImgScreen({super.key});

  @override
  State<ImgScreen> createState() => _ImgScreenState();
}

class _ImgScreenState extends State<ImgScreen> {
  String? imgIdentifier = '';
  File? imageFile;
  String? filePath = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<dynamic>(
          future: fetchImg(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.hasData) {
                return Image.file(
                  snapshot.data!,
                  key: Key(imgIdentifier.toString()),
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                );
              }
            }
            return FutureBuilder<dynamic>(
              future: getLoadingContent(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.hasData) {
                  return snapshot.data;
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          },
        ),
        Text(imgIdentifier.toString()),
      ],
    );
  }

  Future<dynamic> fetchImg() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      imgIdentifier = await prefs.getString('ETag');
      final file = await fetchLocalFile();

      getImg(imgIdentifier)
          .then((response) async {
            imgIdentifier = response.headers.value('ETag');
            if (response.statusCode == 200 && imgIdentifier != null) {
              await prefs.setString('ETag', imgIdentifier.toString());
            }
            await file.writeAsBytes(response.data);
          })
          .catchError((error) {
            print(error);
          });
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<File> fetchLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/temp_image.png';
    return File(filePath);
  }

  Future<Widget> getLoadingContent() async {
    final file = await fetchLocalFile();
    if (await file.exists()) {
      return Image.file(file, width: 300, height: 300, fit: BoxFit.cover);
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }
}
