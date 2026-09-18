import 'dotenv/config'
import { AppError } from '../utils/errors/AppError.js'; //importación del objeto para errores
import { ERROR_CATALOG } from '../utils/errors/errorCatalog.js'; //importación de la biblioteca de errores
import { type Request, type Response, type NextFunction } from 'express'; //importamos los types por que no reconoce next
import jwt from 'jsonwebtoken';
import { getEnv } from '../validators/envValidator.js';
import type { IPayloadResTokenJWT } from '../types/user/userInterfaces.js';


const JWT_SECRET = getEnv('JWT_SECRET');
export const verifyTokenJWT = (req: Request,
  res: Response,
  next: NextFunction) => {
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
    const payload = jwt.verify(token, JWT_SECRET) as IPayloadResTokenJWT;
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
