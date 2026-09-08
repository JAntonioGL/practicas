require('dotenv').config(); //importamos directo modulo para .env
const app = require('./src/app.js'); //importamos la app
const PORT = process.env.PORT || 3000; //definimos el puerto desde el .env o default 3000


app.listen(PORT, () => console.log("holamundosssss")) //ponemos a escuchar la app en el puerto con un log