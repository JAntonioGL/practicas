import 'dotenv/config';//importamos directo modulo para .env
import { type Request, type Response, type NextFunction } from 'express';

import { AppError } from '../utils/AppError.js';
const DevEnvironment = process.env.NODE_ENV || 'development';

// 3. Le pones el tipo a cada parámetro
export const errorHandler = (
  err: AppError | Error | any, // Puede ser tu AppError personalizado o un error general
  req: Request,
  res: Response,
  next: NextFunction
) => {
  const statusCode = err.statusCode || 500; // si trae status code si no general 500
  const errorCode = err.errorCode || 'INTERNAL_SERVER_ERROR';
  const message = err.message || 'Internal server error';
  const details = err.details || null;

  if (DevEnvironment === 'development') {
    console.error(`[💥Error ${statusCode}] ${errorCode}:`, err.stack);
  } else {
    console.error(`[💥Error ${statusCode}] ${errorCode}:`, message);
  }


  // 3. Le respondemos al usuario (Postman / Frontend) con el JSON que diseñaste
  res.status(statusCode).json({
    status: 'error',
    errorCode: errorCode,
    message: message,
    details: details
  });
}
