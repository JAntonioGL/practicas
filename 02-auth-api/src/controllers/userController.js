const userServices = require('../services/userService.js'); //importación de las funciones para leer y escribir el json
const bcrypt = require('bcryptjs');//importación del modulo bycript para usar encrpitación
const userValidationsErrors = require('../validators/userValidator.js')
//función para obtener los usuarios 
async function getAllUsersDB(req, res) {
  try {
    const users = await userServices.getUsersDb(); //obtenemos de la db los ususarios
    // console.log(users)
    res.status(200).json({ //respuesta para el estado de la petición
      status: 'success',
      data: users //retorna lo leido
    })
  }
  catch (err) {
    //manejo de errores para la respuesta y log
    res.status(500).json({
      error: "Internal error, can't procces it."
    })
    console.error(`can't proccess it`, err.message);
  }
}


//función para registrar un usuario nuevo
async function registerUser(req, res, next) {
  console.log("entraron a registrar") //log para bitacora
  const { name, email, password } = req.body; //de request tomamos los datos enviados
  try {

    await userValidationsErrors.checkDataRegister(req.body)
    //verificamos que esten los 3 datos requeridos

    await userValidationsErrors.checkEmailNotTaken(email);

    //si no existe continuamos...
    const hash = await bcrypt.hash(password, 10); //usamos bcrypt para hashear el password

    const userNew = {
      nombre: name,
      correo: email,
      password_hash: hash,
      google_uid: "demo_" + Math.floor(Math.random() * (1000 - 0) + 0),
      fmc_token: "fmc_token_demo_" + Math.floor(Math.random() * (1000 - 0) + 0)

    }; //armamos el objeto con los datos para el nuevo usuario

    await userServices.pushUserDB(userNew); //lo insertamos en la DB
    res.status(200).json({ status: "success", message: "Usuario registrado" }); //mensaje de confirmación de la petición
  }
  catch (err) {
    next(err);
  }
}

async function loginUser(req, res, next) {
  const { email, password } = req.body;

}

//exportación de funciones
module.exports = { getAllUsersDB, registerUser }