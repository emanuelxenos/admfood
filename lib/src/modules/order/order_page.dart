import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../core/env/ui/helpers/loader.dart';
import '../../core/env/ui/helpers/messages.dart';
import 'detail/order_detail_modal.dart';
import 'order_controller.dart';
import 'widget/order_header.dart';
import 'widget/order_item.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with Loader, Messsages {
  final controller = Modular.get<OrderController>();
  late final ReactionDisposer statusDisposer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      statusDisposer = reaction((_) => controller.status, (status) {
        switch (status) {
          case OrderStateStus.initial:
            // TODO: Handle this case.
            break;
          case OrderStateStus.lading:
            showLoader();
            break;
          case OrderStateStus.loaded:
            hideLoader();
            break;
          case OrderStateStus.error:
            hideLoader();
            ShowError(
                controller.erroMessage ?? 'Erro, tente novamente mais tarde!');
            break;
          case OrderStateStus.showDetailModal:
            hideLoader();
            showOrderDetail();
            break;
          case OrderStateStus.statusChanged:
            hideLoader();
            Navigator.of(context, rootNavigator: true).pop();
            controller.findOrders();
            break;
        }
      });
      controller.findOrders();
    });
    super.initState();
  }

  void showOrderDetail() {
    showDialog(
        context: context,
        builder: (context) {
          return OrderDetailModal(
            controller: controller,
            order: controller.orderSelected!,
          );
        });
  }

  @override
  void dispose() {
    statusDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constrains) {
        return Container(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              OrderHeader(
                controller: controller,
              ),
              const SizedBox(
                height: 50,
              ),
              Expanded(child: Observer(
                builder: (_) {
                  return GridView.builder(
                    itemCount: controller.orders.length,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      mainAxisExtent: 91,
                      maxCrossAxisExtent: 600,
                    ),
                    itemBuilder: (context, index) {
                      return OrderItem(order: controller.orders[index]);
                    },
                  );
                },
              ))
            ],
          ),
        );
      },
    );
  }
}
