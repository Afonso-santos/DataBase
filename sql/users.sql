USE cdc;

-- Criação ou substituição dos usuários com senhas definidas
CREATE USER 'detetive'@'localhost' IDENTIFIED BY 'detetive1';
CREATE USER 'estagiario'@'localhost' IDENTIFIED BY 'estagiario5';

-- Concessão de permissões apropriadas para cada usuário
GRANT SELECT, INSERT, UPDATE ON cdc.* TO 'detetive1'@'localhost';
GRANT SELECT ON cdc.* TO 'estagiario5'@'localhost';

-- Atualização dos privilégios
FLUSH PRIVILEGES;
