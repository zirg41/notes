import 'package:firebase_auth/firebase_auth.dart' as firebase_user;

import '../../domain/auth/user.dart' as domain_user;
import '../../domain/core/unique_id.dart';

extension FirebaseUserX on firebase_user.User {
  domain_user.User toDomain() {
    return domain_user.User(UniqueId.fromUniqueString(uid));
  }
}
