const Joi = require('joi');

function schemaValidator(data, schema) {
  return schema.validate(data);
}

module.exports = {
  schemaValidator
}