import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
const defaultURL = 'http://localhost:8888';

String mainURL = defaultURL;

void setUrl(String newUrl){
  mainURL = newUrl;
}

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

TextFormField defaultDecimalFormField(TextEditingController textEditingController,String label){
  return TextFormField(
    keyboardType: const TextInputType.numberWithOptions(decimal: true),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
      TextInputFormatter.withFunction((oldValue, newValue) {
        try {
          final text = newValue.text;
          if (text.isNotEmpty) double.parse(text);
          return newValue;
        } catch (e) {}
        return oldValue;
      }),
    ],
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

SliverPadding sliverPaddingFloatButton(FloatingActionButton floatingActionButton){
  return SliverPadding(
      padding: const EdgeInsets.all(10),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          width: 300,
            child: floatingActionButton
        ),
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

SliverPadding sliverTextPaddingWithStyle(String labelText,TextStyle textStyle){
  return SliverPadding(
    padding: const EdgeInsets.all(10),
    sliver: SliverToBoxAdapter(
      child: Center(
        child: Text(labelText,
            style: textStyle.copyWith(letterSpacing: 1.0)),
      ),
    ),
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

SliverPadding sliverTextCardPadding(String labelText){
  return SliverPadding(
    padding: const EdgeInsets.all(10),
    sliver: SliverToBoxAdapter(
      child: Center(
        child: Card(
            child: Text(labelText)
        ),
      ),
    ),
  );
}