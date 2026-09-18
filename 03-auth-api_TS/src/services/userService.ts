import pool from '../../config/db.js';
import type { IUsuarioDB, IPushUsuarioDB } from '../types/user/userInterfaces.js';

//servicio para obtener todos los usuarios de la db
export const getUsersDb = async (): Promise<IUsuarioDB[]> => {
  const { rows } = await pool.query<IUsuarioDB>(`SELECT * FROM usuarios ORDER BY id`);
  return rows;
}

// servicio para buscar un usuario por email
export const findUserByEmailDb = async (email: string): Promise<IUsuarioDB | undefined> => {
  console.log("entraron a buscar en la db por email")
  // Usamos $1 como un "placeholder" de seguridad. 
  // pg se encarga de limpiarlo para que no nos hackeen.
  const { rows } = await pool.query<IUsuarioDB>(
    'SELECT * FROM usuarios WHERE correo = $1 LIMIT 1',
    [email] // El valor de email reemplazará al $1
  );

  // Si rows.length es 0, significa que no existe y regresamos null o undefined.
  // Si existe, regresamos el primer objeto (rows[0]).
  return rows[0];
}

//servicio para insertar un usuario en la DB
export const pushUserDB = async (userNew: IPushUsuarioDB): Promise<IUsuarioDB> => {
  console.log("entraron a insertar usuario")
  const { nombre, correo, password_hash, google_uid, fcm_token } = userNew;
  const { rows } = await pool.query<IUsuarioDB>(
    'INSERT INTO usuarios (nombre, correo, password_hash, google_uid, fcm_token) VALUES ($1, $2, $3, $4, $5) RETURNING *',
    [nombre, correo, password_hash, google_uid, fcm_token]
  );
  return rows[0]!;
}

//servicio para marcar un login en la DB
export const makeLoginDB = async (id: string): Promise<IUsuarioDB> => {

  const fecha: Date = new Date();
  const payload: [string, Date] = [id, fecha];
  const { rows } = await pool.query<IUsuarioDB>(
    'UPDATE usuarios SET ultimo_login_en = $2 WHERE id = $1 RETURNING *', payload
  );
  return rows[0]!;
}