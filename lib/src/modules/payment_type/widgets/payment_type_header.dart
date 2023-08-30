import 'package:flutter/material.dart';

import '../../../core/env/ui/widgets/base_header.dart';
import '../payment_type_contoller.dart';

class PaymentTypeHeader extends StatefulWidget {
  final PaymentTypeContoller controller;
  PaymentTypeHeader({
    super.key,
    required this.controller,
  });

  @override
  State<PaymentTypeHeader> createState() => _PaymentTypeHeaderState();
}

class _PaymentTypeHeaderState extends State<PaymentTypeHeader> {
  bool? enabled;

  @override
  Widget build(BuildContext context) {
    return BaseHeader(
      title: 'Administrar formas de pagamento',
      buttonLabel: 'Adicionar',
      buttonPressed: () {
        widget.controller.addPayment();
      },
      filterWidget: DropdownButton<bool?>(
        value: enabled,
        items: const [
          DropdownMenuItem(
            value: null,
            child: Text('Todos'),
          ),
          DropdownMenuItem(
            value: true,
            child: Text('Ativos'),
          ),
          DropdownMenuItem(
            value: false,
            child: Text('Inativos'),
          ),
        ],
        onChanged: (value) {
          setState(() {
            enabled = value;
            widget.controller.changeFilter(value);
          });
        },
      ),
    );
  }
}
