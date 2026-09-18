//archivo para definir los parametros de las variables y no tener tanto codigo repetido

import Joi from 'joi';


const name = Joi.string().pattern(/^[\p{L}\p{N} ]+$/u).min(3).max(30).required().messages({
  'string.base': 'Username must be a string',
  'string.empty': 'Username is required',
  'string.min': 'Username must be at least 3 characters',
  'string.max': 'Username must be at most 30 characters',
  'any.required': 'Username is required'
});

const email = Joi.string().email().required().messages({
  'string.email': 'Email must be valid',
  'any.required': 'Email is required'
});

const password = Joi.string().pattern(/^[a-zA-Z0-9\-\_\@\#\$\%\&\*\!\?\.\,]+$/).required().messages({
  'string.pattern.base': 'Password must be 6-30 characters and alphanumeric',
  'any.required': 'Password is required'
});


export const variables = { name, email, password }