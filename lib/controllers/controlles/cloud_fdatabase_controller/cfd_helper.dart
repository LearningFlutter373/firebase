import 'package:cloud_firestore/cloud_firestore.dart';

class CFDHelper {
  CollectionReference students = FirebaseFirestore.instance.collection('students');

  Future<String?> addData(String name, String phone, String email) async {
    try {
      DocumentReference documentReference = await students.add({
        'name': name,
        'phone': phone,
        'email': email,
      });
      String documentId = documentReference.id;
      print("User Added with ID: $documentId");

      return documentId;
    } catch (error) {
      print("Failed to add user: $error");
      return null;
    }
  }

  Future<QuerySnapshot> getData() {
    return students.get();
  }

  void updateData(String documentId, String name, String email, String phone) async {
    try {
      await students.doc(documentId).update({
        'name': name,
        'email': email,
        'phone': phone,
      });
      print("Document updated successfully");
    } catch (e) {
      print('Error updating data: $e');
    }
  }

   deleteData(String documentId) async {
    try {
      await students.doc(documentId).delete();
      print("Document deleted successfully");
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

}
