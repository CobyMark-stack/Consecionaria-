--
-- PostgreSQL database dump
--

\restrict TpY0Wbkhdam1xlJZwRStuTdBfGZvbt8RhTPCWR1cuQxVh5oaTTabsfeBZa4hRQd

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

-- Started on 2026-10-18 23:35:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 222 (class 1259 OID 16669)
-- Name: auto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.auto (
    id integer NOT NULL,
    marca character varying(50) NOT NULL,
    modelo character varying(50) NOT NULL,
    "año" smallint NOT NULL,
    version character varying(50),
    color character varying(30) NOT NULL,
    num_ser character(17) NOT NULL,
    num_mot character varying(30) NOT NULL,
    num_pla character varying(10),
    precio numeric(12,2) NOT NULL
);


ALTER TABLE public.auto OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16668)
-- Name: auto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.auto_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auto_id_seq OWNER TO postgres;

--
-- TOC entry 5082 (class 0 OID 0)
-- Dependencies: 221
-- Name: auto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.auto_id_seq OWNED BY public.auto.id;


--
-- TOC entry 224 (class 1259 OID 16690)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    curp character(18) NOT NULL,
    rfc character varying(13) NOT NULL,
    fecha_nac date NOT NULL,
    estado_civ character varying(20)
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16689)
-- Name: cliente_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cliente_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cliente_id_seq OWNER TO postgres;

--
-- TOC entry 5083 (class 0 OID 0)
-- Dependencies: 223
-- Name: cliente_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cliente_id_seq OWNED BY public.cliente.id;


--
-- TOC entry 227 (class 1259 OID 16723)
-- Name: gestiona; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gestiona (
    id_sucursal integer NOT NULL,
    id_vendedor integer NOT NULL,
    estado boolean DEFAULT true
);


ALTER TABLE public.gestiona OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16650)
-- Name: sucursal; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sucursal (
    id integer NOT NULL,
    nombre character varying(100) NOT NULL,
    direccion character varying(150) NOT NULL,
    ciudad character varying(60) NOT NULL,
    est_prov character varying(60) NOT NULL,
    cod_post character varying(10) NOT NULL,
    pais character varying(50) NOT NULL,
    telefono character varying(20) NOT NULL,
    corr_elec character varying(100) NOT NULL,
    estado boolean DEFAULT true
);


ALTER TABLE public.sucursal OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16649)
-- Name: sucursal_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sucursal_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sucursal_id_seq OWNER TO postgres;

--
-- TOC entry 5084 (class 0 OID 0)
-- Dependencies: 219
-- Name: sucursal_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sucursal_id_seq OWNED BY public.sucursal.id;


--
-- TOC entry 226 (class 1259 OID 16707)
-- Name: vendedor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vendedor (
    id integer NOT NULL,
    nombre character varying(50) NOT NULL,
    apellido character varying(50) NOT NULL,
    curp character(18) NOT NULL,
    rfc character varying(13) NOT NULL,
    fecha_nac date NOT NULL,
    nss character varying(11)
);


ALTER TABLE public.vendedor OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16706)
-- Name: vendedor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.vendedor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.vendedor_id_seq OWNER TO postgres;

--
-- TOC entry 5085 (class 0 OID 0)
-- Dependencies: 225
-- Name: vendedor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.vendedor_id_seq OWNED BY public.vendedor.id;


--
-- TOC entry 229 (class 1259 OID 16742)
-- Name: venta; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.venta (
    id integer NOT NULL,
    id_auto integer NOT NULL,
    id_cliente integer NOT NULL,
    id_vendedor integer NOT NULL,
    fecha_ven timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    monto_fin numeric(12,2) NOT NULL,
    forma_pag character varying(30) NOT NULL
);


ALTER TABLE public.venta OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16741)
-- Name: venta_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.venta_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.venta_id_seq OWNER TO postgres;

--
-- TOC entry 5086 (class 0 OID 0)
-- Dependencies: 228
-- Name: venta_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.venta_id_seq OWNED BY public.venta.id;


--
-- TOC entry 4882 (class 2604 OID 16672)
-- Name: auto id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto ALTER COLUMN id SET DEFAULT nextval('public.auto_id_seq'::regclass);


--
-- TOC entry 4883 (class 2604 OID 16693)
-- Name: cliente id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente ALTER COLUMN id SET DEFAULT nextval('public.cliente_id_seq'::regclass);


