import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: const EdgeInsetsGeometry.all(16.0),
      child: Form(key: _formKey, child: Column(
        children: [
          Text('Bienvenido', style: TextStyle(fontSize: 24.0, color: Colors.blue, fontWeight: FontWeight.bold,),),
          const SizedBox(height: 12),
          TextFormField(initialValue: 'Texto inicial',),
        ],
      ),)
      ),
    );
  }
}

