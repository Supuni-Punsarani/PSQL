--
-- PostgreSQL database dump
--

-- Dumped from database version 10.22
-- Dumped by pg_dump version 10.22

-- Started on 2022-11-16 20:09:11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12924)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2899 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 197 (class 1259 OID 17515)
-- Name: customer; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer (
    cusid character varying(10) NOT NULL,
    empid character varying(10),
    cname character varying(15) NOT NULL,
    homenum character varying(10),
    street character varying(20),
    city character varying(10)
);


ALTER TABLE public.customer OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 17766)
-- Name: drugdetail; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.drugdetail (
    batchno character varying(5) NOT NULL,
    drugid character varying(5) NOT NULL,
    location character varying(10) DEFAULT 'CUB1'::character varying,
    dname character varying(20),
    sname character varying,
    category character varying(10) DEFAULT 'BOTTLES'::character varying,
    temp double precision DEFAULT 5.0,
    noofunit integer DEFAULT 10,
    uprice numeric,
    manufacturer character varying(10) DEFAULT NULL::character varying
);


ALTER TABLE public.drugdetail OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 17506)
-- Name: employee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employee (
    empid character varying(10) NOT NULL,
    firstname character varying(15) NOT NULL,
    lastname character varying(15) NOT NULL,
    surname character varying(15) DEFAULT NULL::character varying,
    role character varying(12) DEFAULT 'Pharmacist'::character varying,
    salary real NOT NULL,
    dateofwork integer DEFAULT 1,
    address character varying(15) DEFAULT 'Malabe'::character varying
);


ALTER TABLE public.employee OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 17786)
-- Name: mobilenum; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mobilenum (
    empid character varying(10) DEFAULT NULL::character varying,
    supid character varying(10) DEFAULT NULL::character varying,
    cusid character varying(10) DEFAULT NULL::character varying,
    mobile character varying(13) NOT NULL
);


ALTER TABLE public.mobilenum OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 17809)
-- Name: onpurchaseinvoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.onpurchaseinvoice (
    batchno character varying(10),
    pinvoiceid character varying(5),
    dquantity integer,
    dpricetotal numeric
);


ALTER TABLE public.onpurchaseinvoice OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 17825)
-- Name: onsaleinvoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.onsaleinvoice (
    batchno character varying(10),
    sinvoiceid character varying(5),
    dquantity integer,
    dpricetotal numeric
);


ALTER TABLE public.onsaleinvoice OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 17733)
-- Name: purchaseinvoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.purchaseinvoice (
    empid character varying(10),
    supid character varying(10),
    pinvoiceid character varying(10) NOT NULL,
    tamount numeric NOT NULL,
    remamount numeric DEFAULT 0.00,
    pamount numeric NOT NULL,
    discount numeric DEFAULT 10.00,
    paytype character varying(10) DEFAULT 'CASH'::character varying,
    date integer NOT NULL
);


ALTER TABLE public.purchaseinvoice OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 17659)
-- Name: saleinvoice; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.saleinvoice (
    sinvoiceid character varying(10) NOT NULL,
    empid character varying(10),
    cusid character varying(10),
    tamount numeric NOT NULL,
    remamount numeric DEFAULT 0.00,
    pamount numeric,
    discount numeric DEFAULT 10.00,
    paytype character(10) DEFAULT 'CASH'::bpchar,
    date integer NOT NULL,
    CONSTRAINT saleinvoice_pamount_check CHECK ((pamount > (0)::numeric))
);


ALTER TABLE public.saleinvoice OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 17754)
-- Name: storeddrug; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.storeddrug (
    batchno character varying(5) NOT NULL,
    manudate integer NOT NULL,
    expdate integer,
    dateofentry integer NOT NULL,
    quantity integer DEFAULT 50
);


