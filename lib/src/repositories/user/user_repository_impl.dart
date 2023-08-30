import 'dart:developer';

import 'package:dio/dio.dart';

import '../../core/env/exceptions/repository_exception.dart';
import '../../core/env/rest_client/custom_dio.dart';
import '../../models/user_model.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final CustomDio _dio;

  UserRepositoryImpl(this._dio);

  @override
  Future<UserModel> getBydId(int id) async {
    try {
      final userResponse = await _dio.auth().get('/users/$id');
      return UserModel.fromMap(userResponse.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar usuário', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar usuário');
    }
  }
}
