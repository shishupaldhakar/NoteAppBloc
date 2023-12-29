 import 'package:flutter/material.dart';

class UiHelper{
  static CustomTextField(TextEditingController controller, String text,IconData iconData ){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 55,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15),color: Colors.black12),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: text,
                border: const OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: Icon(iconData)

          ),
        ),
      ),
    );
  }
 }