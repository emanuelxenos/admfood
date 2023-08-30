import 'package:flutter_modular/flutter_modular.dart';
import '../../repositories/products/product_repository_impl.dart';
import '../products/home/products_page.dart';
import 'detail/product_detail_controller.dart';
import 'detail/product_detail_page.dart';
import 'home/products_contrrole.dart';

class ProductsModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => ProductsContrrole(i())),
        Bind.lazySingleton(
          (i) => ProductDetailController(i()),
        )
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ProductsPage()),
        ChildRoute('/detail',
            child: (context, args) => ProductDetailPage(
                  productId:
                      int.tryParse(args.queryParams['id'] ?? 'não informado'),
                )),
      ];
}
