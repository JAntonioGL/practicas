const Joi = require('joi');

const userRegisterSchema = Joi.object({
  name: Joi.string().pattern(/^[\p{L}\p{N} ]+$/u).min(3).max(30).required().messages({
    'string.base': 'Username must be a string',
    'string.empty': 'Username is required',
    'string.min': 'Username must be at least 3 characters',
    'string.max': 'Username must be at most 30 characters',
    'any.required': 'Username is required'
  }),
  email: Joi.string().email().required().messages({
    'string.email': 'Email must be valid',
    'any.required': 'Email is required'
  }),
  password: Joi.string().pattern(/^[a-zA-Z0-9\-\_\@\#\$\%\&\*\!\?\.\,]+$/).required().messages({
    'string.pattern.base': 'Password must be 6-30 characters and alphanumeric',
    'any.required': 'Password is required'
  }),
  //confirmPassword: Joi.ref('password')
});

const userLoginSchema = Joi.object({
  email: Joi.string().email().required().messages({
    'string.email': 'Email must be valid',
    'any.required': 'Email is required'
  }),
  password: Joi.string().pattern(/^[a-zA-Z0-9\-\_\@\#\$\%\&\*\!\?\.\,]+$/).required().messages({
    'string.pattern.base': 'Password must be 6-30 characters and alphanumeric',
    'any.required': 'Password is required'
  }),
});

const userFindEmailSchema = Joi.object({
  email: Joi.string().email().required().messages({
    'string.email': 'Email must be valid',
    'any.required': 'Email is required'
  })
});

module.exports = {
  userRegisterSchema,
  userLoginSchema,
  userFindEmailSchema
}