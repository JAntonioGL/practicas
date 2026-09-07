const { readFile, writeFile } = require('node:fs/promises')
const path = require('path');

const filePath = path.join(__dirname, '../../data/users.json');

async function getUsers() {
  try {
    const file = await readFile(filePath, 'utf8');
    console.log(file)
    return JSON.parse(file);
  }
  catch (err) {
    console.error('Failed to read file: ', err.message);
    return [];
  }
}

async function saveUsers(users) {
  try {
    const usersNew = JSON.stringify(users, null, 2);
    await writeFile(filePath, usersNew, 'utf8');
  }
  catch (err) {
    console.error('Failed to write file: ', err.message);
  }


}

module.exports = {
  getUsers,
  saveUsers
};