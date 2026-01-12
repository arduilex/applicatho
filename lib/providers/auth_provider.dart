import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AppAuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _error;
  bool _emailSent = false;

  User? get user => _user;
  String? get email => _user?.email;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _user != null && (_user?.emailVerified ?? false);
  bool get isEmailVerified => _user?.emailVerified ?? false;
  bool get emailSent => _emailSent;

  AppAuthProvider() {
    // Initialiser avec l'utilisateur actuel s'il existe
    _initializeAuth();
    
    // Écouter les changements d'état d'authentification
    _authService.authStateChanges.listen((User? user) async {
      if (user != null) {
        // Recharger l'utilisateur pour obtenir l'état de vérification à jour
        await _authService.reloadUser();
        user = _authService.currentUser;
      }
      _user = user;
      _error = null;
      notifyListeners();
    });
  }

  Future<void> _initializeAuth() async {
    final user = _authService.currentUser;
    if (user != null) {
      await _authService.reloadUser();
      _user = _authService.currentUser;
      notifyListeners();
    }
  }

  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    _emailSent = false;
    notifyListeners();

    final result = await _authService.signUp(
      email: email,
      password: password,
    );

    _isLoading = false;

    if (result['success'] == true) {
      _user = result['user'] as User?;
      _emailSent = result['emailSent'] == true;
      _error = null;
      notifyListeners();
      return {
        'success': true,
        'emailSent': _emailSent,
      };
    } else {
      _error = result['error'] as String?;
      _emailSent = false;
      notifyListeners();
      return {
        'success': false,
        'error': _error,
      };
    }
  }

  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _authService.signIn(
      email: email,
      password: password,
    );

    _isLoading = false;

    if (result['success'] == true) {
      // Recharger l'utilisateur pour obtenir l'état de vérification à jour
      await checkEmailVerification();
      _error = null;
      notifyListeners();
      return {
        'success': true,
      };
    } else {
      _error = result['error'] as String?;
      final errorCode = result['error'] as String?;
      notifyListeners();
      return {
        'success': false,
        'error': _error,
        'errorCode': errorCode,
      };
    }
  }

  Future<Map<String, dynamic>> resendVerificationEmail() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _authService.resendVerificationEmail();

    _isLoading = false;

    if (result['success'] == true) {
      _emailSent = true;
      _error = null;
      notifyListeners();
      return {
        'success': true,
        'message': result['message'],
      };
    } else {
      _error = result['error'] as String?;
      notifyListeners();
      return {
        'success': false,
        'error': _error,
      };
    }
  }

  Future<Map<String, dynamic>> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    final result = await _authService.resetPassword(email);

    _isLoading = false;

    if (result['success'] == true) {
      _error = null;
      notifyListeners();
      return {
        'success': true,
        'message': result['message'],
      };
    } else {
      _error = result['error'] as String?;
      notifyListeners();
      return {
        'success': false,
        'error': _error,
      };
    }
  }

  Future<void> checkEmailVerification() async {
    await _authService.reloadUser();
    _user = _authService.currentUser;
    notifyListeners();
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    _emailSent = false;
    _error = null;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
