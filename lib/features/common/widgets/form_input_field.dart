import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

String globalEmail = '';

class FormInputField extends StatefulWidget{
  final String labelText;
  final controller;
  final keyboardType;
  final height;
  final obscureText;


  const FormInputField({super.key, required this.labelText, this.controller, this.keyboardType, this.height, this.obscureText});

  @override
  State<FormInputField> createState() => _FormInputFieldState();
}

class _FormInputFieldState extends State<FormInputField> {
  bool _hasFocus = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height * 0.06,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextFormField(
        onChanged: (value) {
          globalEmail = value;
        },
        onTap: () {
          setState(() {
            _hasFocus = true;
          });
        },
        onEditingComplete: () {
          setState(() {
            _hasFocus = false;
          });
        },
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 16,
          color: Color(0xFF1A1A1A),
        ),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: _hasFocus ? 12 : 14,
              color: const Color(0xFF808080)
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 24.0),
        ),
        keyboardType: widget.keyboardType,
        maxLines: 1,
      ),
    );



  }
}