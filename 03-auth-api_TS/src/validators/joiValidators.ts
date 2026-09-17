import Joi, { type ObjectSchema } from 'joi';

//funcion para validar un esquema con JOI, necesita los datos en objeto y el esquema
export function schemaValidator(data: any, schema: ObjectSchema) {
  return schema.validate(data);
}