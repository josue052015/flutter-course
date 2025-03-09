import 'package:flutter/material.dart';

class CounterFunctionsScreen extends StatefulWidget {
  const CounterFunctionsScreen({super.key});

  @override
  State<CounterFunctionsScreen> createState() => _CounterFunctionsScreenState();
}

class _CounterFunctionsScreenState extends State<CounterFunctionsScreen> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Counter', style: TextStyle(color: Colors.white)),
        ),
        backgroundColor: Colors.brown,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh_rounded)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$counter',
              style: TextStyle(fontSize: 160, fontWeight: FontWeight.w100),
            ),
            Text(
              counter == 1 ? 'Click' : 'Clicks',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomBottom(
            icon: Icons.refresh,
            onPressed: () {
              setState(() {
                counter = 0;
              });
            },
          ),
          const SizedBox(height: 15),
          CustomBottom(
            icon: Icons.plus_one,
            onPressed: () {
              setState(() {
                counter += 1;
              });
            },
          ),
          const SizedBox(height: 15),
          CustomBottom(
            icon: Icons.exposure_minus_1,
            onPressed: () {
              if (counter < 1) return;
              setState(() {
                counter -= 1;
              });
            },
          ),
        ],
      ),
    );
  }
}

//widget personalizado
class CustomBottom extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const CustomBottom({super.key, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: onPressed, child: Icon(icon));
  }
}
