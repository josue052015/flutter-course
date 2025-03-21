
import 'package:dio/dio.dart';

Future<dynamic> getImg(imgIdentifier) async {
  final dio = Dio();
  return await dio.get(
    'https://tripleenableapi.triplecyber.com/api/v1/Profile/UserPhoto/4bm1ce1@tripleenableverified.com?height=300&width=300',
    options: Options(
      responseType:
          ResponseType.bytes, // This ensures the data is returned as bytes.
      headers: {
        'device-token':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9kZXZpY2VJZCI6IjExOTQ0IiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vYXNzZXRJZCI6IjMzMzQiLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9kZXZpY2VOYW1lIjoiQ2hyb21lIFdpbmRvd3MvMjNiN2FiOTMtOTExOC00NTQ1LWIxYmItOTc2OWRhYjMwZmQyIiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vbUZDTVRva2VuIjoiVW5rbm93biIsImh0dHBzOi8vdHJpcGxlZW5hYmxlYXBpLnRyaXBsZWN5YmVyLmNvbS9jbGFpbXMvY3VzdG9tL2lwQWRkcmVzcyI6IjIwMC44OC4xMzIuMTQ3IiwiaHR0cHM6Ly90cmlwbGVlbmFibGVhcGkudHJpcGxlY3liZXIuY29tL2NsYWltcy9jdXN0b20vY2l0eSI6IlNhbnRvIERvbWluZ28iLCJodHRwczovL3RyaXBsZWVuYWJsZWFwaS50cmlwbGVjeWJlci5jb20vY2xhaW1zL2N1c3RvbS9yZWdpb24iOiJOYWNpb25hbCIsImh0dHBzOi8vdHJpcGxlZW5hYmxlYXBpLnRyaXBsZWN5YmVyLmNvbS9jbGFpbXMvY3VzdG9tL2NvdW50cnkiOiJETyIsImh0dHBzOi8vdHJpcGxlZW5hYmxlYXBpLnRyaXBsZWN5YmVyLmNvbS9jbGFpbXMvY3VzdG9tL2xhdGl0dWRlIjoiMTguNDcxOSIsImh0dHBzOi8vdHJpcGxlZW5hYmxlYXBpLnRyaXBsZWN5YmVyLmNvbS9jbGFpbXMvY3VzdG9tL2xvbmdpdHVkZSI6Ii02OS44OTIzIiwiZXhwIjoxNzQyMDY1MzA4fQ.pw-lsXWXVsJCc-vEm6HM-9E_DgXKfiwY7OBGBXh0ve4',
        'authorization':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2FwaS50cmlwbGVjeWJlci5jb20iLCJzdWIiOiJrbHRweG9AVHJpcGxlRW5hYmxlVmVyaWZpZWQuY29tIiwibmFtZSI6IkZhdXN0byBNYXJ0aW5leiIsImdpdmVuX25hbWUiOiJGYXVzdG8iLCJmYW1pbHlfbmFtZSI6Ik1hcnRpbmV6ICIsImVtYWlsIjoiS0xUUFhPQFRSSVBMRUVOQUJMRVZFUklGSUVELkNPTSIsImF1ZCI6WyIiLCJodHRwczovL2FwaS50cmlwbGVjeWJlci5jb20iXSwianRpIjoiMDRkNGZkYWItOWRmNS00ODQ3LTkyMmMtMzYzZjk3Y2NhNjQyIiwibmFtZWlkIjoiOTExIiwicm9sZXMiOlsiQW5vbnltb3VzIiwiUHJpdmF0ZSJdLCJlbWFpbF92ZXJpZmllZCI6IlRydWUiLCJub25jZSI6IiIsIm5iZiI6MTc0MTk2MjE3OSwiZXhwIjoxNzQ0NTU0MTc5LCJpYXQiOjE3NDE5NjIxNzl9.mHA90SmcD-ARLfLAM1FMZskMAAW5otKmbeJ4h3fOwDg',
        'If-None-Match': imgIdentifier ?? "",
      },
    ),
  );
}
