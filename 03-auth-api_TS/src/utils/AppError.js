class AppError extends Error {
  constructor(message, statusCode, errorCode, details = null) {
    super(message); // Llama al constructor del Error original de JS
    this.statusCode = statusCode;
    this.errorCode = errorCode;
    this.details = details;
    
    // Esto asegura que sepamos exactamente en qué línea explotó
    Error.captureStackTrace(this, this.constructor);
  }
}
module.exports = AppError;