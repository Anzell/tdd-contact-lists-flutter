import 'package:flutter/material.dart';

class NotGrantedPermissionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "É necessário autorizar as permissões de armazenamento para utilizar este aplicativo.\nUtilizamos o armazenamento local para salvar os seus contatos.\nReinicie o aplicativo e tente novamente",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
