const jwt = require('jsonwebtoken');//importacion de biblioteca para jwt
require('dotenv') //importación de .env

//función exclusiva para generar token
function generateAccessToken(user) {
  //creamos el payload y le mandamos lo que sea que queramos que traiga desde el login
  const payload = {
    id: user.id,
    correo: user.correo
  };

  //armamos el token
  const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES })
  //se envia el token como respuesta
  return token;
}

module.exports = { generateAccessToken }