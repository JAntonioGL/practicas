const express = require('express'); //importamos express
const userRoutesJSON = require('./routes/userRoutesJSON.js') //importamos las rutas de usuariosJSON
const userRoutes = require('./routes/userRoutesJSON.js') //importamos las rutas de usuariosJSON

const app = express(); //definimos la app express

app.use(express.json())//middleware para que todo sea JSON en las peticiones
app.use('/api/JSON/users', userRoutesJSON);//Definimos las rutas para usarlas con un prefijo en este caso para la v0.1 de JSON
app.use('/api/users', userRoutes);//Definimos las rutas para usuarios

module.exports = app; //exportamos la app
