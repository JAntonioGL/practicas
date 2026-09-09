const pool = require('../../config/db.js');

const getUsersDb = async () => {
  const { rows } = await pool.query(`SELECT * FROM usuarios ORDER BY id`);
  return rows;
}
// Agregamos el parámetro 'email' que queremos buscar
const findUserByEmailDb = async (email) => {
  console.log("entraron a buscar en la db por email")
  // Usamos $1 como un "placeholder" de seguridad. 
  // pg se encarga de limpiarlo para que no nos hackeen.
  const { rows } = await pool.query(
    'SELECT * FROM usuarios WHERE correo = $1 LIMIT 1',
    [email] // El valor de email reemplazará al $1
  );

  // Si rows.length es 0, significa que no existe y regresamos null o undefined.
  // Si existe, regresamos el primer objeto (rows[0]).
  return rows[0];
}

const pushUserDB = async (userNew) => {
  console.log("entraron a insertar usuario")
  const { nombre, correo, password_hash, google_uid, fcm_token } = userNew;
  const { rows } = await pool.query(
    'INSERT INTO usuarios (nombre, correo, password_hash, google_uid, fcm_token) VALUES ($1, $2, $3, $4, $5) RETURNING *',
    [nombre, correo, password_hash, google_uid, fcm_token]
  );
  return rows[0];
}


module.exports = {
  getUsersDb,
  findUserByEmailDb,
  pushUserDB
}