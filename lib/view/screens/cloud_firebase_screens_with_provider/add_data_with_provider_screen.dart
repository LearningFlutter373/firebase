
import 'package:firebase/controllers/controlles/cloud_firebase_with_provider_controller/cfdb_helper_with_provider.dart';
import 'package:flutter/material.dart';

import '../../utils/space_manage.dart';
import '../../widgets/cloud_database_widgets/add_data_widgets.dart';

class AddDataWithProvider extends StatefulWidget {
  AddDataWithProvider({Key? key}) : super(key: key);

  @override
  State<AddDataWithProvider> createState() => _AddDataWithProvider();
}

class _AddDataWithProvider extends State<AddDataWithProvider> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var dataHelper=CFDHelperWithProvider();
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
            addDataWidget.textFormField(
                controller: emailController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                    hintText: "email"

                )
            ),
            SizedBox(height: 15,),
            Container(
                width: double.infinity,
                height: 40,
                child:  addDataWidget.addDataButton(onPressed: (){
                  dataHelper.addData(nameController.text, phoneController.text,emailController.text);
Navigator.pop(context);
                }, child: Text( "Add"),
                )
            )],
        ),
      ),
    ));
  }
}
