import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

mixin Messsages<T extends StatefulWidget> on State<T> {
  void ShowError(String message) {
    _showSnackbar(AwesomeSnackbarContent(
      title: 'Erro',
      message: message,
      contentType: ContentType.failure,
    ));
  }

  void ShowWarning(String message) {
    _showSnackbar(AwesomeSnackbarContent(
      title: 'Aviso',
      message: message,
      contentType: ContentType.warning,
    ));
  }

  void ShowInfo(String message) {
    _showSnackbar(AwesomeSnackbarContent(
      title: 'Aviso',
      message: message,
      contentType: ContentType.help,
    ));
  }

  void ShowSuccess(String message) {
    _showSnackbar(AwesomeSnackbarContent(
      title: 'Sucesso',
      message: message,
      contentType: ContentType.success,
    ));
  }

  void _showSnackbar(AwesomeSnackbarContent content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.only(top: 72),
        backgroundColor: Colors.transparent,
        content: content,
      ),
    );
  }
}