ALTER TABLE public.storeddrug OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 17681)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    empid character varying(10),
    supid character varying(10) NOT NULL,
    companyname character varying(15) NOT NULL,
    address character varying(15)
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- TOC entry 2883 (class 0 OID 17515)
-- Dependencies: 197
-- Data for Name: customer; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer (cusid, empid, cname, homenum, street, city) FROM stdin;
C1	E3	SUNIL	NO.1	GALLE_ROAD	COLOMBO
C2	E3	KAMAL	NO.13	MATARA_ROAD	GALLE
C3	E4	AMAL	NO.15	MATARA_ROAD	GALLE
C4	E4	HIRUSHI	NO.26	GALLE_ROAD	COLOMBO
C5	E3	NIPUNI	NO.56	MATARA_ROAD	GALLE
C6	E6	SADUN	NO.67	MATARA_ROAD	GALLE
C7	E6	HIRUNI	NO.67	MATARA ROAD	GALLE
\.


--
-- TOC entry 2888 (class 0 OID 17766)
-- Dependencies: 202
-- Data for Name: drugdetail; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.drugdetail (batchno, drugid, location, dname, sname, category, temp, noofunit, uprice, manufacturer) FROM stdin;
B2	D1	CUB2	PANADOL	PARACETAMOL	PILLS	10	50	2.50	ABC
B2	D2	CUB2	COUGH_SYRUP	\N	BOTTLES	5	30	450.00	\N
B3	D3	CUB1	ANTISEPTIC	\N	BOTTLES	5	10	580.00	CER
B5	D4	CUB3	EYEDROPS	\N	BOTTLES	20	50	150.00	\N
B5	D5	CUB2	CALCIUM	CALCIUM	PILLS	15	100	1.50	ABC
B3	D6	CUB5	METFORMIN	1_1_DIMETHYL	CAPSULE	10	20	2.50	ABC
B5	D7	CUB1	OMEPRA-ZOLE	\N	CAPSULE	5	10	10.00	\N
\.


--
-- TOC entry 2882 (class 0 OID 17506)
-- Dependencies: 196
-- Data for Name: employee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employee (empid, firstname, lastname, surname, role, salary, dateofwork, address) FROM stdin;
E1	KAMAL	PERERA	WIDANAGAMA	ASSISTANT	15000	10	Matara
E2	DINITHI	SANDARUWANI	\N	MANAGER	25000	10	NUWARA
E3	SADUN	GIMHAN	RATHNAYAKA	Pharmacist	1000	1	Malabe
E4	WIMAL	PERERA	\N	Pharmacist	1000	1	Malabe
E5	KASUN	PERERA	WIDANAGAMA	TECHNICIAN	15000	10	MATARA
E6	WIMAL	SANDARUWAN	\N	MANAGER	50000	20	Malabe
E7	THARUSHI	SANDARUWANI	WICKRAMANAYAKE	Pharmacist	35000	22	MAHARAGAMA
\.


--
-- TOC entry 2889 (class 0 OID 17786)
-- Dependencies: 203
-- Data for Name: mobilenum; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.mobilenum (empid, supid, cusid, mobile) FROM stdin;
E3	\N	\N	077-9452013
E3	\N	\N	078-9452913
E2	\N	\N	077-5456013
E2	\N	\N	076-9462613
\N	Q2	\N	078-5634586
\N	Q2	\N	078-5934786
\N	Q3	\N	078-7674586
\N	Q3	\N	077-6634686
\N	\N	C1	071-4029566
\N	\N	C1	071-4069566
\N	\N	C6	077-4029066
\N	\N	C6	071-4529566
\.


--
-- TOC entry 2890 (class 0 OID 17809)
-- Dependencies: 204
-- Data for Name: onpurchaseinvoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.onpurchaseinvoice (batchno, pinvoiceid, dquantity, dpricetotal) FROM stdin;
B1	P1	100	5000.00
B1	P2	50	7000.00
B1	P3	40	8000.00
B2	P1	10	7000.00
B2	P2	10	5800.00
\.


--
-- TOC entry 2891 (class 0 OID 17825)
-- Dependencies: 205
-- Data for Name: onsaleinvoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.onsaleinvoice (batchno, sinvoiceid, dquantity, dpricetotal) FROM stdin;
B1	S1	10	500.00
B1	S2	5	700.00
B1	S3	4	8000.00
B2	S1	1	70.00
B6	S2	10	580.00
\.


