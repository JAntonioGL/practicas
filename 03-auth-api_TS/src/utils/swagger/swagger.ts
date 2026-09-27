import swaggerJsdoc from "swagger-jsdoc";
import swaggerUi from "swagger-ui-express";
import { type Express } from "express";

const options = {
    definition: {
        openapi: "3.0.4",
        info: {
            title: 'Swagger Yo Verifico - OpenAPI 3.0',
            version: "1.0.0",
            description: "Esta es la documentación basada en OpenAPI para la API de  Yo Verifico.",
            termsOfService: "https://yoverifico.com.mx/terminos",
            contact: {
                email: "soporte@yoverifico.com.mx"
            },
            servers: [
                {
                    url: "https://api.yoverifico.com.mx/"
                }
            ],
        },
        components: {
            schemas: {
                AppError: {
                    type: 'object',
                    properties: {
                        statusCode: { type: 'number' },
                        message: { type: 'string' },
                        errorCode: { type: 'string' },
                        details: { type: 'object', additionalProperties: true, nullable: true }
                    }
                }
            }
        }
    },
    apis: ['./src/utils/swagger/routesFiles/*.ts'],
};

const swaggerSpec = swaggerJsdoc(options);

export const setupSwagger = (app: Express) => {
    // Creamos la ruta /api-docs y le enchufamos la interfaz gráfica usando el JSON que generamos arriba
    app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
    console.log('📄 Swagger Docs disponibles en http://localhost:3000/api-docs');
};
