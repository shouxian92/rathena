CREATE DATABASE ragnarok;
CREATE user 'ragnarok'@'localhost' IDENTIFIED BY 'ragnarok';
GRANT SELECT,INSERT,UPDATE,DELETE ON `ragnarok`.* TO 'ragnarok'@'localhost';
