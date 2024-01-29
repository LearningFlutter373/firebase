import 'package:firebase/controllers/controlles/realtime_database_controller/realtime_database_helper.dart';
import 'package:firebase/view/screens/realtime_database_screens/add_data_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../../utils/space_manage.dart';
import '../../widgets/realtime_database_widgets/read_data_widgets.dart';

class ReadDataScreen extends StatefulWidget {
  const ReadDataScreen({Key? key}) : super(key: key);

  @override
  State<ReadDataScreen> createState() => _ReadDataScreenState();
}

class _ReadDataScreenState extends State<ReadDataScreen> {
  List<Map<String, dynamic>> dataList = [];
  var data = DateTime.now().microsecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    var spaceManage = SpaceMange(context: context);
    var readDataWidget = ReadDataWidgits(context: context);
    var dataHelper = RTDBHelper();

    return SafeArea(
      child: Scaffold(
        floatingActionButton: readDataWidget.floatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDataScreen(updateStatus: false,)));

          },
          child: Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              readDataWidget.textTitle("Read Data"),
              Expanded(
                child: StreamBuilder(
                  stream: dataHelper.refData.onValue,
                  builder: (context, snap) {
                    if (snap.hasData) {
                      DataSnapshot dataSnapshot = snap.data!.snapshot;
                      Map<dynamic, dynamic>? values =
                      dataSnapshot.value as Map?;
                      if (values != null) {
                        dataList = values.entries
                            .map((entry) =>
                        Map<String, dynamic>.from(entry.value))
                            .toList();
                        return ListView.builder(
                          itemCount: dataList.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> record = dataList[index];
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Card(
                                child: Container(
                                  width: spaceManage.getScreenWidth(),
                                  height: spaceManage.getScreenHeight() / 10,
                                  decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: readDataWidget.textTitle("name  : ${record['name']}"),
                                    subtitle: readDataWidget.textTitle("Phone  : ${record['phone']}"),
                                    trailing: Container(
                                      width: spaceManage.getScreenWidth() / 10,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          readDataWidget.editIconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AddDataScreen(
                                                          record: record,
                                                          updateStatus:true
                                                      ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                          readDataWidget.editIconButton(
                                            onPressed: () {


                                               dataHelper.deleteData(record['id']);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('No data available'),
                        );
                      }
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
