import 'dotenv/config'
import { AppError } from '../utils/errors/AppError.js'; //importación del objeto para errores
import { ERROR_CATALOG } from '../utils/errors/errorCatalog.js'; //importación de la biblioteca de errores
import { type Request, type Response, type NextFunction } from 'express'; //importamos los types por que no reconoce next

//función para verificar que tiene el AdminKey en la cabecera, si lo tiene verifica que coincida con el .env
export const verifyAdminKey = ( // Mejor práctica: No sabemos qué cayó aquí
  req: Request,
  res: Response,
  next: NextFunction) => {

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

