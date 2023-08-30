import 'package:flutter_modular/flutter_modular.dart';

import '../../core/env/rest_client/custom_dio.dart';
import '../../core/env/storage/session_storage.dart';
import '../../core/env/storage/storage.dart';
import '../../repositories/payment_type/payment_type.dart';
import '../../repositories/payment_type/payment_type_impl.dart';
import '../../repositories/products/product_repository.dart';
import '../../repositories/products/product_repository_impl.dart';
import '../../repositories/user/user_repository.dart';
import '../../repositories/user/user_repository_impl.dart';

class CoreModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton<Storage>((i) => SessionStorage(), export: true),
        Bind.lazySingleton((i) => CustomDio(i()), export: true),
        Bind.lazySingleton<PaymentType>((i) => PaymentTypeImpl(i()),
            export: true),
        Bind.lazySingleton<ProductRepository>((i) => ProductRepositoryImpl(i()),
            export: true),
        Bind.lazySingleton<UserRepository>((i) => UserRepositoryImpl(i()),
            export: true),
      ];
}
