import 'package:flutter/material.dart';

abstract class ICustomValidator {
  FormFieldValidator<String> validator();
}