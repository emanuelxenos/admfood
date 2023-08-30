import 'package:flutter/material.dart';

import '../../core/env/env.dart';
import '../../core/env/ui/helpers/loader.dart';
import '../../core/env/ui/helpers/messages.dart';
import '../../core/env/ui/helpers/size_extensions.dart';
import '../../core/env/ui/styles/colors_app.dart';
import '../../core/env/ui/styles/text_styles.dart';
import '../template/base_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with Loader, Messsages {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.grey[50],
        width: context.percentWidth(.5),
        height: context.percentHeight(.5),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(
                'Seja Bem-Vindo!',
                // context.screenWidth.toString(),
                style: context.textStyles.textTitle,
              ),
              Text(
                'Área restrita aos administradors, agradecemos a preferência. Clique mos botões ao lado e faça sua navegação',
                style: context.textStyles.textRegular,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
