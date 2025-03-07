import 'package:flutter/material.dart';

class WOWPanel extends StatelessWidget {
  const WOWPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
        image: DecorationImage(
          image: const NetworkImage(
              'https://images.unsplash.com/photo-1567620832903-9fc6debc209f'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.5),
            BlendMode.darken,
          ),
        ),
      ),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Text(
            'W.O.W',
            style: TextStyle(
              color: Color(0xFFB71C1C),
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
