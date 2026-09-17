export class AppError extends Error {
  public statusCode: number;
  public errorCode: string;
  public details: any;
  constructor(message: string, statusCode: number, errorCode: string, details = null) {
    super(message); // Llama al constructor del Error original de JS
    this.statusCode = statusCode;
    this.errorCode = errorCode;
    this.details = details;

    // Esto asegura que sepamos exactamente en qué línea explotó
    Error.captureStackTrace(this, this.constructor);
  }
}
