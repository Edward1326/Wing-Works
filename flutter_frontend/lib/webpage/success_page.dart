import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {
  final VoidCallback onBookNowTap;

  const SuccessDialog({
    super.key,
    required this.onBookNowTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 500,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: const NetworkImage(
                'https://images.unsplash.com/photo-1567620832903-9fc6debc209f'),
            fit: BoxFit.cover,
            opacity: 0.2,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'WingsOnWheels',
              style: TextStyle(
                color: Color(0xFFB71C1C),
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),

            // Green checkmark icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 40,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Account Created Successfully!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please Check Your Email',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 30),

            // Book Now button
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: onBookNowTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB71C1C),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Book Now',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
