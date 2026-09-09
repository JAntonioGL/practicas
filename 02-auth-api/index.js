require('dotenv').config(); //importamos directo modulo para .env
const app = require('./src/app.js'); //importamos la app
const PORT = process.env.PORT || 3000; //definimos el puerto desde el .env o default 3000
const pool = require('./config/db.js')

app.listen(PORT, () => console.log("holamundosssss")) //ponemos a escuchar la app en el puerto con un log

// Prueba de conexión al arrancar
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Error conectando a PostgreSQL:', err.message);
  } else {
    console.log('Conectado a PostgreSQL en:', res.rows[0].now);
  }
});