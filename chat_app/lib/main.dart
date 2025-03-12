import 'package:chat_app/presentation/providers/chat_provider.dart';
import 'package:chat_app/presentation/screens/chat/chat_screen.dart';
import 'package:chat_app/config/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ChatProvider())],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme().theme(),
        home: const ChatScreen(),
      ),
    );
  }
}
