import 'package:flutter/material.dart';
class AddCFDataWidgets{
  BuildContext context;
  AddCFDataWidgets({required this.context});
  textTitle(String title,{TextStyle? style}){
    return Text(title,style: style);
  }

  textFormField({required TextEditingController? controller, required TextInputType? keyboardType, TextStyle? style,InputDecoration? decoration = const InputDecoration(),}){
    return TextFormField(controller: controller,keyboardType: keyboardType,decoration:decoration,style: style,);
  }
  addDataButton({required void Function()? onPressed,required Widget? child}){
    return ElevatedButton(onPressed: onPressed, child: child);
  }


}