import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/env/ui/styles/text_styles.dart';
import '../../../models/orders/order_model.dart';
import '../order_controller.dart';

class OrderItem extends StatelessWidget {
  final OrderModel order;
  const OrderItem({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    var textStyle = context.textStyles;
    return InkWell(
      onTap: () {
        context.read<OrderController>().showDetailModel(order);
      },
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Text(
                      'Pedido',
                      style: textStyle.textBold,
                    ),
                    Text(
                      order.id.toString(),
                      style: textStyle.textExtraBold,
                    ),
                    Expanded(
                        child: Text(
                      order.status.name,
                      textAlign: TextAlign.end,
                      style: textStyle.textBold.copyWith(
                        fontSize: 20,
                        color: order.status.color,
                      ),
                    )),
                    SizedBox(
                      width: 5,
                      height: double.infinity,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
