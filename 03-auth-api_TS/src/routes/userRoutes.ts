import express, { Router} from 'express'; //importación del modulo express para la aplicación
import {getAllUsersDB,loginUser,registerUser} from '../controllers/userController.js'; //importación de funciones controladores para las peticiónes
import {verifyAdminKey} from '../middlewares/verifyAdminKey.js';//middleware que verifica si el endpoint requiere

const userRoutes : Router = express.Router();

userRoutes.get('/', verifyAdminKey, getAllUsersDB);//petición GET para obtener los usuarios existentes
userRoutes.post('/register', registerUser)//petición POST para guardar un usuario
userRoutes.post('/login', loginUser)//petición POST para loguear un usuario

export default userRoutes;
