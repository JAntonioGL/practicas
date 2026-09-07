const userStorage = require('../utils/userStorage.js');
const bcrypt = require('bcryptjs');

async function getAllUsers(req, res) {
  try {
    const users = await userStorage.getUsers();
    // console.log(users)
    res.status(200).json({
      status: 'success',
      data: users
    })
  }
  catch (err) {
    res.status(500).json({
      error: "Internal error, can't procces it."
    })
    console.error(`can't proccess it`, err.message);
  }
}

async function registerUser(req, res) {
  console.log("entraron a registrar")
  const { name, email, password } = req.body;
  try {
    if (!name || !email || !password) {
      return res.status(400).json({ error: "Incomplete data" })
    }

    const users = await userStorage.getUsers();
    const exists = users.find((user) => user.correo === email);
    if (exists !== undefined) {
      return res.status(400).json({ error: "User have been register yet before" })
    }

    const hash = await bcrypt.hash(password, 10);
    const idNewUser = users.length + 1;

    const userNew = {
      id_usuario: idNewUser,
      nombre: name,
      correo: email,
      fmc_token: "fmc_token_demo_" + idNewUser,
      password_hash: hash
    };

    users.push(userNew);
    await userStorage.saveUsers(users);
    res.status(200).json({ status: "success", message: "Usuario registrado" });

  }
  catch (err) {
    res.status(500).json({
      error: "Internal error, can't procces it."
    })
    console.error(`can't proccess it`, err.message);
  }
}

module.exports = { getAllUsers, registerUser }