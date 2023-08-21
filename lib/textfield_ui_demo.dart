import 'package:flutter/material.dart';
import 'package:h_firebase_demo/firebase_api.dart';

class TextfieldDemo extends StatefulWidget {
  const TextfieldDemo({super.key});

  @override
  State<TextfieldDemo> createState() => _TextfieldDemoState();
}

class _TextfieldDemoState extends State<TextfieldDemo> {
  TextEditingController txtNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: txtNameController,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
                onPressed: () async {
                  await FirebaseApi.insertUser(
                      userName: txtNameController.text);
                  setState(() {});
                },
                child: const Text('Submit'))
          ],
        )),
      ),
    );
  }
}
