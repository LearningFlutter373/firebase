import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../controllers/controlles/cloud_fdatabase_controller/cfd_helper.dart';

class UpdateData extends StatefulWidget {
  final String documentId;

  const UpdateData({Key? key, required this.documentId}) : super(key: key);

  @override
  State<UpdateData> createState() => _UpdateData();
}

class _UpdateData extends State<UpdateData> {
  var update = CFDHelper();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  bool _isLoading = true; // Track whether data is still loading

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      var documentSnapshot = await FirebaseFirestore.instance.collection('students').doc(widget.documentId).get();
      var data = documentSnapshot.data() as Map<String, dynamic>;
      nameController.text = data['name'];
      emailController.text = data['email'];
      phoneController.text = data['phone'];
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        _isLoading = false; // Set loading state to false when data fetching is complete
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Data'),
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator while data is being fetched
            : SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  updateData();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updateData() {
    String name = nameController.text;
    String email = emailController.text;
    String phone = phoneController.text;

    if (name.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
      update.updateData(widget.documentId, name, email, phone);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Data updated successfully'),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('All fields are required'),
      ));
    }
  }
}
