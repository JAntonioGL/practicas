const userServices = require('../services/userService.js'); //importación de las funciones para leer y escribir el json
const bcrypt = require('bcryptjs');//importación del modulo bycript para usar encrpitación

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
async function registerUser(req, res) {
  console.log("entraron a registrar") //log para bitacora
  const { name, email, password } = req.body; //de request tomamos los datos enviados
  try {
    if (!name || !email || !password) {
      return res.status(400).json({ error: "Incomplete data" })
    } //verificamos que esten los 3 datos requeridos

    const exists = await userServices.findUserByEmailDb(email);//revisamos si el usuario ya existe
    if (exists) {
      return res.status(400).json({ error: "User have been register yet before" }) //si el usuario existe retornamos error
    }
    //si no existe continuamos...
    const hash = await bcrypt.hash(password, 10); //usamos bcrypt para hashear el password

    const userNew = {
      nombre: name,
      correo: email,
      password_hash: hash,
      google_uid: "demo",
      fmc_token: "fmc_token_demo_"

    }; //armamos el objeto con los datos para el nuevo usuario

    await userServices.pushUserDB(userNew); //lo insertamos en la DB
    res.status(200).json({ status: "success", message: "Usuario registrado" }); //mensaje de confirmación de la petición

  }
  catch (err) {
    res.status(500).json({
      error: "Internal error, can't procces it."
    })
    console.error(`can't proccess it`, err.message); //manejo de errores en la request
  }
}

//exportación de funciones
module.exports = { getAllUsersDB, registerUser }