import 'package:freezed_annotation/freezed_annotation.dart';
import '../core/unique_id.dart';

part 'user.freezed.dart';

@freezed
abstract class User with _$User {
  const factory User(UniqueId id) = _User;
}
