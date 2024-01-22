import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void _showToast(BuildContext context, String msg, ToastificationType type, IconData icon) {
  toastification.dismissAll();

  toastification.show(
    context: context,
    title: Text(msg),
    icon: Icon(icon),
    autoCloseDuration: const Duration(seconds: 3),
    type: type,
    style: ToastificationStyle.fillColored,
    alignment: Alignment.bottomCenter,
  );
}

void showSuccessToast(BuildContext context, msg) {
  _showToast(context, msg, ToastificationType.success, Icons.check_circle);
}

void showErrorToast(BuildContext context, msg) {
  _showToast(context, msg, ToastificationType.error, Icons.error);
}

void showWarningToast(BuildContext context, msg) {
  _showToast(context, msg, ToastificationType.warning, Icons.warning);
}

void showSnackBar(BuildContext context, msg) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  var snackBar = SnackBar(
    content: Text(msg),
    duration: const Duration(seconds: 3),
    showCloseIcon: true,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
