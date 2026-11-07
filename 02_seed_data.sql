-- Script de Datos de Prueba (Seed Data) para la Agencia de Carros

-- 1. Insertar Registros en Tabla Sucursal
INSERT INTO Sucursal (Nombre, Direccion, Ciudad, Est_prov, Cod_post, Pais, Telefono, Corr_elec, Estado) VALUES
('Agencia Carros Guadalajara Centro', 'Av. Vallarta 2440, Col. Arcos Vallarta', 'Guadalajara', 'Jalisco', '44130', 'México', '+52 33 3818 2000', 'contacto.gdl@agenciacarros.mx', TRUE),
('Agencia Carros Zapopan Vallarta', 'Av. Patria 1200, Col. Jardines del Guadalupe', 'Zapopan', 'Jalisco', '45010', 'México', '+52 33 3110 5000', 'vallarta@agenciacarros.mx', TRUE),
('Agencia Carros CDMX Polanco', 'Av. Presidente Masaryk 310', 'Ciudad de México', 'CDMX', '11560', 'México', '+52 55 5280 1100', 'polanco@agenciacarros.mx', TRUE),
('Agencia Carros Monterrey Valle', 'Av. Roble 600, Valle del Campestre', 'San Pedro Garza García', 'Nuevo León', '66265', 'México', '+52 81 8356 9000', 'valle@agenciacarros.mx', TRUE),
('Agencia Carros Puebla Angelópolis', 'Vía Atlixcáyotl 1499', 'Puebla', 'Puebla', '72193', 'México', '+52 22 2225 3000', 'angelopolis@agenciacarros.mx', TRUE),
('Agencia Carros Querétaro Juriquilla', 'Anillo Vial Fray Junípero Serra 2100', 'Querétaro', 'Querétaro', '76230', 'México', '+52 44 2234 8000', 'juriquilla@agenciacarros.mx', TRUE),
('Agencia Carros Mérida Altabrisa', 'Calle 7 No. 300, Altabrisa', 'Mérida', 'Yucatán', '97130', 'México', '+52 99 9930 4000', 'altabrisa@agenciacarros.mx', TRUE),
('Agencia Carros León Campestre', 'Blvd. Campestre 1500, Lomas del Campestre', 'León', 'Guanajuato', '37150', 'México', '+52 47 7717 6000', 'campestre@agenciacarros.mx', TRUE),
('Agencia Carros Tijuana Zona Río', 'Paseo de los Héroes 9300', 'Tijuana', 'Baja California', '22010', 'México', '+52 66 4684 2000', 'zonario@agenciacarros.mx', TRUE),
('Agencia Carros Toluca Metepec', 'Av. Benito Juárez 800, Francisco Coaxustenco', 'Metepec', 'Estado de México', '52141', 'México', '+52 72 2211 9000', 'metepec@agenciacarros.mx', TRUE),
('Agencia Carros San Luis Lomas', 'Av. Venustiano Carranza 2400', 'San Luis Potosí', 'San Luis Potosí', '78210', 'México', '+52 44 4813 5000', 'lomas.slp@agenciacarros.mx', TRUE),
('Agencia Carros Aguascalientes Norte', 'Av. Independencia 1801, Trojes de Alonso', 'Aguascalientes', 'Aguascalientes', '20116', 'México', '+52 44 9914 1000', 'aguascalientes@agenciacarros.mx', TRUE),
('Agencia Carros Veracruz Marina', 'Blvd. Adolfo Ruiz Cortines 3400', 'Boca del Río', 'Veracruz', '94298', 'México', '+52 22 9921 8000', 'bocadelrio@agenciacarros.mx', TRUE),
('Agencia Carros Chihuahua Sun Hills', 'Av. de la Juventud 3300', 'Chihuahua', 'Chihuahua', '31217', 'México', '+52 61 4432 7000', 'chihuahua@agenciacarros.mx', TRUE),
('Agencia Carros Cancún Marina', 'Av. Bonampak Sm 6 Mza 1', 'Cancún', 'Quintana Roo', '77500', 'México', '+52 99 8881 7000', 'cancun@agenciacarros.mx', TRUE);

