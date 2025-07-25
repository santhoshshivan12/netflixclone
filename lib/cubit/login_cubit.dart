import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../nav_helper/nav_helper.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final _auth = FirebaseAuth.instance;
  
  LoginCubit() : super(const LoginInitial()) {
    // Check current auth state on initialization
    _checkCurrentUser();
  }

  Future<void> _checkCurrentUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      await NavHelper.setLoggedIn(true);
      emit(LoginSuccess(email: user.email ?? ''));
    } else {
      await NavHelper.setLoggedIn(false);
      emit(const LoginInitial());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      emit(const LoginLoading());
      
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await NavHelper.setLoggedIn(true);
        emit(LoginSuccess(email: email));
      } else {
        emit(const LoginError(message: 'Login failed. Please try again.'));
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Login failed. Please try again.';
      
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address.';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled.';
          break;
      }
      
      emit(LoginError(message: errorMessage));
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      await NavHelper.setLoggedIn(false);
      emit(const LoginInitial());
    } catch (e) {
      emit(LoginError(message: e.toString()));
    }
  }

  // Listen to auth state changes
  void startAuthStateListener() {
    _auth.authStateChanges().listen((User? user) async {
      if (user != null) {
        await NavHelper.setLoggedIn(true);
        emit(LoginSuccess(email: user.email ?? ''));
      } else {
        await NavHelper.setLoggedIn(false);
        emit(const LoginInitial());
      }
    });
  }
} 