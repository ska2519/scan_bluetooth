import '../authentication/domain/app_user.dart';

class FirebasePath {
  FirebasePath._();

  static String firebaseUser(int id) => 'users/$id';

  static String profileImages(UserId uid) => 'profileImages/$uid';
  static String postImages(UserId uid, String fileName) =>
      'postImages/$uid/$fileName';
  static String chatImages(String chatId, String fileName) =>
      'chatImages/$chatId/$fileName';
  static String verificationImages(UserId uid, String fileName) =>
      'verificationImages/$uid/$fileName';
  static String stockImages(String stockCode) => 'stockImages/$stockCode.png';

  static String chatList() => 'chats';
  static String chat(String? chatId) => 'chats/$chatId';
  static String messages(String? chatId) => 'chats/$chatId/$chatId';
  static String message(String chatId, String documentID) =>
      'chats/$chatId/$chatId/$documentID';

  static String tokens(int userId, String token) =>
      'users/$userId/tokens/$token';

  static String categories() => 'data/categories';
  static String items() => 'data/items';
  static String templates() => 'data/templates';
  static String faqs() => 'data/FAQs';
  static String users({UserId? uid}) => 'users/$uid';
  static String estimates({String? estimatesId}) => 'estimates/$estimatesId';
  static String faqCategories() => 'data/FAQCategories';

  static String bluetoothes({String? deviceId}) => 'bluetoothes/$deviceId';
  static String labels({required String deviceId, required String uid}) =>
      'bluetoothes/$deviceId/labels/$uid';
  static String collectionGroupLabels() => 'labels';
  static String status({UserId? uid}) => 'status/$uid';
  static String collectionStatus() => 'status';
  static String collectionPurchases() => 'purchases';
}
