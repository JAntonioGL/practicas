const userServices = require('../services/userService.js'); //importación de las funciones para leer y escribir el json
const AppError = require('../utils/AppError.js'); //importación del objeto para errores
const ERROR_CATALOG = require('../utils/errorCatalog.js'); //importación de la biblioteca de errores

const checkDataRegister = async (payload) => {
  const { email, name, password } = payload;
  if (!name) {
    const errInfo = ERROR_CATALOG.MISSING_FIELD_NAMEUSER;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }
  else if (!email) {
    const errInfo = ERROR_CATALOG.MISSING_FIELD_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  } else if (!password) {
    const errInfo = ERROR_CATALOG.MISSING_FIELD_PASSWORD;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }
}

const checkEmailNotTaken = async (email) => {
  const exists = await userServices.findUserByEmailDb(email);//revisamos si el usuario ya existe
  if (exists) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }
}

module.exports = {
  checkEmailNotTaken,
  checkDataRegister
}