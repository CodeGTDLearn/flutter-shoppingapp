import 'package:flutter/material.dart';

abstract class ValidationAbstraction {
  FormFieldValidator<String> validate();
}