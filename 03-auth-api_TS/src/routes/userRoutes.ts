import express, { Router} from 'express'; //importación del modulo express para la aplicación
import {getAllUsersDB,loginUser,registerUser} from '../controllers/userController.js'; //importación de funciones controladores para las peticiónes
import {verifyAdminKey} from '../middlewares/verifyAdminKey.js';//middleware que verifica si el endpoint requiere

const userRoutes : Router = express.Router();

userRoutes.get('/', verifyAdminKey, getAllUsersDB);//petición GET para obtener los usuarios existentes

/**
 * @openapi
 * /api/users/register:
 *   post:
 *     summary: Registra un nuevo usuario en el sistema.
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required: [name, email, password]
 *             properties:
 *               name:
 *                 type: string
 *               email:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Usuario registrado exitosamente.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: string
 *                   example: success
 *                 message:
 *                   type: string
 *                   example: Usuario registrado
 *       400:
 *         description: Errores de validación de datos (JOI).
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AppError'
 *             examples:
 *               ValidateRegisterError:
 *                 summary: Faltan datos o formato incorrecto (Joi)
 *                 value:
 *                   statusCode: 400
 *                   message: "Error data."
 *                   errorCode: "VALIDATE_REGISTER"
 *                   details: "\"name\" is required"
 *               ValidateEmailError:
 *                 summary: Error específico al validar email
 *                 value:
 *                   statusCode: 400
 *                   message: "Error data."
 *                   errorCode: "VALIDATE_EMAIL"
 *                   details: "\"email\" must be a valid email"
 *       409:
 *         description: Conflicto - El usuario ya existe.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/AppError'
 *             examples:
 *               UserExists:
 *                 summary: Correo ya registrado
 *                 value:
 *                   statusCode: 409
 *                   message: "The email has been registered yet."
 *                   errorCode: "USER_ALREADY_EXISTS_EMAIL"
 *                   details: null
 */

userRoutes.post('/register', registerUser)//petición POST para guardar un usuario
userRoutes.post('/login', loginUser)//petición POST para loguear un usuario

export default userRoutes;
