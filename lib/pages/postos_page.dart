import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/postos_controller.dart';

class PostoPage extends StatefulWidget {
  const PostoPage({super.key});

  @override
  PostoPageState createState() => PostoPageState();
}

class PostoPageState extends State<PostoPage> {
  @override
  Widget build(BuildContext context) {
    // Adicione o código para construir a página aqui
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Meu Local'),
      ),
      body: Center(
        child: ChangeNotifierProvider<PostoController>(
          create: (context) => PostoController(),
          child: Builder(
            builder: (context) {
              final local = Provider.of<PostoController>(context);

              String mensagem = local.erro == ''
                  ? 'Latitude: ${local.lat}\n | Longitude: ${local.long}'
                  : local.erro;
              return Center(
                child: Text(mensagem),
              );
            },
          ),
        ),
      ),
    );
  }
}
