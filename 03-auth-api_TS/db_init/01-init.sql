-- ==========================================
-- 1. CONFIGURACIÓN DE ROLES Y PERMISOS
-- ==========================================

-- Crear el grupo/rol para la API (no puede iniciar sesión)
CREATE ROLE api_group;

-- Crear el usuario real que usará Node.js para conectarse
-- OJO: En producción usarías una contraseña más segura.
CREATE USER api_user WITH PASSWORD 'api_pass_2026';

-- Meter al usuario dentro del grupo
GRANT api_group TO api_user;

-- Dar permiso para usar el esquema public
GRANT USAGE ON SCHEMA public TO api_group;

-- MAGIA: Todo lo que "postgres" (Root) cree de ahora en adelante en 'public',
-- automáticamente dará permisos CRUD al 'api_group'.
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO api_group;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT USAGE, SELECT ON SEQUENCES TO api_group;

