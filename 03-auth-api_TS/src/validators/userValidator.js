const userServices = require('../services/userService.js'); //importación de las funciones para leer y escribir el json
const AppError = require('../utils/AppError.js'); //importación del objeto para errores
const ERROR_CATALOG = require('../utils/errorCatalog.js'); //importación de la biblioteca de errores
const joiValidator = require('./joiValidators.js')//importación del validador de datos 
const JOI_SCHEMAS = require('../utils/JOI/joiSchemas.js') //importación de biblioteca de respuesta para schemas para joi
const bcrypt = require('bcryptjs');//importación del modulo bycript para usar encrpitación


//validador de datos para un regstro
const checkDataRegister = async (payload) => {
  const { email, name, password } = payload;//descomponemos el payload en las 3 variables
  if (joiValidator.schemaValidator({ name, email, password }, JOI_SCHEMAS.userRegisterSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_REGISTER;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ name, email, password }), JOI_SCHEMAS.userRegisterSchema).error.message)//explotamos para mostrar el error correspondiente
  }
}

//validador para revisar si el email ya esta registrado (retorna error si existe)
const checkEmailNotTaken = async (email) => {
  //revisamos la integridad de los datos con JOI
  if (joiValidator.schemaValidator({ email }, JOI_SCHEMAS.userFindEmailSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ email }), JOI_SCHEMAS.userFindEmailSchema).error.message)
  }//llamada al servicio que verifica si existe el email en db, si existe explota con error personalizado
  if (await userServices.findUserByEmailDb(email)) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }
}

//validador para revisar si el email ya esta registrado (retorna error si NO existe)
const checkEmailTaken = async (email) => {
  //primero verificación de los datos con JOI
  if (joiValidator.schemaValidator({ email }, JOI_SCHEMAS.userFindEmailSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ email }), JOI_SCHEMAS.userFindEmailSchema).error.message)
  }
  //validación de existencia en la DB con error personalizado
  if (!await userServices.findUserByEmailDb(email)) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }//revisamos si el usuario ya existe if (!exists) {
}

//validador para login
const checkDataLogin = async (payload) => {
  // 1. La Aduana: Joi revisa todo de un solo golpe (que vengan, que el formato esté bien)
  const validation = joiValidator.schemaValidator(payload, JOI_SCHEMAS.userLoginSchema);

  if (validation.error) {
    const errInfo = ERROR_CATALOG.VALIDATE_LOGIN;
    // Lanzamos la bomba usando el mensaje exacto que Joi generó (ej. 'Email is required')
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, validation.error.message);
  }
  // 2. Base de Datos: Verificamos si existe el usuario
  const user = await userServices.findUserByEmailDb(payload.email);
  if (!user) {
    const errInfo = ERROR_CATALOG.USER_NOT_MATCH;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details);
  }

  return user;
}

//validador de password para login
const checkPassword = async (password, password_hash) => {
  if (!await bcrypt.compare(password, password_hash)) {
    const errInfo = ERROR_CATALOG.USER_NOT_MATCH;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)//explotamos para mostrar el error correspondiente
  }
}

module.exports = {
  checkEmailNotTaken,
  checkDataRegister,
  checkEmailTaken,
  checkDataLogin,
  checkPassword
}