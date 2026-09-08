const { readFile, writeFile } = require('node:fs/promises') //importación de FS con readFile y writeFile como en la documentación
const path = require('path'); //importación de modulo path para la ruta

const filePath = path.join(__dirname, '../../data/users.json'); //definimos el path con la ruta

//funcion para obtener usuarios desde json, pura logica de lectura de archivos
async function getUsers() {
  try {
    const file = await readFile(filePath, 'utf8'); //almacena el json en utf8 string
    console.log("read users.json") //nomas pa notificar que se leyó el json
    return JSON.parse(file);//parsea el string a un objeto json y lo retorna
  }
  catch (err) {
    console.error('Failed to read file: ', err.message);//mensaje de error
    return [];
  }
}

//funcion para guardar un usuario en el json, recibe el string completo con el nuevo usuario agregado
async function saveUsers(users) {
  try {
    const usersNew = JSON.stringify(users, null, 2); //convierte a string al objeto  json
    await writeFile(filePath, usersNew, 'utf8'); //escribe o sobre escribe el json
  }
  catch (err) {
    console.error('Failed to write file: ', err.message);//mensaje de error
  }


}

//exportación de las funciones en el modulo exports
module.exports = {
  getUsers,
  saveUsers
};