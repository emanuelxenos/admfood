import 'dart:developer';
import 'dart:html';

import 'package:dio/dio.dart';

import '../../core/env/exceptions/repository_exception.dart';
import '../../core/env/rest_client/custom_dio.dart';
import '../../models/payment_type_model.dart';
import './payment_type.dart';

class PaymentTypeImpl implements PaymentType {
  final CustomDio _dio;

  PaymentTypeImpl(this._dio);

  @override
  Future<List<PaymentTypeModel>> findAll(bool? enabled) async {
    try {
      final paymentResult = await _dio.auth().get(
        '/payment-types',
        queryParameters: {if (enabled != null) 'enabled': enabled},
      );

      return paymentResult.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamentos');
    }
  }

  @override
  Future<PaymentTypeModel> getById(int id) async {
    try {
      final paymentResult = await _dio.auth().get(
            '/payment-types/$id',
          );

      return PaymentTypeModel.fromMap(paymentResult.data);
    } on DioError catch (e, s) {
      log('Erro ao buscar forma de pagamento $id', error: e, stackTrace: s);
      throw RepositoryException(
          message: 'Erro ao buscar forma de pagamentos $id');
    }
  }

  @override
  Future<void> save(PaymentTypeModel model) async {
    try {
      final client = _dio.auth();

      if (model.id != null) {
        await client.auth().put(
              '/payment-types/${model.id}',
              data: model.toMap(),
            );
      } else {
        await client.auth().post(
              '/payment-types/',
              data: model.toMap(),
            );
      }
    } on DioError catch (e, s) {
      log('Erro ao salvar forma de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao salvar forma de pagamentos');
    }
  }
}