-- 2. Insertar Registros en Tabla Vendedor
INSERT INTO Vendedor (Nombre, Apellido, CURP, RFC, Fecha_nac, NSS) VALUES
('Carlos Eduardo', 'Ramírez Gómez', 'RAGC850412HDFRMR09', 'RAGC850412AB3', '1985-04-12', '12948573019'),
('Sofia Maria', 'Hernández Cruz', 'HECS920820MDFRNR02', 'HECS920820CD4', '1992-08-20', '23019284710'),
('Alejandro', 'Morales Torres', 'MOTA881105HJCGRR08', 'MOTA881105EF5', '1988-11-05', '34120394821'),
('Gabriela', 'Jiménez Ruiz', 'JIRG950228MDFMNN01', 'JIRG950228GH6', '1995-02-28', '45231405932'),
('Ricardo', 'Ortiz Delgado', 'OUDR900714HNLRLR05', 'OUDR900714IJ7', '1990-07-14', '56342516043'),
('Valeria', 'Sánchez Castro', 'SACV930330MDFNTR07', 'SACV930330KL8', '1993-03-30', '67453627154'),
('Daniel', 'Navarro Silva', 'NASD870919HGTRRN03', 'NASD870919MN9', '1987-09-19', '78564738265'),
('Mariana', 'Reyes Flores', 'REFM911202MDFNLL04', 'REFM911202OP0', '1991-12-02', '89675849376'),
('Jorge', 'Mendoza Vega', 'MEVJ840515HBCRRR01', 'MEVJ840515QR1', '1984-05-15', '90786950487'),
('Andrea', 'Lara Benítez', 'LABA961010MDFRND08', 'LABA961010ST2', '1996-10-10', '01897061598'),
('Miguel Ángel', 'Guerrero Ríos', 'GURM890108HSLRLN02', 'GURM890108UV3', '1989-01-08', '12908172609'),
('Claudia', 'Paredes Soto', 'PASC940625MAGRRN09', 'PASC940625WX4', '1994-06-25', '23019283710'),
('Hector', 'Ceballos Marín', 'CEMH860804HVERRN06', 'CEMH860804YZ5', '1986-08-04', '34120394821'),
('Natalia', 'Estrada Bravo', 'ESBN921118MCHRRR03', 'ESBN921118AA1', '1992-11-18', '45231405932'),
('Fernando', 'Aguilar Ortiz', 'AOF940719HDFRRN01', 'AOF940719TU1', '1994-07-19', '15243546576');

-- 3. Insertar Registros en Tabla Auto
INSERT INTO Auto (Marca, Modelo, Año, Version, Color, Num_ser, Num_mot, Num_pla, Precio) VALUES
('Ford', 'Mustang GT', 2024, 'V8 5.0L Transmisión Manual', 'Rojo Racing', '1FA6P8CF0R5102938', 'MOT-V8-8849201', 'JLX-88-29', 1050000.50),
('Toyota', 'Corolla', 2023, 'LE Automatic', 'Blanco Perlado', '2T1BURHE5NC102948', 'MOT-I4-1920394', 'JMX-12-34', 420000.00),
('Nissan', 'Sentra', 2024, 'Advance CVT', 'Gris Plata', '3N1AB8CV0RL203941', 'MOT-I4-9021034', 'PKL-99-11', 395000.00),
('BMW', 'M3 Competition', 2024, 'M TwinPower Turbo 510HP', 'Azul Portimao', 'WBS31AY08R1029384', 'MOT-L6-8812039', 'GDB-01-02', 1890000.00),
('Mazda', 'CX-5', 2023, 'S Grand Touring AWD', 'Rojo Cratón', 'JM3KE2CY5N0192837', 'MOT-I4-7712039', 'LMN-45-67', 550000.00),
('Honda', 'Civic', 2024, 'Touring 1.5T', 'Negro Cristal', '1HGFE1F90RH019283', 'MOT-I4-3392019', 'RST-88-99', 540000.00),
('Volkswagen', 'Jetta', 2023, 'GLI 35 Aniversario', 'Gris Puro', '3VW447AJ0PM019283', 'MOT-I4-5592019', 'UVW-11-22', 640000.00),
('Audi', 'Q5', 2024, 'S Line 45 TFSI quattro', 'Blanco Ibis', 'WAUZZZFY0R1029384', 'MOT-I4-9920192', 'ABC-33-44', 1150000.00),
('Kia', 'Sportage', 2024, 'EX Pack', 'Plata Sideral', 'KNDP3CA20R7019283', 'MOT-I4-1102938', 'DEF-55-66', 580000.00),
('Hyundai', 'Elantra', 2023, 'Limited Tech', 'Azul Intenso', 'KMHD84LF0PU019283', 'MOT-I4-2201928', 'GHI-77-88', 465000.00),
('Mercedes-Benz', 'C200', 2024, 'Exclusive Vanguard', 'Plata Salagast', 'W1K2060421R019283', 'MOT-I4-6601928', 'JKL-99-00', 1120000.00),
('Chevrolet', 'Silverado 1500', 2023, 'RST V8 4x4', 'Blanco', '3GCPCSEC0PG019283', 'MOT-V8-4401928', 'MNO-12-23', 980000.00),
('Jeep', 'Wrangler Rubicon', 2024, '4x4 V6 Unlimited', 'Verde Sarge', '1C4HJXFG0RW019283', 'MOT-V6-3301928', 'PQR-34-45', 1250000.00),
('Subaru', 'WRX', 2023, 'tS Manual', 'Azul WR', 'JF1VB1A60PH019283', 'MOT-F4-8801928', 'STU-56-67', 790000.00),
('Chevrolet', 'Tahoe', 2024, 'High Country V8', 'Negro Azabache', '1GNSKCKD4RR901234', 'MOT-V8-9901234', 'VWX-78-89', 1850000.00);

