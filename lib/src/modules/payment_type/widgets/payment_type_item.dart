import 'package:flutter/material.dart';

import '../../../core/env/ui/styles/colors_app.dart';
import '../../../core/env/ui/styles/text_styles.dart';
import '../../../models/payment_type_model.dart';
import '../payment_type_contoller.dart';

class PaymentTypeItem extends StatelessWidget {
  final PaymentTypeContoller controller;
  final PaymentTypeModel payemnt;

  const PaymentTypeItem(
      {super.key, required this.payemnt, required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorAll = payemnt.enabled ? Colors.black : Colors.grey;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/icons/payment_${payemnt.acronym}_icon.png',
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "assets/images/icons/payment_notfound_icon.png",
                  color: colorAll,
                );
              },
              color: colorAll,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                    child: Text(
                      'Forma de pagamento',
                      style: context.textStyles.textRegular
                          .copyWith(color: colorAll),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FittedBox(
                    child: Text(
                      payemnt.name,
                      style: context.textStyles.textTitle
                          .copyWith(color: colorAll),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    controller.editPayment(payemnt);
                  },
                  child: Text(
                    'Editar',
                    style: context.textStyles.textMedium.copyWith(
                      color: payemnt.enabled
                          ? context.colors.primary
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
