--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.5
-- Dumped by pg_dump version 9.5.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: checks; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE checks (
    id integer NOT NULL,
    uniq_id uuid NOT NULL,
    user_id integer NOT NULL,
    project_id integer NOT NULL,
    "checkInDateTime" timestamp(0) without time zone DEFAULT now() NOT NULL,
    "checkOutDateTime" timestamp(0) without time zone,
    "longitudeIn" double precision,
    "latitudeIn" double precision,
    "longitudeOut" double precision,
    "latitudeOut" double precision,
    "checkMethod" character varying(255) DEFAULT 'geo'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    "isExceptionIn" boolean DEFAULT false NOT NULL,
    "isExceptionOut" boolean DEFAULT false NOT NULL,
    CONSTRAINT "checks_checkMethod_check" CHECK ((("checkMethod")::text = ANY ((ARRAY['geo'::character varying, 'qr'::character varying, 'manual'::character varying])::text[])))
);


ALTER TABLE checks OWNER TO forge;

--
-- Name: checks_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE checks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE checks_id_seq OWNER TO forge;

--
-- Name: checks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE checks_id_seq OWNED BY checks.id;


--
-- Name: client_project; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE client_project (
    id integer NOT NULL,
    client_id integer NOT NULL,
    project_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE client_project OWNER TO forge;

--
-- Name: client_project_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE client_project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE client_project_id_seq OWNER TO forge;

--
-- Name: client_project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE client_project_id_seq OWNED BY client_project.id;


--
-- Name: clients; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE clients (
    id integer NOT NULL,
    child_of_id integer DEFAULT 0 NOT NULL,
    uniq_id uuid NOT NULL,
    subdomain character varying(64) NOT NULL,
    name character varying(255) NOT NULL,
    fein character varying(250) NOT NULL,
    dba character varying(250),
    address character varying(64),
    city character varying(64),
    state character varying(2),
    zip character varying(12),
    phone character varying(64),
    fax character varying(64),
    website character varying(64),
    status character varying(12) DEFAULT 'inactive'::character varying NOT NULL,
    jdoc jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE clients OWNER TO forge;

--
-- Name: clients_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE clients_id_seq OWNER TO forge;

--
-- Name: clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE clients_id_seq OWNED BY clients.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE failed_jobs (
    id integer NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT ('now'::text)::timestamp(0) with time zone NOT NULL
);


ALTER TABLE failed_jobs OWNER TO forge;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE failed_jobs_id_seq OWNER TO forge;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE failed_jobs_id_seq OWNED BY failed_jobs.id;


--
-- Name: industries; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE industries (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    jdoc jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE industries OWNER TO forge;

--
-- Name: industries_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE industries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE industries_id_seq OWNER TO forge;

--
-- Name: industries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE industries_id_seq OWNED BY industries.id;


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE jobs OWNER TO forge;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE jobs_id_seq OWNER TO forge;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE jobs_id_seq OWNED BY jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE migrations OWNER TO forge;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE migrations_id_seq OWNER TO forge;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE migrations_id_seq OWNED BY migrations.id;


--
-- Name: oauth_access_tokens; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE oauth_access_tokens (
    id character varying(100) NOT NULL,
    user_id integer,
    client_id integer NOT NULL,
    name character varying(255),
    scopes text,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone
);


ALTER TABLE oauth_access_tokens OWNER TO forge;

--
-- Name: oauth_auth_codes; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE oauth_auth_codes (
    id character varying(100) NOT NULL,
    user_id integer NOT NULL,
    client_id integer NOT NULL,
    scopes text,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);


ALTER TABLE oauth_auth_codes OWNER TO forge;

--
-- Name: oauth_clients; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE oauth_clients (
    id integer NOT NULL,
    user_id integer,
    name character varying(255) NOT NULL,
    secret character varying(100) NOT NULL,
    redirect text NOT NULL,
    personal_access_client boolean NOT NULL,
    password_client boolean NOT NULL,
    revoked boolean NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE oauth_clients OWNER TO forge;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE oauth_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oauth_clients_id_seq OWNER TO forge;

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE oauth_clients_id_seq OWNED BY oauth_clients.id;


--
-- Name: oauth_personal_access_clients; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE oauth_personal_access_clients (
    id integer NOT NULL,
    client_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE oauth_personal_access_clients OWNER TO forge;

--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE oauth_personal_access_clients_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE oauth_personal_access_clients_id_seq OWNER TO forge;

--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE oauth_personal_access_clients_id_seq OWNED BY oauth_personal_access_clients.id;


--
-- Name: oauth_refresh_tokens; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE oauth_refresh_tokens (
    id character varying(100) NOT NULL,
    access_token_id character varying(100) NOT NULL,
    revoked boolean NOT NULL,
    expires_at timestamp(0) without time zone
);


ALTER TABLE oauth_refresh_tokens OWNER TO forge;

--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE password_resets OWNER TO forge;

--
-- Name: permission_user; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE permission_user (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE permission_user OWNER TO forge;

--
-- Name: permission_user_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE permission_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permission_user_id_seq OWNER TO forge;

--
-- Name: permission_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE permission_user_id_seq OWNED BY permission_user.id;


--
-- Name: permissions; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE permissions (
    id integer NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE permissions OWNER TO forge;

--
-- Name: permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE permissions_id_seq OWNER TO forge;

--
-- Name: permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE permissions_id_seq OWNED BY permissions.id;


--
-- Name: project_user; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE project_user (
    id integer NOT NULL,
    user_id integer NOT NULL,
    project_id integer NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE project_user OWNER TO forge;

--
-- Name: project_user_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE project_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project_user_id_seq OWNER TO forge;

--
-- Name: project_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE project_user_id_seq OWNED BY project_user.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE projects (
    id integer NOT NULL,
    uniq_id uuid NOT NULL,
    name character varying(250) NOT NULL,
    description character varying(250) NOT NULL,
    client_id integer NOT NULL,
    sector_id integer NOT NULL,
    industry_id integer NOT NULL,
    "startDate" date NOT NULL,
    "endDate" date NOT NULL,
    longitude double precision NOT NULL,
    latitude double precision NOT NULL,
    radius double precision DEFAULT '0'::double precision NOT NULL,
    status character varying(12) DEFAULT 'inactive'::character varying NOT NULL,
    jdoc jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    polyfence polygon,
    pointfence point,
    address character varying(64),
    city character varying(64),
    state character varying(64),
    zip character varying(64),
    county character varying(64),
    country character varying(64),
    deleted_at timestamp(0) without time zone
);


ALTER TABLE projects OWNER TO forge;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projects_id_seq OWNER TO forge;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: reports; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE reports (
    id integer NOT NULL,
    uniq_id uuid NOT NULL,
    report_number character varying(12) NOT NULL,
    name character varying(250) NOT NULL,
    permissions jsonb DEFAULT '{}'::jsonb NOT NULL,
    jdoc jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    deleted_at timestamp(0) without time zone
);


ALTER TABLE reports OWNER TO forge;

--
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE reports_id_seq OWNER TO forge;

--
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE reports_id_seq OWNED BY reports.id;


--
-- Name: sectors; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE sectors (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    jdoc jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE sectors OWNER TO forge;

--
-- Name: sectors_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE sectors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE sectors_id_seq OWNER TO forge;

--
-- Name: sectors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE sectors_id_seq OWNED BY sectors.id;


--
-- Name: user_logs; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE user_logs (
    id integer NOT NULL,
    uniq_id uuid NOT NULL,
    user_id integer NOT NULL,
    project_id integer,
    note text NOT NULL,
    type character varying(24) NOT NULL,
    "dateTime" timestamp(0) without time zone DEFAULT now() NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    check_id integer
);


ALTER TABLE user_logs OWNER TO forge;

--
-- Name: user_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE user_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_logs_id_seq OWNER TO forge;

--
-- Name: user_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE user_logs_id_seq OWNED BY user_logs.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: forge
--

CREATE TABLE users (
    id integer NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    uniq_id uuid NOT NULL,
    client_id integer NOT NULL,
    "mobileNumber" character varying(24),
    role character varying(12) DEFAULT 'user'::character varying NOT NULL,
    status character varying(255) DEFAULT 'inactive'::character varying NOT NULL,
    jdoc jsonb DEFAULT '{"address": {"address1": ""}, "vehicle": {"carMake": ""}, "emerContact": {"name": ""}, "payroll_data": {"pay_rate": ""}}'::jsonb NOT NULL,
    username character varying(64),
    permissions jsonb DEFAULT '{"reports": [], "scanner": []}'::jsonb NOT NULL,
    deleted_at timestamp(0) without time zone,
    tos_agree_date timestamp(0) without time zone,
    CONSTRAINT users_status_check CHECK (((status)::text = ANY ((ARRAY['active'::character varying, 'inactive'::character varying])::text[])))
);


ALTER TABLE users OWNER TO forge;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: forge
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO forge;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: forge
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY checks ALTER COLUMN id SET DEFAULT nextval('checks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY client_project ALTER COLUMN id SET DEFAULT nextval('client_project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY clients ALTER COLUMN id SET DEFAULT nextval('clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY failed_jobs ALTER COLUMN id SET DEFAULT nextval('failed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY industries ALTER COLUMN id SET DEFAULT nextval('industries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY jobs ALTER COLUMN id SET DEFAULT nextval('jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY migrations ALTER COLUMN id SET DEFAULT nextval('migrations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY oauth_clients ALTER COLUMN id SET DEFAULT nextval('oauth_clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY oauth_personal_access_clients ALTER COLUMN id SET DEFAULT nextval('oauth_personal_access_clients_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY permission_user ALTER COLUMN id SET DEFAULT nextval('permission_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY permissions ALTER COLUMN id SET DEFAULT nextval('permissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY project_user ALTER COLUMN id SET DEFAULT nextval('project_user_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY reports ALTER COLUMN id SET DEFAULT nextval('reports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY sectors ALTER COLUMN id SET DEFAULT nextval('sectors_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY user_logs ALTER COLUMN id SET DEFAULT nextval('user_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: forge
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);



--
-- Name: checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('checks_id_seq', 271, true);


--
-- Data for Name: client_project; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Name: client_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('client_project_id_seq', 23, true);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: forge
--

--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('clients_id_seq', 39, true);


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: forge
--



--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('failed_jobs_id_seq', 1, false);


--
-- Data for Name: industries; Type: TABLE DATA; Schema: public; Owner: forge
--



--
-- Name: industries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('industries_id_seq', 1, true);


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: forge
--



--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('jobs_id_seq', 1, false);


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: forge
--

--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('migrations_id_seq', 33, true);


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Data for Name: oauth_auth_codes; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY oauth_auth_codes (id, user_id, client_id, scopes, revoked, expires_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: public; Owner: forge
--

--
-- Name: oauth_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('oauth_clients_id_seq', 1, false);


--
-- Data for Name: oauth_personal_access_clients; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('oauth_personal_access_clients_id_seq', 1, true);


--
-- Data for Name: oauth_refresh_tokens; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Data for Name: permission_user; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY permission_user (id, user_id, permission_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: permission_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('permission_user_id_seq', 1, false);


--
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY permissions (id, name, description, created_at, updated_at) FROM stdin;
1	badge.punch.other	Permission to punch in someone else using Manual or QR methods.	\N	\N
\.


--
-- Name: permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('permissions_id_seq', 1, true);


--
-- Data for Name: project_user; Type: TABLE DATA; Schema: public; Owner: forge
--

--
-- Name: project_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('project_user_id_seq', 29, true);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('projects_id_seq', 12, true);


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('reports_id_seq', 14, true);


--
-- Data for Name: sectors; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY sectors (id, name, jdoc, created_at, updated_at) FROM stdin;
1	Sector	{}	\N	\N
\.


--
-- Name: sectors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('sectors_id_seq', 1, true);


--
-- Data for Name: user_logs; Type: TABLE DATA; Schema: public; Owner: forge
--

--
-- Name: user_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('user_logs_id_seq', 7, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: forge
--


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('users_id_seq', 58, true);


--
-- Name: checks_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY checks
    ADD CONSTRAINT checks_pkey PRIMARY KEY (id);


--
-- Name: checks_uniq_id_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY checks
    ADD CONSTRAINT checks_uniq_id_unique UNIQUE (uniq_id);


--
-- Name: client_project_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY client_project
    ADD CONSTRAINT client_project_pkey PRIMARY KEY (id);


--
-- Name: clients_fein_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_fein_unique UNIQUE (fein);


--
-- Name: clients_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id);


--
-- Name: clients_subdomain_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_subdomain_unique UNIQUE (subdomain);


--
-- Name: clients_uniq_id_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY clients
    ADD CONSTRAINT clients_uniq_id_unique UNIQUE (uniq_id);


--
-- Name: failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: industries_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY industries
    ADD CONSTRAINT industries_pkey PRIMARY KEY (id);


--
-- Name: jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: oauth_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY oauth_access_tokens
    ADD CONSTRAINT oauth_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: oauth_auth_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY oauth_auth_codes
    ADD CONSTRAINT oauth_auth_codes_pkey PRIMARY KEY (id);


--
-- Name: oauth_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY oauth_clients
    ADD CONSTRAINT oauth_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_personal_access_clients_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY oauth_personal_access_clients
    ADD CONSTRAINT oauth_personal_access_clients_pkey PRIMARY KEY (id);


--
-- Name: oauth_refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY oauth_refresh_tokens
    ADD CONSTRAINT oauth_refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: permission_user_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY permission_user
    ADD CONSTRAINT permission_user_pkey PRIMARY KEY (id);


--
-- Name: permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- Name: project_user_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY project_user
    ADD CONSTRAINT project_user_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: projects_uniq_id_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_uniq_id_unique UNIQUE (uniq_id);


--
-- Name: reports_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- Name: reports_uniq_id_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY reports
    ADD CONSTRAINT reports_uniq_id_unique UNIQUE (uniq_id);


--
-- Name: sectors_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY sectors
    ADD CONSTRAINT sectors_pkey PRIMARY KEY (id);


--
-- Name: user_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_pkey PRIMARY KEY (id);


--
-- Name: user_logs_uniq_id_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_uniq_id_unique UNIQUE (uniq_id);


--
-- Name: users_client_id_email_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_client_id_email_unique UNIQUE (client_id, email);


--
-- Name: users_client_id_mobilenumber_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_client_id_mobilenumber_unique UNIQUE (client_id, "mobileNumber");


--
-- Name: users_client_id_username_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_client_id_username_unique UNIQUE (client_id, username);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users_uniq_id_unique; Type: CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_uniq_id_unique UNIQUE (uniq_id);


--
-- Name: checks_checkindatetime_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX checks_checkindatetime_index ON checks USING btree ("checkInDateTime");


--
-- Name: checks_checkoutdatetime_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX checks_checkoutdatetime_index ON checks USING btree ("checkOutDateTime");


--
-- Name: checks_user_id_project_id_checkindatetime_checkoutdatetime_inde; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX checks_user_id_project_id_checkindatetime_checkoutdatetime_inde ON checks USING btree (user_id, project_id, "checkInDateTime", "checkOutDateTime");


--
-- Name: checks_user_id_project_id_checkindatetime_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX checks_user_id_project_id_checkindatetime_index ON checks USING btree (user_id, project_id, "checkInDateTime");


--
-- Name: checks_user_id_project_id_checkoutdatetime_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX checks_user_id_project_id_checkoutdatetime_index ON checks USING btree (user_id, project_id, "checkOutDateTime");


--
-- Name: client_project_client_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX client_project_client_id_index ON client_project USING btree (client_id);


--
-- Name: client_project_project_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX client_project_project_id_index ON client_project USING btree (project_id);


--
-- Name: clients_child_of_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX clients_child_of_id_index ON clients USING btree (child_of_id);


--
-- Name: clients_jdoc_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX clients_jdoc_index ON clients USING btree (jdoc);


--
-- Name: industries_jdoc_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX industries_jdoc_index ON industries USING btree (jdoc);


--
-- Name: jobs_queue_reserved_at_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX jobs_queue_reserved_at_index ON jobs USING btree (queue, reserved_at);


--
-- Name: oauth_access_tokens_user_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX oauth_access_tokens_user_id_index ON oauth_access_tokens USING btree (user_id);


--
-- Name: oauth_clients_user_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX oauth_clients_user_id_index ON oauth_clients USING btree (user_id);


--
-- Name: oauth_personal_access_clients_client_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX oauth_personal_access_clients_client_id_index ON oauth_personal_access_clients USING btree (client_id);


--
-- Name: oauth_refresh_tokens_access_token_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX oauth_refresh_tokens_access_token_id_index ON oauth_refresh_tokens USING btree (access_token_id);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX password_resets_email_index ON password_resets USING btree (email);


--
-- Name: password_resets_token_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX password_resets_token_index ON password_resets USING btree (token);


--
-- Name: permissions_name_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX permissions_name_index ON permissions USING btree (name);


--
-- Name: project_user_project_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX project_user_project_id_index ON project_user USING btree (project_id);


--
-- Name: project_user_user_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX project_user_user_id_index ON project_user USING btree (user_id);


--
-- Name: projects_jdoc_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX projects_jdoc_index ON projects USING btree (jdoc);


--
-- Name: reports_jdoc_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX reports_jdoc_index ON reports USING btree (jdoc);


--
-- Name: reports_permissions_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX reports_permissions_index ON reports USING btree (permissions);


--
-- Name: sectors_jdoc_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX sectors_jdoc_index ON sectors USING btree (jdoc);


--
-- Name: user_logs_project_id_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX user_logs_project_id_index ON user_logs USING btree (project_id);


--
-- Name: users_jdoc_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX users_jdoc_index ON users USING btree (jdoc);


--
-- Name: users_status_index; Type: INDEX; Schema: public; Owner: forge
--

CREATE INDEX users_status_index ON users USING btree (status);


--
-- Name: checks_project_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY checks
    ADD CONSTRAINT checks_project_id_foreign FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: checks_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY checks
    ADD CONSTRAINT checks_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: client_project_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY client_project
    ADD CONSTRAINT client_project_client_id_foreign FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- Name: client_project_project_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY client_project
    ADD CONSTRAINT client_project_project_id_foreign FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: permission_user_permission_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY permission_user
    ADD CONSTRAINT permission_user_permission_id_foreign FOREIGN KEY (permission_id) REFERENCES permissions(id);


--
-- Name: permission_user_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY permission_user
    ADD CONSTRAINT permission_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: project_user_project_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY project_user
    ADD CONSTRAINT project_user_project_id_foreign FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: project_user_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY project_user
    ADD CONSTRAINT project_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: projects_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_client_id_foreign FOREIGN KEY (client_id) REFERENCES clients(id);


--
-- Name: projects_industry_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_industry_id_foreign FOREIGN KEY (industry_id) REFERENCES industries(id) ON DELETE CASCADE;


--
-- Name: projects_sector_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_sector_id_foreign FOREIGN KEY (sector_id) REFERENCES sectors(id) ON DELETE CASCADE;


--
-- Name: user_logs_check_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_check_id_foreign FOREIGN KEY (check_id) REFERENCES checks(id);


--
-- Name: user_logs_project_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_project_id_foreign FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: user_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY user_logs
    ADD CONSTRAINT user_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users_client_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: forge
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_client_id_foreign FOREIGN KEY (client_id) REFERENCES clients(id) ON DELETE CASCADE;


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

