import 'dotenv/config';//importamos directo modulo para .env
import app from './src/app.js'; //importamos la app
import pool from './config/db.js';
const PORT = process.env.PORT || 3000; //definimos el puerto desde el .env o default 3000


app.listen(PORT, () => console.log("holamundosssss")) //ponemos a escuchar la app en el puerto con un log

// Prueba de conexión al arrancar
pool.query('SELECT NOW()', (err: Error, res: any) => {
  if (err) {
    console.error('Error conectando a PostgreSQL:', err.message);
  } else {
    console.log('Conectado a PostgreSQL en:', res.rows[0].now);
  }
});