import 'package:flutter/material.dart';


class UserCadastro extends StatelessWidget{
  const UserCadastro({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro")
      ),
      body: const Center(
        child: Text("Cadastrar")
      ),
    );
  }
}

class UserLeitura extends StatelessWidget{
  const UserLeitura({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Listagem")
      ),
      body: const Center(
        child: Text("Listar")
      ),
    );
  }
}
