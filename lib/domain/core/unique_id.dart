import 'package:dartz/dartz.dart';
import 'package:notes/domain/core/failures.dart';
import 'package:notes/domain/core/value_objects.dart';

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(
        // TODO Replace this code
        right('r'));
    // to this:
    // right(Uuid().v1())
    // and add uuid package to pubspec.yaml
  }

  factory UniqueId.fromUniqueString(String input) {
    return UniqueId._(right(input));
  }
  const UniqueId._(this.value);
}
