import type { IPayloadResTokenJWT } from './user/userInterfaces.js';

// Esto le dice a TypeScript que vamos a modificar variables globales del sistema
declare global {
  namespace Express {
    // Abrimos la caja original de Request y le agregamos nuestra propiedad opcional (?)
    interface Request {
      user?: IPayloadResTokenJWT;
    }
  }
}
