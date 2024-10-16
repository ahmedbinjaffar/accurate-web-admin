// ignore_for_file: file_names

import 'package:admin/constants/colors.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  final String title;
  final String content;
  final String confirmText;
  final String cancelText;

  const ConfirmDeleteDialog({super.key, 
    required this.onConfirm,
    this.title = 'Confirm Deletion',
    this.content = 'Are you sure you want to delete it?',
    this.confirmText = 'Yes',
    this.cancelText = 'No',
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(content),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(
            cancelText,
            style: const TextStyle(
                color: AppClr.primaryColor, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(
            confirmText,
            style: const TextStyle(
                color: AppClr.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
