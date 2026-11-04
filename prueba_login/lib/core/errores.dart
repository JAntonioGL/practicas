/// Clase base de todos los errores de la app.
/// `sealed` = "estos son TODOS los hijos que existen, no hay más".
/// UNIONES DISCRIMINADAS , PATROM DE DISEÑO PARA ERRORES 
/// traducimos los errores técnicos de la red a tipos de datos especificos de la aplicación 
sealed class AppError implements Exception {//sealed == sellada , no se puede instanciar esta clase ,clase abstracta 
  //con implements Exception cualquier hijo de AppError califica como un error de la app
  //así podemos atrapar el error con un catch   
  const AppError();
}
class SinConexion extends AppError {
  const SinConexion();
}
class CredencialesInvalidas extends AppError {
  const CredencialesInvalidas();
}
class ErrorServidor extends AppError {
  final int codigo;
  const ErrorServidor(this.codigo);
}
class ErrorDesconocido extends AppError {
  const ErrorDesconocido();
}

class CorreoYaRegistrado extends AppError{
  const CorreoYaRegistrado();
}