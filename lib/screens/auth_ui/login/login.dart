import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/contants.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:h_firebase_demo/screens/auth_ui/sign_up/sign_up.dart';
import 'package:h_firebase_demo/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:h_firebase_demo/widgets/primary_button/primary_button.dart';
import 'package:h_firebase_demo/widgets/top_title/top_title.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isShowPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopTitle(
                  title: 'Login', subTitle: 'Welcome Back to E-Commerce App'),
              const SizedBox(height: 46),
              TextFormField(
                decoration: const InputDecoration(
                    hintText: 'E-mail', prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: 12),
              TextFormField(
                obscureText: isShowPassword,
                decoration: InputDecoration(
                    hintText: 'Password',
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
              const SizedBox(height: 36),
              PrimaryButton(
                title: 'Login',
                onPressed: () async {
                  bool isValidated = loginValidation(
                      emailController.text, passwordController.text);
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance.login(
                        emailController.text, passwordController.text, context);
                    if (isLogined) {
                      // ignore: use_build_context_synchronously
                      Routes.instance.pushAndRemoveUntil(
                          widget: const CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              const SizedBox(height: 24),
              const Center(child: Text("Don't have an account")),
              const SizedBox(height: 12),
              Center(
                child: CupertinoButton(
                  child: Text(
                    'Create an account',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Routes.instance
                        .push(widget: const SignUp(), context: context);
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
