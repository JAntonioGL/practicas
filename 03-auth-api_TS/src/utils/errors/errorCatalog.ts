import type { IErrorCatalogItem } from "../../types/errors/errorsInterfaces.js";

//usamos el catalogo como en la version vieja pero al final del objeto usamos satisfies que fusiona la inferencia de TS + Record
export const ERROR_CATALOG = {
  USER_ALREADY_EXISTS_EMAIL: {
    statusCode: 409,
    message: "The email has been registered yet.",
    errorCode: "USER_ALREADY_EXISTS_EMAIL",
    details: null
  },
  USER_NOT_FIND: {
    statusCode: 406,
    message: "Invalid email or password.",
    errorCode: "USER_NOT_FIND",
    details: {
      field: "password or email wrong"
    }
  },
  USER_NOT_MATCH: {
    statusCode: 406,
    message: "Invalid email or password.",
    errorCode: "USER_NOT_MATCH",
    details: {
      field: "password or email wrong"
    }
  },
  MISSING_FIELD_EMAIL: {
    statusCode: 400,
    message: "Missing data to complete.",
    errorCode: "MISSING_FIELD_EMAIL",
    details: {
      field: "email"
    }
  },
  MISSING_FIELD_NAMEUSER: {
    statusCode: 400,
    message: "Missing data to complete.",
    errorCode: "MISSING_FIELD_NAMEUSER",
    details: {
      field: "name"
    }
  },
  MISSING_FIELD_PASSWORD: {
    statusCode: 400,
    message: "Missing data to complete.",
    errorCode: "MISSING_FIELD_PASSWORD",
    details: {
      field: "password"
    }
  },
  VALIDATE_REGISTER: {
    statusCode: 400,
    message: "Error data.",
    errorCode: "VALIDATE_REGISTER",
    details: null
  },
  VALIDATE_EMAIL: {
    statusCode: 400,
    message: "Error data.",
    errorCode: "VALIDATE_EMAIL",
    details: null
  },
  VALIDATE_LOGIN: {
    statusCode: 400,
    message: "Error data.",
    errorCode: "VALIDATE_LOGIN",
    details: null
  },
  PERMISSION_DENIED: {
    statusCode: 403,
    message: "Unauthorized.",
    errorCode: "PERMISSION_DENIED",
    details: null
  },
  DATA_BASE_ERROR: {
    statusCode: 500,
    message: "Database error",
    errorCode: "DATA_BASE_ERROR",
    details: null
  },
  ENV_MISSING: {
    statusCode: 500,
    message: "System error",
    errorCode: "ENV_MISSING",
    details: "check environment variables"
  }
} satisfies Record<string, IErrorCatalogItem>; //aqui esta defunido que puede ser cualquier string pero con la interface de errores
