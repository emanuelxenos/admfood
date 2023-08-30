import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import 'package:flutter_modular/flutter_modular.dart';

import '../env/storage/storage.dart';

class GlobalContext {
  late final GlobalKey<NavigatorState> _navigaotrKey;

  static GlobalContext? _instance;
  // Avoid self isntance
  GlobalContext._();
  static GlobalContext get instance {
    _instance ??= GlobalContext._();
    return _instance!;
  }

  set navigatorKey(GlobalKey<NavigatorState> key) => _navigaotrKey = key;
  void loginExpire() {
    Modular.get<Storage>().clean();
    ScaffoldMessenger.of(_navigaotrKey.currentContext!).showSnackBar(SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.only(top: 72),
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Login Expirado',
        message: 'Sua seção expirou, faça login novamente',
        contentType: ContentType.warning,
      ),
    ));
    Modular.to.navigate('/login');
  }
}
