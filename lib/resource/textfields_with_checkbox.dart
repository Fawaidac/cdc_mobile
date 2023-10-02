import 'package:cdc_mobile/resource/colors.dart';
import 'package:cdc_mobile/resource/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldCheckbox extends StatefulWidget {
  TextEditingController controller;
  String label;
  TextInputType keyboardType;
  TextInputFormatter inputFormatters;
  bool isEnable;
  TextInputAction textInputAction;
  bool checkboxValue;
  ValueChanged<bool?> onCheckboxChanged;

  CustomTextFieldCheckbox({
    Key? key,
    required this.controller,
    required this.label,
    required this.keyboardType,
    this.isEnable = false,
    required this.inputFormatters,
    this.textInputAction = TextInputAction.done,
    required this.checkboxValue,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  State<CustomTextFieldCheckbox> createState() =>
      _CustomTextFieldCheckboxState();
}

class _CustomTextFieldCheckboxState extends State<CustomTextFieldCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            textInputAction: widget.textInputAction,
            controller: widget.controller,
            style: MyFont.poppins(fontSize: 13, color: black),
            keyboardType: widget.keyboardType,
            enabled: widget.isEnable,
            onSaved: (val) => widget.controller = val as TextEditingController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter ${widget.label}';
              }
              return null;
            },
            inputFormatters: [widget.inputFormatters],
            decoration: InputDecoration(
              hintText: widget.label,
              isDense: true,
              hintStyle: GoogleFonts.poppins(fontSize: 13),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      widget.isEnable ? Color(0xffF0F1F7) : Color(0xffF0F1F7),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              fillColor: const Color(0xFFFCFDFE),
              suffixIcon: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.padded,
                value: widget.checkboxValue,
                onChanged: widget.onCheckboxChanged,
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1, // Ketebalan border
                    color: black, // Warna border
                  ),
                  borderRadius:
                      BorderRadius.circular(10.0), // Jika ingin sudut terbulat
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
