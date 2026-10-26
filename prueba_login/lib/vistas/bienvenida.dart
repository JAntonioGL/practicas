import 'package:flutter/material.dart';
import 'package:prueba_login/vistas/login.dart';
import 'package:prueba_login/widgets/boton_glass.dart';

class Bienvenida extends StatelessWidget {
  final String? email;
  final String? nombre;

  const Bienvenida({
    super.key,
    this.email,
    this.nombre,
  });

  @override
  Widget build(BuildContext context) {
    final String displayName = nombre ?? email?.split('@').first ?? 'Usuario';//toma el nombre del correo si no tiene le pone usuario
    //revisa si tiene nombre si si lo coloca y sino corrobora que haya correo sino deuvelve null, y corta el correo por la mitad 
    //usando @ como separador y .first toma la primera parte , si nombre y correo son nulos deuelve Usuario como default 

    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment(0, -0.2),
            radius: 0.8,
            colors: [
              Color.fromARGB(255, 37, 120, 141),
              Color(0xFF0A0E17),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 380),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              padding: const EdgeInsets.all(28),
              // Tarjeta Glass idéntica a Login y Register
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Ícono o avatar en contenedor Glass circular con resplandor
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withValues(alpha: 0.08),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.cyanAccent.withValues(alpha: 0.25),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check_circle_outline_rounded,
                      size: 50,
                      color: Colors.cyanAccent,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Título
                  const Text(
                    '¡Bienvenido!',
                    style: TextStyle(
                      fontSize: 28.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Hola, $displayName',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.cyanAccent.withValues(alpha: 0.9),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'Has iniciado sesión con éxito en la aplicación.',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white.withValues(alpha: 0.75),
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24),

                  // Caja informativa tipo sesión
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.verified_user_outlined,
                          color: Colors.cyanAccent.withValues(alpha: 0.8),
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sesión Activa',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.9),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                              if (email != null && email!.isNotEmpty)
                                Text(
                                  email!,
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 12,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Botón Cerrar Sesión con estilo BotonGlass
                  Row(
                    children: [
                      BotonGlass(
                        texto: 'Cerrar Sesión',
                        cargando: false,
                        presionar: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                            (route) => false,
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
