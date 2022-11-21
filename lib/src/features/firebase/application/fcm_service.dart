import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../cloud_firestore.dart';
import '../firebase_path.dart';

final fcmServiceProvider = Provider<FCMService>(FCMService.new);

class FCMService {
  FCMService(this.ref);
  final Ref ref;

  Future<void> setToken(int userId, String token) async =>
      ref.read(cloudFirestoreProvider).setData(
          path: FirebasePath.tokens(userId, token),
          data: <String, dynamic>{
            'token': token,
            'createdAt': FieldValue.serverTimestamp(),
            'platform': Platform.operatingSystem,
          });
}
