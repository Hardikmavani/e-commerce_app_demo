import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/contants.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:h_firebase_demo/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:h_firebase_demo/widgets/primary_button/primary_button.dart';
import 'package:h_firebase_demo/widgets/top_title/top_title.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
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
                  title: 'Create Account',
                  subTitle: 'Welcome Back to E-Commerce App'),
              const SizedBox(height: 46),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                    hintText: 'Name', prefixIcon: Icon(Icons.person_outline)),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                    hintText: 'E-mail', prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: 'Phone', prefixIcon: Icon(Icons.phone_outlined)),
              ),
              const SizedBox(height: 12),
              const SizedBox(height: 12),
              TextFormField(
                controller: passwordController,
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
                title: 'Create an account',
                onPressed: () async {
                  bool isValidated = signUpValidation(
                      emailController.text,
                      passwordController.text,
                      nameController.text,
                      phoneController.text);
                  if (isValidated) {
                    bool isLogined = await FirebaseAuthHelper.instance.signUp(
                        nameController.text,
                        emailController.text,
                        passwordController.text,
                        context);
                    if (isLogined) {
                      // ignore: use_build_context_synchronously
                      Routes.instance.pushAndRemoveUntil(
                          widget: const CustomBottomBar(), context: context);
                    }
                  }
                },
              ),
              const SizedBox(height: 24),
              const Center(child: Text("I have already an account")),
              const SizedBox(height: 12),
              Center(
                child: CupertinoButton(
                  child: Text(
                    'Login',
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
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
