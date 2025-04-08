import 'package:flutter/material.dart';
import 'dart:io';



class ScrollScaleTransitionExample extends StatefulWidget {
  @override
  _ScrollScaleTransitionExampleState createState() =>
      _ScrollScaleTransitionExampleState();
}

class _ScrollScaleTransitionExampleState
    extends State<ScrollScaleTransitionExample>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _initialAnimationDone = false;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 0), // usaremos el value directamente
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Ejecutar animación inicial
    _animationController.forward().whenComplete(() {
      // Después de la animación inicial, conectamos con el scroll
      setState(() {
        _initialAnimationDone = true;
      });
    });

    _scrollController.addListener(() {
      if (_initialAnimationDone) {
        // Mapea el offset del scroll entre 0 y 200 (puedes ajustarlo)
        double scrollOffset = _scrollController.offset.clamp(0, 100);
        double value = 1 - (scrollOffset / 100); // 1.0 → 0.0
        _animationController.value = value;
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              margin: EdgeInsets.only(top: 40),
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text('Logo', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 50,
              itemBuilder: (_, index) => ListTile(title: Text('Item $index')),
            ),
          ),
        ],
      ),
    );
  }
}
