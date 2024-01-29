import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class CFDHelper {
  BuildContext context;

  CFDHelper({required this.context});
  CollectionReference users = FirebaseFirestore.instance.collection('students');

  Future<String?> addData(String name, String phone) async {
    try {
      DocumentReference documentReference = await users.add({
        'name': name,
        'phone': phone,
      });
      String documentId = documentReference.id;
      print("User Added with ID: $documentId");

      return documentId;
    } catch (error) {
      print("Failed to add user: $error");
      return null;
    }
  }
}
