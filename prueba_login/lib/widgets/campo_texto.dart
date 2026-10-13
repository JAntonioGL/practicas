import 'package:flutter/material.dart';

class CampoTexto extends StatelessWidget{
  
  final TextEditingController controlador; 
  final String hintText;
  final bool esPassword; 
  final IconData? icono;
  final String? Function(String?)? validador; 
  
  
  const CampoTexto({super.key, required this.controlador, required this.hintText, required this.esPassword, this.icono, this.validador});

  @override
  Widget build (BuildContext context){
    return TextFormField(
      controller: controlador,
      validator: validador,
      obscureText: esPassword,
      style: const TextStyle(color: Colors.white), // Color de las letras escritas
      cursorColor: Colors.white,                   // Color de la rayita que parpadea
      
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white38),
        
        // 🎨 Fondo translúcido tipo cristal
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.08),
        
        // 🔒 El icono a la izquierda
        prefixIcon: icono != null 
            ? Icon(icono, color: Colors.white70) 
            : null,
            
        // Espaciado interno cómodo
        contentPadding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        // ⭕ Borde en reposo (cuando no se está usando)
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1.5,
          ),
        ),
        // 💡 Borde activo (cuando el usuario hace clic para escribir)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white.withValues(alpha: 0.8),
            width: 2.0,
          ),
        ),
      ),
    );
  }
} 