import 'dart:ui'; // Necesario para el ImageFilter del efecto cristal

import 'package:flutter/material.dart';

class BotonGlass extends StatelessWidget {
  final String texto;
  final VoidCallback presionar;
  final bool cargando;

  const BotonGlass({
    super.key,
    required this.texto,
    required this.presionar,
    required this.cargando,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.25),
                    Colors.blueAccent.withValues(alpha: 0.10),
                  ],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.4),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withValues(alpha: 0.2),
                    blurRadius: 15,
                    spreadRadius: -2,
                  ),
                ],
              ),
              //aqui va el comportamiento del widget al tocarlo
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: cargando ? null : presionar,

                  splashColor: Colors.cyanAccent.withValues(alpha: 0.3),
                  highlightColor: Colors.white.withValues(alpha: 0.1),
                  splashFactory: InkRipple.splashFactory,

                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      //capa de contenido del boton-container
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: cargando
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : Text(
                                texto,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
