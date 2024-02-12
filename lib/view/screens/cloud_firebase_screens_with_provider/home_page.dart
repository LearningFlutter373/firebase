import 'package:firebase/controllers/controlles/cloud_firebase_with_provider_controller/cfdb_helper_with_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'add_data_with_provider_screen.dart';

class ViewDataWithProvider extends StatelessWidget {


   ViewDataWithProvider({Key? key}) : super(key: key);
var helper=CFDHelperWithProvider();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddDataWithProvider()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('View Data'),
      ),
      body: Center(
        child: FutureBuilder<QuerySnapshot>(
          future: helper.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Text('No data available');
            } else {
              List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var document = documents[index];
                  return ListTile(
                    title: Text('Name: ${document['name']}'),
                    subtitle: Text('Phone: ${document['phone']}, Email: ${document['email']}'),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
