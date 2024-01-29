import 'package:firebase/controllers/controlles/realtime_database_controller/realtime_database_helper.dart';
import 'package:flutter/material.dart';

import '../../utils/space_manage.dart';
import '../../widgets/realtime_database_widgets/add_data_widgets.dart';
class AddDataScreen extends StatefulWidget {
  final Map<String, dynamic>? record;
  bool updateStatus;
  AddDataScreen({Key? key, this.record, required this.updateStatus}) : super(key: key);


  @override
  State<AddDataScreen> createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  var data = DateTime.now().microsecondsSinceEpoch;
  var dataHelper=RTDBHelper();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  String? recordKey;

  @override
  void initState() {
    super.initState();
    if (widget.record!=null) {
      recordKey = widget.record!['id'];
      nameController.text = widget.record!['name'];
      phoneController.text = widget.record!['phone'];
    }
  }
  @override
  Widget build(BuildContext context) {
    var addDataWidget=AddDataWidgets(context: context);
    var spaceManage=SpaceMange(context: context);
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Container(
               width: spaceManage.getScreenWidth()/2,
               height:spaceManage.getScreenHeight()/10,
               color: Colors.red,
             ),
            addDataWidget.textTitle("Add Data"),
          addDataWidget.textFormField(
          controller: nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: "name"
            )
          ),
            addDataWidget.textFormField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    hintText: "phone"

                )
            ),
           SizedBox(height: 15,),
           Container(
             width: double.infinity,
             height: 40,
             child:  addDataWidget.addDataButton(onPressed: (){
               if (widget.updateStatus == false) {
                 dataHelper.addData(nameController.text, phoneController.text);

                 ScaffoldMessenger.of(context)
                     .showSnackBar(SnackBar(content: Text("Data added successfully")));
                 Navigator.pop(context);
               } else {

                 dataHelper.updateData(name:nameController.text,phone:phoneController.text,id:widget.record?['id']);
                 Navigator.pop(context);
               }
             }, child: Text(widget.updateStatus == false ? "Add" : "Update"),
           )
           )],
        ),
      ),
    ));
  }
}
