import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
const mainURL = 'http://localhost:8888';

InputDecoration inputDefaultDecoration(String label){
  return InputDecoration(
    labelText: label,
    border: const OutlineInputBorder()
  );
}

TextFormField defaultTextFormField(TextEditingController textEditingController,String label){
  return TextFormField(
    keyboardType: TextInputType.text,
    controller: textEditingController,
    decoration: inputDefaultDecoration(label),
    validator: (value){
      if(value == null || value.isEmpty){
        return 'Preencha o campo';
      }
      return null;
    },
  );
}
TextFormField defaultNumberFormField(TextEditingController textEditingController,String label){
  return TextFormField(
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.digitsOnly,
    ],
    keyboardType: TextInputType.number,
    controller: textEditingController,
    decoration: inputDefaultDecoration(label),
    validator: (value){
      if(value == null || value.isEmpty){
        return 'Campo vazio';
      }
      return null;
    },
  );
}

class DefaultDatePicker extends StatefulWidget{
  final TextEditingController textEditingController;
  final String labelText;
  const DefaultDatePicker({required this.textEditingController,required this.labelText});

  @override
  State<DefaultDatePicker> createState() => DefaultDatePickerState();
}

class DefaultDatePickerState extends State<DefaultDatePicker>{
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textEditingController,
      decoration: InputDecoration(
          icon:const Icon(Icons.calendar_month_outlined),
          labelText: widget.labelText
      ),
      readOnly: true,
      onTap:()async{
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100));

        if(pickedDate != null){
          String formattedDate = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS').format(pickedDate);
          setState(() {
            widget.textEditingController.text = formattedDate;
          });
        }
        else{}
      },
    );
  }
}

SliverPadding sliverDivider(){
  return const SliverPadding(padding: EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: Divider(),
      )
  );
}

SliverPadding sliverPaddingFormField(TextFormField textFormField){
  return SliverPadding(
    padding: const EdgeInsets.all(10),
    sliver: SliverToBoxAdapter(
      child: textFormField,
    )
  );
}


SliverPadding sliverTextPadding(String labelText){
  return SliverPadding(
      padding: const EdgeInsets.all(10),
    sliver: SliverToBoxAdapter(
      child: Center(
        child: Text(labelText),
      ),
    ),
  );
}



PopupMenuButton crudButtonMenu(){
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return const[
        PopupMenuItem(child: Icon(Icons.info_outline)),
        PopupMenuItem(child: Icon(Icons.edit)),
        PopupMenuItem(child: Icon(Icons.delete_outline))
      ];
    },
  );
}