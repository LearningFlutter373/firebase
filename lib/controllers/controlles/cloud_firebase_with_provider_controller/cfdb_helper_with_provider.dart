import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CFDHelperWithProvider extends ChangeNotifier {
  final CollectionReference teachers =
  FirebaseFirestore.instance.collection('teachers');

  Future<String?> addData(String name, String phone, String email) async {
    try {
      DocumentReference documentReference = await teachers.add({
        'name': name,
        'phone': phone,
        'email': email,
      });
      String documentId = documentReference.id;
      print("User Added with ID: $documentId");
      notifyListeners(); // Notify listeners after data is added
      return documentId;
    } catch (error) {
      print("Failed to add user: $error");
      return null;
    }
  }

  Future<QuerySnapshot> getData() async {
    try {
      QuerySnapshot querySnapshot = await teachers.get();
      notifyListeners(); // Notify listeners after data is fetched
      return querySnapshot;
    } catch (error) {
      print("Failed to get data: $error");
      throw error; // Propagate the error
    }
  }
}
