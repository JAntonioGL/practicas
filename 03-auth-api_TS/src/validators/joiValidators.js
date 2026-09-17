const Joi = require('joi');

//funcion para validar un esquema con JOI, necesita los datos en objeto y el esquema
function schemaValidator(data, schema) {
  return schema.validate(data);
}

module.exports = {
  schemaValidator
}