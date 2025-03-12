import 'package:flutter/material.dart';

class OtherMessageBubble extends StatelessWidget {
  const OtherMessageBubble({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 8, end: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: colors.secondary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('ipsum', style: TextStyle(color: Colors.white)),
            ),
          ),
          SizedBox(height: 5),
          _GiftWidget(),
        ],
      ),
    );
  }
}

class _GiftWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://yesno.wtf/assets/no/20-56c4b19517aa69c8f7081939198341a4.gif',
            width: size.width * 0.55,
            height: 150,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: size.width * 0.55,
                height: 150,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Text('My princesa is writting...'),
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
