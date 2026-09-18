import 'dotenv/config';//importamos directo modulo para .env
import { type Request, type Response, type NextFunction } from 'express';

import { AppError } from '../utils/errors/AppError.js';
const DevEnvironment = process.env.NODE_ENV || 'development';

// 3. Le pones el tipo a cada parámetro
export const errorHandler = (
  err: unknown, // Mejor práctica: No sabemos qué cayó aquí
  req: Request,
  res: Response,
  next: NextFunction
) => {
  // Inicializamos los valores por defecto asumiendo el peor escenario
  let statusCode = 500;
  let errorCode = 'INTERNAL_SERVER_ERROR';
  let message = 'Internal server error';
  let details = null;
  let stack = null;

  // --- AQUÍ EMPIEZA EL TYPE GUARD ---
  // Pasamos la caja por el escáner: ¿El error fue creado con "new AppError"?
  if (err instanceof AppError) {
    // ¡Magia! Adentro de este "if", TypeScript cambia automáticamente el tipo 
    // de "err" de "unknown" a "AppError". ¡Ya te da autocompletado!
    statusCode = err.statusCode;
    errorCode = err.errorCode;
    message = err.message;
    details = err.details;
    stack = err.stack;
  } else if (err instanceof Error) {
    // Si no fue un AppError, tal vez fue un Error nativo de JS (ej. falló una librería)
    message = err.message;
    stack = err.stack;
  }
  // --- AQUÍ TERMINA EL TYPE GUARD ---

  // El resto para imprimir e iterar se queda igual...
  if (DevEnvironment === 'development') {
    console.error(`[💥Error ${statusCode}] ${errorCode}:`, stack || err);
  } else {
    console.error(`[💥Error ${statusCode}] ${errorCode}:`, message);
  }

  res.status(statusCode).json({
    status: 'error',
    errorCode: errorCode,
    message: message,
    details: details
  });
}
