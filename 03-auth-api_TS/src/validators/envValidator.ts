import 'dotenv/config'
import { ERROR_CATALOG } from '../utils/errors/errorCatalog.js';
import { AppError } from '../utils/errors/AppError.js'; //importación del objeto para errores

export const getEnv = (llave: string): string => {
  const valor = process.env[llave];
  if (!valor) {
    const errInfo = ERROR_CATALOG.ENV_MISSING;
    // Esto tira el servidor abajo de inmediato
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, `FATAL MISSING: ${llave}`);
  }
  return valor; // Como ya pasó el 'if', TS sabe que 100% es un string
}

export const getNumberEnv = (llave: string): number => {
  const valorTexto = getEnv(llave); // Reutilizamos la función original
  const valorNumero = parseInt(valorTexto, 10);

  // ¡Aquí atrapamos si en NaN"!
  if (isNaN(valorNumero)) {
    const errInfo = ERROR_CATALOG.ENV_MISSING;
    throw new AppError(errInfo.message, errInfo.statusCode, errInfo.errorCode, `FATAL: the environment variable ${llave} ned to be a valid number`);
  }

  return valorNumero;
}