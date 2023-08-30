import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/env/ui/helpers/size_extensions.dart';
import '../../../../core/env/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../../payment_type_contoller.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeContoller contoller;
  final PaymentTypeModel? model;

  const PaymentTypeFormModal(
      {super.key, required this.model, required this.contoller});

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final acronymEC = TextEditingController();
  var enabled = false;
  void _closeModal() => Navigator.of(context).pop();

  @override
  void initState() {
    final paymentModel = widget.model;
    if (paymentModel != null) {
      nameEC.text = paymentModel.name;
      acronymEC.text = paymentModel.acronym;
      enabled = paymentModel.enabled;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    acronymEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screeWidth = context.screenWidth;

    return SingleChildScrollView(
      child: Container(
        width: screeWidth * (screeWidth > 1200 ? .5 : .7),
        padding: const EdgeInsets.all(30),
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.model == null ? 'Adicionar' : 'Editar'} forma de pagamento',
                        textAlign: TextAlign.center,
                        style: context.textStyles.textTitle,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: _closeModal,
                        child: const Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome Origatório'),
                  decoration: const InputDecoration(
                    label: Text("Nome"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: acronymEC,
                  validator: Validatorless.required('Sigla Origatória'),
                  decoration: const InputDecoration(
                    label: Text("Sigla"),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Nome"),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      'Ativo',
                      style: context.textStyles.textRegular,
                    ),
                    Switch(
                      value: enabled,
                      onChanged: (value) {
                        setState(() {
                          enabled = value;
                        });
                      },
                    )
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 60,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        onPressed: _closeModal,
                        child: Text(
                          'Cancelar',
                          style: context.textStyles.textExtraBold.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: 60,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final valid =
                              formKey.currentState?.validate() ?? false;
                          if (valid) {
                            final name = nameEC.text;
                            final acronym = acronymEC.text;
                            widget.contoller.savePayment(
                                id: widget.model?.id,
                                name: name,
                                acronym: acronym,
                                enabled: enabled);
                          }
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Salvar'),
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}