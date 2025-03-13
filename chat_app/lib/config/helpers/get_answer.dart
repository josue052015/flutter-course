import 'package:chat_app/domain/entities/message.dart';
import 'package:dio/dio.dart';

class GetAnswer {
  final _dio = Dio();
  Future<Message> getAnswer() async {
    final response = await _dio.get('https://yesno.wtf/api');
    return Message(text: response.data['answer'], fromMessage: FromWho.other);
  }
}
