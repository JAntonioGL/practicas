-- ==========================================
-- 2. CREACIÓN DE TABLAS (DDL)
-- ==========================================

CREATE TABLE usuarios (
    -- Usamos UUID para mayor seguridad en lugar de un serial predecible
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR(255) NOT NULL,
    correo VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    google_uid VARCHAR(255) UNIQUE,
    fcm_token VARCHAR(255),
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP WITH TIME ZONE,
    ultimo_login_en TIMESTAMP WITH TIME ZONE
);

-- Crear índice especial para búsquedas case-insensitive en el login
CREATE UNIQUE INDEX ux_usuarios_correo_lower ON usuarios (lower(correo));


