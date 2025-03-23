import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends StatelessWidget {
  const CustomCacheManager({super.key});

  @override
  Widget build(BuildContext context) {
    return  CachedNetworkImage(imageUrl: "https://tripleenableapi.triplecyber.com/api/v1/Profile/UserPhoto/ghostlyexplorer2044@tripleenableanonymous.com?height=300&width=300", cacheManager: MyCustomCacheManager(), width: 300, height: 300,);
  }
}
class MyCustomCacheManager extends CacheManager {
  static const String key = "myCustomCache";

  static final MyCustomCacheManager _instance = MyCustomCacheManager._internal();

  factory MyCustomCacheManager() {
    return _instance;
  }

  MyCustomCacheManager._internal()
      : super(
          Config(
            key,
            stalePeriod: Duration(days: 7), // Caché válido por 7 días
            maxNrOfCacheObjects: 50, // Máximo 50 archivos en caché
          ),
        ){
    // Al instanciarse, se llama a fetchUpdatedFile para precargar la imagen.
    final imageUrl =
        "https://tripleenableapi.triplecyber.com/api/v1/Profile/UserPhoto/4bm1ce1@tripleenableverified.com?height=300&width=300";
    fetchUpdatedFile(imageUrl).then((file) {
      print("Imagen precargada en la caché: ${file.path}");
    }).catchError((error) {
      print("Error al precargar la imagen: $error");
    });
  }


  /// 🚀 Lógica de HTTP Conditional GET con `If-None-Match`
  Future<File> fetchUpdatedFile(String url) async {
    final cacheObject = await store.retrieveCacheData(url); // Obtener info del caché
    String? eTag = cacheObject?.eTag; // Extraer ETag

    try {
      // Hacemos la solicitud HTTP con `If-None-Match`
      final fileResponse = await downloadFile(
        url,
        authHeaders: {
           'If-None-Match': eTag ?? "",
           'device-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9kZXZpY2VJZCI6IjEyMDAwIiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vYXNzZXRJZCI6IjM0MDUiLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9hc3NldE5hbWUiOiJUQzNfQU5PTklNT1VTX1BBR0VfQ0xJRU5UIiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vZGV2aWNlTmFtZSI6IkNocm9tZSBPUyBYL2ZlMWZmYzBkLWI3N2YtNDZlOS1hNjU1LWIxMDQwNzJlNjE2ZiIsImh0dHBzOi8vdHJpcGxlZW5hYmxlYXBpLnRyaXBsZWN5YmVyLmNvbS9jbGFpbXMvY3VzdG9tL21GQ01Ub2tlbiI6IlVua25vd24iLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9pcEFkZHJlc3MiOiJVbmtub3duIiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vY2l0eSI6IlVua25vd24iLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9yZWdpb24iOiJVbmtub3duIiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vY291bnRyeSI6IlVua25vd24iLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9sYXRpdHVkZSI6IlVua25vd24iLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9sb25naXR1ZGUiOiJVbmtub3duIiwiZXhwIjoxNzQyNjc2MDc3fQ.TPl4gVmgRSgIWUCBCIMTLVUjujJcZVGtAcxsfCzWCMg',
        'authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FwaS50cmlwbGVjeWJlci5jb20iLCJzdWIiOiJHaG9zdGx5RXhwbG9yZXIyMDQ0QFRyaXBsZUVuYWJsZUFub255bW91cy5jb20iLCJuYW1lIjoiIiwiZ2l2ZW5fbmFtZSI6IiIsImZhbWlseV9uYW1lIjoiIiwiZW1haWwiOiJHSE9TVExZRVhQTE9SRVIyMDQ0QFRSSVBMRUVOQUJMRUFOT05ZTU9VUy5DT00iLCJhdWQiOlsiIiwiaHR0cHM6Ly9hcGkudHJpcGxlY3liZXIuY29tIl0sImp0aSI6ImZkOTNmMjEyLWI2YTItNDFkNi04YmE4LTg1YzNmZjI3MDAxMSIsIm5hbWVpZCI6Ijk1OCIsInJvbGVzIjpbIkFub255bW91cyJdLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJub25jZSI6IiIsIm5iZiI6MTc0MjU4OTY3MCwiZXhwIjoxNzQ1MTgxNjcwLCJpYXQiOjE3NDI1ODk2NzB9.7NoqbWeopV48B0z4q6xVVQYeO8UvMRLH97YOZDVkq60',
        }, // Agregar ETag en headers
      );

      print("Nuevo archivo descargado con código 200");
      return fileResponse.file; // Archivo actualizado

    } on HttpExceptionWithStatus catch (e) {
      if (e.statusCode == 304) {
        print("El archivo no ha cambiado, usando caché");
        final cachedFile = await getFileFromCache(url);
        return cachedFile!.file; // Usamos la versión en caché
      }
      rethrow; // Si hay otro error, lo propagamos
    }
  }
}