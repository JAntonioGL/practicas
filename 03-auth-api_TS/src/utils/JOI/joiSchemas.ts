import { variables } from './joiDefinitions.js';

const Joi = require('joi');

const userRegisterSchema = Joi.object({
  name: variables.name,
  email: variables.email,
  password: variables.password,
  //confirmPassword: Joi.ref('password')
});

const userLoginSchema = Joi.object({
  email: variables.email,
  password: variables.password,
});

const userFindEmailSchema = Joi.object({
  email: variables.email
});

export const JOI_SCHEMAS = { userRegisterSchema, userLoginSchema, userFindEmailSchema }