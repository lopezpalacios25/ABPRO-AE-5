/*
Ejercicio grupal ABPRO 5
Integrantes:
Christopher López
Diego Ortiz
Joshua Vargas
Alejandro Quiñones
*/



/*
Parte 1: Crear entorno de trabajo
- Crear una base de datos
- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
*/

CREATE DATABASE control_usuarios;

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON * . * TO 'admin'@'localhost';


/*
Parte 2: Crear dos tablas.
*/
CREATE TABLE control_usuarios.usr_aplicacion (
    id_usuario INT PRIMARY KEY,
    nombre VARCHAR(20),
    apellido VARCHAR(20),
    clave VARCHAR(10),
    zona_horaria VARCHAR(30) DEFAULT 'UTC-3',
    genero VARCHAR(1),
    telefono VARCHAR(12)
);

CREATE TABLE control_usuarios.ingresos (
    id_ingreso INT PRIMARY KEY,
    id_usuario INT,
    fecha_ingreso DATETIME DEFAULT NOW(),
    FOREIGN KEY (id_usuario) REFERENCES control_usuarios.usr_aplicacion (id_usuario)
);


/*
Parte 3: Modificación de la tabla
*/
ALTER TABLE control_usuarios.usr_aplicacion ALTER zona_horaria SET DEFAULT 'UTC-2';


/*
Parte 4: Creación de registros.
*/
INSERT INTO control_usuarios.usr_aplicacion(id_usuario, nombre, apellido, clave, zona_horaria, genero, telefono) VALUES
    (1,'Juan', 'López', '1234', 'UTC-3', 'M', '+5697551234'),
    (2,'Claudia', 'Cáceres', '1234', 'UTC-3', 'F', '+56975555678'),
    (3,'Pedro', 'López', '1234', 'UTC-3', 'M', '+56975559876'),
    (4,'Andrea', 'Martínez', '1234', 'UTC-3', 'F', '+56975554321'),
    (5,'Diego', 'Sánchez', '1234', 'UTC-3', 'M', '+56975552468'),
    (6,'Laura', 'Rodríguez', '1234', 'UTC-3', 'F', '+56975551357'),
    (7,'Mario', 'Fernández', '1234', 'UTC-3', 'M', '+56975553698'),
    (8,'Valentina', 'Díaz', '1234', 'UTC-3', 'F', '+56975557890');

INSERT INTO control_usuarios.ingresos (id_ingreso, id_usuario, fecha_ingreso) VALUES 
    (1, 1, '2023-05-04 09:30:00'),
    (2, 1, '2023-05-05 10:45:00'),
    (3, 2, '2023-05-06 12:15:00'),
    (4, 3, '2023-05-07 08:00:00'),
    (5, 2, '2023-05-08 13:30:00'),
    (6, 4, '2023-05-09 11:00:00'),
    (7, 4, '2023-05-10 14:45:00'),
    (8, 3, '2023-05-11 15:20:00');


/*
Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?

TABLA USUARIO
id_usuario INT PRIMARY KEY: permite id de tipo numérico.
nombre varchar(20): permite caracteres para ingresar el nombre.
apellido varchar(20): permite caracteres para ingresar el apellido.
clave varchar(10): permite que la contraseña contenga letras, números o caracteres especiales.
zona_horaria varchar(30) default "UTC-3": permite ingresar con caracteres cualquier zona horaria.
genero varchar(1): permite ingresar 1 caracter para el género. Se puede usar otros largos de varchar dependiendo de los requisitos de la organización
telefono varchar(12): en este caso elegimos varchar para incluir el "+" del codigo de área más un largo de 11 números.
TABLA INGRESOS
id_ingreso int : permite id de tipo numérico.
id_usuario int: es llave foranea por lo que tiene el mismo tipo de dato que el original.
fecha_ingreso datetime default now(): permite ingresar fecha y hora en el dato.
*/


/*
Parte 6: Crear una nueva tabla
*/
CREATE TABLE control_usuarios.contactos (
    id_contacto INT,
    id_usuario INT,
    telefono VARCHAR(12),
    email VARCHAR(20)
);


/*
Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla 
Usuarios y la
tabla Contactos.
*/
ALTER TABLE control_usuarios.contactos ADD PRIMARY KEY(telefono);

INSERT INTO control_usuarios.contactos VALUES
	(1, 1, '+5697551234', 'jlopez@gmail.com'),
	(2, 2, '+56975555678', 'ccaceres@gmail.com'),
	(3, 3, '+56975559876', 'plopez@gmail.com'),
	(4, 4, '+56975554321', 'amartinez@gmail.com'),
	(5, 5, '+56975552468', 'dsanchez@gmail.com'),
	(6, 6, '+56975551357', 'lrodriguez@gmail.com'),
	(7, 7, '+56975553698', 'mfernandez@gmail.com'),
	(8, 8, '+56975557890', 'vdiaz@gmail.com');
    
ALTER TABLE control_usuarios.usr_aplicacion ADD FOREIGN KEY (telefono) REFERENCES control_usuarios.contactos (telefono);
