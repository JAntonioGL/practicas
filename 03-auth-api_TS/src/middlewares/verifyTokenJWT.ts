require('dotenv');
const jwt = require('jsonwebtoken');

const AppError = require('../utils/AppError.js'); //importación del objeto para errores
const ERROR_CATALOG = require('../utils/errorCatalog.js'); //importación de la biblioteca de errores


const verifyTokenJWT = (req, res, next) => {
  const auth = req.headers.authorization || '';
  const errInfo = ERROR_CATALOG.PERMISSION_DENIED;

  // 1. Validamos que venga el encabezado correcto
  if (!auth.startsWith('Bearer ')) {
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, "Invalid token")
  }

  try {
    // Cortamos la palabra "Bearer " para quedarnos solo con el churrete de texto
    const token = auth.slice(7);
    // 2. Verificamos matemáticamente el token. Si algo falla, estalla y se va al catch.
    const payload = jwt.verify(token, process.env.JWT_SECRET)
    // 3. ¡Lo logramos! Le pegamos la info a la caja (req) para que el Controlador la use.
    req.user = payload;
    // 4. Que pase el siguiente
    next();

  } catch (err) {
    // Si jwt.verify explota (token caducado o inventado), caemos aquí
    const errInfo = ERROR_CATALOG.PERMISSION_DENIED;
    // Ojo: En un catch, usamos next(new AppError(...)) en lugar de throw
    next(new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, "Invalid or expired token"));

  }

}

module.exports = verifyTokenJWT;