--
-- TOC entry 4880 (class 2604 OID 16653)
-- Name: sucursal id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal ALTER COLUMN id SET DEFAULT nextval('public.sucursal_id_seq'::regclass);


--
-- TOC entry 4884 (class 2604 OID 16710)
-- Name: vendedor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor ALTER COLUMN id SET DEFAULT nextval('public.vendedor_id_seq'::regclass);


--
-- TOC entry 4886 (class 2604 OID 16745)
-- Name: venta id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta ALTER COLUMN id SET DEFAULT nextval('public.venta_id_seq'::regclass);


--
-- TOC entry 5069 (class 0 OID 16669)
-- Dependencies: 222
-- Data for Name: auto; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.auto VALUES (1, 'Ford', 'Mustang GT', 2024, 'V8 5.0L Transmisión Manual', 'Rojo Racing', '1FA6P8CF0R5102938', 'MOT-V8-8849201', 'JLX-88-29', 1050000.50);
INSERT INTO public.auto VALUES (2, 'Toyota', 'Corolla', 2023, 'LE Automatic', 'Blanco Perlado', '2T1BURHE5NC102948', 'MOT-I4-1920394', 'JMX-12-34', 420000.00);
INSERT INTO public.auto VALUES (3, 'Nissan', 'Sentra', 2024, 'Advance CVT', 'Gris Plata', '3N1AB8CV0RL203941', 'MOT-I4-9021034', 'PKL-99-11', 395000.00);
INSERT INTO public.auto VALUES (4, 'BMW', 'M3 Competition', 2024, 'M TwinPower Turbo 510HP', 'Azul Portimao', 'WBS31AY08R1029384', 'MOT-L6-8812039', 'GDB-01-02', 1890000.00);
INSERT INTO public.auto VALUES (5, 'Mazda', 'CX-5', 2023, 'S Grand Touring AWD', 'Rojo Cratón', 'JM3KE2CY5N0192837', 'MOT-I4-7712039', 'LMN-45-67', 550000.00);
INSERT INTO public.auto VALUES (6, 'Honda', 'Civic', 2024, 'Touring 1.5T', 'Negro Cristal', '1HGFE1F90RH019283', 'MOT-I4-3392019', 'RST-88-99', 540000.00);
INSERT INTO public.auto VALUES (7, 'Volkswagen', 'Jetta', 2023, 'GLI 35 Aniversario', 'Gris Puro', '3VW447AJ0PM019283', 'MOT-I4-5592019', 'UVW-11-22', 640000.00);
INSERT INTO public.auto VALUES (8, 'Audi', 'Q5', 2024, 'S Line 45 TFSI quattro', 'Blanco Ibis', 'WAUZZZFY0R1029384', 'MOT-I4-9920192', 'ABC-33-44', 1150000.00);
INSERT INTO public.auto VALUES (9, 'Kia', 'Sportage', 2024, 'EX Pack', 'Plata Sideral', 'KNDP3CA20R7019283', 'MOT-I4-1102938', 'DEF-55-66', 580000.00);
INSERT INTO public.auto VALUES (10, 'Hyundai', 'Elantra', 2023, 'Limited Tech', 'Azul Intenso', 'KMHD84LF0PU019283', 'MOT-I4-2201928', 'GHI-77-88', 465000.00);
INSERT INTO public.auto VALUES (11, 'Mercedes-Benz', 'C200', 2024, 'Exclusive Vanguard', 'Plata Salagast', 'W1K2060421R019283', 'MOT-I4-6601928', 'JKL-99-00', 1120000.00);
INSERT INTO public.auto VALUES (12, 'Chevrolet', 'Silverado 1500', 2023, 'RST V8 4x4', 'Blanco', '3GCPCSEC0PG019283', 'MOT-V8-4401928', 'MNO-12-23', 980000.00);
INSERT INTO public.auto VALUES (13, 'Jeep', 'Wrangler Rubicon', 2024, '4x4 V6 Unlimited', 'Verde Sarge', '1C4HJXFG0RW019283', 'MOT-V6-3301928', 'PQR-34-45', 1250000.00);
INSERT INTO public.auto VALUES (14, 'Subaru', 'WRX', 2023, 'tS Manual', 'Azul WR', 'JF1VB1A60PH019283', 'MOT-F4-8801928', 'STU-56-67', 790000.00);
INSERT INTO public.auto VALUES (15, 'Chevrolet', 'Tahoe', 2024, 'High Country V8', 'Negro Azabache', '1GNSKCKD4RR901234', 'MOT-V8-9901234', 'VWX-78-89', 1850000.00);


