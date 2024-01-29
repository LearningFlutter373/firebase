import 'package:flutter/material.dart';

class ReadDataWidgits{
  BuildContext context;
  ReadDataWidgits({required this.context});

  textTitle(String title,{TextStyle? style}){
    return Text(title,style: style);
  }
  floatingActionButton({required void Function()? onPressed,Widget? child}){
    return FloatingActionButton(onPressed:onPressed ,child: child,);
  }
  deleteIconButton({required void Function()? onPressed,required Widget icon}){
    return IconButton(onPressed:onPressed ,icon: icon,);
  }
  editIconButton({required void Function()? onPressed,required Widget icon}){
    return IconButton(onPressed:onPressed ,icon: icon,);
  }
}