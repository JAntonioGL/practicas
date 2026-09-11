const jwt = require('jsonwebtoken');
require('dotenv')

function generateAccessToken(user) {
  const payload = {
    id: user.id,
    correo: user.correo
  };

  const token = jwt.sign(payload, process.env.JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES })

  return token;
}

module.exports = { generateAccessToken }