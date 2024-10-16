import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: AppClr.primaryColor,
    textColor: AppClr.whiteColor,
    fontSize: 16.0,
    toastLength:
        Toast.LENGTH_LONG, // Duration is approximately 3.5 to 4 seconds
  );

  // No need for additional delay; Fluttertoast will auto-dismiss
}

void showLoaderDialog(BuildContext context) {
  AlertDialog alert = const AlertDialog(
    content: SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(
            color: AppClr.primaryColor,
          ),
          SizedBox(height: 10.0),
          Text("Loading..."),
        ],
      ),
    ),
  );

  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
