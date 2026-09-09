const express = require('express'); //importación del modulo express para la aplicación
const userController = require('../controllers/userController.js'); //importación de funciones controladores para las peticiónes


const router = express.Router(); //definición para las rutas en express

router.get('/', userController.getAllUsersDB);//petición GET para obtener los usuarios existentes
router.post('/register', userController.registerUser)//petición POST para guardar un usuario

module.exports = router; //exportación de las rutas