--
-- TOC entry 2886 (class 0 OID 17733)
-- Dependencies: 200
-- Data for Name: purchaseinvoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.purchaseinvoice (empid, supid, pinvoiceid, tamount, remamount, pamount, discount, paytype, date) FROM stdin;
E2	Q1	P1	1500.00	10	1530.00	20	card	2010
E1	Q1	P2	1700.00	30	2010.00	10.00	CASH	2003
E2	Q2	P3	1000.00	0.00	1020.00	10.00	CASH	2005
E1	Q1	P4	2500.00	20	2530.00	10.00	cash	2004
E5	Q3	P5	1700.00	0.00	1900.00	10.00	CASH	1994
E2	Q3	P6	1300.00	20	1400.00	80	card	1992
E2	Q7	P7	1800.00	40	1900.00	60	card	1995
\.


--
-- TOC entry 2884 (class 0 OID 17659)
-- Dependencies: 198
-- Data for Name: saleinvoice; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.saleinvoice (sinvoiceid, empid, cusid, tamount, remamount, pamount, discount, paytype, date) FROM stdin;
S1	E3	C2	1500.00	10	1530.00	20	card      	2009
S2	E3	C2	1700.00	20	2000.00	10.00	CASH      	2004
S3	E5	C3	1000.00	0.00	1020.00	10.00	CASH      	2006
S4	E3	C2	2500.00	20	2530.00	10.00	cash      	2006
S5	E6	C5	1700.00	0.00	1900.00	10.00	CASH      	1995
S6	E6	C7	1300.00	20	1400.00	80	card      	1995
S7	E6	C7	1800.00	40	1900.00	60	card      	1993
\.


--
-- TOC entry 2887 (class 0 OID 17754)
-- Dependencies: 201
-- Data for Name: storeddrug; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.storeddrug (batchno, manudate, expdate, dateofentry, quantity) FROM stdin;
B1	2012	2008	1996	40
B2	2009	2009	2014	50
B3	2008	2003	2014	50
B4	2010	2008	2014	50
B5	2005	2009	2011	50
B6	2012	2007	1995	40
B7	2016	2004	1995	60
\.


--
-- TOC entry 2885 (class 0 OID 17681)
-- Dependencies: 199
-- Data for Name: supplier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.supplier (empid, supid, companyname, address) FROM stdin;
E2	Q1	ABC	BELIATTA
E2	Q2	ABC	BELIATTA
E2	Q3	ABC	BELIATTA
E5	Q4	ERT	MATARA
E5	Q5	ET	GALLE
E2	Q6	AWP	GALLE
E1	Q7	APK	COLOMBO
\.


--
-- TOC entry 2732 (class 2606 OID 17519)
-- Name: customer customer_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT customer_pkey PRIMARY KEY (cusid);


--
-- TOC entry 2742 (class 2606 OID 17780)
-- Name: drugdetail drugdetail_dname_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drugdetail
    ADD CONSTRAINT drugdetail_dname_key UNIQUE (dname);


--
-- TOC entry 2744 (class 2606 OID 17778)
-- Name: drugdetail drugdetail_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drugdetail
    ADD CONSTRAINT drugdetail_pkey PRIMARY KEY (batchno, drugid);


--
-- TOC entry 2730 (class 2606 OID 17514)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (empid);


--
-- TOC entry 2746 (class 2606 OID 17793)
-- Name: mobilenum mobilenum_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mobilenum
    ADD CONSTRAINT mobilenum_pkey PRIMARY KEY (mobile);


--
-- TOC entry 2738 (class 2606 OID 17743)
-- Name: purchaseinvoice purchaseinvoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchaseinvoice
    ADD CONSTRAINT purchaseinvoice_pkey PRIMARY KEY (pinvoiceid);


--
-- TOC entry 2734 (class 2606 OID 17670)
-- Name: saleinvoice saleinvoice_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saleinvoice
    ADD CONSTRAINT saleinvoice_pkey PRIMARY KEY (sinvoiceid);


