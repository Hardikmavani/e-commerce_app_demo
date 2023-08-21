import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopTitle extends StatelessWidget {
  final String title, subTitle;
  const TopTitle({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: kToolbarHeight + 12),
        if (title == 'Login' || title == 'Create Account')
          GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios)),
        const SizedBox(height: 15),
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(subTitle,
            style: const TextStyle(
              fontSize: 18,
            )),
      ],
    );
  }
}
