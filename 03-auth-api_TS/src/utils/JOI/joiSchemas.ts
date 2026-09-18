import type { IRegistroPayload } from '../../types/user/userInterfaces.js';
import { variables } from './joiDefinitions.js';

import Joi from 'joi';

export const userRegisterSchema = Joi.object<IRegistroPayload>({
  name: variables.name,
  email: variables.email,
  password: variables.password,
  //confirmPassword: Joi.ref('password')
});

export const userLoginSchema = Joi.object({
  email: variables.email,
  password: variables.password,
});

export const userFindEmailSchema = Joi.object({
  email: variables.email
});

