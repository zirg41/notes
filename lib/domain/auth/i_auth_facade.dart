import 'package:notes/domain/auth/value_objects.dart';

abstract class IAuthFacade {
  Future<void> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<void> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<void> signInWithGoogle();
}