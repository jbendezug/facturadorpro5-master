-- Tablas del sistema para hyn/multi-tenant
-- Creadas antes de las migraciones para evitar errores de bootstrap

CREATE TABLE IF NOT EXISTS websites (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    uuid VARCHAR(255) UNIQUE NOT NULL,
    managed_by_database_connection VARCHAR(255) NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS hostnames (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fqdn VARCHAR(255) UNIQUE NOT NULL,
    redirect_to VARCHAR(255) NULL,
    force_https TINYINT(1) DEFAULT 0,
    under_maintenance_since TIMESTAMP NULL,
    website_id BIGINT UNSIGNED NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    deleted_at TIMESTAMP NULL,
    FOREIGN KEY (website_id) REFERENCES websites(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
