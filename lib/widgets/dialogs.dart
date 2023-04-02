import 'package:flutter/material.dart';

class AppDialogs {
  static showConfirm(BuildContext context,
      {required String title, String? content}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: content != null ? Text(content) : null,
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: const Text("Confirm")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: const Text("Cancel")),
          ],
        );
      },
    );
  }
}
