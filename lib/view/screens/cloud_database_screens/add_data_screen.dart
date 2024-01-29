import 'package:firebase/controllers/controlles/realtime_database_controller/realtime_database_helper.dart';
import 'package:firebase/view/widgets/cloud_database_widgets/add_data_widgets.dart';
import 'package:flutter/material.dart';

import '../../../controllers/controlles/cloud_fdatabase_controller/cfd_helper.dart';
import '../../utils/space_manage.dart';
import '../../widgets/realtime_database_widgets/add_data_widgets.dart';
class AddDataCFScreen extends StatefulWidget {
  bool updateStatus;
  AddDataCFScreen({Key? key, required this.updateStatus}) : super(key: key);

  @override
  State<AddDataCFScreen> createState() => _AddDataCFScreen();
}

class _AddDataCFScreen extends State<AddDataCFScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var dataHelper=CFDHelper(context: context);
    var addDataWidget=AddCFDataWidgets(context: context);
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
                  dataHelper.addData(nameController.text, phoneController.text);
                }, child: Text(widget.updateStatus == false ? "Add" : "Update"),
                )
            )],
        ),
      ),
    ));
  }
}
