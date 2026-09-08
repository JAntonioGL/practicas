const express = require('express'); //importamos express
const userRoutes = require('./routes/userRoutesJSON.js') //importamos las rutas de usuariosJSON
const app = express(); //definimos la app express

app.use(express.json())//middleware para que todo sea JSON en las peticiones
app.use('/api/JSON/users', userRoutes);//Definimos las rutas para usarlas con un prefijo

module.exports = app; //exportamos la app