--
-- TOC entry 5071 (class 0 OID 16690)
-- Dependencies: 224
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.cliente VALUES (1, 'Ana María', 'Mendoza López', 'MELA920918MDFNNN03', 'MELA9209188A2', '1992-09-18', 'Soltera');
INSERT INTO public.cliente VALUES (2, 'Roberto', 'Vargas Silva', 'VASR800125HJCGRN09', 'VASR8001259B3', '1980-01-25', 'Casado');
INSERT INTO public.cliente VALUES (3, 'Laura Patricia', 'Castillo Ríos', 'CARL950610MDFRSR01', 'CARL9506101C4', '1995-06-10', 'Soltera');
INSERT INTO public.cliente VALUES (4, 'Javier', 'Ibarra Morales', 'IAMJ781130HNTLLN04', 'IAMJ7811302D5', '1978-11-30', 'Casado');
INSERT INTO public.cliente VALUES (5, 'Elena', 'Guuzmán Soto', 'GUSE880405MDFRRD07', 'GUSE8804053E6', '1988-04-05', 'Divorciada');
INSERT INTO public.cliente VALUES (6, 'Francisco', 'Peña Rangel', 'PERF830812HGTRRN02', 'PERF8308124F7', '1983-08-12', 'Casado');
INSERT INTO public.cliente VALUES (7, 'Monica', 'Solis Campos', 'SOCM940219MDFRNN08', 'SOCM9402195G8', '1994-02-19', 'Soltera');
INSERT INTO public.cliente VALUES (8, 'Gustavo', 'Espinosa Luna', 'ESLG861022HJCGRR06', 'ESLG8610226H9', '1986-10-22', 'Casado');
INSERT INTO public.cliente VALUES (9, 'Rosa Elena', 'Cabrera Fuentes', 'CAFR910514MDFRLR03', 'CAFR9105147I0', '1991-05-14', 'Casada');
INSERT INTO public.cliente VALUES (10, 'Alberto', 'Medina Bravo', 'MEBA820703HNTLRR01', 'MEBA8207038J1', '1982-07-03', 'Casado');
INSERT INTO public.cliente VALUES (11, 'Carmen', 'Pineda Franco', 'PIFC970328MDFRNR05', 'PIFC9703289K2', '1997-03-28', 'Soltera');
INSERT INTO public.cliente VALUES (12, 'Diego', 'Salazar Orozco', 'SAOD891211HGTRRN08', 'SAOD8912110L3', '1989-12-11', 'Casado');
INSERT INTO public.cliente VALUES (13, 'Teresa', 'Arias Delgado', 'AADT930116MDFRLN04', 'AADT9301161M4', '1993-01-16', 'Soltera');
INSERT INTO public.cliente VALUES (14, 'Enrique', 'Bautista Vega', 'BAVE850909HJCGRR02', 'BAVE8509092N5', '1985-09-09', 'Casado');
INSERT INTO public.cliente VALUES (15, 'Patricia', 'Navarro Medina', 'NAMP960811MJCGRR04', 'NAMP960811KL2', '1996-08-11', 'Soltera');


--
-- TOC entry 5074 (class 0 OID 16723)
-- Dependencies: 227
-- Data for Name: gestiona; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.gestiona VALUES (1, 1, true);
INSERT INTO public.gestiona VALUES (1, 2, true);
INSERT INTO public.gestiona VALUES (2, 3, true);
INSERT INTO public.gestiona VALUES (3, 4, true);
INSERT INTO public.gestiona VALUES (4, 5, true);
INSERT INTO public.gestiona VALUES (5, 6, true);
INSERT INTO public.gestiona VALUES (6, 7, true);
INSERT INTO public.gestiona VALUES (7, 8, true);
INSERT INTO public.gestiona VALUES (8, 9, true);
INSERT INTO public.gestiona VALUES (9, 10, true);
INSERT INTO public.gestiona VALUES (10, 11, true);
INSERT INTO public.gestiona VALUES (11, 12, true);
INSERT INTO public.gestiona VALUES (12, 13, true);
INSERT INTO public.gestiona VALUES (13, 14, true);
INSERT INTO public.gestiona VALUES (14, 15, true);


