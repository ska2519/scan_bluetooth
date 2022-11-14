import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../exceptions/error_logger.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

final cloudFirestoreProvider =
    Provider<CloudFirestore>((ref) => CloudFirestore());

class CloudFirestore {
  static final _instance = FirebaseFirestore.instance;

  Future<void> batchSetAndSet({
    required String path1,
    required String path2,
    required Map<String, dynamic> data1,
    required Map<String, dynamic> data2,
    bool merge = true,
  }) async {
    final ref1 = _instance.doc(path1);
    final ref2 = _instance.doc(path2);
    _instance.batch().set(ref1, data1, SetOptions(merge: merge));
    _instance.batch().set(ref2, data1, SetOptions(merge: merge));
    await _instance.batch().commit();
  }

  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final ref = _instance.doc(path);
    await ref.set(data, SetOptions(merge: merge));
  }

  Future<DocumentReference<Map<String, dynamic>>> addData({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final ref = _instance.collection(path);
    return ref.add(data);
  }

  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
    Function(T result)? countBiggerThanZero,
  }) async {
    Query query = _instance.collection(path);
    if (queryBuilder != null) query = queryBuilder(query);

    final snapshots = await query.get();

    final result = snapshots.docs
        .map((QueryDocumentSnapshot doc) =>
            builder(doc.data() as Map<String, dynamic>?, doc.id))
        .where((value) => value != null)
        .toList();

    if (sort != null) result.sort(sort);

    if (countBiggerThanZero != null) {
      final countResult = <T>[];
      result.map((e) {
        if (countBiggerThanZero(e) == true) countResult.add(e);
      }).toList();
      return countResult;
    }
    return result;
  }

  Future<void> updateDoc({
    required String path,
    required Map<String, dynamic> data,
  }) async =>
      _instance.doc(path).update(data);

  Future<void> deleteDoc({required String path}) async {
    final ref = _instance.doc(path);
    await ref.delete();
  }

  Future<void> deleteCollection({required String path}) async {
    final ref = _instance.collection(path);
    final snapshots = await ref.get();
    for (final doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  Stream<List<T>> collectionGroupStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = _instance.collectionGroup(path);

    if (queryBuilder != null) query = queryBuilder(query);

    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>?, snapshot.id))
          .where((value) => value != null)
          .toList();

      if (sort != null) result.sort(sort);

      return result;
    });
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
    Function(T result)? unOrdDeepEq,
    Function(T result)? containsAll,
  }) {
    // Stream<List<T>> streamDocs;
    try {} catch (e) {
      logger.e('collectionStream e: $e');
    }
    Query query = _instance.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final streamDocs = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>?, snapshot.id))
          .where((value) => value != null)
          .toList();

      if (sort != null) streamDocs.sort(sort);
// TODO:  streamDocs.map((e){}); check orderResult & containsAll function
      if (unOrdDeepEq != null) {
        final orderResult = <T>[];
        streamDocs.map((e) {
          if (unOrdDeepEq(e) == true) orderResult.add(e);
        }).toList();
        return orderResult;
      }
      if (containsAll != null) {
        final containsResult = <T>[];
        streamDocs.map((e) {
          if (containsAll(e) == true) containsResult.add(e);
        }).toList();
        return containsResult;
      }
      return streamDocs;
    });
  }

  Future<T> getDoc<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) async {
    final ref = _instance.doc(path);
    final DocumentSnapshot snapshot = await ref.get();
    final data = snapshot.data() as Map<String, dynamic>;
    return builder(data, snapshot.id);
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentID) builder,
  }) {
    final ref = _instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = ref.snapshots();
    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>?, snapshot.id));
  }

  // Future<void> setTransaction({
  //   required String firstPath,
  //   required String secondPath,
  //   Map<String, dynamic>? firstData,
  //   Map<String, dynamic>? secondData,
  //   Transaction? action,
  // }) async {
  //   final firstTransactionRef = instance.doc(firstPath);
  //   final secondTransactionRef = instance.doc(secondPath);
  //   instance.runTransaction((transaction) async {
  //     transaction.set(firstTransactionRef, firstData);
  //     transaction.set(secondTransactionRef, secondData!);
  //   });
  // }

  Future<void> updateBatchDocs({
    required String firstPath,
    required String secondPath,
    required Map<String, dynamic> firstData,
    required Map<String, dynamic> secondData,
  }) async {
    final batch = _instance.batch();
    final firstRef = _instance.doc(firstPath);
    final secondRef = _instance.doc(secondPath);
    batch.update(firstRef, firstData);
    batch.set(secondRef, secondData, SetOptions(merge: true));

    await batch.commit();
  }
}
