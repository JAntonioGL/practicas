require('dotenv').config();
const AppError = require('../utils/AppError.js'); //importación del objeto para errores
const ERROR_CATALOG = require('../utils/errorCatalog.js'); //importación de la biblioteca de errores

//función para verificar que tiene el AdminKey en la cabecera, si lo tiene verifica que coincida con el .env
const verifyAdminKey = (req, res, next) => {
  const key = req.headers['x-admin-api-key']; //cabecera requerida
  if (!key) { //no la trae explota
    const errInfo = ERROR_CATALOG.PERMISSION_DENIED;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo);
  } else if (key !== (process.env.ADMIN_API_KEY)) {//la trae pues la verificamos que coincida
    const errInfo = ERROR_CATALOG.PERMISSION_DENIED;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo);
  }
  next();//todo piola pasa
}

module.exports = verifyAdminKey;