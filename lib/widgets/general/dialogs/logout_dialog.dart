import 'package:first_flutter_project/widgets/general/custom_text.dart';
import 'package:flutter/material.dart';

Future<void> showLogoutDialog(BuildContext context, 
  VoidCallback onConfirm, Color backgroundColor,) 
  {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundColor,
        content: const CustomText(
          title: 'Are you sure?',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          textColor: Colors.white,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const CustomText(
              title: 'Cancel',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              textColor: Colors.white,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onConfirm();
            },
            child: const CustomText(
              title: 'Logout',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              textColor: Colors.redAccent,
            ),
          ),
        ],
      );
    },
  );
}
