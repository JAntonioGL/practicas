const ERROR_CATALOG = {
  USER_ALREADY_EXISTS_EMAIL: {
    statusCode: 406,
    message: "The email has been registered yet.",
    errorCode: "USER_ALREADY_EXISTS_EMAIL",
  },
  USER_NOT_EXISTS_EMAIL: {
    statusCode: 406,
    message: "The email has not been registered yet.",
    errorCode: "USER_NOT_EXISTS_EMAIL",
  },
  USER_NOT_MATCH: {
    statusCode: 401,
    message: "Credentials don't match with any user",
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
  },
  VALIDATE_EMAIL: {
    statusCode: 400,
    message: "Error data.",
    errorCode: "VALIDATE_EMAIL",
  },
  VALIDATE_LOGIN: {
    statusCode: 400,
    message: "Error data.",
    errorCode: "VALIDATE_LOGIN",
  }
};

module.exports = ERROR_CATALOG;