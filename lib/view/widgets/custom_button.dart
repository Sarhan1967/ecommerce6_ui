import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;

  CustomButton(this.text, this.onPress);

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(20),
      //   color: Colors.red,
      // ),
      child: ElevatedButton(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(10.0),
            // ),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red)
                )
            )
        ),

        // style: ElevatedButton.styleFrom(
        //   primary: kPrimaryColor,
        //   elevation: 0,
        //   padding: EdgeInsets.symmetric(vertical: 5.0),
        // ),
        onPressed: onPress,
        child: CustomText(
          text: text,
          size: 25,
          weight: FontWeight.bold,
          fontColor: Colors.white,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}
