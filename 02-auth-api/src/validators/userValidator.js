const userServices = require('../services/userService.js'); //importación de las funciones para leer y escribir el json
const AppError = require('../utils/AppError.js'); //importación del objeto para errores
const ERROR_CATALOG = require('../utils/errorCatalog.js'); //importación de la biblioteca de errores
const joiValidator = require('../validators/joiValidators.js')//importación del validador de datos 
const JOI_SCHEMAS = require('../utils/JOI/joiSchemas.js') //importación de biblioteca de respuesta para schemas para joi

//funcion para agregar usuario al registro
const checkDataRegister = async (payload) => {
  const { email, name, password } = payload;//descomponemos el payload en las 3 variables
  if (!name) {//si no viene el nombre
    const errInfo = ERROR_CATALOG.MISSING_FIELD_NAMEUSER;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)//explotamos para mostrar el error correspondiente
  }
  else if (!email) {//si no viene el email
    const errInfo = ERROR_CATALOG.MISSING_FIELD_EMAIL;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)//explotamos para mostrar el error correspondiente
  } else if (!password) {//si no viene el password
    const errInfo = ERROR_CATALOG.MISSING_FIELD_PASSWORD;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)//explotamos para mostrar el error correspondiente
  }// agregamos verificación con JOI, incluyendo biblioteca y schemas 
  else if (joiValidator.schemaValidator({ name, email, password }, JOI_SCHEMAS.userRegisterSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_REGISTER;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ name, email, password }), JOI_SCHEMAS.userRegisterSchema).error.message)//explotamos para mostrar el error correspondiente
  }
}

//función para revisar si el email ya esta registrado (retorna error si existe)
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

//función para revisar que el email ya esta registrado (retorna error de datos si no existe)
const checkEmailTaken = async (email) => {
  //primero verificación de los datos con JOI
  if (joiValidator.schemaValidator({ email }, JOI_SCHEMAS.userFindEmailSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ email }), JOI_SCHEMAS.userFindEmailSchema).error.message)
  }
  //validación de existencia en la DB con error personalizado
  else if (!await userServices.findUserByEmailDb(email)) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }//revisamos si el usuario ya existe if (!exists) {

}

//validador para login
const checkDataLogin = async (payload) => {
  const { email, password } = payload;
  if (!email) {//no viene email con error personalizado
    const errInfo = ERROR_CATALOG.MISSING_FIELD_EMAIL;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)//explotamos para mostrar el error correspondiente
  } else if (!password) {//si no viene el password
    const errInfo = ERROR_CATALOG.MISSING_FIELD_PASSWORD;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)//explotamos para mostrar el error correspondiente
  }// agregamos verificación con JOI, incluyendo biblioteca y schemas 
  else if (joiValidator.schemaValidator({ name, email, password }, JOI_SCHEMAS.userRegisterSchema).error) {
    const errInfo = ERROR_CATALOG.VALIDATE_REGISTER;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, joiValidator.schemaValidator(({ name, email, password }), JOI_SCHEMAS.userRegisterSchema).error.message)//explotamos para mostrar el error correspondiente
  } else if (!await userServices.findUserByEmailDb(email)) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }
}

module.exports = {
  checkEmailNotTaken,
  checkDataRegister,
  checkEmailTaken,
  checkDataLogin
}