import express, { type Express, Router } from 'express';//importamos express
import userRoutes from './routes/userRoutes.js';//importamos las rutas de usuariosJSON
import { errorHandler } from './middlewares/errorHandler.js';//middleware que captura errores

const app: Express = express(); //definimos la app express
app.use(express.json())//middleware para que todo sea JSON en las peticiones
app.use('/api/users', userRoutes);//Definimos las rutas para usuarios


app.use(errorHandler);//para capturar los errores con el middleware

export default app; //exportamos la app
