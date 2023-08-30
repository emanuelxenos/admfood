import 'dart:developer';

import 'package:mobx/mobx.dart';

import '../../core/env/exceptions/unauthorized_exception.dart';
import '../../services/login/login_service.dart';
part 'login_controller.g.dart';

enum LoginStateStatus {
  initial,
  loading,
  success,
  error;
}

class LoginController = LoginControllerBase with _$LoginController;

abstract class LoginControllerBase with Store {
  final LoginService _loginService;

  @readonly
  var _LoginStatus = LoginStateStatus.initial;

  @readonly
  String? _errorMessage;

  LoginControllerBase(this._loginService);

  @action
  Future<void> login(String email, String password) async {
    try {
      _LoginStatus = LoginStateStatus.loading;
      await _loginService.execute(email, password);
      _LoginStatus = LoginStateStatus.success;
    } on UnauthorizedException {
      _errorMessage = 'Login ou senha invalida';
      _LoginStatus = LoginStateStatus.error;
    } catch (e, s) {
      log('Erro ao ralizar login', error: e, stackTrace: s);
      _errorMessage = 'Tente novamente mais tarde';
      _LoginStatus = LoginStateStatus.error;
    }
  }
}
