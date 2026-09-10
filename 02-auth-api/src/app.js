const express = require('express'); //importamos express
const userRoutesJSON = require('./routes/userRoutesJSON.js') //importamos las rutas de usuariosJSON
const userRoutes = require('./routes/userRoutes.js') //importamos las rutas de usuariosJSON
const errorHandler = require('./middlewares/errorHandler.js');

const app = express(); //definimos la app express

app.use(express.json())//middleware para que todo sea JSON en las peticiones
app.use('/api/JSON/users', userRoutesJSON);//Definimos las rutas para usarlas con un prefijo en este caso para la v0.1 de JSON
app.use('/api/users', userRoutes);//Definimos las rutas para usuarios


app.use(errorHandler); 
module.exports = app; //exportamos la app
