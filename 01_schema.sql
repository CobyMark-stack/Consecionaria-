-- 1. Tabla Sucursal
CREATE TABLE Sucursal (
	ID SERIAL PRIMARY KEY,
	Nombre VARCHAR(100) NOT NULL,
	Direccion VARCHAR(150) NOT NULL,
	Ciudad VARCHAR(60) NOT NULL,
	Est_prov VARCHAR(60) NOT NULL,
	Cod_post VARCHAR(10) NOT NULL,
	Pais VARCHAR(50) NOT NULL,
	Telefono VARCHAR(20) NOT NULL,
	Corr_elec VARCHAR(100) NOT NULL,
	Estado BOOLEAN DEFAULT TRUE
);

-- 2. Tabla Auto
CREATE TABLE Auto (
    ID SERIAL PRIMARY KEY,
    Marca VARCHAR(50) NOT NULL,
    Modelo VARCHAR(50) NOT NULL,
    Año SMALLINT NOT NULL,
    Version VARCHAR(50),
    Color VARCHAR(30) NOT NULL,
    Num_ser CHAR(17) UNIQUE NOT NULL,
    Num_mot VARCHAR(30) UNIQUE NOT NULL,
    Num_pla VARCHAR(10) UNIQUE,
    Precio DECIMAL(12,2) NOT NULL
);

-- 3. Tabla Cliente
CREATE TABLE Cliente (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
	CURP CHAR(18) UNIQUE NOT NULL,
    RFC VARCHAR(13) UNIQUE NOT NULL,
    Fecha_nac DATE NOT NULL,
    Estado_civ VARCHAR(20)
);

-- 4. Tabla Vendedor
CREATE TABLE Vendedor (
    ID SERIAL PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido VARCHAR(50) NOT NULL,
    CURP CHAR(18) UNIQUE NOT NULL,
    RFC VARCHAR(13) UNIQUE NOT NULL,
    Fecha_nac DATE NOT NULL,
    NSS VARCHAR(11)
);

-- 5. Tabla Intermedia Gestiona (Sucursal - Vendedor)
CREATE TABLE Gestiona (
    ID_sucursal INT NOT NULL,
    ID_vendedor INT NOT NULL,
    Estado BOOLEAN DEFAULT TRUE,
    PRIMARY KEY (ID_sucursal, ID_vendedor),
    FOREIGN KEY (ID_sucursal) REFERENCES Sucursal(ID) ON DELETE CASCADE,
    FOREIGN KEY (ID_vendedor) REFERENCES Vendedor(ID) ON DELETE CASCADE
);

-- 6. Tabla Ternaria Venta
CREATE TABLE Venta (
    ID SERIAL PRIMARY KEY,
    ID_auto INT NOT NULL,
    ID_cliente INT NOT NULL,
    ID_vendedor INT NOT NULL,
    Fecha_ven TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Monto_fin DECIMAL(12,2) NOT NULL,
    Forma_pag VARCHAR(30) NOT NULL,
    FOREIGN KEY (ID_auto) REFERENCES Auto(ID),
    FOREIGN KEY (ID_cliente) REFERENCES Cliente(ID),
    FOREIGN KEY (ID_vendedor) REFERENCES Vendedor(ID)
);