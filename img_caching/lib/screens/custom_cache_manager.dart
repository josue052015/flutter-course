import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cache_manager/src/web/web_helper.dart';
import 'package:flutter_cache_manager/src/cache_store.dart';
import 'package:img_caching/config/helpers/get_user_img.dart' show getImg;


class MyCustomCacheManager extends CacheManager {
  static const String key = "myCustomCache";
  static String eTag = "";

  static final MyCustomCacheManager _instance =
      MyCustomCacheManager._internal();

  factory MyCustomCacheManager() {
    return _instance;
  }
  MyCustomCacheManager._internal() : super(Config(key));
  @override
  Stream<FileResponse> getFileStream(
    String url, {
    String? key,
    Map<String, String>? headers,
    bool withProgress = false,
  }) async* {
    final cacheObject = await store.retrieveCacheData(
      url,
    ); 
    String? eTag = cacheObject?.eTag; 
    key = url;
    final file = await getFileFromCache(url);
    if (file != null) {
      print("file from cache...");
      yield file;
    }
    print(eTag);
    try {
      final response = await getImg(url, eTag);
      eTag = response.headers.value('ETag');
      if (response.statusCode == 200 && eTag != null) {
        await putFile(
          url,
          response.data,
          key: url,
          eTag: eTag,
          maxAge: Duration(days: 30),
        );
        final files = await getFileFromCache(url);
        if (files != null) {
          print("new Img cached");
          yield files;
        }
      }
      print("Nuevo archivo descargado con código 200");
    } catch (e) {
  
    }
  }

}
