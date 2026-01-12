import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Stream pour écouter les changements d'état d'authentification
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Obtenir l'utilisateur actuel
  User? get currentUser => _auth.currentUser;

  // Vérifier si l'email est vérifié
  bool get isEmailVerified => _auth.currentUser?.emailVerified ?? false;

  // Inscription avec email et mot de passe
  Future<Map<String, dynamic>> signUp({
    required String email,
    required String password,
  }) async {
    try {
      // Créer le compte Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        return {
          'success': false,
          'error': 'Erreur lors de la création du compte',
        };
      }

      // Envoyer l'email de vérification
      await user.sendEmailVerification();

      // Stocker les informations utilisateur dans Firestore
      try {
        await _firestore.collection('users').doc(user.uid).set({
          'email': email.trim(),
          'createdAt': FieldValue.serverTimestamp(),
          'emailVerified': false,
        });
      } catch (e) {
        // Si erreur de permissions, donner un message clair
        if (e.toString().contains('PERMISSION_DENIED') || 
            e.toString().contains('permission')) {
          return {
            'success': false,
            'error': 'Erreur de permissions Firestore.\n\n'
                'Veuillez configurer les règles de sécurité Firestore dans la console Firebase.\n\n'
                '1. Allez dans Firestore Database > Règles\n'
                '2. Copiez le contenu du fichier firestore.rules\n'
                '3. Collez-le dans l\'éditeur et publiez',
          };
        }
        rethrow;
      }

      return {
        'success': true,
        'user': user,
        'emailSent': true,
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Erreur lors de l\'inscription';
      if (e.code == 'weak-password') {
        errorMessage = 'Le mot de passe est trop faible';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'Cet email est déjà utilisé';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'L\'adresse email n\'est pas valide';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'L\'authentification par email/mot de passe n\'est pas activée. Veuillez l\'activer dans la console Firebase.';
      } else if (e.message != null && e.message!.contains('CONFIGURATION_NOT_FOUND')) {
        errorMessage = 'Firebase Authentication n\'est pas correctement configuré. Veuillez activer l\'authentification Email/Password dans la console Firebase.';
      } else {
        errorMessage = 'Erreur: ${e.code} - ${e.message ?? "Erreur inconnue"}';
      }
      return {
        'success': false,
        'error': errorMessage,
      };
    } catch (e) {
      String errorString = e.toString();
      String errorMessage = 'Erreur inattendue lors de l\'inscription';
      
      // Vérifier si c'est l'erreur de configuration Firebase
      if (errorString.contains('CONFIGURATION_NOT_FOUND') || 
          errorString.contains('configuration') ||
          errorString.contains('Recaptcha')) {
        errorMessage = 'Firebase Authentication n\'est pas correctement configuré.\n\n'
            'Veuillez :\n'
            '1. Aller sur https://console.firebase.google.com\n'
            '2. Sélectionner votre projet\n'
            '3. Aller dans Authentication > Sign-in method\n'
            '4. Activer "Email/Password"\n'
            '5. Redémarrer l\'application';
      } else {
        errorMessage = 'Erreur: $errorString';
      }
      
      return {
        'success': false,
        'error': errorMessage,
      };
    }
  }

  // Connexion avec email et mot de passe
  Future<Map<String, dynamic>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Se connecter avec Firebase Auth
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        return {
          'success': false,
          'error': 'Erreur lors de la connexion',
        };
      }

      // Recharger l'utilisateur pour obtenir l'état de vérification à jour
      await user.reload();
      final reloadedUser = _auth.currentUser;
      
      if (reloadedUser == null) {
        return {
          'success': false,
          'error': 'Erreur lors de la connexion',
        };
      }

      // Vérifier si l'email est vérifié
      if (!reloadedUser.emailVerified) {
        return {
          'success': false,
          'error': 'email_not_verified',
          'message': 'Votre email n\'a pas été vérifié. Veuillez vérifier votre boîte mail.',
        };
      }

      // Mettre à jour le statut de vérification dans Firestore
      try {
        await _firestore.collection('users').doc(user.uid).update({
          'emailVerified': true,
          'lastLogin': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        // Ignorer les erreurs de permissions pour la mise à jour (non bloquant)
        // L'utilisateur peut quand même se connecter
        debugPrint('Erreur lors de la mise à jour Firestore: $e');
      }

      return {
        'success': true,
        'user': reloadedUser,
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Erreur lors de la connexion';
      if (e.code == 'user-not-found') {
        errorMessage = 'Aucun compte trouvé avec cet email';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Mot de passe incorrect';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'L\'adresse email n\'est pas valide';
      } else if (e.code == 'user-disabled') {
        errorMessage = 'Ce compte a été désactivé';
      } else if (e.code == 'too-many-requests') {
        errorMessage = 'Trop de tentatives. Veuillez réessayer plus tard';
      } else if (e.code == 'operation-not-allowed') {
        errorMessage = 'L\'authentification par email/mot de passe n\'est pas activée. Veuillez l\'activer dans la console Firebase.';
      } else if (e.message != null && e.message!.contains('CONFIGURATION_NOT_FOUND')) {
        errorMessage = 'Firebase Authentication n\'est pas correctement configuré. Veuillez activer l\'authentification Email/Password dans la console Firebase.';
      } else {
        errorMessage = 'Erreur: ${e.code} - ${e.message ?? "Erreur inconnue"}';
      }
      return {
        'success': false,
        'error': errorMessage,
      };
    } catch (e) {
      String errorString = e.toString();
      String errorMessage = 'Erreur inattendue lors de la connexion';
      
      // Vérifier si c'est l'erreur de configuration Firebase
      if (errorString.contains('CONFIGURATION_NOT_FOUND') || 
          errorString.contains('configuration') ||
          errorString.contains('Recaptcha')) {
        errorMessage = 'Firebase Authentication n\'est pas correctement configuré.\n\n'
            'Veuillez :\n'
            '1. Aller sur https://console.firebase.google.com\n'
            '2. Sélectionner votre projet\n'
            '3. Aller dans Authentication > Sign-in method\n'
            '4. Activer "Email/Password"\n'
            '5. Redémarrer l\'application';
      } else {
        errorMessage = 'Erreur: $errorString';
      }
      
      return {
        'success': false,
        'error': errorMessage,
      };
    }
  }

  // Renvoyer l'email de vérification
  Future<Map<String, dynamic>> resendVerificationEmail() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        return {
          'success': false,
          'error': 'Aucun utilisateur connecté',
        };
      }

      if (user.emailVerified) {
        return {
          'success': false,
          'error': 'Votre email est déjà vérifié',
        };
      }

      await user.sendEmailVerification();

      return {
        'success': true,
        'message': 'Email de vérification envoyé',
      };
    } on FirebaseAuthException catch (e) {
      return {
        'success': false,
        'error': 'Erreur lors de l\'envoi: ${e.message ?? e.code}',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur inattendue: ${e.toString()}',
      };
    }
  }

  // Réinitialiser le mot de passe
  Future<Map<String, dynamic>> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return {
        'success': true,
        'message': 'Un email de réinitialisation a été envoyé',
      };
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Erreur lors de l\'envoi de l\'email';
      if (e.code == 'user-not-found') {
        errorMessage = 'Aucun compte trouvé avec cet email';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'L\'adresse email n\'est pas valide';
      }
      return {
        'success': false,
        'error': errorMessage,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Erreur inattendue: ${e.toString()}',
      };
    }
  }

  // Rafraîchir l'état de vérification de l'email
  Future<void> reloadUser() async {
    await _auth.currentUser?.reload();
  }

  // Déconnexion
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Vérifier si l'utilisateur est connecté
  bool get isSignedIn => _auth.currentUser != null;
}
