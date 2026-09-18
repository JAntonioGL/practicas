import jwt from 'jsonwebtoken';
import 'dotenv/config';
import type { IPayloadResTokenJWT } from '../types/user/userInterfaces.js';
import { getEnv, getNumberEnv } from '../validators/envValidator.js';

const JWT_SECRET = getEnv('JWT_SECRET');
const JWT_EXPIRES = getNumberEnv('JWT_EXPIRES');
//función exclusiva para generar token
export function generateAccessToken(user: IPayloadResTokenJWT): string {
  //creamos el payload y le mandamos lo que sea que queramos que traiga desde el login
  const payload = {
    id: user.id,
    correo: user.correo
  };
  //armamos el token
  const token = jwt.sign(payload, JWT_SECRET, { expiresIn: JWT_EXPIRES })
  //se envia el token como respuesta
  return token;
}
