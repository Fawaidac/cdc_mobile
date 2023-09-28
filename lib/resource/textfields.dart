import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String label;
  TextInputType keyboardType;
  TextInputFormatter inputFormatters;
  bool isEnable;
  bool isObscure;
  IconData icon;
  TextInputAction textInputAction;
  CustomTextField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.keyboardType,
      this.isEnable = false,
      this.isObscure = false,
      required this.inputFormatters,
      required this.icon,
      this.textInputAction = TextInputAction.done})
      : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            obscureText: widget.isObscure,
            style: MyFont.poppins(fontSize: 13, color: black),
            keyboardType: widget.keyboardType,
            enabled: widget.isEnable,
            onSaved: (val) => widget.controller = val as TextEditingController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $widget.hintName';
              }
              return null;
            },
            inputFormatters: [
              widget.inputFormatters,
            ],
            decoration: InputDecoration(
              hintText: widget.label,
              suffixIcon: Icon(
                widget.icon,
                color: grey,
              ),
              isDense: true,
              hintStyle: GoogleFonts.poppins(fontSize: 13, color: grey),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: Color(0xffC4C4C4).withOpacity(0.2),
            ),
          )
        ],
      ),
    );
  }
}
