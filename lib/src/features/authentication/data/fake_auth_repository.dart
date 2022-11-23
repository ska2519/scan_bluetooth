import 'package:firebase_auth/firebase_auth.dart';

import '../../../utils/delay.dart';
import '../../../utils/in_memory_store.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.addDelay = true});
  final bool addDelay;
  final _authUserState = InMemoryStore<User?>(null);
  final _authState = InMemoryStore<AppUser?>(null);

  @override
  Stream<User?> authStateChanges() => _authUserState.stream;
  // Stream<AppUser?> authStateChanges() => _authState.stream;

  @override
  AppUser? get currentUser => _authState.value;
  // AppUser? get currentUser => _authState.value;

  @override
  void userChanges() {
    // TODO: implement userChanges
  }

  @override
  Future<void> signInAnonymously() async {
    await delay(addDelay);
    _authState.value = const AppUser(
      uid: 'Anonymously',
      isAnonymous: true,
    );
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await delay(addDelay);
    createNewUser(email);
  }

  @override
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    await delay(addDelay);
    createNewUser(email);
  }

  @override
  Future<void> signOut() async {
    _authState.value = null;
  }

  @override
  void dispose() => _authState.close();

  void createNewUser(String email) {
    _authState.value = AppUser(
      uid: email.split('').reversed.join(),
      email: email,
    );
  }

  @override
  Future<void> signInWithGoogle({String? displayName}) {
    throw UnimplementedError();
  }

  @override
  Future<void> signInWithApple({String? displayName}) {
    throw UnimplementedError();
  }

  @override
  Future<AppUser?> getAppUser(String uid) {
    // TODO: implement getAppUser
    throw UnimplementedError();
  }

  Stream<User?> authUserStateChanges() {
    // TODO: implement authUserStateChanges
    throw UnimplementedError();
  }

  @override
  Future<void> updateAppUser(AppUser user) {
    // TODO: implement updateAppUser
    throw UnimplementedError();
  }

  @override
  Future<void> setAppUser(User user) {
    // TODO: implement setAppUser
    throw UnimplementedError();
  }
}
