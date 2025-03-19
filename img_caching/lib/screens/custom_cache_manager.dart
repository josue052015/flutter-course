import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/// Tu método que obtiene la imagen usando Dio.
Future<dynamic> getImg(String? imgIdentifier) async {
  final dio = Dio();
  return await dio.get(
    'https://tripleenableapi.triplecyber.com/api/v1/Profile/UserPhoto/4bm1ce1@tripleenableverified.com?height=300&width=300',
    options: Options(
      responseType: ResponseType.bytes, // Se obtienen los datos como bytes.
      headers: {
        'device-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9kZXZpY2VJZCI6IjExOTQ0IiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vYXNzZXRJZCI6IjMzMzQiLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9kZXZpY2VOYW1lIjoiQ2hyb21lIFdpbmRvd3MvMjNiN2FiOTMtOTExOC00NTQ1LWIxYmItOTc2OWRhYjMwZmQyIiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vbUZDTVRva2VuIjoiVW5rbm93biIsImh0dHBzOi8vdHJpcGxlZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9jaXR5IjoiU2FudG8gRG9taW5nbyIsImh0dHBzOi8vdHJpcGxlZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9yZWdpb24iOiJOYWNpb25hbCIsImh0dHBzOi8vdHJpcGxlZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9jb3VudHJ5IjoiRE8iLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9sYXRpdHVkZSI6IjE4LjQ3MTkiLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9sb25naXR1ZGUiOiItNjkuODkyMyIsImV4cCI6MTc0MjA2NTMwOH0.pw-lsXWXVsJCc-vEm6HM-9E_DgXKfiwY7OBGBXh0ve4',
        'authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FwaS50cmlwbGVjeWJlci5jb20iLCJzdWIiOiJrbHRweG9AVHJpcGxlRW5hYmxlVmVyaWZpZWQuY29tIiwibmFtZSI6IkZhdXN0byBNYXJ0aW5leiIsImdpdmVuX25hbWUiOiJGYXVzdG8iLCJmYW1pbHlfbmFtZSI6Ik1hcnRpbmV6ICIsImVtYWlsIjoiS0xUUFhPQFRSSVBMRUVOQUJMRVZFUklGSUVELkNPTSIsImF1ZCI6WyIiLCJodHRwczovL2FwaS50cmlwbGVjeWJlci5jb20iXSwianRpIjoiMDRkNGZkYWItOWRmNS00ODQ3LTkyMmMtMzYzZjk3Y2NhNjQyIiwibmFtZWlkIjoiOTExIiwicm9sZXMiOlsiQW5vbnltb3VzIiwiUHJpdmF0ZSJdLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJub25jZSI6IiIsIm5iZiI6MTc0MTk2MjE3OSwiZXhwIjoxNzQ0NTU0MTc5LCJpYXQiOjE3NDE5NjIxNzl9.mHA90SmcD-ARLfLAM1FMZskMAAW5otKmbeJ4h3fOwDg',
        'If-None-Match': imgIdentifier ?? "",
      },
    ),
  );
}

/// Cache manager personalizado que utiliza el método getImg en su función de descarga.
class CustomCacheManager extends BaseCacheManager {
  static const key = 'customCacheManager';
  static final CustomCacheManager _instance = CustomCacheManager._internal();

  factory CustomCacheManager() => _instance;

  CustomCacheManager._internal()
      : super(
          key,
          maxAgeCacheObject: const Duration(days: 7),
          // La función fileFetcher usa getImg para descargar la imagen.
          fileFetcher: _customFetcher,
        );

  static Future<FileFetcherResponse> _customFetcher(
    String url, {
    Map<String, String>? headers,
  }) async {
    // Se utiliza el header 'If-None-Match' como identificador (ETag).
    final response = await getImg(headers?['If-None-Match']);
    return HttpFileFetcherResponse(response);
  }
}

/// Widget que obtiene la imagen mediante el cache manager y la muestra.
class CachedImageWidget extends StatelessWidget {
  final String etag; // Identificador opcional para el control de versiones.

  const CachedImageWidget({Key? key, required this.etag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Aunque se requiere un URL, en este ejemplo usamos un valor dummy,
    // ya que el método getImg utiliza internamente la URL fija.
    return FutureBuilder<File>(
      future: CustomCacheManager().getSingleFile(
        'dummy_url',
        headers: {'If-None-Match': etag},
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Icon(Icons.error));
        } else if (snapshot.hasData) {
          return Image.file(
            snapshot.data!,
            width: 300,
            height: 300,
            fit: BoxFit.cover,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
