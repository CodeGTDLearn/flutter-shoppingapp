import '../field_validators/validator_abstraction.dart';

abstract class PropertiesAbstraction {
  Map<String, dynamic> properties(
    String fieldName,
    String initialValue,
    ValidatorAbstraction fieldValidator,
  );
}
