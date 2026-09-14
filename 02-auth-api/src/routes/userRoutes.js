const express = require('express'); //importación del modulo express para la aplicación
const userController = require('../controllers/userController.js'); //importación de funciones controladores para las peticiónes
const verifyAdminKey = require('../middlewares/verifyAdminKey.js')//middleware que verifica si el endpoint requiere

const router = express.Router(); //definición para las rutas en express

router.get('/', verifyAdminKey, userController.getAllUsersDB);//petición GET para obtener los usuarios existentes
router.post('/register', userController.registerUser)//petición POST para guardar un usuario
router.post('/login', userController.loginUser)//petición POST para loguear un usuario
module.exports = router; //exportación de las rutas