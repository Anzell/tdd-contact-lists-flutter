import 'package:flutter/material.dart';

class NotGrantedPermissionScreen extends StatelessWidget {
  const NotGrantedPermissionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "É necessário autorizar as permissões de armazenamento local para utilizar este aplicativo.\nUtilizamos o armazenamento local para salvar os seus contatos.\nReinicie o aplicativo e tente novamente",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
