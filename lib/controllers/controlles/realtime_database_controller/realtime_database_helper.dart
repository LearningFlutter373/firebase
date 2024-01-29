
import 'package:firebase/view/screens/realtime_database_screens/read_data_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
class RTDBHelper {
  late BuildContext context;
  var refData =  FirebaseDatabase.instance.ref("students");
  var data = DateTime.now().microsecondsSinceEpoch;
  addData(String name, String phone) {
    refData.child(data.toString()).set({
      "id":data.toString(),
      "name":name,
      "phone":phone
    });

  }

  getData() {
    refData;
  }

  void updateData({String? id, required String name, required String phone}) {
    try {
      Map<String, dynamic> updateData = {
        'name': name,
        'phone': phone,
      };

      refData.child(id!).update(updateData).then((_) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Data updated successfully")));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ReadDataScreen()),
        );
      });
    } catch (error) {
      print("Error updating data: $error");

    }
  }

  void deleteData(String id) {
    refData.child(id).remove().then((_) {
      print("Data deleted successfully");
    });
  }
}
