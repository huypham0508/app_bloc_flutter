import 'package:app_bloc_flutter/app/constants/constants.dart';

class ApiException implements Exception {
  @override
  String toString() {
    return CommonString.ERROR_MESSAGE;
  }
}
