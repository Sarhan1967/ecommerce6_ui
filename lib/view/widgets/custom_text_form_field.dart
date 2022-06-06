import 'package:e_commerce/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_text.dart';

class CustomTextFormField extends StatefulWidget {
  final String titleText;
  final String hint;

  //final Function validate;
  final String? Function(String?)? validate;

  //final Function()? onTilePressed;
  final void Function(String?) onSave;

  //final Color hintColor;
  final Color color;

  //final bool hidePassword;
  bool hidePassword;
  final TextInputType? keyboardType;
  final String initialValue;
  final bool obscureText;

  CustomTextFormField({
    required this.titleText,
    required this.validate,
    required this.onSave,
    required this.hint,
    this.color = Colors.blueAccent,
    this.hidePassword = false,
    this.keyboardType,
    this.initialValue = '',
    this.obscureText = false,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          text: widget.titleText,
          fontColor: Colors.black,
          size: 18.0,
          alignment: Alignment.center,
        ),
        TextFormField(
          textAlign: TextAlign.center,
          validator: widget.validate,
          onSaved: widget.onSave,
          obscureText: widget.hidePassword,
          initialValue: widget.initialValue,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: Colors.blue,
                width: 2.0,
              ),
            ),
            fillColor: Colors.blueAccent,
            helperText: '',
            contentPadding: EdgeInsets.all(5.0),
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 20.0,
            ),
            suffixIcon: widget.titleText == 'Password'
                ? IconButton(
                    icon: widget.hidePassword
                        ? Icon(Icons.visibility_outlined)
                        : Icon(Icons.visibility_off_outlined),
                    onPressed: () {
                      setState(() {
                        widget.hidePassword = !widget.hidePassword;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
