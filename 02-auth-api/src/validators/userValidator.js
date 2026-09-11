const userServices = require('../services/userService.js'); //importación de las funciones para leer y escribir el json
const AppError = require('../utils/AppError.js'); //importación del objeto para errores
const ERROR_CATALOG = require('../utils/errorCatalog.js'); //importación de la biblioteca de errores
const joiValidator = require('../validators/joiValidators.js')//importación del validador de datos 
const JOI_SCHEMAS = require('../utils/joiSchemas.js') //importación de biblioteca de respuesta para schemas para joi

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
  } else if (joiValidator.schemaValidator({ name, email, password }, JOI_SCHEMAS.userRegisterSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_REGISTER;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ name, email, password }), JOI_SCHEMAS.userRegisterSchema).error.message)
  }
}

const checkEmailNotTaken = async (email) => {

  if (joiValidator.schemaValidator({ email }, JOI_SCHEMAS.userFindEmailSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ email }), JOI_SCHEMAS.userFindEmailSchema).error.message)
  }
  if (await userServices.findUserByEmailDb(email)) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }
}

const checkEmailTaken = async (email) => {

  if (joiValidator.schemaValidator({ email }, JOI_SCHEMAS.userFindEmailSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ email }), JOI_SCHEMAS.userFindEmailSchema).error.message)
  }
  const exists = await userServices.findUserByEmailDb(email);//revisamos si el usuario ya existe if (!exists) {
  const errInfo = ERROR_CATALOG.USER_NOT_EXISTS_EMAIL;
  throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
}


const checkDataLogin = async (payload) => {
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

module.exports = {
  checkEmailNotTaken,
  checkDataRegister,
  checkEmailTaken,
  checkDataLogin
}