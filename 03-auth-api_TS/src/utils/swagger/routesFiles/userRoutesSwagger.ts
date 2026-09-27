/**
* @openapi
* /api/users/:
*   get:
*     summary: Retorna los usuarios registrrados.
*     tags: [Users]
*     parameters:
*       - in: header
*         name: x-admin-api-key
*         required: true
*         schema:
*           type: string
*           description: API Key de administrador requerida para obtener la lista.
*     responses:
*       200:
*         description: Lista de usuarios.
*         content:
*           application/json:
*             schema:
*               type: object
*               properties:
*                 status:
*                   type: string
*                   example: success
*                 data:
*                   type: array
*                   items:
*                     type: object
*                     properties:
*                       id:
*                         type: int
*                         example: 21373
*                       nombre: 
*                         type: string
*                         example: Juan Pérez
*                       correo: 
*                         type: string
*                         format: email
*                         example: "soporte@yoverifico.com.mx"
*                       password_hash: 
*                         type: string
*                         example: $2b$10$Y6KeQiv...
*                       google_uid: 
*                         type: string
*                         example: "demo_884"
*                       fcm_token: 
*                         type: string
*                         example: "fmc_token_demo_833"
*                       creado_en: 
*                         type: string
*                         format: date-time
*                         example: "2026-09-18T09:14:27.638Z"
*                       actualizado_en:
*                         type: string
*                         format: date-time
*                         nullable: true    # Permite que venga un valor null
*                         example: null
*                       ultimo_login_en:
*                         format: date-time
*                         type: string
*                         nullable: true
*                         example: "2026-09-18T09:15:41.399Z"               
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
*                 format: email
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

/**
* @openapi
* /api/users/login:
*   post:
*     summary: "Permite el inicio se sesión a usuarios registrados"
*     tags: [Users]
*     requestBody:
*       required: true
*       content:
*         application/json:
*           schema:
*             type: object
*             required: [email, password]
*             properties:
*               email:
*                 type: string
*                 format: email
*               password:
*                 type: string
*            
*     responses:
*       200:
*         description: Usuario inicio sesión exitosamente.
*         content:
*           application/json:
*             schema:
*               type: object
*               properties:
*                 status:
*                   type: string
*                   example: success
*                 token:
*                   type: string
*                   example: 2jde209dj09j2djkokdm930
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
*                   details: "\"email\" is required"
*               ValidateEmailError:
*                 summary: Error específico al validar email
*                 value:
*                   statusCode: 400
*                   message: "Error data."
*                   errorCode: "VALIDATE_EMAIL"
*                   details: "\"email\" must be a valid email"
*       406:
*         description: Conflicto - Usuario o contraseña incorrectos.
*         content:
*           application/json:
*             schema:
*               $ref: '#/components/schemas/AppError'
*             examples:
*               EmailOrPassWrong:
*                 summary: Usuario o contraseña incorrectos
*                 value:
*                   statusCode: 406
*                   message: "Invalid email or password."
*                   errorCode: "USER_NOT_MATCH"
*                   details: "password or email wrong"
*                   
*/