const { Pool } = require('pg')

require('dotenv').config();

const pool = new Pool({
  user: process.env.POSTGRES_USER,
  database: process.env.POSTGRES_DB,
  password: process.env.POSTGRES_PASSWORD,
  host: process.env.POSTGRES_HOST,
  max: 10,
  idleTimeoutMillis: 1000,
})

module.exports = pool; 