import 'package:flutter/material.dart';

Widget BotonBase({
  required String texto,
  Color? colorFondo,
  Color? colorTexto,
  required VoidCallback presionar,
}) {
  return Expanded(
    child: Padding(
      padding: EdgeInsetsGeometry.all(4.0),
      child: SizedBox.expand(child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorFondo ?? Colors.grey[850],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: presionar,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            texto,
            style: TextStyle(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: colorTexto ?? Colors.white,
            ),
          ),
        ),
        
      ),),
    ),
  );
}