--
-- TOC entry 5067 (class 0 OID 16650)
-- Dependencies: 220
-- Data for Name: sucursal; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.sucursal VALUES (1, 'Agencia Carros Guadalajara Centro', 'Av. Vallarta 2440, Col. Arcos Vallarta', 'Guadalajara', 'Jalisco', '44130', 'México', '+52 33 3818 2000', 'contacto.gdl@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (2, 'Agencia Carros Zapopan Vallarta', 'Av. Patria 1200, Col. Jardines del Guadalupe', 'Zapopan', 'Jalisco', '45010', 'México', '+52 33 3110 5000', 'vallarta@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (3, 'Agencia Carros CDMX Polanco', 'Av. Presidente Masaryk 310', 'Ciudad de México', 'CDMX', '11560', 'México', '+52 55 5280 1100', 'polanco@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (4, 'Agencia Carros Monterrey Valle', 'Av. Roble 600, Valle del Campestre', 'San Pedro Garza García', 'Nuevo León', '66265', 'México', '+52 81 8356 9000', 'valle@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (5, 'Agencia Carros Puebla Angelópolis', 'Vía Atlixcáyotl 1499', 'Puebla', 'Puebla', '72193', 'México', '+52 22 2225 3000', 'angelopolis@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (6, 'Agencia Carros Querétaro Juriquilla', 'Anillo Vial Fray Junípero Serra 2100', 'Querétaro', 'Querétaro', '76230', 'México', '+52 44 2234 8000', 'juriquilla@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (7, 'Agencia Carros Mérida Altabrisa', 'Calle 7 No. 300, Altabrisa', 'Mérida', 'Yucatán', '97130', 'México', '+52 99 9930 4000', 'altabrisa@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (8, 'Agencia Carros León Campestre', 'Blvd. Campestre 1500, Lomas del Campestre', 'León', 'Guanajuato', '37150', 'México', '+52 47 7717 6000', 'campestre@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (9, 'Agencia Carros Tijuana Zona Río', 'Paseo de los Héroes 9300', 'Tijuana', 'Baja California', '22010', 'México', '+52 66 4684 2000', 'zonario@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (10, 'Agencia Carros Toluca Metepec', 'Av. Benito Juárez 800, Francisco Coaxustenco', 'Metepec', 'Estado de México', '52141', 'México', '+52 72 2211 9000', 'metepec@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (11, 'Agencia Carros San Luis Lomas', 'Av. Venustiano Carranza 2400', 'San Luis Potosí', 'San Luis Potosí', '78210', 'México', '+52 44 4813 5000', 'lomas.slp@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (12, 'Agencia Carros Aguascalientes Norte', 'Av. Independencia 1801, Trojes de Alonso', 'Aguascalientes', 'Aguascalientes', '20116', 'México', '+52 44 9914 1000', 'aguascalientes@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (13, 'Agencia Carros Veracruz Marina', 'Blvd. Adolfo Ruiz Cortines 3400', 'Boca del Río', 'Veracruz', '94298', 'México', '+52 22 9921 8000', 'bocadelrio@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (14, 'Agencia Carros Chihuahua Sun Hills', 'Av. de la Juventud 3300', 'Chihuahua', 'Chihuahua', '31217', 'México', '+52 61 4432 7000', 'chihuahua@agenciacarros.mx', true);
INSERT INTO public.sucursal VALUES (15, 'Agencia Carros Cancún Marina', 'Av. Bonampak Sm 6 Mza 1', 'Cancún', 'Quintana Roo', '77500', 'México', '+52 99 8881 7000', 'cancun@agenciacarros.mx', true);


--
-- TOC entry 5073 (class 0 OID 16707)
-- Dependencies: 226
-- Data for Name: vendedor; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.vendedor VALUES (1, 'Carlos Eduardo', 'Ramírez Gómez', 'RAGC850412HDFRMR09', 'RAGC850412AB3', '1985-04-12', '12948573019');
INSERT INTO public.vendedor VALUES (2, 'Sofia Maria', 'Hernández Cruz', 'HECS920820MDFRNR02', 'HECS920820CD4', '1992-08-20', '23019284710');
INSERT INTO public.vendedor VALUES (3, 'Alejandro', 'Morales Torres', 'MOTA881105HJCGRR08', 'MOTA881105EF5', '1988-11-05', '34120394821');
INSERT INTO public.vendedor VALUES (4, 'Gabriela', 'Jiménez Ruiz', 'JIRG950228MDFMNN01', 'JIRG950228GH6', '1995-02-28', '45231405932');
INSERT INTO public.vendedor VALUES (5, 'Ricardo', 'Ortiz Delgado', 'OUDR900714HNLRLR05', 'OUDR900714IJ7', '1990-07-14', '56342516043');
INSERT INTO public.vendedor VALUES (6, 'Valeria', 'Sánchez Castro', 'SACV930330MDFNTR07', 'SACV930330KL8', '1993-03-30', '67453627154');
INSERT INTO public.vendedor VALUES (7, 'Daniel', 'Navarro Silva', 'NASD870919HGTRRN03', 'NASD870919MN9', '1987-09-19', '78564738265');
INSERT INTO public.vendedor VALUES (8, 'Mariana', 'Reyes Flores', 'REFM911202MDFNLL04', 'REFM911202OP0', '1991-12-02', '89675849376');
INSERT INTO public.vendedor VALUES (9, 'Jorge', 'Mendoza Vega', 'MEVJ840515HBCRRR01', 'MEVJ840515QR1', '1984-05-15', '90786950487');
INSERT INTO public.vendedor VALUES (10, 'Andrea', 'Lara Benítez', 'LABA961010MDFRND08', 'LABA961010ST2', '1996-10-10', '01897061598');
INSERT INTO public.vendedor VALUES (11, 'Miguel Ángel', 'Guerrero Ríos', 'GURM890108HSLRLN02', 'GURM890108UV3', '1989-01-08', '12908172609');
INSERT INTO public.vendedor VALUES (12, 'Claudia', 'Paredes Soto', 'PASC940625MAGRRN09', 'PASC940625WX4', '1994-06-25', '23019283710');
INSERT INTO public.vendedor VALUES (13, 'Hector', 'Ceballos Marín', 'CEMH860804HVERRN06', 'CEMH860804YZ5', '1986-08-04', '34120394821');
INSERT INTO public.vendedor VALUES (14, 'Natalia', 'Estrada Bravo', 'ESBN921118MCHRRR03', 'ESBN921118AA1', '1992-11-18', '45231405932');
INSERT INTO public.vendedor VALUES (15, 'Fernando', 'Aguilar Ortiz', 'AOF940719HDFRRN01 ', 'AOF940719TU1', '1994-07-19', '15243546576');


--
-- TOC entry 5076 (class 0 OID 16742)
-- Dependencies: 229
-- Data for Name: venta; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.venta VALUES (1, 1, 1, 1, '2026-01-10 10:30:00', 1050000.50, 'Contado');
INSERT INTO public.venta VALUES (2, 2, 2, 2, '2026-01-15 11:45:00', 420000.00, 'Crédito');
INSERT INTO public.venta VALUES (3, 3, 3, 1, '2026-02-01 16:20:00', 395000.00, 'Transferencia SPEI');
INSERT INTO public.venta VALUES (4, 4, 4, 3, '2026-02-14 09:15:00', 1890000.00, 'Crédito');
INSERT INTO public.venta VALUES (5, 5, 5, 2, '2026-03-05 13:00:00', 550000.00, 'Contado');
INSERT INTO public.venta VALUES (6, 6, 6, 4, '2026-03-20 17:10:00', 540000.00, 'Transferencia SPEI');
INSERT INTO public.venta VALUES (7, 7, 7, 5, '2026-04-02 12:40:00', 640000.00, 'Crédito');
INSERT INTO public.venta VALUES (8, 8, 8, 6, '2026-04-18 15:30:00', 1150000.00, 'Contado');
INSERT INTO public.venta VALUES (9, 9, 9, 7, '2026-05-11 10:00:00', 580000.00, 'Crédito');
INSERT INTO public.venta VALUES (10, 10, 10, 8, '2026-05-29 18:05:00', 465000.00, 'Transferencia SPEI');
INSERT INTO public.venta VALUES (11, 11, 11, 9, '2026-06-12 11:20:00', 1120000.00, 'Crédito');
INSERT INTO public.venta VALUES (12, 12, 12, 10, '2026-07-04 14:50:00', 980000.00, 'Contado');
INSERT INTO public.venta VALUES (13, 13, 13, 11, '2026-08-19 09:30:00', 1250000.00, 'Transferencia SPEI');
INSERT INTO public.venta VALUES (14, 14, 14, 12, '2026-09-08 16:15:00', 790000.00, 'Contado');
INSERT INTO public.venta VALUES (15, 15, 15, 15, '2026-10-18 16:45:00', 1850000.00, 'Crédito');


--
-- TOC entry 5087 (class 0 OID 0)
-- Dependencies: 221
-- Name: auto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.auto_id_seq', 15, true);


--
-- TOC entry 5088 (class 0 OID 0)
-- Dependencies: 223
-- Name: cliente_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cliente_id_seq', 15, true);


--
-- TOC entry 5089 (class 0 OID 0)
-- Dependencies: 219
-- Name: sucursal_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sucursal_id_seq', 15, true);


--
-- TOC entry 5090 (class 0 OID 0)
-- Dependencies: 225
-- Name: vendedor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.vendedor_id_seq', 15, true);


--
-- TOC entry 5091 (class 0 OID 0)
-- Dependencies: 228
-- Name: venta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.venta_id_seq', 15, true);


--
-- TOC entry 4891 (class 2606 OID 16686)
-- Name: auto auto_num_mot_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto
    ADD CONSTRAINT auto_num_mot_key UNIQUE (num_mot);


--
-- TOC entry 4893 (class 2606 OID 16688)
-- Name: auto auto_num_pla_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto
    ADD CONSTRAINT auto_num_pla_key UNIQUE (num_pla);


--
-- TOC entry 4895 (class 2606 OID 16684)
-- Name: auto auto_num_ser_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto
    ADD CONSTRAINT auto_num_ser_key UNIQUE (num_ser);


--
-- TOC entry 4897 (class 2606 OID 16682)
-- Name: auto auto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.auto
    ADD CONSTRAINT auto_pkey PRIMARY KEY (id);


--
-- TOC entry 4899 (class 2606 OID 16703)
-- Name: cliente cliente_curp_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_curp_key UNIQUE (curp);


--
-- TOC entry 4901 (class 2606 OID 16701)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (id);


--
-- TOC entry 4903 (class 2606 OID 16705)
-- Name: cliente cliente_rfc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_rfc_key UNIQUE (rfc);


--
-- TOC entry 4911 (class 2606 OID 16730)
-- Name: gestiona gestiona_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestiona
    ADD CONSTRAINT gestiona_pkey PRIMARY KEY (id_sucursal, id_vendedor);


--
-- TOC entry 4889 (class 2606 OID 16667)
-- Name: sucursal sucursal_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sucursal
    ADD CONSTRAINT sucursal_pkey PRIMARY KEY (id);


--
-- TOC entry 4905 (class 2606 OID 16720)
-- Name: vendedor vendedor_curp_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_curp_key UNIQUE (curp);


--
-- TOC entry 4907 (class 2606 OID 16718)
-- Name: vendedor vendedor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_pkey PRIMARY KEY (id);


--
-- TOC entry 4909 (class 2606 OID 16722)
-- Name: vendedor vendedor_rfc_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vendedor
    ADD CONSTRAINT vendedor_rfc_key UNIQUE (rfc);


--
-- TOC entry 4913 (class 2606 OID 16755)
-- Name: venta venta_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_pkey PRIMARY KEY (id);


--
-- TOC entry 4914 (class 2606 OID 16731)
-- Name: gestiona gestiona_id_sucursal_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestiona
    ADD CONSTRAINT gestiona_id_sucursal_fkey FOREIGN KEY (id_sucursal) REFERENCES public.sucursal(id) ON DELETE CASCADE;


--
-- TOC entry 4915 (class 2606 OID 16736)
-- Name: gestiona gestiona_id_vendedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gestiona
    ADD CONSTRAINT gestiona_id_vendedor_fkey FOREIGN KEY (id_vendedor) REFERENCES public.vendedor(id) ON DELETE CASCADE;


--
-- TOC entry 4916 (class 2606 OID 16756)
-- Name: venta venta_id_auto_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_id_auto_fkey FOREIGN KEY (id_auto) REFERENCES public.auto(id);


--
-- TOC entry 4917 (class 2606 OID 16761)
-- Name: venta venta_id_cliente_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_id_cliente_fkey FOREIGN KEY (id_cliente) REFERENCES public.cliente(id);


--
-- TOC entry 4918 (class 2606 OID 16766)
-- Name: venta venta_id_vendedor_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.venta
    ADD CONSTRAINT venta_id_vendedor_fkey FOREIGN KEY (id_vendedor) REFERENCES public.vendedor(id);


-- Completed on 2026-10-18 23:35:33

--
-- PostgreSQL database dump complete
--

\unrestrict TpY0Wbkhdam1xlJZwRStuTdBfGZvbt8RhTPCWR1cuQxVh5oaTTabsfeBZa4hRQd

