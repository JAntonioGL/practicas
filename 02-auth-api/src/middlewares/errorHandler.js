require('dotenv').config();

const DevEnvironment = process.env.NODE_ENV || 'development';

const errorHandler = (err, req, res, next) => {
  const statusCode = err.statusCode || 500; // si trae status code si no general 500
  const errorCode = err.errorCode || 'INTERNAL_SERVER_ERROR';
  const message = err.message || 'Internal server error';
  const details = err.details || null;

  if (DevEnvironment === 'development') {
    console.error(`[💥Error ${statusCode}] ${errorCode}:`, err.stack);
  } else {
    console.error(`[💥Error ${statusCode}] ${errorCode}:`, message);
  }


  // 3. Le respondemos al usuario (Postman / Frontend) con el JSON que diseñaste
  res.status(statusCode).json({
    status: 'error',
    errorCode: errorCode,
    message: message,
    details: details
  });
}

module.exports = errorHandler;