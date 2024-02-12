import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/view/screens/cloud_database_screens/update_screen.dart';
import 'package:flutter/material.dart';
import '../../../controllers/controlles/cloud_fdatabase_controller/cfd_helper.dart';
import 'add_data_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late CFDHelper cfHelper;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    cfHelper = CFDHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDataCFScreen(updateStatus: false)),
          );
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: FutureBuilder<QuerySnapshot>(
          future: cfHelper.getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No data available'));
            } else {
              var data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  var document = data[index];
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 2, color: Colors.red),
                      ),
                      height: 150,
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(document['name'].toString()),
                          Text(document['phone'].toString()),
                          Text(document['email'].toString()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                   MaterialPageRoute(
                                     builder: (context) => UpdateData(documentId: document.id,),
                                    ),
                                 );
                                },
                              ),
                              SizedBox(width: 20),
                              IconButton(


                  icon: _isLoading ? CircularProgressIndicator() : Icon(Icons.delete),
                                onPressed: () async {
                                  setState(() {
                                    _isLoading = true; // Show loading indicator
                                  });
                                  await cfHelper.deleteData(document.id);
                                  setState(() {
                                    _isLoading = false; // Hide loading indicator once deletion is complete
                                  });
                                },
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
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
