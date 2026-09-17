import express, { type Express } from 'express';//importamos express
import userRoutesJSON from './routes/userRoutesJSON.js'; //importamos las rutas de usuariosJSON
import userRoutes from './routes/userRoutes.js';//importamos las rutas de usuariosJSON
import errorHandler from './middlewares/errorHandler.js';//middleware que captura errores

const app: Express = express(); //definimos la app express

app.use(express.json())//middleware para que todo sea JSON en las peticiones
app.use('/api/JSON/users', userRoutesJSON);//Definimos las rutas para usarlas con un prefijo en este caso para la v0.1 de JSON
app.use('/api/users', userRoutes);//Definimos las rutas para usuarios


app.use(errorHandler);//para capturar los errores con el middleware

export default app; //exportamos la app
