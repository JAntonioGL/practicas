import { getUsersDb, findUserByEmailDb, pushUserDB, makeLoginDB } from '../services/userService.js'; //importación de las funciones para leer y escribir el json
import { AppError } from '../utils/errors/AppError.js'; //importación del objeto para errores
import { ERROR_CATALOG } from '../utils/errors/errorCatalog.js'; //importación de la biblioteca de errores
import bcrypt from 'bcryptjs';//importación del modulo bycript para usar encrpitación
import type { ILoginPayload, IRegistroPayload } from '../types/user/userInterfaces.js';
import { userRegisterSchema, userLoginSchema, userFindEmailSchema } from '../utils/JOI/joiSchemas.js'

//validador de datos para un regstro
export const checkDataRegister = async (payload: IRegistroPayload): Promise<void> => {
  const isError = userRegisterSchema.validate(payload).error;
  if (isError) {
    const errInfo = ERROR_CATALOG.VALIDATE_REGISTER;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, isError.message)//explotamos para mostrar el error correspondiente
  }
}

//validador para revisar si el email ya esta registrado (retorna error si existe)
export const checkEmailNotTaken = async (email: string) => {
  //revisamos la integridad de los datos con JOI

  const isError = userFindEmailSchema.validate({ email }).error;
  if (isError) {
    const errInfo = ERROR_CATALOG.VALIDATE_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, isError.message)
  }//llamada al servicio que verifica si existe el email en db, si existe explota con error personalizado
  if (await findUserByEmailDb(email)) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }
}

//validador para revisar si el email ya esta registrado (retorna error si NO existe)
export const checkEmailTaken = async (email: string) => {
  //primero verificación de los datos con JOI
  let isError = userFindEmailSchema.validate(email).error;
  if (isError) {
    const errInfo = ERROR_CATALOG.VALIDATE_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, isError.message)
  }
  //validación de existencia en la DB con error personalizado
  if (!await findUserByEmailDb(email)) {
    const errInfo = ERROR_CATALOG.USER_ALREADY_EXISTS_EMAIL;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)
  }//revisamos si el usuario ya existe if (!exists) {
}

//validador para login
export const checkDataLogin = async (payload: ILoginPayload) => {
  // 1. La Aduana: Joi revisa todo de un solo golpe (que vengan, que el formato esté bien)
  const validation = userLoginSchema.validate(payload);
  if (validation.error) {
    const errInfo = ERROR_CATALOG.VALIDATE_LOGIN;
    // Lanzamos la bomba usando el mensaje exacto que Joi generó (ej. 'Email is required')
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, validation.error.message);
  }
  // 2. Base de Datos: Verificamos si existe el usuario
  const user = await findUserByEmailDb(payload.email);
  if (!user) {
    const errInfo = ERROR_CATALOG.USER_NOT_MATCH;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details);
  }

  return user;
}

//validador de password para login
export const checkPassword = async (password: string, password_hash: string) => {
  if (!await bcrypt.compare(password, password_hash)) {
    const errInfo = ERROR_CATALOG.USER_NOT_MATCH;//tomamos del catalogo el mensaje de error correspondiente
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, errInfo.details)//explotamos para mostrar el error correspondiente
  }
}
