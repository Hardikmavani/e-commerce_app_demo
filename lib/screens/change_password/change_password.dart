import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/contants.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:h_firebase_demo/widgets/primary_button/primary_button.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();

  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Change Password',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          TextFormField(
            controller: newPasswordController,
            obscureText: isShowPassword,
            decoration: InputDecoration(
                hintText: 'New Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: CupertinoButton(
                    onPressed: () {
                      setState(() {
                        isShowPassword = !isShowPassword;
                      });
                    },
                    child: isShowPassword == false
                        ? const Icon(
                            Icons.visibility,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.visibility_off,
                            color: Colors.grey,
                          ))),
          ),
          const SizedBox(
            height: 25,
          ),
          TextFormField(
            controller: confirmPasswordController,
            obscureText: isShowPassword,
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: CupertinoButton(
                onPressed: () {
                  setState(() {
                    isShowPassword = !isShowPassword;
                  });
                },
                child: isShowPassword == false
                    ? const Icon(
                        Icons.visibility,
                        color: Colors.grey,
                      )
                    : const Icon(
                        Icons.visibility_off,
                        color: Colors.grey,
                      ),
              ),
            ),
          ),
          const SizedBox(
            height: 36,
          ),
          PrimaryButton(
            title: 'Update',
            onPressed: () async {
              if (newPasswordController.text.isEmpty) {
                showMessage('New Password is empty');
              } else if (confirmPasswordController.text.isEmpty) {
                showMessage('Confirm Password is empty');
              } else if (confirmPasswordController.text ==
                  newPasswordController.text) {
                FirebaseAuthHelper.instance
                    .changePassword(newPasswordController.text, context);
              } else {
                showMessage('Confirm Password is not match');
              }
            },
          )
        ],
      ),
    );
  }
}
