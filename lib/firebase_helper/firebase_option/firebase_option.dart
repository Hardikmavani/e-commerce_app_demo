import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseConfig {
  static FirebaseOptions get plateformOptions {
    if (Platform.isAndroid) {
      return const FirebaseOptions(
          apiKey: "AIzaSyBvkJgVG4SyAqmOqL4rJw9oA2TlETlK23Q",
          appId: '1:776196512069:android:4da07492ab3c4ba670462c',
          messagingSenderId: '776196512069',
          projectId: "h-firebase-new");
    } else {
      return const FirebaseOptions(
          apiKey: 'AIzaSyBvkJgVG4SyAqmOqL4rJw9oA2TlETlK23Q',
          appId: '1:776196512069:android:4da07492ab3c4ba670462c',
          messagingSenderId: '776196512069',
          projectId: "h-firebase-new");
    }
  }
}
