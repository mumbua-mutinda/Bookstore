USE BookStore_DB;
-- Table for user roles
CREATE TABLE user_role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Table for application users
CREATE TABLE app_user (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES user_role(role_id)
);

-- Table for permissions
CREATE TABLE permission (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(100) NOT NULL UNIQUE
);

-- Table to associate roles with permissions (many-to-many relationship)
CREATE TABLE role_permission (
    role_id INT,
    permission_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES user_role(role_id),
    FOREIGN KEY (permission_id) REFERENCES permission(permission_id)
);

-- Default roles
START TRANSACTION;

INSERT INTO user_role (role_name)
VALUES 
('Admin'),
('Manager'),
('Customer');

-- Default permissions
INSERT INTO permission (permission_name)
VALUES 
('Manage Users'),
('Manage Orders'),
('View Reports'),
('Browse Books');

-- Assigned permissions to roles
INSERT INTO role_permission (role_id, permission_id)
VALUES 
((SELECT role_id FROM user_role WHERE role_name = 'Admin'), (SELECT permission_id FROM permission WHERE permission_name = 'Manage Users')),
((SELECT role_id FROM user_role WHERE role_name = 'Admin'), (SELECT permission_id FROM permission WHERE permission_name = 'Manage Orders')),
((SELECT role_id FROM user_role WHERE role_name = 'Admin'), (SELECT permission_id FROM permission WHERE permission_name = 'View Reports')),
((SELECT role_id FROM user_role WHERE role_name = 'Manager'), (SELECT permission_id FROM permission WHERE permission_name = 'Manage Orders')),
((SELECT role_id FROM user_role WHERE role_name = 'Manager'), (SELECT permission_id FROM permission WHERE permission_name = 'View Reports')),
((SELECT role_id FROM user_role WHERE role_name = 'Customer'), (SELECT permission_id FROM permission WHERE permission_name = 'Browse Books'));

--  Sample users and assigned roles
INSERT INTO app_user (username, password_hash, role_id)
VALUES 
('admin_user', SHA2('password124', 256), (SELECT role_id FROM user_role WHERE role_name = 'Admin')),
('manager_user', SHA2('password432', 256), (SELECT role_id FROM user_role WHERE role_name = 'Manager')),
('customer_user', SHA2('password123', 256), (SELECT role_id FROM user_role WHERE role_name = 'Customer'));

COMMIT;