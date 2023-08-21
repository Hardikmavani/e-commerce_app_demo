// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:h_firebase_demo/constants/routes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:h_firebase_demo/screens/change_password/change_password.dart';
import 'package:h_firebase_demo/screens/edit_profile/edit_profile.dart';
import 'package:h_firebase_demo/screens/favourite_screen/favourite_screen.dart';
import 'package:h_firebase_demo/widgets/primary_button/primary_button.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Account',
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  appProvider.getUserInformation.image == null
                      ? const Icon(Icons.person_outline, size: 120)
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              appProvider.getUserInformation.image!),
                          radius: 60,
                        ),
                  Text(
                    appProvider.getUserInformation.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text(
                    appProvider.getUserInformation.email,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 130,
                    child: PrimaryButton(
                      title: 'Edit profile',
                      onPressed: () {
                        Routes.instance.push(
                            widget: const EditProfile(), context: context);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.shopping_bag_outlined),
                    title: const Text('Your Orders'),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(
                          widget: const FavouriteScreen(), context: context);
                    },
                    leading: const Icon(Icons.favorite_border),
                    title: const Text('Favourite'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About us'),
                  ),
                  ListTile(
                    onTap: () {},
                    leading: const Icon(Icons.support_outlined),
                    title: const Text('Support'),
                  ),
                  ListTile(
                    onTap: () {
                      Routes.instance.push(
                          widget: const ChangePassword(), context: context);
                    },
                    leading: const Icon(Icons.change_circle_outlined),
                    title: const Text('Change Password'),
                  ),
                  ListTile(
                    onTap: () {
                      FirebaseAuthHelper.instance.signOut();
                      setState(() {});
                    },
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Log out'),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  const Text('Version 1.0.0')
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