-- 4. Insertar Registros en Tabla Cliente
INSERT INTO Cliente (Nombre, Apellido, CURP, RFC, Fecha_nac, Estado_civ) VALUES
('Ana María', 'Mendoza López', 'MELA920918MDFNNN03', 'MELA9209188A2', '1992-09-18', 'Soltera'),
('Roberto', 'Vargas Silva', 'VASR800125HJCGRN09', 'VASR8001259B3', '1980-01-25', 'Casado'),
('Laura Patricia', 'Castillo Ríos', 'CARL950610MDFRSR01', 'CARL9506101C4', '1995-06-10', 'Soltera'),
('Javier', 'Ibarra Morales', 'IAMJ781130HNTLLN04', 'IAMJ7811302D5', '1978-11-30', 'Casado'),
('Elena', 'Guuzmán Soto', 'GUSE880405MDFRRD07', 'GUSE8804053E6', '1988-04-05', 'Divorciada'),
('Francisco', 'Peña Rangel', 'PERF830812HGTRRN02', 'PERF8308124F7', '1983-08-12', 'Casado'),
('Monica', 'Solis Campos', 'SOCM940219MDFRNN08', 'SOCM9402195G8', '1994-02-19', 'Soltera'),
('Gustavo', 'Espinosa Luna', 'ESLG861022HJCGRR06', 'ESLG8610226H9', '1986-10-22', 'Casado'),
('Rosa Elena', 'Cabrera Fuentes', 'CAFR910514MDFRLR03', 'CAFR9105147I0', '1991-05-14', 'Casada'),
('Alberto', 'Medina Bravo', 'MEBA820703HNTLRR01', 'MEBA8207038J1', '1982-07-03', 'Casado'),
('Carmen', 'Pineda Franco', 'PIFC970328MDFRNR05', 'PIFC9703289K2', '1997-03-28', 'Soltera'),
('Diego', 'Salazar Orozco', 'SAOD891211HGTRRN08', 'SAOD8912110L3', '1989-12-11', 'Casado'),
('Teresa', 'Arias Delgado', 'AADT930116MDFRLN04', 'AADT9301161M4', '1993-01-16', 'Soltera'),
('Enrique', 'Bautista Vega', 'BAVE850909HJCGRR02', 'BAVE8509092N5', '1985-09-09', 'Casado'),
('Patricia', 'Navarro Medina', 'NAMP960811MJCGRR04', 'NAMP960811KL2', '1996-08-11', 'Soltera');

-- 5. Insertar Registros en Tabla Gestiona (Sucursal <-> Vendedor)
INSERT INTO Gestiona (ID_sucursal, ID_vendedor, Estado) VALUES
(1, 1, TRUE),
(1, 2, TRUE),
(2, 3, TRUE),
(3, 4, TRUE),
(4, 5, TRUE),
(5, 6, TRUE),
(6, 7, TRUE),
(7, 8, TRUE),
(8, 9, TRUE),
(9, 10, TRUE),
(10, 11, TRUE),
(11, 12, TRUE),
(12, 13, TRUE),
(13, 14, TRUE),
(14, 15, TRUE);

-- 6. Insertar Registros en Tabla Venta
INSERT INTO Venta (ID_auto, ID_cliente, ID_vendedor, Fecha_ven, Monto_fin, Forma_pag) VALUES
(1,  1,  1,  '2026-01-10 10:30:00', 1050000.50, 'Contado'),
(2,  2,  2,  '2026-01-15 11:45:00',  420000.00, 'Crédito'),
(3,  3,  1,  '2026-02-01 16:20:00',  395000.00, 'Transferencia SPEI'),
(4,  4,  3,  '2026-02-14 09:15:00', 1890000.00, 'Crédito'),
(5,  5,  2,  '2026-03-05 13:00:00',  550000.00, 'Contado'),
(6,  6,  4,  '2026-03-20 17:10:00',  540000.00, 'Transferencia SPEI'),
(7,  7,  5,  '2026-04-02 12:40:00',  640000.00, 'Crédito'),
(8,  8,  6,  '2026-04-18 15:30:00', 1150000.00, 'Contado'),
(9,  9,  7,  '2026-05-11 10:00:00',  580000.00, 'Crédito'),
(10, 10, 8,  '2026-05-29 18:05:00',  465000.00, 'Transferencia SPEI'),
(11, 11, 9,  '2026-06-12 11:20:00', 1120000.00, 'Crédito'),
(12, 12, 10, '2026-07-04 14:50:00',  980000.00, 'Contado'),
(13, 13, 11, '2026-08-19 09:30:00', 1250000.00, 'Transferencia SPEI'),
(14, 14, 12, '2026-09-08 16:15:00',  790000.00, 'Contado'),
(15, 15, 15, '2026-10-18 16:45:00', 1850000.00, 'Crédito');