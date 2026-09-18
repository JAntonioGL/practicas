export interface IErrorCatalogItem {
  statusCode: number;
  message: string;
  errorCode: string;
  details?: object | string | null; // Opcional
}