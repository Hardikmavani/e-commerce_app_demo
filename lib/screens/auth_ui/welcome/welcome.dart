import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/assets_images.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/screens/auth_ui/login/login.dart';
import 'package:h_firebase_demo/screens/auth_ui/sign_up/sign_up.dart';
import 'package:h_firebase_demo/widgets/primary_button/primary_button.dart';
import 'package:h_firebase_demo/widgets/top_title/top_title.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitle(
                  title: 'Welcome', subTitle: 'Buy any item from using app'),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Center(
                  child: Image.asset(
                    AssetsImages.intance.welcomeImages,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      Icons.facebook,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  CupertinoButton(
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    child: Image.asset(
                      AssetsImages.intance.googleLogo,
                      scale: 60,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 60),
              PrimaryButton(
                title: 'Login',
                onPressed: () {
                  Routes.instance.push(widget: const Login(), context: context);
                },
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                title: 'Sign up',
                onPressed: () {
                  Routes.instance
                      .push(widget: const SignUp(), context: context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
