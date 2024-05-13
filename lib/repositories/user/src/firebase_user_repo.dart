import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:logger/logger.dart';
import 'package:mobile_app/models/auth/auth_result.dart';
import 'package:mobile_app/models/user/user.dart';
import 'package:mobile_app/repositories/user/interface/i_user_repo.dart';

class FirebaseUserRepo implements IUserRepo {
  const FirebaseUserRepo();

  @override
  Future<User?> fetchUser() async {
    final auth = firebase_auth.FirebaseAuth.instance;

    if (auth.currentUser is! firebase_auth.User) return null;

    final firestore = FirebaseFirestore.instance;
    final doc = firestore
        .collection('users')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              User.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(auth.currentUser?.uid);

    final user = await doc.get();
    return user.data();
  }

  @override
  Future<AuthResult> login({
    required String email,
    required String password,
    bool rememberMe = false,
  }) async {
    final auth = firebase_auth.FirebaseAuth.instance;

    firebase_auth.UserCredential userCredential;

    try {
      userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: e.message);
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      return AuthResult(
        errorMessage: 'Unknown error occurs',
      );
    }

    final firestore = FirebaseFirestore.instance;
    final doc = firestore
        .collection('users')
        .withConverter(
          fromFirestore: (snapshot, options) =>
              User.fromJson(snapshot.data() ?? {}),
          toFirestore: (value, options) => value.toJson(),
        )
        .doc(userCredential.user?.uid);

    final user = await doc.get();
    if (user.exists) return AuthResult(user: user.data());

    return AuthResult(
      errorMessage:
          'No users found with such credentials, registration is required',
    );
  }

  @override
  Future<AuthResult> register({required User user}) async {
    final auth = firebase_auth.FirebaseAuth.instance;

    if (auth.currentUser is firebase_auth.User) return AuthResult(user: user);

    firebase_auth.UserCredential userCredential;

    try {
      userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      return AuthResult(errorMessage: e.message);
    } catch (e, s) {
      Logger().e(e, stackTrace: s);
      return AuthResult(
        errorMessage: 'Unknown error occurs',
      );
    }

    user.uid = userCredential.user?.uid ?? user.uid;

    final firestore = FirebaseFirestore.instance;
    final doc = firestore.collection('users').doc(user.uid);
    await doc.set(user.toJson());

    return AuthResult(user: user);
  }

  @override
  Future<void> signOut({required User user}) async {
    final auth = firebase_auth.FirebaseAuth.instance;

    if (auth.currentUser is! firebase_auth.User) return;
    await auth.signOut();
  }

  @override
  Future<void> updateUser({required User user}) async {
    final firestore = FirebaseFirestore.instance;
    final doc = firestore.collection('users').doc(user.uid);
    final data = await doc.get();

    if (!data.exists) return;

    await doc.update(user.toJson());
  }
}
