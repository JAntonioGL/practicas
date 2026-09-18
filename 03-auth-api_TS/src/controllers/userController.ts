import type { Request, Response, NextFunction } from "express";

import { getUsersDb, makeLoginDB, pushUserDB } from '../services/userService.js'; //importación de las funciones para leer y escribir el json
import bcrypt from "bcryptjs";//importación del modulo bycript para usar encrpitación
import { checkDataLogin, checkDataRegister, checkEmailNotTaken, checkPassword } from '../validators/userValidator.js';
import { generateAccessToken } from '../utils/jwtUtils.js';
import { } from '../utils/jwtUtils.js';
import type { IPushUsuarioDB, IRegistroPayload } from "../types/user/userInterfaces.js";


//función para obtener los usuarios 
export async function getAllUsersDB(req: Request,
  res: Response, next: NextFunction) {
  try {
    const users = await getUsersDb(); //obtenemos de la db los ususarios
    // console.log(users)
    res.status(200).json({ //respuesta para el estado de la petición
      status: 'success',
      data: users //retorna lo leido
    })
  }
  catch (err) {
    //manejo de errores para la respuesta y log
    next(err);
  }
}


//función para registrar un usuario nuevo
export async function registerUser(req: Request,
  res: Response, next: NextFunction) {
  console.log("entraron a registrar") //log para bitacora
  const payload = req.body as IRegistroPayload; //de request tomamos los datos enviados
  try {

    //verificamos que esten los 3 datos requeridos
    await checkDataRegister(payload)


    await checkEmailNotTaken(payload.email);

    //si no existe continuamos...
    const hash = await bcrypt.hash(payload.password, 10); //usamos bcrypt para hashear el password

    const userNew: IPushUsuarioDB = {
      nombre: payload.name,
      correo: payload.email,
      password_hash: hash,
      google_uid: "demo_" + Math.floor(Math.random() * (1000 - 0) + 0),
      fcm_token: ("fmc_token_demo_" + Math.floor(Math.random() * (1000 - 0) + 0)),

    }; //armamos el objeto con los datos para el nuevo usuario

    await pushUserDB(userNew); //lo insertamos en la DB
    res.status(200).json({ status: "success", message: "Usuario registrado" }); //mensaje de confirmación de la petición
  }
  catch (err) {
    next(err);
  }
}

export async function loginUser(req: Request, res: Response, next: NextFunction): Promise<void> {

  try {
    // 1. El validador revisa que traiga todo, valida JOI y busca en BD.
    // Como el validador es async, le ponemos 'await'. Cuando termine, nos regresa el usuario.
    const user = await checkDataLogin(req.body);
    // 2. Comparamos contraseñas
    await checkPassword(req.body.password, user.password_hash);

    //3. Marcamos el login en la DB
    await makeLoginDB(user.id);


    res.status(200).json({ status: "success", token: generateAccessToken(user) }); //mensaje de confirmación de la petición

  }
  catch (err) {
    next(err);
  }


}

