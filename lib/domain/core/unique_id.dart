import 'package:dartz/dartz.dart';
import 'failures.dart';
import 'value_objects.dart';
import 'package:uuid/uuid.dart';

class UniqueId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UniqueId() {
    return UniqueId._(
      right(const Uuid().v1()),
    );
  }

  factory UniqueId.fromUniqueString(String input) {
    return UniqueId._(right(input));
  }
  const UniqueId._(this.value);
}
