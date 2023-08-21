import 'package:firebase_database/firebase_database.dart';

class FirebaseApi {
  static final DatabaseReference db = FirebaseDatabase.instance.ref('user');

  static Future<void> insertUser({required String userName}) async {
    await db.set({
      'userName': userName,
    });
  }
}