--
-- TOC entry 2740 (class 2606 OID 17759)
-- Name: storeddrug storeddrug_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.storeddrug
    ADD CONSTRAINT storeddrug_pkey PRIMARY KEY (batchno);


--
-- TOC entry 2736 (class 2606 OID 17685)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (supid);


--
-- TOC entry 2753 (class 2606 OID 17781)
-- Name: drugdetail drugdetail_batchno_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.drugdetail
    ADD CONSTRAINT drugdetail_batchno_fkey FOREIGN KEY (batchno) REFERENCES public.storeddrug(batchno) ON DELETE CASCADE;


--
-- TOC entry 2747 (class 2606 OID 17520)
-- Name: customer fk_cusr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer
    ADD CONSTRAINT fk_cusr FOREIGN KEY (empid) REFERENCES public.employee(empid);


--
-- TOC entry 2755 (class 2606 OID 17794)
-- Name: mobilenum fk_mobile1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mobilenum
    ADD CONSTRAINT fk_mobile1 FOREIGN KEY (empid) REFERENCES public.employee(empid);


--
-- TOC entry 2754 (class 2606 OID 17799)
-- Name: mobilenum fk_mobile2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mobilenum
    ADD CONSTRAINT fk_mobile2 FOREIGN KEY (cusid) REFERENCES public.customer(cusid);


--
-- TOC entry 2756 (class 2606 OID 17804)
-- Name: mobilenum fk_mobile3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.mobilenum
    ADD CONSTRAINT fk_mobile3 FOREIGN KEY (supid) REFERENCES public.supplier(supid);


--
-- TOC entry 2757 (class 2606 OID 17815)
-- Name: onpurchaseinvoice fk_onpurchase1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.onpurchaseinvoice
    ADD CONSTRAINT fk_onpurchase1 FOREIGN KEY (batchno) REFERENCES public.storeddrug(batchno);


--
-- TOC entry 2758 (class 2606 OID 17820)
-- Name: onpurchaseinvoice fk_onpurchase2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.onpurchaseinvoice
    ADD CONSTRAINT fk_onpurchase2 FOREIGN KEY (pinvoiceid) REFERENCES public.purchaseinvoice(pinvoiceid);


--
-- TOC entry 2759 (class 2606 OID 17831)
-- Name: onsaleinvoice fk_onsale1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.onsaleinvoice
    ADD CONSTRAINT fk_onsale1 FOREIGN KEY (batchno) REFERENCES public.storeddrug(batchno);


--
-- TOC entry 2760 (class 2606 OID 17836)
-- Name: onsaleinvoice fk_onsale2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.onsaleinvoice
    ADD CONSTRAINT fk_onsale2 FOREIGN KEY (sinvoiceid) REFERENCES public.saleinvoice(sinvoiceid);


--
-- TOC entry 2752 (class 2606 OID 17749)
-- Name: purchaseinvoice fk_purchas2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchaseinvoice
    ADD CONSTRAINT fk_purchas2 FOREIGN KEY (supid) REFERENCES public.supplier(supid);


--
-- TOC entry 2751 (class 2606 OID 17744)
-- Name: purchaseinvoice fk_purchase1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.purchaseinvoice
    ADD CONSTRAINT fk_purchase1 FOREIGN KEY (empid) REFERENCES public.employee(empid);


--
-- TOC entry 2748 (class 2606 OID 17671)
-- Name: saleinvoice fk_sale; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saleinvoice
    ADD CONSTRAINT fk_sale FOREIGN KEY (empid) REFERENCES public.employee(empid);


--
-- TOC entry 2749 (class 2606 OID 17676)
-- Name: saleinvoice fk_sale2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.saleinvoice
    ADD CONSTRAINT fk_sale2 FOREIGN KEY (cusid) REFERENCES public.customer(cusid);


--
-- TOC entry 2750 (class 2606 OID 17686)
-- Name: supplier fk_supp; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT fk_supp FOREIGN KEY (empid) REFERENCES public.employee(empid);


-- Completed on 2022-11-16 20:09:13

--
-- PostgreSQL database dump complete
--

