import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

class LotoFirebaseDatabase {
  final DatabaseReference refData;
  final DatabaseReference refUsers;

  LotoFirebaseDatabase({
    required this.refData,
    required this.refUsers,
  });

  Future listenData(Function(DatabaseEvent event) onListener) async {
    return refData.onValue.listen((event) => onListener(event));
  }

  Future listenUsers(Function(DatabaseEvent event) onListener) async {
    return refUsers.onValue.listen((event) => onListener(event));
  }

  Future updateUserName(String userName, List oldData) async {
    String newListUsers = jsonEncode(oldData..add(userName));
    return refUsers.set(newListUsers);
  }
}
