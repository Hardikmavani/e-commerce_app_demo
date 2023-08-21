import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:h_firebase_demo/constants/themes.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_auth_helper/firebase_auth_helper.dart';
import 'package:h_firebase_demo/firebase_helper/firebase_option/firebase_option.dart';
import 'package:h_firebase_demo/provider/app_provider.dart';
import 'package:h_firebase_demo/screens/auth_ui/welcome/welcome.dart';
import 'package:h_firebase_demo/screens/custom_bottom_bar/custom_bottom_bar.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51MWx8OAVMyklfe3CsjEzA1CiiYOXBTlHYbZ8jQlGtVFlwQi4aNeGv8J1HUw4rgSavMTLzTwgn0XRlwoTVRFXyu2h00mRUeWmAf';
  await Firebase.initializeApp(
    options: DefaultFirebaseConfig.plateformOptions,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeData,
        home: StreamBuilder(
          stream: FirebaseAuthHelper.instance.getAuthChange,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const CustomBottomBar();
            }
            return const Welcome();
          },
        ),
      ),
    );
  }
}
