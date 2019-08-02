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
    CONSTRAINT "checks_checkMethod_check" CHECK ((("checkMethod")::text = ANY (ARRAY[('geo'::character varying)::text, ('qr'::character varying)::text, ('manual'::character varying)::text, ('face'::character varying)::text])))
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
    deleted_at timestamp(0) without time zone,
    facelistid character varying(255)
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
    radius double precision DEFAULT '100'::double precision NOT NULL,
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
    "persistanceFaceId" character varying(255),
    CONSTRAINT users_status_check CHECK (((status)::text = ANY (ARRAY[('active'::character varying)::text, ('inactive'::character varying)::text])))
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
-- Data for Name: checks; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY checks (id, uniq_id, user_id, project_id, "checkInDateTime", "checkOutDateTime", "longitudeIn", "latitudeIn", "longitudeOut", "latitudeOut", "checkMethod", created_at, updated_at, "isExceptionIn", "isExceptionOut") FROM stdin;
279	c4ac46bb-0124-46aa-9abd-817b2ff7e6d0	135	16	2017-06-16 13:46:29	2017-06-16 13:51:31	90	90	75.8671365999999949	22.7000959999999985	manual	2017-06-16 13:46:28	2017-06-16 13:51:31	t	t
522	6f525eb7-9af3-403c-861b-9a5038f289c1	133	16	2017-07-25 13:57:02	2017-07-25 13:58:26	75.8671819999999997	22.7000545000000002	75.8672863999999976	22.6999335000000002	geo	2017-07-25 13:57:01	2017-07-25 13:58:26	f	f
280	40a88b58-1d13-4edc-b64a-c23161b1a94e	2	17	2017-06-16 14:17:12	2017-06-16 14:17:47	75.8671365999999949	22.7000959999999985	75.8671030000000002	22.7000704999999989	geo	2017-06-16 14:17:12	2017-06-16 14:17:47	f	t
281	96c972f7-f983-44ed-96ed-5df4d8c194b0	135	16	2017-06-20 10:49:36	2017-06-20 11:00:28	75.8672160999999932	22.6999779000000004	75.8671467000000064	22.700018	geo	2017-06-20 10:49:35	2017-06-20 11:00:28	t	t
289	379c58aa-ed8e-40ae-8598-dbdb5f6b3cd1	135	16	2017-06-20 12:44:29	2017-06-20 12:44:29	123	123	23	321	geo	2017-06-20 12:44:29	2017-06-20 12:44:29	f	f
290	346a0c13-a4fa-4100-a628-0860c3067efd	135	16	2017-06-20 13:06:26	2017-06-20 13:06:26	\N	\N	\N	\N	face	2017-06-20 13:06:26	2017-06-20 13:06:26	t	f
291	c02dae96-9d35-416b-b12e-302941a2e5b6	135	16	2017-06-20 13:18:08	2017-06-20 13:18:08	\N	\N	\N	\N	face	2017-06-20 13:18:08	2017-06-20 13:18:08	t	f
526	1620d531-71f5-4ca7-b589-b4912dbaf429	173	22	2017-07-25 22:09:55	2017-07-25 22:51:59	-82.0279000000000025	27.0152000000000001	-82.0280999999999949	27.0151000000000003	qr	2017-07-25 22:09:55	2017-07-25 22:51:59	t	t
282	15337741-e247-4465-915b-1d5282d586e5	135	16	2017-06-20 11:01:29	2017-06-21 06:34:57	75.8671831000000054	22.6999922000000005	75.8672160999999932	22.6999779000000004	geo	2017-06-20 11:01:29	2017-06-21 06:34:57	t	t
306	ca359d8f-5e85-49ae-a07c-bd43bcdfae76	135	16	2017-06-22 10:07:40	2017-06-22 10:07:40	\N	\N	\N	\N	face	2017-06-22 10:07:40	2017-06-22 10:07:40	t	f
307	125a02ae-1514-446f-8f14-7f65ee2bdc38	135	16	2017-06-22 10:07:56	2017-06-22 10:07:56	\N	\N	\N	\N	face	2017-06-22 10:07:56	2017-06-22 10:07:56	t	f
308	4972973e-f412-4095-9563-ceb0fc59daf2	135	16	2017-06-22 10:08:37	2017-06-22 10:08:37	\N	\N	\N	\N	face	2017-06-22 10:08:37	2017-06-22 10:08:37	t	f
309	98e236f7-8a8e-43fc-b285-a4d3a5416337	135	16	2017-06-22 10:08:50	2017-06-22 10:08:50	\N	\N	\N	\N	face	2017-06-22 10:08:50	2017-06-22 10:08:50	t	f
310	3c80935b-c744-481f-980c-32236c82b2be	135	16	2017-06-22 10:09:14	2017-06-22 10:09:14	\N	\N	\N	\N	face	2017-06-22 10:09:14	2017-06-22 10:09:14	t	f
311	747f851d-7285-4b59-9542-e1512c39e0a1	135	16	2017-06-22 10:09:20	2017-06-22 10:09:20	\N	\N	\N	\N	face	2017-06-22 10:09:20	2017-06-22 10:09:20	t	f
312	82fc255a-aaf6-4f90-9311-e8da091011d8	135	16	2017-06-22 10:09:38	2017-06-22 10:09:38	\N	\N	\N	\N	face	2017-06-22 10:09:38	2017-06-22 10:09:38	t	f
313	adfb89d3-e4d4-4a1c-8348-997a8b80bf6e	135	16	2017-06-22 10:12:28	2017-06-22 10:12:28	\N	\N	\N	\N	face	2017-06-22 10:12:28	2017-06-22 10:12:28	t	f
314	143ff212-515f-49a6-a30e-8d574be7d20b	135	16	2017-06-22 10:15:08	2017-06-22 10:15:08	\N	\N	\N	\N	face	2017-06-22 10:15:08	2017-06-22 10:15:08	t	f
315	7eea3b35-2dfc-40c0-b604-0b35fe4844f9	135	16	2017-06-22 10:17:06	2017-06-22 10:17:06	\N	\N	\N	\N	face	2017-06-22 10:17:06	2017-06-22 10:17:06	t	f
316	50cd9951-05f8-4adc-8b35-00050429a65a	135	16	2017-06-22 10:23:08	2017-06-22 10:23:08	\N	\N	\N	\N	face	2017-06-22 10:23:08	2017-06-22 10:23:08	t	f
317	d2d21992-3a69-4c9d-920d-419ac57ac38d	135	16	2017-06-22 10:23:24	2017-06-22 10:23:24	\N	\N	\N	\N	face	2017-06-22 10:23:24	2017-06-22 10:23:24	t	f
324	a9289de5-4828-4eaa-8c00-7ea7ee5f4d42	135	16	2017-06-22 11:25:48	2017-06-22 11:25:48	\N	\N	\N	\N	face	2017-06-22 11:25:48	2017-06-22 11:25:48	t	f
325	9063bcf5-bf47-46d5-b5ba-3ccd19a2f923	135	16	2017-06-22 12:32:00	2017-06-22 12:32:00	\N	\N	\N	\N	face	2017-06-22 12:32:00	2017-06-22 12:32:00	t	f
326	c179b9c5-9735-460b-92b0-30ce5ef46e06	135	16	2017-06-22 12:43:54	2017-06-22 12:43:54	\N	\N	\N	\N	face	2017-06-22 12:43:54	2017-06-22 12:43:54	t	f
327	86f4ba30-7033-4e0b-9a71-cbf45625e8c9	135	16	2017-06-22 13:16:19	2017-06-22 13:16:19	\N	\N	\N	\N	face	2017-06-22 13:16:19	2017-06-22 13:16:19	t	f
328	08ed4bf5-1c0a-4ba6-acc7-21320e11c2a7	135	16	2017-06-22 13:23:42	2017-06-22 13:23:42	\N	\N	\N	\N	face	2017-06-22 13:23:42	2017-06-22 13:23:42	t	f
329	dc46e59e-74f6-4871-95d5-64352754b302	135	16	2017-06-22 13:38:31	2017-06-22 13:38:31	\N	\N	\N	\N	face	2017-06-22 13:38:31	2017-06-22 13:38:31	t	f
330	fa10914e-7840-4d27-8501-25463f34e891	135	16	2017-06-22 13:50:57	2017-06-22 13:50:57	\N	\N	\N	\N	face	2017-06-22 13:50:57	2017-06-22 13:50:57	t	f
332	58c0b291-c82a-4313-b4ca-7332d1c6fc7f	173	18	2017-07-05 20:26:18	2017-07-05 21:05:36	90	90	90	90	manual	2017-07-05 20:26:18	2017-07-05 21:05:36	t	t
333	e707aca4-1059-4e26-97c2-cccd71fd6ecf	174	18	2017-07-05 20:26:23	2017-07-05 21:05:41	90	90	90	90	manual	2017-07-05 20:26:22	2017-07-05 21:05:41	t	t
334	80542bb2-d1df-488e-8ebf-4486b9bce479	175	18	2017-07-05 20:26:26	2017-07-05 21:05:44	90	90	90	90	manual	2017-07-05 20:26:26	2017-07-05 21:05:44	t	t
335	5f07abe8-56e8-4a0c-a770-ea2ff1cee9b7	177	18	2017-07-05 20:58:48	2017-07-05 21:05:48	90	90	90	90	manual	2017-07-05 20:58:47	2017-07-05 21:05:48	t	t
336	d1600830-02ab-4106-a060-14ef9597d395	178	18	2017-07-05 20:58:52	2017-07-05 21:05:51	90	90	90	90	manual	2017-07-05 20:58:52	2017-07-05 21:05:51	t	t
337	c5d4c2e9-5f17-4ecb-9918-039217965a19	179	18	2017-07-05 21:00:26	2017-07-05 21:05:54	90	90	90	90	manual	2017-07-05 21:00:25	2017-07-05 21:05:54	t	t
338	9b9be045-feea-4416-8dcb-5cda9838bcbf	180	18	2017-07-05 21:00:30	2017-07-05 21:05:57	90	90	90	90	manual	2017-07-05 21:00:29	2017-07-05 21:05:57	t	t
331	2638110d-40b1-4fce-9943-eb424baddd70	170	18	2017-07-05 20:26:13	2017-07-05 21:07:06	90	90	90	90	manual	2017-07-05 20:26:12	2017-07-05 21:07:06	t	t
339	549c7dae-526c-4622-9f93-de957965e3bd	157	18	2017-07-05 21:20:23	2017-07-05 21:35:51	90	90	90	90	manual	2017-07-05 21:20:23	2017-07-05 21:35:51	t	t
340	14d1bb82-2d9f-4922-b158-e96b307f5497	170	18	2017-07-06 15:40:22	2017-07-06 15:45:13	90	90	90	90	manual	2017-07-06 15:40:21	2017-07-06 15:45:13	t	t
341	902cfbe8-5901-4900-aec5-93161408f2a8	180	18	2017-07-06 15:40:26	2017-07-06 15:45:18	90	90	90	90	manual	2017-07-06 15:40:25	2017-07-06 15:45:18	t	t
342	e71b80ac-edec-4cdb-a9a6-510b432dd0d4	178	18	2017-07-06 15:40:30	2017-07-06 15:46:00	90	90	90	90	manual	2017-07-06 15:40:30	2017-07-06 15:46:00	t	t
343	7945a0eb-d4a4-4edb-bf71-13fe28443af8	179	18	2017-07-06 15:40:35	2017-07-06 15:46:03	90	90	90	90	manual	2017-07-06 15:40:34	2017-07-06 15:46:03	t	t
344	4ec6363e-62a4-4f7f-8383-4a3b4ca9b506	182	18	2017-07-06 15:40:39	2017-07-06 15:46:07	90	90	90	90	manual	2017-07-06 15:40:38	2017-07-06 15:46:07	t	t
345	80844128-3a5a-41b5-aeb4-ca8ce2d6dde1	183	18	2017-07-06 15:40:43	2017-07-06 15:46:11	90	90	90	90	manual	2017-07-06 15:40:42	2017-07-06 15:46:11	t	t
346	784b9283-2757-429b-b66b-d64ba0538547	173	22	2017-07-06 15:41:00	2017-07-06 15:46:22	90	90	90	90	manual	2017-07-06 15:40:59	2017-07-06 15:46:22	t	t
360	41b99d9e-44e8-4d71-9c22-25396bf686cd	176	20	2017-07-06 17:19:51	2017-07-06 17:20:02	90	90	-82.536412900000002	27.3383074999999991	manual	2017-07-06 17:19:50	2017-07-06 17:20:02	t	f
361	8f0fe646-5be9-4be6-9d1d-12624d113004	176	20	2017-07-06 17:35:38	2017-07-06 17:44:47	90	90	-82.536412900000002	27.3383074999999991	manual	2017-07-06 17:35:37	2017-07-06 17:44:47	t	f
359	dde90f91-0d55-4679-8dff-96f1ef22e728	157	22	2017-07-06 15:50:12	2017-07-06 17:57:40	90	90	-82.536412900000002	27.3384216000000002	manual	2017-07-06 15:50:11	2017-07-06 17:57:40	t	f
362	050c60da-e6a2-4eaa-91a1-fdbf6d8f3567	157	22	2017-07-06 17:58:44	2017-07-06 17:58:55	90	90	-82.5363605000000007	27.3382541000000003	manual	2017-07-06 17:58:44	2017-07-06 17:58:55	t	f
363	3ba6bfcf-11a3-4a76-b8a2-27ffa9768b68	157	22	2017-07-06 17:59:20	2017-07-06 17:59:57	90	90	-82.5364339999999999	27.3383086000000013	manual	2017-07-06 17:59:20	2017-07-06 17:59:57	t	f
347	8c94f53b-4741-47da-8cb7-e1b3dafe022c	173	22	2017-07-06 15:48:27	2017-07-06 18:14:25	90	90	90	90	manual	2017-07-06 15:48:26	2017-07-06 18:14:25	t	t
348	8c54c2f8-d814-4255-aceb-99ac84ade528	174	22	2017-07-06 15:48:30	2017-07-06 18:14:29	90	90	90	90	manual	2017-07-06 15:48:30	2017-07-06 18:14:29	t	t
349	72fa839a-c470-4ab2-bfce-55525ae59ab6	177	22	2017-07-06 15:48:35	2017-07-06 18:14:34	90	90	90	90	manual	2017-07-06 15:48:34	2017-07-06 18:14:34	t	t
351	989c6b97-7f7b-4390-8867-11a5d39d5e63	181	22	2017-07-06 15:48:41	2017-07-06 18:14:46	90	90	90	90	manual	2017-07-06 15:48:40	2017-07-06 18:14:46	t	t
352	890fdb2a-a332-44da-be9e-7a9fbbd97b10	184	22	2017-07-06 15:48:44	2017-07-06 18:14:52	90	90	90	90	manual	2017-07-06 15:48:43	2017-07-06 18:14:52	t	t
353	89331cba-f6cc-404d-afde-796cc8f1dbea	170	18	2017-07-06 15:48:55	2017-07-06 18:16:08	90	90	90	90	manual	2017-07-06 15:48:55	2017-07-06 18:16:08	t	t
354	0613c53c-fec0-4c58-8810-2e5bd16863cf	175	18	2017-07-06 15:48:59	2017-07-06 18:16:12	90	90	90	90	manual	2017-07-06 15:48:59	2017-07-06 18:16:12	t	t
355	771167cb-2083-4a4f-a85a-903e3d4c90c2	178	18	2017-07-06 15:49:02	2017-07-06 18:16:16	90	90	90	90	manual	2017-07-06 15:49:02	2017-07-06 18:16:16	t	t
356	9c9e8046-9461-4a68-a9c1-25ce8b3d713e	179	18	2017-07-06 15:49:06	2017-07-06 18:16:21	90	90	90	90	manual	2017-07-06 15:49:05	2017-07-06 18:16:21	t	t
358	bc295346-4bac-43ac-9991-4fb3f368f03c	183	18	2017-07-06 15:49:13	2017-07-06 18:16:30	90	90	90	90	manual	2017-07-06 15:49:12	2017-07-06 18:16:30	t	t
364	3dffd6f3-2765-4be6-92c9-51645906769e	157	22	2017-07-06 18:00:28	2017-07-06 18:00:54	90	90	-82.5364873000000046	27.3382192999999987	manual	2017-07-06 18:00:27	2017-07-06 18:00:54	t	f
368	b70bbbcb-fbad-43d5-b306-a84a198dd666	175	18	2017-07-06 18:18:00	2017-07-06 20:23:23	90	90	90	90	manual	2017-07-06 18:18:00	2017-07-06 20:23:23	t	t
369	00840b11-3bef-4453-b119-c186a67d8048	178	18	2017-07-06 18:18:05	2017-07-06 20:23:26	90	90	90	90	manual	2017-07-06 18:18:05	2017-07-06 20:23:26	t	t
350	b9d6b2ff-7251-4978-8168-bd9af3ec20d3	180	22	2017-07-06 15:48:38	2017-07-06 18:14:42	90	90	90	90	manual	2017-07-06 15:48:37	2017-07-06 18:14:42	t	t
365	77bc48ff-4ac7-4520-b60a-ad8bcd6c7bdb	157	22	2017-07-06 18:01:57	2017-07-06 18:15:01	90	90	90	90	manual	2017-07-06 18:01:56	2017-07-06 18:15:01	t	t
357	d9e390bf-a027-4fe9-b2ca-6ba25bd87415	182	18	2017-07-06 15:49:10	2017-07-06 18:16:26	90	90	90	90	manual	2017-07-06 15:49:10	2017-07-06 18:16:26	t	t
366	b879982a-6510-4c90-9a4f-dd79d8a767b3	176	20	2017-07-06 18:02:40	2017-07-06 18:16:31	90	90	-82.536412900000002	27.3383074999999991	manual	2017-07-06 18:02:39	2017-07-06 18:16:31	t	f
370	f82cdf47-ce8f-4223-881c-72cea7afdcff	179	18	2017-07-06 18:18:08	2017-07-06 20:23:29	90	90	90	90	manual	2017-07-06 18:18:08	2017-07-06 20:23:29	t	t
627	dbcae6da-86ca-4d1e-90e4-854cb80b53f1	208	25	2017-07-28 16:43:44	2017-07-28 20:37:11	-82.5024779000000024	27.3633449999999989	-82.5023992999999933	27.3634327000000006	geo	2017-07-28 16:43:43	2017-07-28 20:37:11	t	t
371	5569b207-716c-478e-bdd8-ff3e679f1f88	182	18	2017-07-06 18:18:14	2017-07-06 20:23:33	90	90	90	90	manual	2017-07-06 18:18:13	2017-07-06 20:23:33	t	t
372	e40380b0-e78e-4a01-bd7b-9023464f86a6	183	18	2017-07-06 18:18:16	2017-07-06 20:23:36	90	90	90	90	manual	2017-07-06 18:18:16	2017-07-06 20:23:36	t	t
373	9c6272f6-0f17-492b-ae53-2751cdeec6e3	157	18	2017-07-06 18:18:30	2017-07-06 20:23:56	90	90	-82.536412900000002	27.3383074999999991	manual	2017-07-06 18:18:30	2017-07-06 20:23:56	t	t
385	b44924a2-8b66-40e8-a96a-d58520d12fbb	133	16	2017-07-07 07:26:45	2017-07-07 07:30:13	75.8669436999999931	22.7001355999999994	75.8669550999999984	22.7001251999999987	geo	2017-07-07 07:26:44	2017-07-07 07:30:13	t	t
386	520ba36a-52ac-40d4-86bf-5313705f6f4e	2	17	2017-07-07 11:01:26	2017-07-07 11:01:30	75.8669550999999984	22.7001251999999987	75.8669550999999984	22.7001251999999987	geo	2017-07-07 11:01:25	2017-07-07 11:01:30	f	f
387	71f92197-db18-494d-b974-05348adeda1b	2	17	2017-07-07 11:02:06	2017-07-07 11:09:51	75.8669550999999984	22.7001251999999987	75.8669550999999984	22.7001251999999987	geo	2017-07-07 11:02:05	2017-07-07 11:09:51	f	f
533	ec68264e-97bb-433e-b490-d4f344dc93b6	157	18	2017-07-25 22:10:33	2017-07-25 22:11:12	-82.0280000000000058	27.0152000000000001	-82.0280999999999949	27.0152000000000001	geo	2017-07-25 22:10:33	2017-07-25 22:11:12	f	f
381	79114f51-e9f1-470a-95db-52723b7324cf	166	20	2017-07-06 19:28:23	2017-07-06 19:30:48	90	90	-82.536412900000002	27.3383074999999991	manual	2017-07-06 19:28:22	2017-07-06 19:30:48	t	f
527	b780cf4a-b124-4dc0-9035-c8bfb1e2af3b	203	22	2017-07-25 22:09:58	2017-07-25 22:11:43	-82.0279000000000025	27.0152000000000001	-82.0280999999999949	27.0152000000000001	qr	2017-07-25 22:09:58	2017-07-25 22:11:43	t	t
539	98e337cf-cdc3-4782-a008-55bd400f6244	184	18	2017-07-25 22:11:06	2017-07-25 22:50:55	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	qr	2017-07-25 22:11:05	2017-07-25 22:50:55	f	f
374	fab2708b-6173-407a-a1c3-3e245d64a037	173	22	2017-07-06 18:18:40	2017-07-06 20:22:43	90	90	90	90	manual	2017-07-06 18:18:39	2017-07-06 20:22:43	t	t
375	066acaf0-41c1-4fbe-8816-c1ce9d0bf93b	174	22	2017-07-06 18:18:42	2017-07-06 20:22:48	90	90	90	90	manual	2017-07-06 18:18:42	2017-07-06 20:22:48	t	t
376	bcdeedcb-bbb3-40fb-bbd8-b46845de9fa6	177	22	2017-07-06 18:18:48	2017-07-06 20:22:54	90	90	90	90	manual	2017-07-06 18:18:47	2017-07-06 20:22:54	t	t
377	efa416ee-46cd-4fc6-b2fc-df19a8fee0c7	180	22	2017-07-06 18:18:50	2017-07-06 20:22:59	90	90	90	90	manual	2017-07-06 18:18:50	2017-07-06 20:22:59	t	t
378	a704f363-33ed-407e-8f4b-be211beb8ea2	181	22	2017-07-06 18:18:54	2017-07-06 20:23:03	90	90	90	90	manual	2017-07-06 18:18:53	2017-07-06 20:23:03	t	t
379	61e0741b-0e89-401a-8487-511544125099	184	22	2017-07-06 18:18:57	2017-07-06 20:23:07	90	90	90	90	manual	2017-07-06 18:18:56	2017-07-06 20:23:07	t	t
367	5ce134e5-e9aa-42d8-80d7-2d268d4cc0d4	170	18	2017-07-06 18:17:57	2017-07-06 20:23:20	90	90	90	90	manual	2017-07-06 18:17:56	2017-07-06 20:23:20	t	t
537	fccd429c-2325-4129-b9fb-590bd6f84550	179	18	2017-07-25 22:10:57	2017-07-25 22:51:01	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	qr	2017-07-25 22:10:56	2017-07-25 22:51:01	f	f
388	ebd5cd15-0586-426e-b5a9-b4e99127427a	2	17	2017-07-07 11:09:59	2017-07-10 13:02:54	75.8669550999999984	22.7001251999999987	75.8669493999999958	22.700130399999999	geo	2017-07-07 11:09:59	2017-07-10 13:02:54	f	f
535	3e6a7573-5b8a-41b3-a91f-185772337778	174	18	2017-07-25 22:10:47	2017-07-25 22:51:08	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	qr	2017-07-25 22:10:47	2017-07-25 22:51:08	f	f
391	f566ee82-6f0c-423e-8ff0-e9d5d69a5693	2	17	2017-07-10 13:03:03	2017-07-10 13:03:26	75.8669486000000006	22.7001311000000001	75.8669454999999999	22.7001339999999985	geo	2017-07-10 13:03:03	2017-07-10 13:03:26	f	t
541	cda414dd-8471-402f-9847-b55b708c6845	157	18	2017-07-25 22:11:57	2017-07-25 22:51:23	-82.0280999999999949	27.0152000000000001	-82.0280999999999949	27.0152000000000001	geo	2017-07-25 22:11:57	2017-07-25 22:51:23	f	f
392	f16e84bc-e0c3-43ce-b718-eca351cb685c	2	17	2017-07-10 13:03:31	2017-07-10 13:06:03	75.8669459999999987	22.7001334999999997	75.8669902999999977	22.7001050000000006	geo	2017-07-10 13:03:30	2017-07-10 13:06:03	t	t
393	63e1f8b3-adb9-460d-8d6b-73e3982806aa	133	16	2017-07-10 13:08:20	2017-07-10 13:08:33	75.8669550999999984	22.7001251999999987	75.8669550999999984	22.7001251999999987	geo	2017-07-10 13:08:19	2017-07-10 13:08:33	t	t
394	e0daef1f-b966-4fd8-8936-4114f6c7b1e1	133	16	2017-07-10 13:08:38	2017-07-10 13:09:31	75.8669550999999984	22.7001251999999987	75.8670864999999992	22.7000884999999997	geo	2017-07-10 13:08:38	2017-07-10 13:09:31	t	t
395	72699957-0431-4843-8969-e65bbe2d9fa3	2	17	2017-07-10 13:13:50	2017-07-10 13:25:44	75.8670544999999947	22.7000932999999989	75.8669550999999984	22.7001251999999987	geo	2017-07-10 13:13:49	2017-07-10 13:25:44	t	f
396	2aa906f2-737f-4c43-90e8-bb17d2557307	2	17	2017-07-10 13:29:45	2017-07-10 13:29:53	75.866948899999997	22.7001309000000013	75.8669507999999979	22.7001291000000016	geo	2017-07-10 13:29:45	2017-07-10 13:29:53	f	f
397	4bb48068-00ae-4e80-b716-01b6ee4b5790	2	17	2017-07-10 13:36:13	2017-07-10 13:37:43	75.8669550999999984	22.7001251999999987	75.8669436999999931	22.7001355999999994	geo	2017-07-10 13:36:12	2017-07-10 13:37:43	f	t
398	40244d55-f8d0-448a-9202-d58f96d9b619	2	17	2017-07-10 13:37:47	2017-07-10 13:37:55	75.8669436999999931	22.7001355999999994	75.8669436999999931	22.7001355999999994	geo	2017-07-10 13:37:47	2017-07-10 13:37:55	t	t
399	99736a7c-8d99-4c58-8884-bad90676874d	2	17	2017-07-10 13:44:18	2017-07-10 13:44:31	75.8669436999999931	22.7001355999999994	75.8669436999999931	22.7001355999999994	geo	2017-07-10 13:44:18	2017-07-10 13:44:31	t	t
400	e4e7895a-56bc-48d6-a948-3bbe970412d7	2	17	2017-07-10 13:44:44	2017-07-10 13:44:49	75.8669471999999985	22.7001324000000011	75.8669481999999959	22.7001315000000012	geo	2017-07-10 13:44:43	2017-07-10 13:44:49	t	f
401	5ac4f678-4d4a-4118-9dca-2aa78e2072ac	2	17	2017-07-10 13:45:04	2017-07-10 13:45:38	75.8669771999999938	22.7001227000000014	75.8670046000000013	22.7001145999999991	geo	2017-07-10 13:45:03	2017-07-10 13:45:38	t	t
402	50d4bdf7-0f12-4fa1-b106-8a7e106d1120	2	17	2017-07-10 13:46:01	2017-07-10 13:48:11	75.8670058000000012	22.7001142000000016	75.8669550999999984	22.7001251999999987	geo	2017-07-10 13:46:00	2017-07-10 13:48:11	t	t
553	e51a562b-2922-4b1b-b828-d77f39614ac9	173	22	2017-07-26 12:36:44	2017-07-26 15:44:27	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:36:44	2017-07-26 15:44:27	t	f
403	e8115505-0c40-4f39-8a9a-17070e107d3e	2	17	2017-07-10 13:48:21	2017-07-10 13:48:59	75.8669512999999966	22.7001287000000005	75.8669461000000069	22.7001334999999997	geo	2017-07-10 13:48:20	2017-07-10 13:48:59	t	t
404	87d15f6e-ac9a-4f34-8179-7841b29c9891	2	17	2017-07-10 13:49:04	2017-07-10 13:49:18	75.8669461000000069	22.7001334999999997	75.8669454000000059	22.7001340999999996	geo	2017-07-10 13:49:04	2017-07-10 13:49:18	t	t
405	efc789e8-049e-4c56-9648-7f15d27278c3	2	17	2017-07-10 13:49:59	2017-07-10 14:13:56	75.8669452000000035	22.7001342000000008	75.8669550999999984	22.7001251999999987	geo	2017-07-10 13:49:58	2017-07-10 14:13:56	t	t
383	03886a7f-f94f-48bd-a5fe-ff53542baac1	169	20	2017-07-06 19:39:42	2017-07-10 19:37:58	90	90	90	90	manual	2017-07-06 19:39:41	2017-07-10 19:37:58	t	t
380	703257ed-0a54-4b64-b36b-7f096fe1d206	176	20	2017-07-06 18:24:09	2017-07-10 19:38:03	90	90	90	90	manual	2017-07-06 18:24:09	2017-07-10 19:38:03	t	t
384	ea507b54-0db3-4df0-8b11-4594c0969a20	171	20	2017-07-06 19:39:49	2017-07-10 19:38:08	90	90	90	90	manual	2017-07-06 19:39:48	2017-07-10 19:38:08	t	t
382	7f2c6c27-d0d4-43c8-94b7-fd1216f607ed	166	20	2017-07-06 19:32:15	2017-07-10 19:38:37	90	90	90	90	manual	2017-07-06 19:32:15	2017-07-10 19:38:37	t	t
407	0f9441a2-32c6-4182-b50b-55df3cae18c2	176	20	2017-07-10 20:01:34	\N	90	90	\N	\N	manual	2017-07-10 20:01:34	2017-07-10 20:01:34	t	f
406	9d1ae21d-7533-4cb3-b260-e27c1914e376	2	17	2017-07-10 14:14:04	2017-07-11 06:47:48	75.8669519000000037	22.7001281000000006	75.8669436999999931	22.7001355999999994	geo	2017-07-10 14:14:04	2017-07-11 06:47:48	t	t
410	aa209c9a-a592-410d-94cb-8039652c73d5	133	16	2017-07-11 07:05:48	2017-07-11 07:11:34	75.8670039000000003	22.7001014000000012	75.8669550999999984	22.7001251999999987	geo	2017-07-11 07:05:48	2017-07-11 07:11:34	t	t
411	433ff167-a8b6-4cf5-a57d-62184f503953	133	16	2017-07-11 07:12:18	2017-07-11 07:14:12	75.867133999999993	22.7000382000000016	75.8670517000000046	22.7001014999999988	geo	2017-07-11 07:12:18	2017-07-11 07:14:12	t	t
412	502bcf0f-572c-4ef1-aa05-b86592d2a440	2	17	2017-07-11 07:15:08	\N	75.8669663999999955	22.7001148999999991	\N	\N	geo	2017-07-11 07:15:08	2017-07-11 07:15:08	t	f
414	2868531c-cf64-4dc8-b5fd-875f1d1e46fe	135	16	2017-07-11 07:25:00	2017-07-11 07:27:44	75.8669550999999984	22.7001251999999987	75.8669550999999984	22.7001251999999987	manual	2017-07-11 07:24:59	2017-07-11 07:27:44	t	t
419	d963c0bd-aed8-447f-9c50-b571bcca52e2	176	20	2017-07-11 15:22:20	\N	90	90	\N	\N	manual	2017-07-11 15:22:20	2017-07-11 15:22:20	t	f
524	b2d68c37-a062-4a9c-bc9e-686b3049223d	157	18	2017-07-25 21:29:59	2017-07-25 21:31:36	-82.0280999999999949	27.0152000000000001	-82.0280999999999949	27.0151000000000003	geo	2017-07-25 21:29:59	2017-07-25 21:31:36	f	f
421	13852964-e8a6-4c42-aab9-1349ea4266c8	202	20	2017-07-14 14:54:13	2017-07-14 15:38:55	90	90	90	90	manual	2017-07-14 14:54:12	2017-07-14 15:38:55	t	t
422	dfcc3a2e-ca1d-4c01-80a5-1fdaf04627dc	202	20	2017-07-14 15:39:00	2017-07-14 15:39:01	90	90	90	90	manual	2017-07-14 15:38:59	2017-07-14 15:39:01	t	t
423	1df72400-e7d7-4f08-bbb7-d5ea649f9e19	202	20	2017-07-14 15:39:04	\N	90	90	\N	\N	manual	2017-07-14 15:39:04	2017-07-14 15:39:04	t	f
413	1570c03d-65af-4d5a-b7d0-95350c93ee0d	133	16	2017-07-11 07:23:50	2017-07-17 07:36:22	75.8669550999999984	22.7001251999999987	75.8669550999999984	22.7001251999999987	geo	2017-07-11 07:23:49	2017-07-17 07:36:22	t	t
424	87f94db5-5d47-4fc7-9eb6-1d1f4411b490	133	16	2017-07-17 07:38:39	2017-07-17 07:48:54	75.8669584000000015	22.7001251000000011	75.8669550999999984	22.7001251999999987	geo	2017-07-17 07:38:39	2017-07-17 07:48:54	t	t
428	5f5497b1-bc19-4ab5-b58e-1b48cc7ba654	211	25	2017-07-17 18:06:07	2017-07-17 19:04:33	90	90	-82.536412900000002	27.3383132000000018	manual	2017-07-17 18:06:06	2017-07-17 19:04:33	t	f
427	1cd8ce69-5e7d-47cb-8ee1-a971c4eb79e4	210	25	2017-07-17 18:06:01	2017-07-17 19:29:39	90	90	-82.536412900000002	27.3383074999999991	manual	2017-07-17 18:06:01	2017-07-17 19:29:39	t	f
429	db05effe-581e-4c78-b0d4-789bf755bb5e	212	25	2017-07-17 18:06:12	2017-07-17 19:31:18	90	90	-82.536402300000006	27.338318300000001	manual	2017-07-17 18:06:12	2017-07-17 19:31:18	t	f
430	9cce2125-bbcf-45b9-bc67-1cc8d2215eec	213	25	2017-07-17 18:06:26	2017-07-17 19:45:02	90	90	90	90	manual	2017-07-17 18:06:26	2017-07-17 19:45:02	t	t
431	13d02582-2f68-4cd9-b1c7-ba17a545bb08	214	25	2017-07-17 18:06:32	2017-07-17 19:45:06	90	90	90	90	manual	2017-07-17 18:06:31	2017-07-17 19:45:06	t	t
432	560acb3b-3ab3-413f-a421-9c553f78e69b	215	25	2017-07-17 18:06:36	2017-07-17 19:45:13	90	90	90	90	manual	2017-07-17 18:06:35	2017-07-17 19:45:13	t	t
433	2ce2b753-32f8-4657-9b05-b7a05e260046	216	25	2017-07-17 18:06:42	2017-07-17 19:45:20	90	90	90	90	manual	2017-07-17 18:06:42	2017-07-17 19:45:20	t	t
426	69cbb381-7dd8-4b8e-ace9-fd9d012bdfaf	209	25	2017-07-17 18:05:29	2017-07-17 19:46:12	90	90	90	90	manual	2017-07-17 18:05:28	2017-07-17 19:46:12	t	t
425	88bd04ee-5347-48bd-86a7-d438c01244de	133	16	2017-07-17 09:57:42	2017-07-18 09:08:24	75.8674316000000033	22.6998719999999992	75.8672501000000068	22.6998557000000005	geo	2017-07-17 09:57:42	2017-07-18 09:08:24	t	t
437	4f514c82-d7e3-4f8d-8ebe-e28fc4de9fe3	208	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-18 17:24:35	2017-07-18 17:24:35	f	f
438	78fecbe3-8d73-4239-a5e3-ceb99988f546	208	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-18 17:24:35	2017-07-18 17:24:35	f	f
439	2dbade36-1ff8-4b3f-a00e-faf1c099ff61	208	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-18 17:24:35	2017-07-18 17:24:35	f	f
440	698d02bb-061d-499b-963e-f154e1a106a7	208	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-18 17:24:35	2017-07-18 17:24:35	f	f
441	6f75dc2a-f1f9-45f9-8d2e-5e666f6db1a4	208	25	2017-07-05 07:00:00	2017-07-05 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-18 17:24:35	2017-07-18 17:24:35	f	f
436	e7111e63-5ffa-44e7-80fa-da83cfe7481b	133	16	2017-07-18 09:08:26	2017-07-19 07:36:01	75.8672284000000019	22.6999515000000009	75.8671819999999997	22.7000545000000002	geo	2017-07-18 09:08:26	2017-07-19 07:36:01	t	f
442	18997c3e-e9dd-432b-a717-d5d37351c487	133	16	2017-07-19 09:34:27	2017-07-19 09:34:36	75.8672274000000044	22.6998992000000008	75.8671819999999997	22.7000545000000002	geo	2017-07-19 09:34:27	2017-07-19 09:34:36	f	f
443	03bea878-d341-445b-8332-967b863e1596	133	16	2017-07-19 09:34:43	2017-07-19 09:35:17	75.8671819999999997	22.7000545000000002	75.867247699999993	22.7000001000000005	geo	2017-07-19 09:34:42	2017-07-19 09:35:17	f	f
446	5d500b91-9c7d-41e9-97f8-9dcef7dae42e	209	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
447	0fcab529-efe2-4972-a0fc-01d7c3c2dd07	209	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
448	db8c6e8b-4013-4a5d-adff-4c9ad35f6f01	209	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
449	9a94fe54-b316-4394-a539-76fb118008fb	209	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
450	fe5d57a7-4eb6-4486-948d-af750cd4b4e7	209	25	2017-07-05 07:00:00	2017-07-05 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
451	87d07a6e-95d1-414c-8577-768e448f38ee	210	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
452	30814d98-0e76-4133-873c-436305b3a0ff	210	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
453	f3cc22c0-57e3-45cf-a9dd-0e56ec7f6d9f	210	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
454	a616b593-e27f-42e5-bf30-4dddc98eef17	210	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
455	e995a887-e81d-45bb-b4a4-efe54dc855d1	210	25	2017-07-05 07:00:00	2017-07-05 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
456	633de3a7-cf78-4491-bf52-8add2f88d863	211	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
457	4b2a73dd-cf46-4cf8-9a74-17a676d7e4b3	211	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
458	9c2c00fd-6956-477a-a057-1a4b098d2f2e	211	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
459	457835db-1290-41f9-9f12-5ae1e184fd05	211	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
460	197ebaf6-1c20-47e4-b11f-6b4d712c4689	211	25	2017-07-05 07:00:00	2017-07-05 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
461	1be6c146-c7cd-44b9-993f-7bb7bcdcf13b	212	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
462	605ffed1-4bde-4a54-ac40-8570a308ae7d	212	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
463	fd242eb3-ad23-442a-be8b-cd5e7c6dcf19	212	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
464	32cfa0d5-8e8f-4f4c-90b9-c5774bcabab4	212	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
465	556d5354-a86e-42ef-92e3-7f0886f2a0c1	212	25	2017-07-05 07:00:00	2017-07-05 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:29:44	2017-07-19 20:29:44	f	f
466	dac97672-a3f4-4da0-8577-aac41c988888	213	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
467	b254eeb2-1c3a-4fc4-8876-26f27d18f178	213	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
468	0b5bb5df-e254-4bc8-9afe-02259a2f3732	213	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
469	d9a76ac1-1f79-4320-a846-744b9251d7a6	213	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
470	a8be3d67-0cd8-49b2-81c6-ef493633203f	214	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
471	7122bacb-795a-4438-a7e4-17a47136fe06	214	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
472	0ba6c948-4136-44ca-b2ac-affb2636404d	214	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
473	1d42c59d-ff89-4c34-abc0-4d707606c125	214	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
474	0255669b-9154-4d70-ad0f-1130c04ba526	215	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
475	593ccd4f-b2c4-4ff6-bb6a-863deb611a71	215	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:33:29	2017-07-19 20:33:29	f	f
476	b2e12942-4965-4d01-b37e-ac4fa8412d8c	215	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:30	2017-07-19 20:33:30	f	f
477	cde7a603-7212-47d8-8cf4-d391c0c20073	215	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:30	2017-07-19 20:33:30	f	f
478	567b6c10-c229-46f6-973a-dd204d98b00d	216	25	2017-07-01 07:00:00	2017-07-11 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:30	2017-07-19 20:33:30	f	f
479	ba53dd60-d2a7-4e7c-903d-f7174e79b7fb	216	25	2017-07-02 07:00:00	2017-07-02 17:00:00	27.3352973699999993	-82.5321069499999993	27.312339999999999	-82.577606000000003	geo	2017-07-19 20:33:30	2017-07-19 20:33:30	f	f
480	ce4c0d17-1ebf-411f-b729-dca6f986d2a3	216	25	2017-07-03 07:00:00	2017-07-03 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:30	2017-07-19 20:33:30	f	f
481	1d52571b-7713-4381-a0c5-13ffc7b5ea97	216	25	2017-07-04 07:00:00	2017-07-04 17:00:00	27.3352973699999993	-82.5321069499999993	27.3352973699999993	-82.5321069499999993	geo	2017-07-19 20:33:30	2017-07-19 20:33:30	f	f
444	3671693d-2c30-43e6-b236-49411f4edc4f	133	16	2017-07-19 09:35:24	2017-07-20 06:44:03	75.8672633000000047	22.6999904999999984	75.8671707000000026	22.700064900000001	geo	2017-07-19 09:35:23	2017-07-20 06:44:03	f	f
485	2b8928df-02da-458e-bb47-71ec372f9b80	173	22	2017-07-20 15:28:07	2017-07-25 21:27:51	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:28:07	2017-07-25 21:27:51	f	t
487	ec2a8685-7f69-47f3-986b-69813a072825	177	22	2017-07-20 15:28:17	2017-07-25 21:29:04	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:28:16	2017-07-25 21:29:04	f	t
483	3faee770-5966-4041-a29b-e79b20d8577c	157	22	2017-07-20 15:18:07	2017-07-20 15:26:55	-82.5418564999999944	27.3460256999999984	-82.536412900000002	27.3383074999999991	geo	2017-07-20 15:18:07	2017-07-20 15:26:55	t	f
488	a6d5b274-e17f-4b11-800f-c8ae2bad886c	184	22	2017-07-20 15:30:35	2017-07-25 21:29:09	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	qr	2017-07-20 15:30:34	2017-07-25 21:29:09	f	t
484	2a8b6765-cbe6-455c-aef7-5ead9c6d0b23	157	22	2017-07-20 15:27:02	2017-07-20 15:33:19	-82.536412900000002	27.3383074999999991	-82.5364043000000009	27.3383345999999996	geo	2017-07-20 15:27:02	2017-07-20 15:33:19	f	f
490	9fa3527e-582d-45d7-92b6-03e39f8dc9f2	180	22	2017-07-20 15:33:06	2017-07-25 21:29:19	90	90	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:33:05	2017-07-25 21:29:19	t	t
491	a0f1afb5-ad5a-4503-8489-71379c6fcc2a	157	18	2017-07-20 15:33:34	2017-07-20 15:35:42	-82.5364043000000009	27.3383345999999996	-82.536412900000002	27.3383074999999991	geo	2017-07-20 15:33:33	2017-07-20 15:35:42	t	t
486	32492632-f167-436f-a2f3-66725679f022	174	22	2017-07-20 15:28:13	2017-07-25 21:29:22	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:28:12	2017-07-25 21:29:22	f	t
489	0eeb347c-eec1-4acb-a315-b2b417951d4b	181	22	2017-07-20 15:31:21	2017-07-25 21:29:43	-82.5364255000000071	27.3383082000000002	-82.0280999999999949	27.0152000000000001	qr	2017-07-20 15:31:20	2017-07-25 21:29:43	f	t
498	1747be16-059c-48f5-bf8b-28f0502c86bd	157	22	2017-07-20 15:35:49	2017-07-25 21:29:54	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	geo	2017-07-20 15:35:48	2017-07-25 21:29:54	f	t
501	cba65058-c5a0-49f0-9b91-81f799970a4b	214	25	2017-07-20 18:52:55	2017-07-20 19:02:19	-82.536412900000002	27.3383074999999991	-82.536412900000002	27.3383074999999991	geo	2017-07-20 18:52:55	2017-07-20 19:02:19	f	f
497	fbe21c5c-f352-4fa4-9e73-8745541a1f9f	183	18	2017-07-20 15:34:43	2017-07-25 21:31:03	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:34:43	2017-07-25 21:31:03	t	f
500	e627867b-24b9-4492-8e50-6082667d336a	210	25	2017-07-20 18:51:34	2017-07-20 19:03:38	-82.536412900000002	27.3383150000000015	-82.536412900000002	27.3383074999999991	geo	2017-07-20 18:51:33	2017-07-20 19:03:38	f	f
502	3664f940-9509-41ed-ba02-716c6bd14681	214	25	2017-07-20 19:03:07	2017-07-20 19:05:22	-82.5364117999999962	27.3383086000000013	-82.5364110000000011	27.3383094	geo	2017-07-20 19:03:07	2017-07-20 19:05:22	f	f
499	c0bcf45e-a400-4356-855e-6eb05031a01d	208	25	2017-07-20 18:23:25	2017-07-20 19:05:30	-82.536402300000006	27.338318300000001	-82.5364114999999998	27.3383089000000012	geo	2017-07-20 18:23:24	2017-07-20 19:05:30	f	f
495	14015734-417f-4fe3-8c57-76630313dc64	179	18	2017-07-20 15:34:31	2017-07-25 21:31:08	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:34:30	2017-07-25 21:31:08	t	f
494	fac7dd43-7fea-4ab3-ac5a-71d0af52dca4	178	18	2017-07-20 15:34:25	2017-07-25 21:31:13	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:34:25	2017-07-25 21:31:13	t	f
503	8620839f-4454-4ab7-9fa8-93e01ff43329	208	25	2017-07-20 20:35:56	2017-07-20 21:20:56	-82.536412900000002	27.3383074999999991	-82.5024753999999945	27.363366899999999	geo	2017-07-20 20:35:56	2017-07-20 21:20:56	f	t
496	fd3e363e-c003-4536-b90a-ac45ec615778	182	18	2017-07-20 15:34:37	2017-07-25 21:31:17	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:34:37	2017-07-25 21:31:17	t	f
493	7a2c4167-dea5-43ea-9d2a-61a76613d725	175	18	2017-07-20 15:34:20	2017-07-25 21:31:22	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	manual	2017-07-20 15:34:19	2017-07-25 21:31:22	t	f
492	2f266cf0-1230-4467-a854-1ce3f7d992cc	170	18	2017-07-20 15:34:09	2017-07-25 21:31:29	-82.536412900000002	27.3383074999999991	-82.0280999999999949	27.0152000000000001	qr	2017-07-20 15:34:09	2017-07-25 21:31:29	t	f
508	e641c40a-82bb-4b28-8d0c-2096eb75f667	213	25	2017-07-20 21:39:42	2017-07-21 15:18:36	-82.5024362999999994	27.3633719999999983	-82.5625887000000063	27.4949292000000014	geo	2017-07-20 21:39:41	2017-07-21 15:18:36	t	t
505	e5041810-72ba-4d67-976e-c1372f5a3c26	214	25	2017-07-20 21:22:55	2017-07-21 15:19:44	-82.5025049999999993	27.3633698999999986	-82.5625873999999982	27.4949267999999982	geo	2017-07-20 21:22:54	2017-07-21 15:19:44	t	t
506	c8c66a2b-519b-46bb-ac30-ab022d888133	215	25	2017-07-20 21:38:44	2017-07-21 15:20:21	-82.5024944000000033	27.3633808000000016	-82.5625765999999999	27.4950058000000013	geo	2017-07-20 21:38:44	2017-07-21 15:20:21	t	t
507	27def8e3-5a9c-4851-b9b4-8262a53bac33	216	25	2017-07-20 21:39:08	2017-07-21 15:20:47	-82.5024837999999932	27.3633687999999999	-82.5625873999999982	27.4949267999999982	geo	2017-07-20 21:39:08	2017-07-21 15:20:47	t	t
504	6eddfce3-e47b-418d-a103-fc89b7655de3	210	25	2017-07-20 20:40:47	2017-07-21 15:22:23	-82.536412900000002	27.3383074999999991	-82.5625519000000025	27.4950514999999989	geo	2017-07-20 20:40:47	2017-07-21 15:22:23	f	t
509	51451fcb-6281-4dd1-ac60-81e9c1f18b32	208	25	2017-07-21 17:26:36	2017-07-21 20:15:38	-82.5024779000000024	27.3633449999999989	-82.5024779000000024	27.3633449999999989	geo	2017-07-21 17:26:35	2017-07-21 20:15:38	t	t
510	6f5db8fe-3516-400c-96bb-a10b2165a4ba	216	25	2017-07-21 20:35:13	2017-07-21 21:45:12	-82.5024779000000024	27.3633449999999989	-82.5024779000000024	27.3633449999999989	geo	2017-07-21 20:35:12	2017-07-21 21:45:12	t	t
525	e45c0eaa-bf14-44d0-9cc0-99859618ac9f	157	22	2017-07-25 22:09:45	2017-07-25 22:10:29	-82.0279000000000025	27.0152000000000001	-82.0280000000000058	27.0152000000000001	geo	2017-07-25 22:09:44	2017-07-25 22:10:29	t	t
511	b8c4c625-e550-4737-a776-fa72cf2dae8d	208	25	2017-07-22 15:18:03	2017-07-22 20:24:48	-82.5024779000000024	27.3633449999999989	-82.5024779000000024	27.3633449999999989	geo	2017-07-22 15:18:02	2017-07-22 20:24:48	t	t
512	7b8d6c5c-1887-46a4-b5a9-b3257f5d61ef	208	25	2017-07-23 20:57:47	2017-07-24 14:19:12	-82.5024779000000024	27.3633449999999989	-82.536412900000002	27.3383074999999991	geo	2017-07-23 20:57:47	2017-07-24 14:19:12	t	f
513	f9745c79-4dac-442d-8583-e28a5092f2be	208	25	2017-07-24 14:19:32	2017-07-24 15:50:26	-82.5364107999999987	27.3383095999999988	-82.536402300000006	27.338318300000001	geo	2017-07-24 14:19:32	2017-07-24 15:50:26	f	f
514	0b0f96e3-350c-4389-929e-ac72162ab675	208	25	2017-07-24 20:47:06	2017-07-24 21:49:32	-82.5024779000000024	27.3633449999999989	-82.5024779000000024	27.3633449999999989	geo	2017-07-24 20:47:06	2017-07-24 21:49:32	t	t
482	e4c71620-9ab7-4ba2-b85c-05b09e5378ce	133	16	2017-07-20 06:44:08	2017-07-25 11:20:17	75.8671707000000026	22.700064900000001	75.8688350999999983	22.7006580999999983	geo	2017-07-20 06:44:07	2017-07-25 11:20:17	f	f
515	ea7b2b42-634b-4035-825c-cc32a781bd10	133	16	2017-07-25 11:21:01	2017-07-25 11:36:15	75.8688343999999972	22.7006580000000007	75.8671819999999997	22.7000545000000002	geo	2017-07-25 11:21:00	2017-07-25 11:36:15	f	f
540	d414a7ed-9159-4d77-bf7b-cf2838e06711	157	22	2017-07-25 22:11:21	2017-07-25 22:11:53	-82.0280000000000058	27.0152000000000001	-82.0280999999999949	27.0152000000000001	geo	2017-07-25 22:11:20	2017-07-25 22:11:53	t	t
516	2dbd5263-003f-430a-b1a1-feb31b9a75f3	133	16	2017-07-25 11:38:15	2017-07-25 11:46:37	75.8688386000000037	22.7006583999999982	75.8688386000000037	22.7006583999999982	geo	2017-07-25 11:38:15	2017-07-25 11:46:37	f	f
517	27942135-8aa2-4ecd-beb8-c826bcea3240	133	16	2017-07-25 11:46:41	2017-07-25 11:49:21	75.8688386000000037	22.7006583999999982	75.8688386000000037	22.7006583999999982	geo	2017-07-25 11:46:40	2017-07-25 11:49:21	f	f
538	782097b9-8305-4b78-9678-a082fac2f48e	182	18	2017-07-25 22:11:04	2017-07-25 22:50:58	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	qr	2017-07-25 22:11:03	2017-07-25 22:50:58	f	f
518	1ea2bc2b-881a-4f5e-8853-57af47321c0d	133	16	2017-07-25 11:49:26	2017-07-25 12:04:09	75.8671819999999997	22.7000317000000003	75.867204700000002	22.6999655000000011	geo	2017-07-25 11:49:25	2017-07-25 12:04:09	f	f
536	9422d0a1-291c-4c8a-85c0-7e5c17b7c144	177	18	2017-07-25 22:10:55	2017-07-25 22:51:03	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	qr	2017-07-25 22:10:54	2017-07-25 22:51:03	f	f
519	d2a8557f-e956-4312-9bc8-f05439400ef6	133	16	2017-07-25 12:04:30	2017-07-25 12:04:55	75.8671819999999997	22.7000545000000002	75.8688386000000037	22.7006583999999982	geo	2017-07-25 12:04:30	2017-07-25 12:04:55	f	f
542	71b2a3ec-bfb0-40d1-85ac-0c8e8b255b8f	203	18	2017-07-25 22:12:21	2017-07-25 22:51:05	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	qr	2017-07-25 22:12:21	2017-07-25 22:51:05	f	f
520	9625c1ea-934c-4c29-80eb-50bb912bdb57	133	16	2017-07-25 12:04:59	2017-07-25 12:07:28	75.8688386000000037	22.7006583999999982	75.8688386000000037	22.7006583999999982	geo	2017-07-25 12:04:58	2017-07-25 12:07:28	f	f
534	c473e7f4-d2f6-48f3-881e-2e57bf089581	170	18	2017-07-25 22:10:45	2017-07-25 22:51:10	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	qr	2017-07-25 22:10:45	2017-07-25 22:51:10	f	f
521	f9c64797-0083-4975-be06-7d8361d1f581	133	16	2017-07-25 12:10:32	2017-07-25 13:56:47	75.8672501000000068	22.6999011999999993	75.8671819999999997	22.7000545000000002	geo	2017-07-25 12:10:31	2017-07-25 13:56:47	f	f
532	6973bf48-a1d7-4f10-87f2-157458a96c1e	183	22	2017-07-25 22:10:14	2017-07-25 22:51:43	-82.0279000000000025	27.0152000000000001	-82.0280999999999949	27.0151000000000003	qr	2017-07-25 22:10:13	2017-07-25 22:51:43	t	t
531	0c3d2208-32df-4112-ae7d-a0b7f5a33622	181	22	2017-07-25 22:10:12	2017-07-25 22:51:45	-82.0279000000000025	27.0152000000000001	-82.0280999999999949	27.0151000000000003	qr	2017-07-25 22:10:11	2017-07-25 22:51:45	t	t
530	70aad38a-5566-4129-9976-2d3c295b16af	180	22	2017-07-25 22:10:06	2017-07-25 22:51:49	-82.0279000000000025	27.0152000000000001	-82.0280999999999949	27.0151000000000003	qr	2017-07-25 22:10:05	2017-07-25 22:51:49	t	t
529	4ac95ab9-ac90-479c-9b3f-b8bfcf644e65	178	22	2017-07-25 22:10:04	2017-07-25 22:51:52	-82.0279000000000025	27.0152000000000001	-82.0280999999999949	27.0151000000000003	qr	2017-07-25 22:10:03	2017-07-25 22:51:52	t	t
528	e0b59856-a42e-403a-870e-f8c82d2c054b	175	22	2017-07-25 22:10:01	2017-07-25 22:51:54	-82.0279000000000025	27.0152000000000001	-82.0280999999999949	27.0151000000000003	qr	2017-07-25 22:10:00	2017-07-25 22:51:54	t	t
543	f167b95d-1f96-4a60-b12e-2034f7ae4bf6	157	22	2017-07-25 22:51:34	2017-07-25 22:52:12	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	geo	2017-07-25 22:51:34	2017-07-25 22:52:12	t	t
545	9dedc1e2-a826-44f4-acc8-fd9608a732f2	157	18	2017-07-26 01:57:14	2017-07-26 01:57:16	-82.0279000000000025	27.0152000000000001	-82.0280000000000058	27.0152000000000001	geo	2017-07-26 01:57:14	2017-07-26 01:57:16	f	f
546	8f3bacf2-40ca-4ac6-aa64-4f50f70014a3	157	18	2017-07-26 01:57:24	2017-07-26 01:58:48	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	geo	2017-07-26 01:57:24	2017-07-26 01:58:48	f	f
547	1d401eea-de40-4d94-8fef-8a158241bd62	157	22	2017-07-26 01:59:47	2017-07-26 01:59:58	-82.0280999999999949	27.0152000000000001	-82.0280999999999949	27.0152000000000001	geo	2017-07-26 01:59:47	2017-07-26 01:59:58	t	t
523	31e2cf75-d45e-4e94-b3c1-74fe2767133e	133	16	2017-07-25 13:58:45	2017-07-26 09:38:48	75.8672698000000025	22.6999548000000004	75.8669550999999984	22.7001251999999987	geo	2017-07-25 13:58:45	2017-07-26 09:38:48	f	f
548	2d5ef548-1b5c-427d-a7d5-93b59827d435	133	16	2017-07-26 09:39:30	2017-07-26 09:41:30	75.8669601999999941	22.7001245999999988	75.8669436999999931	22.7001355999999994	geo	2017-07-26 09:39:30	2017-07-26 09:41:30	f	f
549	f17ab3c0-1a5f-4a0b-92c2-a7bb99bc5266	133	16	2017-07-26 09:41:41	2017-07-26 09:42:21	75.8669469000000021	22.7001327000000011	75.8669476000000031	22.700132	geo	2017-07-26 09:41:40	2017-07-26 09:42:21	f	f
550	0e0a9863-21e5-4511-9bc6-57a87efe3645	133	16	2017-07-26 09:42:45	2017-07-26 11:30:28	75.8669478000000055	22.7001318000000012	75.8669550999999984	22.7001251999999987	geo	2017-07-26 09:42:45	2017-07-26 11:30:28	f	f
551	2b760580-dfe2-429b-9c39-260f762d1d64	133	16	2017-07-26 12:13:32	2017-07-26 12:18:51	75.8674316000000033	22.6998719999999992	75.8669550999999984	22.7001251999999987	geo	2017-07-26 12:13:32	2017-07-26 12:18:51	f	f
766	b5ae5148-376a-44eb-b292-c90aee015fec	223	60	2017-08-16 21:04:44	2017-08-16 21:04:45	-82.5364000000000004	27.3382000000000005	-82.5364000000000004	27.3382000000000005	manual	2017-08-16 21:04:43	2017-08-16 21:04:45	f	f
629	f7d911aa-8cda-4f0b-be45-97bd8d904559	135	16	2017-07-29 06:51:53	2017-07-29 07:07:14	75.8670735000000036	22.6998491999999992	75.867204700000002	22.6998971999999988	geo	2017-07-29 06:51:53	2017-07-29 07:07:14	f	f
631	823b2d14-70b4-42e8-8837-1e69ab87db2d	135	16	2017-07-29 07:19:46	2017-07-29 08:01:59	75.8670589999999976	22.6998621999999983	75.867065199999999	22.6998537999999996	geo	2017-07-29 07:19:45	2017-07-29 08:01:59	f	f
633	cdd14a3c-a35b-4140-bb8d-9972a8bff051	135	16	2017-07-29 08:24:03	2017-07-29 08:24:49	75.867082300000007	22.6998740999999988	75.8671310999999946	22.699897	geo	2017-07-29 08:24:02	2017-07-29 08:24:49	f	f
635	d6291699-2bdf-4604-81a4-09fd5ec71bb0	135	16	2017-07-29 09:12:53	2017-07-29 09:13:10	75.8670646000000062	22.6998539000000008	75.8670639000000051	22.6998512999999988	geo	2017-07-29 09:12:53	2017-07-29 09:13:10	f	f
637	16b653ae-e3cd-4f8e-9ec6-4a119bcac2d7	135	16	2017-07-31 06:38:18	2017-07-31 06:42:11	75.867057200000005	22.6998539000000008	75.867057200000005	22.6998497999999991	manual	2017-07-31 06:38:17	2017-07-31 06:42:11	f	f
723	6ede561b-6cd5-4f78-9ea7-27e3d8b8dda6	135	16	2017-08-09 12:55:34	2017-08-17 07:26:49	75.8670573999999931	22.700062599999999	75.8670931000000053	22.6999944000000013	geo	2017-08-09 12:55:33	2017-08-17 07:26:49	f	f
721	3c10dcfc-05d5-4151-bc2c-e806dd34cd70	135	16	2017-08-09 12:51:05	2017-08-17 07:27:03	75.867173600000001	22.6998263000000016	75.867090300000001	22.6999949000000001	geo	2017-08-09 12:51:05	2017-08-17 07:27:03	f	f
628	5d3684df-2c51-4c90-9ff9-a8d69b1e0db5	208	25	2017-07-28 22:13:57	2017-07-31 18:11:49	-82.4830000000000041	27.2237000000000009	-82.5364000000000004	27.3383000000000003	geo	2017-07-28 22:13:56	2017-07-31 18:11:49	t	f
653	56763305-06b7-4d31-abd3-1d5e42b7cc45	174	18	2017-07-31 14:51:14	2017-07-31 18:32:52	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:51:14	2017-07-31 18:32:52	f	f
655	63288a2d-58c4-4aa0-b81d-25d970cffa21	177	18	2017-07-31 14:51:19	2017-07-31 18:32:56	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:51:18	2017-07-31 18:32:56	f	f
657	94c65b5a-750f-413b-8205-f423d3b52f29	182	18	2017-07-31 14:51:25	2017-07-31 18:33:02	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:51:24	2017-07-31 18:33:02	f	f
651	edad78d2-814c-49ce-84cb-07b2a4f5981b	157	18	2017-07-31 14:51:03	2017-07-31 18:33:10	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	geo	2017-07-31 14:51:02	2017-07-31 18:33:10	f	f
640	5d0ed120-6e90-4129-b469-3bd0618158f2	173	22	2017-07-31 14:50:17	2017-07-31 18:33:27	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:16	2017-07-31 18:33:27	t	t
642	e1be96b6-8e2c-4d55-8033-3db765df4c28	175	22	2017-07-31 14:50:26	2017-07-31 18:33:32	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:26	2017-07-31 18:33:32	t	t
644	282e3fc6-e424-4aaf-949d-654d8c7c8ec5	180	22	2017-07-31 14:50:30	2017-07-31 18:33:37	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:30	2017-07-31 18:33:37	t	t
646	f9837893-0883-4aea-a333-fca4ce117a0b	183	22	2017-07-31 14:50:36	2017-07-31 18:33:41	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:35	2017-07-31 18:33:41	t	t
648	b2efa0c3-0492-4260-9cee-bfbde999e5c2	219	22	2017-07-31 14:50:39	2017-07-31 18:33:45	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:39	2017-07-31 18:33:45	t	t
650	8aa300fd-371a-4767-8776-2d2104f07de4	221	22	2017-07-31 14:50:43	2017-07-31 18:33:48	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:43	2017-07-31 18:33:48	t	t
660	c9bc50b2-77b9-4c2b-ab79-05e4007a0f0d	157	22	2017-07-31 18:33:18	2017-07-31 18:33:59	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0152000000000001	geo	2017-07-31 18:33:18	2017-07-31 18:33:59	t	t
662	b9fc5b85-7d39-443c-b26f-a055a4fad4fb	223	25	2017-08-01 17:09:55	2017-08-01 17:10:04	-82.5394000000000005	27.3363000000000014	-82.5394000000000005	27.3363000000000014	geo	2017-08-01 17:09:55	2017-08-01 17:10:04	t	t
666	4af66d24-963b-4e5c-a9a3-737eefb66584	135	16	2017-08-03 10:42:58	2017-08-03 11:02:02	75.867057200000005	22.6998497999999991	75.8670458999999937	22.6998373999999998	geo	2017-08-03 10:42:58	2017-08-03 11:02:02	f	f
667	ebc0eddf-cea6-409e-9e38-147c9998f77a	135	16	2017-08-03 12:10:58	2017-08-03 12:14:46	75.8670458999999937	22.6998373999999998	75.8670513	22.6998390999999984	geo	2017-08-03 12:10:57	2017-08-03 12:14:46	f	f
669	75fb6b1a-9295-43d2-8363-1d1f2b1880b0	135	16	2017-08-03 12:17:02	2017-08-03 12:23:33	75.8670458999999937	22.6998373999999998	75.8670685999999961	22.6998393999999983	geo	2017-08-03 12:17:02	2017-08-03 12:23:33	f	f
671	de61f6b4-6fa8-4426-bdd7-2dfe58c4ba10	135	16	2017-08-03 13:40:58	2017-08-03 13:43:40	75.8670458999999937	22.6998373999999998	75.8670458999999937	22.6998373999999998	geo	2017-08-03 13:40:57	2017-08-03 13:43:40	f	f
673	c7136afe-3c7a-4a52-925e-aefd5eb969d3	135	16	2017-08-03 13:44:38	2017-08-03 13:45:59	75.8670458999999937	22.6998373999999998	75.8670458999999937	22.6998373999999998	geo	2017-08-03 13:44:37	2017-08-03 13:45:59	f	f
664	328f104e-9b2d-43c3-a7ff-ac078a629f07	157	22	2017-08-02 15:15:06	2017-08-03 15:00:03	-82.5362999999999971	27.3384	-82.5364000000000004	27.3383000000000003	geo	2017-08-02 15:15:06	2017-08-03 15:00:03	f	f
677	c2226707-9e62-4043-89e4-e314988bca5e	157	18	2017-08-03 15:00:14	2017-08-03 15:00:51	-82.5364000000000004	27.3383000000000003	-82.5361999999999938	27.3384	geo	2017-08-03 15:00:13	2017-08-03 15:00:51	t	t
697	3c5b818b-4414-4d3b-ba67-e770f44562fc	135	16	2017-08-04 10:38:47	2017-08-04 10:39:00	75.8670517999999987	22.6998378999999986	75.867049300000005	22.6998376999999998	geo	2017-08-04 10:38:47	2017-08-04 10:39:00	f	f
699	ea8553c4-4074-4bee-b91b-3880bae7d2ec	135	16	2017-08-04 10:40:08	2017-08-04 10:41:53	75.8670500000000061	22.6998382999999997	75.8671065000000056	22.6999491999999989	geo	2017-08-04 10:40:08	2017-08-04 10:41:53	f	f
701	f9ce9a08-68ca-4a2b-8347-20d91f9cc20b	135	16	2017-08-04 13:37:32	2017-08-04 13:38:45	75.8670958000000013	22.6999017999999992	75.8670685999999961	22.6998393999999983	geo	2017-08-04 13:37:32	2017-08-04 13:38:45	f	f
703	87e1b3d1-23b2-42a7-af0f-46282057f828	135	16	2017-08-04 13:40:27	2017-08-04 13:44:14	75.8671487000000013	22.6999086000000005	75.8670934000000017	22.6998914999999997	manual	2017-08-04 13:40:26	2017-08-04 13:44:14	f	f
711	096458f1-eb8b-4546-8b4c-dcd61cc8d2d9	208	45	2017-08-07 13:22:39	2017-08-07 13:22:51	-82.5027000000000044	27.3636000000000017	-82.5027000000000044	27.3636000000000017	manual	2017-08-07 13:22:39	2017-08-07 13:22:51	t	t
709	f7ad8430-7849-4284-b9b1-2015bff58f86	135	40	2017-08-04 14:25:56	2017-08-09 12:22:26	75.8670458999999937	22.6998373999999998	75.86721	22.6999116000000001	geo	2017-08-04 14:25:55	2017-08-09 12:22:26	f	f
707	54c97ee8-784c-4917-93fc-f321a15923d3	135	40	2017-08-04 14:20:10	2017-08-09 12:23:09	75.8670556999999945	22.6998482000000017	75.8670685999999961	22.6998621999999983	manual	2017-08-04 14:20:09	2017-08-09 12:23:09	f	f
705	4729510c-f07d-4d72-a885-cc5392e542d4	135	40	2017-08-04 14:01:23	2017-08-09 12:23:54	75.8670697000000018	22.6998603999999986	75.8670726000000002	22.6998666	manual	2017-08-04 14:01:23	2017-08-09 12:23:54	f	f
713	e6a5e02b-317d-4336-aef5-be3bf988b3ed	135	16	2017-08-09 12:20:37	2017-08-09 12:24:02	75.8672044000000056	22.6999069999999996	75.8670716999999968	22.699865599999999	geo	2017-08-09 12:20:37	2017-08-09 12:24:02	f	f
715	8ed504e3-3a6b-42a3-8e9b-c0d221d52a79	135	16	2017-08-09 12:27:16	2017-08-09 12:32:47	75.8671961999999951	22.6999054999999998	75.8672609000000051	22.699921100000001	geo	2017-08-09 12:27:15	2017-08-09 12:32:47	f	f
717	e20f4dfb-d75a-4612-8918-a8e1c5b8754d	135	16	2017-08-09 12:44:20	2017-08-09 12:49:48	75.867124000000004	22.6999022000000004	75.8672434000000067	22.6999279999999999	manual	2017-08-09 12:44:19	2017-08-09 12:49:48	f	f
724	dbfe330f-3f5c-4aba-8a8b-cd070b1a49be	135	16	2017-08-09 12:57:10	2017-08-09 12:59:15	75.8670685999999961	22.6998621999999983	75.8670685999999961	22.6998621999999983	geo	2017-08-09 12:57:10	2017-08-09 12:59:15	f	f
719	719d8107-e795-4436-bb11-098b92b45062	135	16	2017-08-09 12:49:55	2017-08-09 13:02:26	75.8672262000000046	22.6999215999999997	75.8671365999999949	22.6999366000000009	manual	2017-08-09 12:49:55	2017-08-09 13:02:26	f	f
725	42fb0ba3-47e4-4c95-9022-652b9a9c49a3	135	16	2017-08-09 13:02:38	2017-08-09 13:07:38	75.8670685999999961	22.6998621999999983	75.8670685999999961	22.6998621999999983	geo	2017-08-09 13:02:37	2017-08-09 13:07:38	f	f
687	dabdc831-0df2-471a-a29a-e68e360dbbb9	175	22	2017-08-03 15:01:05	2017-08-09 15:16:54	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:04	2017-08-09 15:16:54	f	f
689	c224732a-806c-46bd-b968-93cedaa23d53	180	22	2017-08-03 15:01:08	2017-08-09 15:16:57	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:08	2017-08-09 15:16:57	f	f
691	e8fdf092-c141-4e17-ad18-03110dc71ff7	183	22	2017-08-03 15:01:15	2017-08-09 15:17:08	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:14	2017-08-09 15:17:08	f	f
693	74b072b2-7339-4532-861c-658469576b6b	219	22	2017-08-03 15:01:18	2017-08-09 15:17:11	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:18	2017-08-09 15:17:11	f	f
695	6b51fb94-f51d-4d77-a2ff-eaa96c66cb4a	221	22	2017-08-03 15:01:21	2017-08-09 15:17:15	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:21	2017-08-09 15:17:15	f	f
679	804bdd77-9b28-4c23-8cb4-53f0efa187b1	174	18	2017-08-03 15:00:29	2017-08-09 15:27:59	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	qr	2017-08-03 15:00:29	2017-08-09 15:27:59	t	t
683	24c97f2e-67cf-4450-baa6-01540896591a	184	18	2017-08-03 15:00:40	2017-08-09 15:28:14	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	qr	2017-08-03 15:00:39	2017-08-09 15:28:14	t	t
675	1e06841b-e84f-4e8f-bc2a-dc7f253fb08e	133	16	2017-08-03 14:04:00	2017-08-16 12:15:26	75.8670458999999937	22.6998373999999998	75.8670646000000062	22.6998561000000016	geo	2017-08-03 14:03:59	2017-08-16 12:15:26	f	f
600	973b5ff1-6df6-400f-877b-2d98740e177c	208	25	2017-07-27 14:03:29	2017-07-28 15:17:36	-82.4491000000000014	27.3125	-82.5169000000000068	27.3896000000000015	geo	2017-07-27 14:03:28	2017-07-28 15:17:36	t	t
554	98e3dd4d-3b29-4ad7-ac77-09b8f591ca53	203	22	2017-07-26 12:36:48	2017-07-26 12:37:11	-82.0280999999999949	27.0152000000000001	-82.0280999999999949	27.0152000000000001	qr	2017-07-26 12:36:47	2017-07-26 12:37:11	t	t
770	d1d69246-ad08-4690-95d5-a678350913eb	135	16	2017-08-17 07:13:34	2017-08-17 07:26:08	75.8670798999999931	22.7000111999999987	75.8671018999999944	22.6999935000000015	geo	2017-08-17 07:13:34	2017-08-17 07:26:08	f	f
552	d42b1f5e-a95c-47a3-ad52-4f11f45fff36	157	22	2017-07-26 12:36:34	2017-07-26 12:39:44	-82.0280999999999949	27.0152000000000001	-82.0280999999999949	27.0152000000000001	geo	2017-07-26 12:36:34	2017-07-26 12:39:44	t	t
562	f6281680-61aa-40a4-8efc-fb7693cccc1c	157	18	2017-07-26 12:39:49	2017-07-26 12:40:32	-82.0280999999999949	27.0152000000000001	-82.0280000000000058	27.0152000000000001	geo	2017-07-26 12:39:48	2017-07-26 12:40:32	f	f
544	059608d1-95b1-4cd4-a1ce-bf2827181df4	208	25	2017-07-26 01:36:17	2017-07-26 13:10:55	-82.4830000000000041	27.2237000000000009	-82.5361999999999938	27.3384	geo	2017-07-26 01:36:17	2017-07-26 13:10:55	t	f
569	0ecd992b-8c8b-4d61-a344-d30967e1dadd	157	22	2017-07-26 12:40:41	2017-07-26 15:43:31	-82.0280000000000058	27.0152000000000001	-82.5362999999999971	27.3385999999999996	geo	2017-07-26 12:40:40	2017-07-26 15:43:31	t	f
579	b4b1251d-0f3d-478e-99f7-d74a2581d3af	157	18	2017-07-26 15:44:09	2017-07-26 15:44:15	-82.5362999999999971	27.3383000000000003	-82.5362999999999971	27.3383000000000003	geo	2017-07-26 15:44:09	2017-07-26 15:44:15	t	t
558	a1f33904-0c3a-47ba-97e5-588bd35fd99b	203	22	2017-07-26 12:37:47	2017-07-26 15:44:28	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:37:47	2017-07-26 15:44:28	t	f
555	640182b2-74b6-4707-850e-4afe3a970a8f	175	22	2017-07-26 12:37:40	2017-07-26 15:44:30	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:37:40	2017-07-26 15:44:30	t	f
556	770f9af2-d688-4f97-8d14-fc744b1a3d1d	178	22	2017-07-26 12:37:43	2017-07-26 15:44:32	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:37:43	2017-07-26 15:44:32	t	f
557	5fd3ed10-3df8-46ed-aada-6f8c3dcb1517	180	22	2017-07-26 12:37:45	2017-07-26 15:44:33	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:37:45	2017-07-26 15:44:33	t	f
559	a8aad8ab-e8d0-4419-96e7-5bab660bf11a	181	22	2017-07-26 12:37:52	2017-07-26 15:44:37	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:37:52	2017-07-26 15:44:37	t	f
560	df7e392e-cd05-4710-9877-a735df545b92	183	22	2017-07-26 12:37:55	2017-07-26 15:44:39	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:37:54	2017-07-26 15:44:39	t	f
561	4f540922-42a5-495e-bd49-62bb1fc2dcd8	218	22	2017-07-26 12:37:57	2017-07-26 15:44:41	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:37:56	2017-07-26 15:44:41	t	f
576	b280651d-0683-4899-bd73-4ce5731ed7d3	219	22	2017-07-26 15:41:18	2017-07-26 15:44:42	-82.5362999999999971	27.3384999999999998	-82.5362999999999971	27.3384	qr	2017-07-26 15:41:17	2017-07-26 15:44:42	f	f
577	2dd40c31-355f-4e2e-a475-15fb2056c4c3	220	22	2017-07-26 15:41:21	2017-07-26 15:44:44	-82.5362999999999971	27.3384999999999998	-82.5362999999999971	27.3384	qr	2017-07-26 15:41:20	2017-07-26 15:44:44	f	f
578	5d311741-4336-4a98-9ca7-23c5b21c3855	221	22	2017-07-26 15:41:23	2017-07-26 15:44:46	-82.5362999999999971	27.3384999999999998	-82.5362999999999971	27.3384	qr	2017-07-26 15:41:23	2017-07-26 15:44:46	f	f
580	a5012822-20ca-4fc5-82c0-dc62f80a879e	157	22	2017-07-26 15:44:19	2017-07-26 15:44:59	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384999999999998	geo	2017-07-26 15:44:18	2017-07-26 15:44:59	f	f
570	158b8bb1-fac5-4d1a-bfa0-11a47afc43f9	208	25	2017-07-26 13:11:00	2017-07-26 19:55:25	-82.5361999999999938	27.3384	-82.536412900000002	27.3383074999999991	geo	2017-07-26 13:11:00	2017-07-26 19:55:25	f	f
593	13399667-a451-4da6-8f0c-8254571e75ab	208	38	2017-07-26 19:55:38	2017-07-26 19:56:15	-82.536412900000002	27.3383074999999991	-82.536412900000002	27.3383074999999991	geo	2017-07-26 19:55:38	2017-07-26 19:56:15	t	t
594	ba5a678f-f11e-40ff-9074-0f9d67870c62	208	39	2017-07-26 19:56:21	2017-07-26 20:27:19	-82.536412299999995	27.338308099999999	-82.536412299999995	27.3383082000000002	geo	2017-07-26 19:56:20	2017-07-26 20:27:19	f	f
595	e2809aee-e115-4dba-be18-c5412ea611ec	208	39	2017-07-26 20:27:23	2017-07-26 21:31:16	-82.536412299999995	27.338308099999999	-82.5363916999999958	27.3383292000000004	geo	2017-07-26 20:27:22	2017-07-26 21:31:16	f	f
574	d8486c29-4795-461d-b2d7-6d67cdaead20	209	25	2017-07-26 13:13:03	2017-07-26 21:32:19	-82.5364000000000004	27.3384	-82.5365000000000038	27.3384	geo	2017-07-26 13:13:03	2017-07-26 21:32:19	f	f
571	938ed88f-142b-4a44-b14d-0c01d6317610	210	25	2017-07-26 13:11:37	2017-07-26 21:32:37	-82.5362999999999971	27.3384	-82.5362999999999971	27.3383000000000003	geo	2017-07-26 13:11:36	2017-07-26 21:32:37	f	f
572	af751437-811e-4f47-95b2-aa697403627c	211	25	2017-07-26 13:12:00	2017-07-26 21:32:54	-82.5362999999999971	27.3383000000000003	-82.5362999999999971	27.3384	geo	2017-07-26 13:12:00	2017-07-26 21:32:54	f	f
573	075c735e-ae05-475c-b1b5-fe343b15f091	212	25	2017-07-26 13:12:31	2017-07-26 21:33:12	-82.5364000000000004	27.3383000000000003	-82.5364000000000004	27.3383000000000003	geo	2017-07-26 13:12:30	2017-07-26 21:33:12	f	f
596	06d03f9a-858d-4a78-8115-95bfb092b9dd	212	25	2017-07-26 21:37:22	2017-07-26 21:40:06	-82.535899999999998	27.3382000000000005	-82.5313000000000017	27.3388999999999989	geo	2017-07-26 21:37:22	2017-07-26 21:40:06	t	t
597	6528a072-bf61-4e14-930d-a9669bfd62f1	208	38	2017-07-26 22:00:47	2017-07-26 22:00:55	-82.5024626999999953	27.3634589000000013	-82.502463800000001	27.3634510000000013	geo	2017-07-26 22:00:46	2017-07-26 22:00:55	f	f
598	0747b85a-144e-4ce7-802a-e2f48b9bae2b	208	39	2017-07-26 22:01:07	2017-07-26 22:01:16	-82.5024645999999962	27.3634449000000011	-82.5024673000000064	27.3634246999999995	geo	2017-07-26 22:01:07	2017-07-26 22:01:16	t	t
599	abd8679b-b672-4890-aab4-2565c2274c0b	212	25	2017-07-27 02:32:35	2017-07-27 14:02:45	-82.4830000000000041	27.2237000000000009	-82.4491000000000014	27.3125	geo	2017-07-27 02:32:34	2017-07-27 14:02:45	t	t
582	9c0528e2-bbba-4fef-aacd-423cad313e57	173	22	2017-07-26 15:45:28	2017-07-27 16:41:53	-82.5361999999999938	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:45:28	2017-07-27 16:41:53	f	f
583	125e5663-66a2-4126-9077-5b37f526c672	203	22	2017-07-26 15:45:30	2017-07-27 16:41:55	-82.5361999999999938	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:45:29	2017-07-27 16:41:55	f	f
584	40e43497-890d-40d6-a96e-225ca4a3d17f	175	22	2017-07-26 15:45:36	2017-07-27 16:41:59	-82.5362999999999971	27.3386999999999993	-82.5362999999999971	27.3384999999999998	manual	2017-07-26 15:45:35	2017-07-27 16:41:59	f	f
585	6a4773fa-b28c-4b8e-afd7-7f50da8c4040	178	22	2017-07-26 15:45:41	2017-07-27 16:42:06	-82.5362999999999971	27.3386999999999993	-82.5362999999999971	27.3384999999999998	manual	2017-07-26 15:45:41	2017-07-27 16:42:06	f	f
586	1140dc30-0d4c-4507-af71-f0f62e58d67e	180	22	2017-07-26 15:45:52	2017-07-27 16:42:08	-82.5362999999999971	27.3386999999999993	-82.5362999999999971	27.3384999999999998	manual	2017-07-26 15:45:52	2017-07-27 16:42:08	f	f
587	03c6d36a-52fc-4a0e-9d56-c935ed7737c9	181	22	2017-07-26 15:46:13	2017-07-27 16:42:15	-82.5361000000000047	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:46:12	2017-07-27 16:42:15	f	f
588	1eff4ca5-068d-41a8-a6ee-622163e17e0d	183	22	2017-07-26 15:46:14	2017-07-27 16:42:17	-82.5361000000000047	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:46:14	2017-07-27 16:42:17	f	f
589	28dc17ae-3a5d-4bbe-a5a8-92bc573cf4e8	218	22	2017-07-26 15:46:16	2017-07-27 16:42:19	-82.5361000000000047	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:46:15	2017-07-27 16:42:19	f	f
590	d116d323-2f25-459b-8fb2-e4078369a95d	219	22	2017-07-26 15:46:18	2017-07-27 16:42:21	-82.5361000000000047	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:46:17	2017-07-27 16:42:21	f	f
591	f14a553e-af81-4781-becd-2bf1515b3f10	220	22	2017-07-26 15:46:19	2017-07-27 16:42:22	-82.5361000000000047	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:46:19	2017-07-27 16:42:22	f	f
592	245a3d6f-7090-440f-8ae2-7605949adc0e	221	22	2017-07-26 15:46:21	2017-07-27 16:42:24	-82.5361000000000047	27.3384999999999998	-82.5362999999999971	27.3384999999999998	qr	2017-07-26 15:46:20	2017-07-27 16:42:24	f	f
581	8cf2a312-3572-4dc8-923e-3b2af0996429	157	22	2017-07-26 15:45:09	2017-07-27 16:42:39	-82.5362999999999971	27.3385999999999996	-82.5362999999999971	27.3384	geo	2017-07-26 15:45:09	2017-07-27 16:42:39	f	f
563	49a1c90a-fb06-4b97-8266-23f59eeefa3f	170	18	2017-07-26 12:40:00	2017-07-27 16:42:55	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:39:59	2017-07-27 16:42:55	f	t
564	8211cee6-ca31-47a3-ac5e-621350e4314b	174	18	2017-07-26 12:40:02	2017-07-27 16:42:57	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:40:01	2017-07-27 16:42:57	f	t
565	1dbe865b-4085-4919-91f2-f16f4ddf2e2c	177	18	2017-07-26 12:40:08	2017-07-27 16:43:05	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:40:08	2017-07-27 16:43:05	f	t
566	7af6c2c2-ec3b-4420-8c24-f30399dea8e8	179	18	2017-07-26 12:40:11	2017-07-27 16:43:06	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:40:10	2017-07-27 16:43:06	f	t
567	96a8f05b-c103-4e6b-8036-2fafd5995e84	182	18	2017-07-26 12:40:18	2017-07-27 16:43:10	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:40:18	2017-07-27 16:43:10	f	t
568	c9e12ee4-9710-42db-b0f0-7d563c70ded4	184	18	2017-07-26 12:40:21	2017-07-27 16:43:11	-82.0280999999999949	27.0152000000000001	-82.5362999999999971	27.3384	qr	2017-07-26 12:40:20	2017-07-27 16:43:11	f	t
601	415235bf-1dad-4d37-b444-6ecc6496e43f	157	18	2017-07-27 16:42:48	2017-07-27 16:43:25	-82.5364000000000004	27.3383000000000003	-82.5360000000000014	27.3385999999999996	geo	2017-07-27 16:42:47	2017-07-27 16:43:25	t	t
602	fa047173-1ebe-4532-94ec-7fa36bd1b429	222	44	2017-07-27 16:44:09	2017-07-27 16:44:15	-82.5361999999999938	27.3384	-82.5361999999999938	27.3384	geo	2017-07-27 16:44:09	2017-07-27 16:44:15	t	t
603	6c2acb6c-8e8b-48ee-b1c6-b9c35e4aa144	222	44	2017-07-27 16:45:40	2017-07-27 16:47:52	-82.5366000000000071	27.3382000000000005	-82.5362999999999971	27.3382000000000005	geo	2017-07-27 16:45:39	2017-07-27 16:47:52	f	f
605	910c27a7-ab6f-494d-adea-21643f9ff834	170	18	2017-07-27 18:15:28	2017-07-28 14:33:28	-82.5362999999999971	27.3383000000000003	-82.0280000000000058	27.0152999999999999	qr	2017-07-27 18:15:27	2017-07-28 14:33:28	t	f
606	c81e9707-3c75-49c0-a29f-1566e719d373	174	18	2017-07-27 18:15:30	2017-07-28 14:33:30	-82.5362999999999971	27.3383000000000003	-82.0280000000000058	27.0152999999999999	qr	2017-07-27 18:15:29	2017-07-28 14:33:30	t	f
607	970b6c39-d88d-4198-a0b9-e796c6f03b1e	177	18	2017-07-27 18:15:32	2017-07-28 14:33:33	-82.5362999999999971	27.3383000000000003	-82.0280000000000058	27.0152999999999999	qr	2017-07-27 18:15:32	2017-07-28 14:33:33	t	f
608	4412a69f-de24-4cc0-bf9f-08ec493fb047	179	18	2017-07-27 18:15:34	2017-07-28 14:33:35	-82.5362999999999971	27.3383000000000003	-82.0280000000000058	27.0152999999999999	qr	2017-07-27 18:15:33	2017-07-28 14:33:35	t	f
630	d3bc48cd-1e4d-4938-8f28-23c59520332d	135	16	2017-07-29 07:11:04	2017-07-29 07:11:11	75.8670458999999937	22.6998373999999998	75.8670458999999937	22.6998373999999998	geo	2017-07-29 07:11:03	2017-07-29 07:11:11	f	f
632	a67c968e-9b6d-427e-9d18-5e4db1e9ae69	135	16	2017-07-29 08:02:09	2017-07-29 08:15:13	75.8670620000000042	22.6998514	75.8670802000000037	22.6998661000000013	geo	2017-07-29 08:02:09	2017-07-29 08:15:13	f	f
604	d1c5a70c-c1b4-4235-a262-3402564eac6f	157	18	2017-07-27 18:15:16	2017-07-27 18:15:57	-82.5364000000000004	27.3383000000000003	-82.5362999999999971	27.3384	geo	2017-07-27 18:15:15	2017-07-27 18:15:57	t	t
634	7fcaf76e-ea0c-4b2b-bacf-2e527116e23b	135	16	2017-07-29 08:25:08	2017-07-29 09:12:45	75.8671384000000018	22.6998864000000005	75.867065299999993	22.6998545999999983	geo	2017-07-29 08:25:08	2017-07-29 09:12:45	f	f
636	12889f93-cf8a-4295-8f33-72fc6bbefbaa	135	16	2017-07-29 09:16:19	2017-07-29 09:29:56	75.8670642999999956	22.6998496000000003	75.8670685999999961	22.6998393999999983	geo	2017-07-29 09:16:18	2017-07-29 09:29:56	f	f
638	1c05dfec-73da-44ea-b121-b282b2b9b164	134	16	2017-07-31 08:02:29	2017-07-31 08:02:33	75.8670974999999999	22.6999037000000001	75.8671046000000047	22.6999220000000008	qr	2017-07-31 08:02:28	2017-07-31 08:02:33	f	f
641	c5ad7f93-ae30-43e4-ac97-687da7f28880	203	22	2017-07-31 14:50:19	2017-07-31 14:50:22	-82.0279000000000025	27.0151000000000003	-82.0279000000000025	27.0151000000000003	qr	2017-07-31 14:50:19	2017-07-31 14:50:22	t	t
767	97a77d41-12e1-4204-9a85-79fe57f84ade	133	42	2017-08-17 06:45:49	2017-08-17 06:45:52	75.8670798999999931	22.7000078999999992	75.8670828000000057	22.7000056999999984	manual	2017-08-17 06:45:48	2017-08-17 06:45:52	f	f
720	6dba1a40-1676-4cce-bfb9-7cc6563bb9e7	135	16	2017-08-09 12:50:08	2017-08-17 07:27:09	75.8672035999999963	22.699913200000001	75.8670879000000014	22.6999950000000013	geo	2017-08-09 12:50:08	2017-08-17 07:27:09	f	f
639	866583bd-8efa-4be4-89e0-4f9960e532c8	157	22	2017-07-31 14:50:10	2017-07-31 14:50:54	-82.0277999999999992	27.0151000000000003	-82.0280999999999949	27.0151000000000003	geo	2017-07-31 14:50:10	2017-07-31 14:50:54	t	t
623	64620f8f-547e-4f46-90ca-a4a39064ce5f	135	16	2017-07-28 13:05:52	2017-07-28 13:13:44	75.8670685999999961	22.7000442999999983	75.8670458999999937	22.6998373999999998	geo	2017-07-28 13:05:52	2017-07-28 13:13:44	f	f
624	ba6580da-3caa-44d7-a62e-a54f0820e076	135	16	2017-07-28 13:13:52	2017-07-28 13:18:20	75.8670577000000037	22.6999445999999985	75.8670627999999994	22.6999428999999999	geo	2017-07-28 13:13:52	2017-07-28 13:18:20	f	f
652	e11abab3-c2d5-40f1-be19-c16f68fe24f1	170	18	2017-07-31 14:51:11	2017-07-31 18:32:51	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:51:10	2017-07-31 18:32:51	f	f
625	c94ab933-6554-48cd-b244-fd5a5a677f58	135	16	2017-07-28 13:19:55	2017-07-28 13:20:32	75.8670685999999961	22.7000442999999983	75.8670644999999979	22.7000399000000002	geo	2017-07-28 13:19:54	2017-07-28 13:20:32	f	f
612	eee9cdba-a422-47ae-b97d-c17e521a535b	173	22	2017-07-27 18:16:08	2017-07-28 14:32:21	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:08	2017-07-28 14:32:21	f	t
613	783fb09b-619d-4c29-a1fd-ba0a99864251	203	22	2017-07-27 18:16:10	2017-07-28 14:32:23	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:09	2017-07-28 14:32:23	f	t
614	b77499fa-bc8e-46c2-a872-8b6739c7b56f	175	22	2017-07-27 18:16:12	2017-07-28 14:32:29	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:12	2017-07-28 14:32:29	f	t
615	193feda9-3e2c-469c-8efb-2b3a92a6bc83	178	22	2017-07-27 18:16:14	2017-07-28 14:32:32	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:13	2017-07-28 14:32:32	f	t
616	18551394-95e2-450b-b889-ee593482328d	180	22	2017-07-27 18:16:15	2017-07-28 14:32:33	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:15	2017-07-28 14:32:33	f	t
617	febc8802-239e-40f9-96c0-052edbcb3e0d	181	22	2017-07-27 18:16:19	2017-07-28 14:32:38	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:18	2017-07-28 14:32:38	f	t
618	5cf97a20-f7f9-422a-b643-89d7f53f4da4	183	22	2017-07-27 18:16:20	2017-07-28 14:32:40	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:20	2017-07-28 14:32:40	f	t
619	66a5a4d4-55db-4031-b728-9826ace8d039	218	22	2017-07-27 18:16:23	2017-07-28 14:32:41	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:22	2017-07-28 14:32:41	f	t
620	26900d04-daa1-4644-8456-b46a5e9286f6	219	22	2017-07-27 18:16:25	2017-07-28 14:32:44	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:24	2017-07-28 14:32:44	f	t
621	be9a11cd-43bd-4d36-a088-9ffb5eff40da	220	22	2017-07-27 18:16:27	2017-07-28 14:32:46	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:26	2017-07-28 14:32:46	f	t
622	c9120c6d-0e0e-4f39-aa72-0493c73196ac	221	22	2017-07-27 18:16:28	2017-07-28 14:32:48	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152000000000001	qr	2017-07-27 18:16:28	2017-07-28 14:32:48	f	t
611	bcda8010-4a78-4c7b-875d-847cb11892f6	157	22	2017-07-27 18:16:02	2017-07-28 14:33:12	-82.5362999999999971	27.3384	-82.0280000000000058	27.0152999999999999	geo	2017-07-27 18:16:01	2017-07-28 14:33:12	f	t
654	00a05a67-e3c0-46a5-a6ae-b89e95dc14a1	203	18	2017-07-31 14:51:17	2017-07-31 18:32:55	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:51:16	2017-07-31 18:32:55	f	f
609	76227c38-76a5-4001-b489-e6ce04b6ff97	182	18	2017-07-27 18:15:38	2017-07-28 14:33:39	-82.5362999999999971	27.3383000000000003	-82.0280000000000058	27.0152999999999999	qr	2017-07-27 18:15:38	2017-07-28 14:33:39	t	f
610	22ae2f2b-ae5f-4033-82c0-9d4ffdc1449f	184	18	2017-07-27 18:15:40	2017-07-28 14:33:42	-82.5362999999999971	27.3383000000000003	-82.0280000000000058	27.0152999999999999	qr	2017-07-27 18:15:39	2017-07-28 14:33:42	t	f
626	eaf4fb4a-1315-45af-84a9-d70999f9636c	157	18	2017-07-28 14:33:17	2017-07-28 14:33:53	-82.0280000000000058	27.0152999999999999	-82.0280999999999949	27.0152000000000001	geo	2017-07-28 14:33:17	2017-07-28 14:33:53	f	f
656	c6491fab-7079-47c0-a768-4c73b9a8e473	179	18	2017-07-31 14:51:21	2017-07-31 18:32:58	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:51:20	2017-07-31 18:32:58	f	f
658	f70383c4-a102-4340-a6a2-233747629069	184	18	2017-07-31 14:51:27	2017-07-31 18:33:04	-82.0280999999999949	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:51:26	2017-07-31 18:33:04	f	f
643	91842c87-afcb-4dde-8f93-02e519b44056	178	22	2017-07-31 14:50:28	2017-07-31 18:33:35	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:28	2017-07-31 18:33:35	t	t
645	ef905624-2698-44b5-be5b-a5276c089efa	181	22	2017-07-31 14:50:34	2017-07-31 18:33:40	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:34	2017-07-31 18:33:40	t	t
647	3c5ea983-660a-4583-85c8-eba44c7f111c	218	22	2017-07-31 14:50:37	2017-07-31 18:33:43	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:37	2017-07-31 18:33:43	t	t
649	01b0ed79-8c04-44f0-8c21-6c240239e4a3	220	22	2017-07-31 14:50:42	2017-07-31 18:33:47	-82.0279000000000025	27.0151000000000003	-82.0280999999999949	27.0151000000000003	qr	2017-07-31 14:50:41	2017-07-31 18:33:47	t	t
659	ea7f808a-b246-4cf0-a9e1-bc77bdd7d8a5	208	45	2017-07-31 18:12:01	2017-07-31 19:25:23	-82.5362999999999971	27.3383000000000003	-82.5362999999999971	27.3383000000000003	geo	2017-07-31 18:12:01	2017-07-31 19:25:23	t	t
661	30ab4929-7781-466f-a4b4-fb9bc7796a60	223	45	2017-07-31 19:30:25	2017-07-31 19:32:12	-82.5365000000000038	27.3382000000000005	-82.5364000000000004	27.3381000000000007	geo	2017-07-31 19:30:25	2017-07-31 19:32:12	t	t
702	44c40886-3d1d-45d0-b2b5-d1e3b43b99e5	135	16	2017-08-04 13:38:49	2017-08-04 13:40:15	75.8670919000000055	22.6998649000000015	75.8671472999999992	22.6999014999999993	geo	2017-08-04 13:38:48	2017-08-04 13:40:15	f	f
704	44aa3b87-ba78-4bae-b30f-c7beebbac214	135	16	2017-08-04 13:47:16	2017-08-04 13:51:07	75.8670644999999979	22.6998679999999986	75.8670484999999957	22.6998390000000008	geo	2017-08-04 13:47:15	2017-08-04 13:51:07	f	f
706	ad83db96-bb1f-4c95-ac6b-9a2426669719	135	40	2017-08-04 14:18:21	2017-08-04 14:18:58	75.8670472000000018	22.6998388999999996	75.8670685999999961	22.6998393999999983	geo	2017-08-04 14:18:20	2017-08-04 14:18:58	f	f
708	1f74b112-1b81-4bc1-908d-21be344830e0	135	40	2017-08-04 14:20:54	2017-08-04 14:22:02	75.8670611999999949	22.6998600999999987	75.8671046999999987	22.6999394000000017	geo	2017-08-04 14:20:53	2017-08-04 14:22:02	f	f
676	bd5b6bc6-9b96-495e-bbf6-776514c8e3da	208	25	2017-08-03 14:21:18	2017-08-04 17:26:12	-82.5364000000000004	27.3382000000000005	-82.4489999999999981	27.3125	geo	2017-08-03 14:21:17	2017-08-04 17:26:12	f	t
710	8c164014-4774-4945-afc3-a5068b9ef7f1	208	25	2017-08-04 17:31:30	2017-08-07 13:15:51	-82.4489999999999981	27.3125999999999998	-82.502600000000001	27.3636000000000017	manual	2017-08-04 17:31:29	2017-08-07 13:15:51	t	t
663	c63c6119-8cce-453b-9862-7494b319444d	223	45	2017-08-01 22:01:00	2017-08-07 13:23:18	-82.5341999999999985	27.9814000000000007	-82.5027000000000044	27.3636000000000017	geo	2017-08-01 22:00:59	2017-08-07 13:23:18	t	t
712	dfd32b62-6821-4ba1-9992-c4c89ad7f120	223	47	2017-08-08 18:53:31	2017-08-08 19:05:30	-82.5363916999999958	27.3383520000000004	-82.5362999999999971	27.3384	manual	2017-08-08 18:53:31	2017-08-08 19:05:30	t	t
714	d7edf71d-852e-445b-9151-c622d905b192	135	16	2017-08-09 12:24:06	2017-08-09 12:26:52	75.8670716999999968	22.699865599999999	75.8671913000000018	22.6999011999999993	manual	2017-08-09 12:24:06	2017-08-09 12:26:52	f	f
716	809c2a58-a720-410e-88ee-d5fbc1d8b1e8	135	16	2017-08-09 12:27:36	2017-08-09 12:29:22	75.8672954999999973	22.6999281000000011	75.8672236000000026	22.6999263999999989	manual	2017-08-09 12:27:36	2017-08-09 12:29:22	f	f
688	13a419a9-703e-4a73-abf7-e5063d152e76	178	22	2017-08-03 15:01:07	2017-08-09 15:16:55	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:06	2017-08-09 15:16:55	f	f
690	d9e3cb71-3efb-4094-a88e-3ec1e371f4c4	181	22	2017-08-03 15:01:13	2017-08-09 15:17:06	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:13	2017-08-09 15:17:06	f	f
692	7c14181c-d4a7-4b80-b1dd-efab3c4a8c03	218	22	2017-08-03 15:01:16	2017-08-09 15:17:09	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:16	2017-08-09 15:17:09	f	f
694	bd84fa19-07d6-45bb-bb81-cce4956614d1	220	22	2017-08-03 15:01:20	2017-08-09 15:17:13	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:19	2017-08-09 15:17:13	f	f
680	6d2d3892-3bd6-4852-9a63-db862cca52af	177	18	2017-08-03 15:00:32	2017-08-09 15:28:06	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	qr	2017-08-03 15:00:32	2017-08-09 15:28:06	t	t
678	50ca068a-ed8e-4054-b217-4fb490e91f46	170	18	2017-08-03 15:00:27	2017-08-09 15:29:05	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	qr	2017-08-03 15:00:27	2017-08-09 15:29:05	t	t
684	ea508fa5-4136-45bf-8e5e-0a4dd804a37f	157	22	2017-08-03 15:00:56	2017-08-16 12:34:19	-82.5362999999999971	27.3384	-82.4749000000000052	27.3355999999999995	geo	2017-08-03 15:00:55	2017-08-16 12:34:19	f	t
765	3cc3e9d2-2a3c-4ab8-939e-474673491634	223	60	2017-08-16 16:25:55	2017-08-16 21:04:41	-82.5362999999999971	27.3383000000000003	-82.5364000000000004	27.3382000000000005	manual	2017-08-16 16:25:54	2017-08-16 21:04:41	f	f
685	642fd5c2-2c88-43bc-bd2b-1814e534f9bb	173	22	2017-08-03 15:01:01	2017-08-09 15:16:49	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:01	2017-08-09 15:16:49	f	f
686	c218185d-f175-456c-9a45-588ac24c67fb	203	22	2017-08-03 15:01:03	2017-08-09 15:16:51	-82.5362999999999971	27.3384	-82.5362999999999971	27.3382000000000005	qr	2017-08-03 15:01:02	2017-08-09 15:16:51	f	f
761	1499ec85-fe37-4f7a-aa6a-d03f5dbd021a	133	16	2017-08-16 12:44:06	2017-08-17 06:45:15	75.8670685999999961	22.6998621999999983	75.8670798999999931	22.7000111999999987	manual	2017-08-16 12:44:05	2017-08-17 06:45:15	f	f
681	094e12ab-a990-4054-8884-4f194ddeca97	179	18	2017-08-03 15:00:34	2017-08-09 15:28:08	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	qr	2017-08-03 15:00:34	2017-08-09 15:28:08	t	t
682	b1d9ce38-6f45-4336-92d0-7319416df643	182	18	2017-08-03 15:00:37	2017-08-09 15:28:12	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	qr	2017-08-03 15:00:37	2017-08-09 15:28:12	t	t
730	efa905c0-37e3-403a-b965-7fb61f08ce5b	203	18	2017-08-09 15:28:59	2017-08-09 15:29:13	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	manual	2017-08-09 15:28:58	2017-08-09 15:29:13	t	t
768	bc0e21e1-6c16-44a6-9e3a-2a129ec93612	133	16	2017-08-17 06:49:34	2017-08-17 06:49:48	75.8670759999999973	22.7000132000000008	75.8670912999999985	22.7000008000000015	manual	2017-08-17 06:49:34	2017-08-17 06:49:48	f	f
729	1d369e66-cd3b-472b-a2fe-69029841084c	173	22	2017-08-09 15:25:31	2017-08-09 15:31:11	-82.5362999999999971	27.3384	90	90	manual	2017-08-09 15:25:30	2017-08-09 15:31:11	f	t
731	1d878d95-8fc8-457b-92b7-53f9035527ce	203	22	2017-08-09 15:29:19	2017-08-09 15:31:24	-82.5364000000000004	27.3384	90	90	manual	2017-08-09 15:29:19	2017-08-09 15:31:24	f	t
728	67c177a3-c93d-484e-a841-ffd48062d7f9	223	47	2017-08-09 14:28:27	2017-08-09 16:51:07	-81.5276999999999958	28.4057999999999993	-81.5271999999999935	28.4054000000000002	manual	2017-08-09 14:28:26	2017-08-09 16:51:07	f	f
732	4e02aceb-93ae-4a1c-a0a1-453fa08abbde	135	16	2017-08-10 07:17:36	2017-08-17 07:26:31	75.8670685999999961	22.6998621999999983	75.8670967999999988	22.6999955	geo	2017-08-10 07:17:36	2017-08-17 07:26:31	f	f
727	5e10a8db-5dd2-48f4-853f-a17df47851dc	135	16	2017-08-09 14:10:40	2017-08-17 07:26:37	75.8671429000000046	22.699888399999999	75.8670975999999939	22.6999913000000006	geo	2017-08-09 14:10:39	2017-08-17 07:26:37	f	f
734	e858ebab-8bee-4cc7-ade8-34d7569b5d74	173	22	2017-08-11 15:19:27	2017-08-11 15:20:03	-82.0280000000000058	27.0152000000000001	-82.0280000000000058	27.0152000000000001	manual	2017-08-11 15:19:27	2017-08-11 15:20:03	t	t
726	cdaca4a8-1e22-4870-885f-22beb35eb818	135	16	2017-08-09 13:08:38	2017-08-17 07:26:43	75.8670685999999961	22.6998621999999983	75.8670939999999945	22.6999932999999992	geo	2017-08-09 13:08:38	2017-08-17 07:26:43	f	f
735	21414a5b-97d9-4576-83cf-4053c06d8e5f	157	22	2017-08-11 15:41:37	2017-08-11 15:41:40	90	90	90	90	manual	2017-08-11 15:41:36	2017-08-11 15:41:40	t	t
722	742ff6ee-3600-4ff5-b0fc-9d450cbd1650	135	16	2017-08-09 12:54:17	2017-08-17 07:26:57	75.8671197000000035	22.6998937000000005	75.867092999999997	22.6999934000000003	geo	2017-08-09 12:54:17	2017-08-17 07:26:57	f	f
736	7ef5806a-feb0-4966-8ef9-31b57441bb99	157	22	2017-08-11 15:43:32	2017-08-11 15:43:34	90	90	90	90	manual	2017-08-11 15:43:32	2017-08-11 15:43:34	t	t
769	fbef22fd-c981-47b2-8954-febc33d7425d	133	42	2017-08-17 06:49:49	2017-08-17 11:05:20	75.8670912999999985	22.7000008000000015	75.867057200000005	22.700031899999999	manual	2017-08-17 06:49:49	2017-08-17 11:05:20	f	f
737	91b8f93d-724f-4856-a68b-f5149684fd76	157	22	2017-08-11 15:43:35	2017-08-11 15:43:37	90	90	90	90	manual	2017-08-11 15:43:34	2017-08-11 15:43:37	t	t
771	6049fcd1-4f97-4c04-9e94-d11b53f17d5f	133	16	2017-08-17 11:09:55	2017-08-17 11:10:48	75.867074400000007	22.700009399999999	75.8670912999999985	22.6999780999999992	manual	2017-08-17 11:09:54	2017-08-17 11:10:48	f	f
738	40d60193-a3c6-4a14-ac7f-263d71a8ece5	157	22	2017-08-11 15:43:38	2017-08-11 15:43:38	90	90	90	90	manual	2017-08-11 15:43:38	2017-08-11 15:43:38	t	t
739	77e460b6-5789-4d35-9ba3-a258a269feff	157	22	2017-08-11 15:43:39	2017-08-11 15:43:39	90	90	90	90	manual	2017-08-11 15:43:39	2017-08-11 15:43:39	t	t
772	9d8dcf04-ad8b-4134-9f9a-2a09bf56ba36	133	42	2017-08-17 11:10:50	2017-08-17 11:14:13	75.8670912999999985	22.6999780999999992	75.8670781999999946	22.7000004000000004	manual	2017-08-17 11:10:49	2017-08-17 11:14:13	f	f
740	d496fa6e-6dfd-4e4c-93f9-040b97aeaef0	157	22	2017-08-11 15:43:49	2017-08-11 15:43:57	90	90	90	90	manual	2017-08-11 15:43:49	2017-08-11 15:43:57	t	t
763	5f08b1b9-9a65-44a4-8541-ffca0debbae2	157	61	2017-08-16 15:42:15	2017-08-17 13:31:24	-82.5361999999999938	27.3381000000000007	-82.5362999999999971	27.3383000000000003	manual	2017-08-16 15:42:15	2017-08-17 13:31:24	f	f
741	f0190b05-e720-4203-af3e-fef9214f65e6	157	22	2017-08-11 15:44:43	2017-08-11 15:45:00	90	90	90	90	manual	2017-08-11 15:44:42	2017-08-11 15:45:00	t	t
742	8cd6f355-812f-4d67-9399-bf7a0ed1750a	157	18	2017-08-11 15:46:21	2017-08-11 15:47:51	90	90	90	90	manual	2017-08-11 15:46:20	2017-08-11 15:47:51	t	t
773	f938b5b7-f3da-4c6c-9e4f-96d62d8a3241	223	60	2017-08-17 13:31:34	2017-08-17 14:33:47	-82.5362999999999971	27.3384999999999998	-82.5363916999999958	27.3383520000000004	manual	2017-08-17 13:31:33	2017-08-17 14:33:47	f	f
744	cbdb1339-e9cd-4174-8a32-63453b6a4477	157	22	2017-08-11 15:52:52	2017-08-11 15:53:57	-82.0280015999999961	27.0151733000000007	-82.028003499999997	27.0151843000000014	manual	2017-08-11 15:52:52	2017-08-11 15:53:57	t	t
743	982237b0-ad5f-44c9-b209-588c91fb7a54	203	22	2017-08-11 15:52:36	2017-08-11 15:54:23	-82.0280486000000053	27.0152011999999999	-82.028003499999997	27.0151819999999994	manual	2017-08-11 15:52:36	2017-08-11 15:54:23	t	t
745	034b9421-4f39-450e-9d6b-82d123b05a0e	157	22	2017-08-11 21:22:30	2017-08-11 21:22:30	90	90	90	90	manual	2017-08-11 21:22:29	2017-08-11 21:22:30	t	t
775	d18ec045-f44d-4f19-8047-306764b3e92b	223	65	2017-08-17 14:34:22	2017-08-17 14:46:43	-82.5361000000000047	27.3382000000000005	-82.5363916999999958	27.3383520000000004	manual	2017-08-17 14:34:22	2017-08-17 14:46:43	t	t
746	220ee5e9-cb13-4ebe-9395-5e39ea167455	203	18	2017-08-11 21:23:32	2017-08-11 21:23:33	-82.0280479999999983	27.0151758999999991	-82.0280479999999983	27.0151758999999991	manual	2017-08-11 21:23:32	2017-08-11 21:23:33	f	f
747	79faa378-e57b-4312-8a70-c6799255e007	203	18	2017-08-11 21:23:36	2017-08-11 21:23:39	-82.0280520000000024	27.0151508999999983	-82.0280524000000071	27.0151490999999986	manual	2017-08-11 21:23:36	2017-08-11 21:23:39	f	f
733	7d2a74df-25ab-4e37-9b16-d6bb04882be9	223	60	2017-08-11 15:14:07	2017-08-14 11:49:47	-82.5362999999999971	27.3382000000000005	-82.4831999999999965	27.2237000000000009	manual	2017-08-11 15:14:06	2017-08-14 11:49:47	t	t
777	934a41c3-5cee-433e-a445-0a3e9f77a81b	183	22	2017-08-17 15:10:09	\N	-82.5362125000000049	27.3381782999999992	\N	\N	geo	2017-08-17 15:10:08	2017-08-17 15:10:08	f	f
748	7cbbd971-064b-4780-975c-d4bbafbf456d	223	65	2017-08-14 11:49:57	2017-08-15 13:42:23	-82.4831999999999965	27.2237000000000009	-82.5362999999999971	27.3384	manual	2017-08-14 11:49:57	2017-08-15 13:42:23	t	t
778	27e232b3-739d-4d11-93f9-474a5d9a258e	183	22	2017-08-17 15:18:29	\N	-82.5362125000000049	27.3381782999999992	\N	\N	geo	2017-08-17 15:18:29	2017-08-17 15:18:29	f	f
774	0e6a7bd7-1a05-41a9-8288-5ed42027af75	157	22	2017-08-17 14:19:32	2017-08-17 15:19:55	-82.5363916000000017	27.3383445000000016	-82.5363949000000048	27.3383487999999986	manual	2017-08-17 14:19:32	2017-08-17 15:19:55	f	f
750	32d5a627-3c5a-4925-b980-810c81b8b4c9	135	16	2017-08-16 12:01:08	2017-08-16 12:01:10	90	90	90	90	manual	2017-08-16 12:01:07	2017-08-16 12:01:10	t	t
776	ee6e596e-7629-4d10-a0f5-eb379ed214de	210	60	2017-08-17 14:50:20	2017-08-17 15:22:35	-82.5363916999999958	27.3383520000000004	-82.5363738000000069	27.3383505999999983	manual	2017-08-17 14:50:20	2017-08-17 15:22:35	f	f
751	f762166b-cebb-4263-bc7a-1cb56128f9fb	135	16	2017-08-16 12:02:39	2017-08-16 12:02:49	90	90	90	90	manual	2017-08-16 12:02:38	2017-08-16 12:02:49	t	t
752	f3ac7179-bccc-489a-bb0b-ab8469ba0144	133	16	2017-08-16 12:16:34	2017-08-16 12:18:41	75.8670647999999943	22.6998551000000006	75.8670596999999987	22.6998517	manual	2017-08-16 12:16:33	2017-08-16 12:18:41	f	f
780	cccd32ca-76de-4e5b-9bd2-687df3dc457d	183	22	2017-08-17 15:27:58	\N	-82.5362125000000049	27.3381782999999992	\N	\N	geo	2017-08-17 15:27:57	2017-08-17 15:27:57	f	f
753	a78a0a7a-da3e-474d-8cee-33d02a9f69e0	133	16	2017-08-16 12:18:57	2017-08-16 12:19:19	75.8670637999999968	22.6998533000000009	75.8670920999999936	22.6998658000000013	manual	2017-08-16 12:18:57	2017-08-16 12:19:19	f	f
754	b4d96648-feb2-456d-a82b-d322a95a54c6	157	22	2017-08-16 12:35:38	2017-08-16 12:35:54	-82.4749999999999943	27.3356999999999992	-82.4750999999999976	27.3356999999999992	manual	2017-08-16 12:35:37	2017-08-16 12:35:54	t	t
779	bdcd0eec-8889-41d7-8883-e7882872bb54	210	60	2017-08-17 15:22:40	2017-08-17 15:55:28	-82.5363746999999961	27.3383491999999997	-82.5363875000000036	27.3383518000000016	manual	2017-08-17 15:22:39	2017-08-17 15:55:28	f	f
755	0981ba59-37e9-4e54-9c57-b0187cba3df5	157	22	2017-08-16 12:36:09	2017-08-16 12:36:18	-82.4750999999999976	27.3356999999999992	-82.4750999999999976	27.3356999999999992	manual	2017-08-16 12:36:09	2017-08-16 12:36:18	t	t
756	aa99db69-5521-4fa2-89eb-d24246232bb6	157	18	2017-08-16 12:36:27	2017-08-16 12:36:35	-82.4750999999999976	27.3356999999999992	-82.4750999999999976	27.3356999999999992	manual	2017-08-16 12:36:27	2017-08-16 12:36:35	t	t
757	e522b3f4-045f-48f2-a22b-f9d4b8de11a6	157	18	2017-08-16 12:40:16	2017-08-16 12:41:00	-82.4750999999999976	27.3355999999999995	-82.4749999999999943	27.3355999999999995	manual	2017-08-16 12:40:15	2017-08-16 12:41:00	t	t
758	ab559409-ef03-428e-806b-12c0d27b9313	203	18	2017-08-16 12:40:47	2017-08-16 15:38:22	-82.4749999999999943	27.3355999999999995	90	90	manual	2017-08-16 12:40:47	2017-08-16 15:38:22	t	t
759	04d0a2aa-554f-45d2-91d5-fb4d74ad7910	157	22	2017-08-16 12:41:08	2017-08-16 15:39:08	-82.4749999999999943	27.3355999999999995	90	90	manual	2017-08-16 12:41:07	2017-08-16 15:39:08	t	t
760	72c1fefb-2195-4f71-bc15-667662cee75a	203	22	2017-08-16 12:41:23	2017-08-16 15:39:29	-82.4749999999999943	27.3355999999999995	90	90	manual	2017-08-16 12:41:22	2017-08-16 15:39:29	t	t
762	38ea093f-85dd-45f2-87b8-6f3843d79707	157	61	2017-08-16 15:41:42	2017-08-16 15:41:51	-82.5362999999999971	27.3383000000000003	-82.5361000000000047	27.3382000000000005	manual	2017-08-16 15:41:42	2017-08-16 15:41:51	t	t
749	4bd260de-7171-4cfb-9699-4179bc27c89b	223	60	2017-08-15 13:42:34	2017-08-16 16:21:21	-82.5364000000000004	27.3383000000000003	-82.5361999999999938	27.3384	manual	2017-08-15 13:42:33	2017-08-16 16:21:21	t	t
764	14e8e0a5-720f-4831-9424-878653253fee	223	65	2017-08-16 16:21:31	2017-08-16 16:25:50	-82.5361999999999938	27.3384	-82.5362999999999971	27.3383000000000003	manual	2017-08-16 16:21:30	2017-08-16 16:25:50	f	t
781	90976b61-b727-4108-b332-d70da6e43b89	183	22	2017-08-17 15:32:11	2017-08-17 15:38:59	-82.5363847999999933	27.3383527999999991	-82.5363847999999933	27.3383527999999991	geo	2017-08-17 15:32:10	2017-08-17 15:38:59	f	f
782	747f01c7-b4ff-4246-af6c-316c93aef467	183	22	2017-08-17 15:42:20	2017-08-17 15:42:54	-82.5363847999999933	27.3383527999999991	-82.5363847999999933	27.3383527999999991	geo	2017-08-17 15:42:20	2017-08-17 15:42:54	f	f
783	7e42e7c3-8c47-4d52-b9af-d10b114cc0d0	183	22	2017-08-17 15:43:13	2017-08-17 15:43:18	-82.5363847999999933	27.3383527999999991	-82.5363847999999933	27.3383527999999991	geo	2017-08-17 15:43:12	2017-08-17 15:43:18	f	f
784	770c81a5-66c8-451b-9d9e-42227003f4a4	183	22	2017-08-17 15:43:22	2017-08-17 15:43:29	-82.5362175000000065	27.3379118000000005	-82.5361831999999964	27.3378937999999998	manual	2017-08-17 15:43:21	2017-08-17 15:43:29	t	t
785	3b365828-0b60-42fc-a58d-9d1b17c2309e	183	22	2017-08-17 15:43:56	2017-08-17 15:44:17	-82.5361565000000041	27.3378534000000002	-82.5361438000000049	27.3378999	manual	2017-08-17 15:43:55	2017-08-17 15:44:17	t	t
786	258b5334-afee-4b89-8a1c-077d4de9e840	183	22	2017-08-17 15:49:01	2017-08-17 15:49:37	-82.5362290000000058	27.3383387000000013	-82.5362290000000058	27.3383387000000013	geo	2017-08-17 15:49:01	2017-08-17 15:49:37	f	f
787	f83f56b4-4369-4017-80e4-4304f69add8e	183	22	2017-08-17 15:50:07	2017-08-17 15:50:12	-82.5362290000000058	27.3383387000000013	-82.5362290000000058	27.3383387000000013	geo	2017-08-17 15:50:06	2017-08-17 15:50:12	f	f
788	192a4911-54fb-44ad-a10f-3ede0ff5353a	183	22	2017-08-17 15:51:41	2017-08-17 15:52:33	-82.5362290000000058	27.3383387000000013	-82.5362290000000058	27.3383387000000013	geo	2017-08-17 15:51:40	2017-08-17 15:52:33	f	f
790	2b6b379b-9de7-4150-a898-32d7ca0696bb	183	22	2017-08-17 15:56:16	2017-08-17 15:57:21	-82.5362290000000058	27.3383387000000013	-82.5362290000000058	27.3383387000000013	geo	2017-08-17 15:56:15	2017-08-17 15:57:21	f	f
791	ce8e4ef8-07da-4fc8-973f-2b159d1c5d18	183	22	2017-08-17 15:57:53	2017-08-17 15:58:31	-82.5362290000000058	27.3383387000000013	-82.5362290000000058	27.3383387000000013	geo	2017-08-17 15:57:53	2017-08-17 15:58:31	f	f
789	a9b28ca5-6428-43dd-95fc-e3e6e0e62259	210	45	2017-08-17 15:55:38	2017-08-17 15:58:49	-82.5363875000000036	27.3383518000000016	-82.5363916999999958	27.3383520000000004	manual	2017-08-17 15:55:37	2017-08-17 15:58:49	t	t
792	5dc2d5ac-3314-460b-a916-837ee54ff07b	183	22	2017-08-17 15:58:51	2017-08-17 15:59:02	-82.5362290000000058	27.3383387000000013	-82.5362290000000058	27.3383387000000013	geo	2017-08-17 15:58:51	2017-08-17 15:59:02	f	f
793	83127354-1e75-41b9-a73b-29f877780c72	210	60	2017-08-17 15:59:03	2017-08-17 16:58:05	-82.5363779999999991	27.3383512999999994	-82.5362601000000069	27.3384633000000008	manual	2017-08-17 15:59:02	2017-08-17 16:58:05	f	f
794	d6b415c5-624c-4f4c-9243-b3395cb8f4c2	210	60	2017-08-17 16:58:10	2017-08-17 16:58:13	-82.536260299999995	27.3384633000000008	-82.5362601000000069	27.338461800000001	manual	2017-08-17 16:58:09	2017-08-17 16:58:13	f	f
795	01f4d6f3-7afd-4b55-b01d-900da701398e	210	60	2017-08-17 17:12:07	2017-08-17 17:12:57	-82.5365496999999948	27.3384259000000007	-82.5365496999999948	27.3384259000000007	geo	2017-08-17 17:12:07	2017-08-17 17:12:57	f	f
797	6c61e03b-1fa8-4127-933e-d3abeda1fbf6	210	60	2017-08-18 15:20:19	2017-08-18 18:38:10	-82.5362226000000021	27.3378610000000002	-82.5362980000000022	27.3379747000000002	manual	2017-08-18 15:20:19	2017-08-18 18:38:10	t	t
798	182d374f-c72c-4dd5-a1f9-0e9c352f5c63	223	60	2017-08-18 20:17:26	2017-08-18 23:29:06	-82.5027000000000044	27.3633999999999986	-82.5315999999999974	27.3887999999999998	manual	2017-08-18 20:17:25	2017-08-18 23:29:06	t	t
799	4ba1cc97-e983-4af9-9db1-5ddc0ed64620	223	60	2017-08-21 16:53:28	2017-08-21 21:48:04	-82.5364000000000004	27.3383000000000003	-82.5361000000000047	27.3384	manual	2017-08-21 16:53:27	2017-08-21 21:48:04	f	f
800	8d19e70f-ee4f-4190-b67e-a4acf766a8f0	223	60	2017-08-22 13:31:51	2017-08-22 16:35:54	-82.5364000000000004	27.3383000000000003	-82.5361999999999938	27.3373999999999988	manual	2017-08-22 13:31:50	2017-08-22 16:35:54	f	t
808	6fc76911-44c4-4f19-8159-ff9c0c64ad29	210	60	2017-08-24 18:15:02	2017-08-24 18:15:17	-82.536285399999997	27.3380380999999986	-82.5365670000000051	27.3381344000000013	manual	2017-08-24 18:15:02	2017-08-24 18:15:17	t	t
809	388109ac-d574-447c-a910-931beabbd9d2	135	16	2017-08-26 07:35:30	2017-08-26 07:36:58	75.9141503000000029	22.7535536	75.9141297000000037	22.7535519999999991	manual	2017-08-26 07:35:30	2017-08-26 07:36:58	f	f
810	32c6ee0f-f1e2-4708-b115-183155d43f77	135	16	2017-08-26 07:41:54	2017-08-26 07:42:03	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 07:41:54	2017-08-26 07:42:03	f	f
811	66da0a26-9460-419c-bbd2-616a18adec8d	135	16	2017-08-26 08:01:49	2017-08-26 08:02:14	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 08:01:48	2017-08-26 08:02:14	f	f
812	ed2fbc06-2213-406f-95d8-7494355c7d7a	135	16	2017-08-26 08:49:13	2017-08-26 08:49:51	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 08:49:13	2017-08-26 08:49:51	f	f
813	c0052969-8a2c-44e1-ab1c-4c41aca92144	135	16	2017-08-26 08:52:33	2017-08-26 08:53:14	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 08:52:32	2017-08-26 08:53:14	f	f
814	54eaa56c-18c4-44cd-9505-4b2179dafd6d	135	16	2017-08-26 08:54:58	2017-08-26 08:55:18	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 08:54:57	2017-08-26 08:55:18	f	f
815	fd03d9ea-515d-4a76-89c1-98fac6222046	135	16	2017-08-26 08:57:00	2017-08-26 08:57:26	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 08:56:59	2017-08-26 08:57:26	f	f
816	f0cb2020-473c-4598-9fa1-c451e0b0c67b	135	16	2017-08-26 08:58:59	2017-08-26 08:59:18	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 08:58:58	2017-08-26 08:59:18	f	f
817	32799c55-c658-4c02-a8e0-5dd593d5f38d	135	16	2017-08-26 08:59:30	2017-08-26 08:59:57	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 08:59:30	2017-08-26 08:59:57	f	f
818	da9dea80-9d36-4dda-ada7-597fd2910255	135	16	2017-08-26 09:00:25	2017-08-26 09:00:40	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 09:00:25	2017-08-26 09:00:40	f	f
819	bff7996f-70d0-4383-8d24-395d06b705e9	135	16	2017-08-26 09:01:14	2017-08-26 09:01:40	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 09:01:13	2017-08-26 09:01:40	f	f
820	49769e64-37ff-442e-90fb-6f26ef4ee703	135	16	2017-08-26 09:02:32	2017-08-26 10:01:38	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 09:02:32	2017-08-26 10:01:38	f	f
821	14e09c54-bcd9-42cf-ba01-b9f9df5a77a5	135	16	2017-08-26 10:02:10	2017-08-26 10:02:15	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 10:02:09	2017-08-26 10:02:15	f	f
822	cb1ee7e0-b3dc-46a2-a443-4a23c04ab615	135	16	2017-08-26 10:04:30	2017-08-26 10:06:06	75.9145000000000039	22.7534999999999989	75.9141350999999958	22.7538145999999983	manual	2017-08-26 10:04:29	2017-08-26 10:06:06	f	f
823	b9c04bef-2944-40e3-953e-ca20dcf12810	135	16	2017-08-26 10:06:20	2017-08-26 10:06:27	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 10:06:20	2017-08-26 10:06:27	f	f
824	1824253e-63d0-4ac0-b380-9a583d7cd7dd	135	16	2017-08-26 10:06:34	2017-08-26 10:08:14	75.9141237999999987	22.7537033999999991	75.9145000000000039	22.7534999999999989	manual	2017-08-26 10:06:34	2017-08-26 10:08:14	f	f
826	e5d2519d-0571-401f-9547-4b2174482433	135	16	2017-08-26 13:56:12	2017-08-26 14:03:45	75.9140555999999975	22.7537134999999999	75.9140555999999975	22.7537134999999999	geo	2017-08-26 13:56:12	2017-08-26 14:03:45	f	f
827	fc0ecb1c-55f2-4eb5-acbf-4751b1ddbd09	135	16	2017-08-26 14:04:50	2017-08-26 14:09:52	75.9140555999999975	22.7537134999999999	75.9140555999999975	22.7537134999999999	geo	2017-08-26 14:04:50	2017-08-26 14:09:52	f	f
828	da836b7e-31d5-4d2d-b88f-5868389895e6	135	16	2017-08-26 14:10:53	2017-08-26 14:14:55	75.9140555999999975	22.7537134999999999	75.9140555999999975	22.7537134999999999	geo	2017-08-26 14:10:53	2017-08-26 14:14:55	f	f
829	ea9dd6df-4c09-4f63-a6a9-af8ba9ae142a	135	16	2017-08-26 14:17:02	2017-08-26 14:20:05	75.9140555999999975	22.7537134999999999	75.9140555999999975	22.7537134999999999	geo	2017-08-26 14:17:01	2017-08-26 14:20:05	f	f
830	be694533-1516-4cd7-98cf-b91c21b6b590	135	16	2017-08-26 14:23:07	2017-08-26 14:25:07	75.9140555999999975	22.7537134999999999	75.9140555999999975	22.7537134999999999	geo	2017-08-26 14:23:06	2017-08-26 14:25:07	f	f
831	92405a29-6f5a-47fd-98c1-739665e703d3	135	16	2017-08-26 14:26:08	2017-08-26 14:32:14	75.9140555999999975	22.7537134999999999	75.9140555999999975	22.7537134999999999	geo	2017-08-26 14:26:08	2017-08-26 14:32:14	f	f
832	3281f49b-1527-42f3-89c0-5556acd2966a	135	16	2017-08-26 14:33:18	2017-08-26 14:47:40	75.9140555999999975	22.7537134999999999	75.9140555999999975	22.7537134999999999	geo	2017-08-26 14:33:18	2017-08-26 14:47:40	f	f
825	f09f57cf-473d-45d3-b49f-c3cbe7f0761e	135	16	2017-08-26 10:09:07	2017-08-27 09:25:40	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-26 10:09:07	2017-08-27 09:25:40	f	f
833	65e7156e-d2ef-4b16-b0bf-c6a9560d52cc	135	16	2017-08-27 09:26:25	2017-08-27 09:27:13	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 09:26:25	2017-08-27 09:27:13	f	f
834	1607df78-d5c0-4732-8f17-5ab1eae70ba8	135	16	2017-08-27 09:29:37	2017-08-27 09:29:56	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 09:29:37	2017-08-27 09:29:56	f	f
835	d9b8bc37-e21e-434a-a9a9-c1e4639252a2	135	16	2017-08-27 09:37:04	2017-08-27 11:21:33	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 09:37:04	2017-08-27 11:21:33	f	f
836	ca5cead7-5945-4821-9b0b-d50485372d29	135	16	2017-08-27 11:21:38	2017-08-27 11:27:49	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 11:21:37	2017-08-27 11:27:49	f	f
837	b20cd39b-720c-4894-9ecc-110088030881	135	16	2017-08-27 11:27:52	2017-08-27 11:40:44	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 11:27:52	2017-08-27 11:40:44	f	f
838	7a19c744-ca32-4b46-9883-98358c6d665c	135	16	2017-08-27 11:42:55	2017-08-27 11:46:20	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 11:42:55	2017-08-27 11:46:20	f	f
839	0769eb6c-ec7c-4775-88ae-5c67788b20f4	135	16	2017-08-27 11:50:49	2017-08-27 12:52:45	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 11:50:49	2017-08-27 12:52:45	f	f
840	943d7777-f8b7-4a98-b419-afac33691afd	135	16	2017-08-27 12:54:38	2017-08-27 12:55:18	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 12:54:38	2017-08-27 12:55:18	f	f
841	aae9b5ef-cca3-4ab4-bac8-eda334ab04de	135	16	2017-08-27 12:56:43	2017-08-27 12:57:07	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-27 12:56:43	2017-08-27 12:57:07	f	f
842	1d727b50-409e-4134-931b-8fa60021435f	135	16	2017-08-28 05:54:15	2017-08-28 08:58:28	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-28 05:54:14	2017-08-28 08:58:28	f	f
807	aa0fa87e-d8c2-411b-9cfc-483b1b930aaa	223	60	2017-08-24 14:27:00	2017-08-24 04:00:00	-82.5362999999999971	27.338000000000001	\N	\N	manual	2017-08-24 14:27:00	2017-08-29 20:07:18	t	f
843	08f9628c-ee05-483d-ba9f-df5f6c842f92	135	16	2017-08-28 08:59:15	2017-08-28 09:01:02	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-28 08:59:15	2017-08-28 09:01:02	f	f
844	ff9b73d5-282a-43bd-ae50-fad2ec6ee293	135	16	2017-08-28 09:01:13	2017-08-28 13:19:29	75.9145000000000039	22.7534999999999989	75.9145000000000039	22.7534999999999989	manual	2017-08-28 09:01:13	2017-08-28 13:19:29	f	f
845	0154a2ad-63ac-44c5-ad84-b5f7d215c32f	208	60	2017-08-28 15:14:55	2017-08-28 15:14:56	-82.5362999999999971	27.3384	-82.5362999999999971	27.3384	manual	2017-08-28 15:14:55	2017-08-28 15:14:56	f	f
847	edd4a7fb-0988-482a-aac6-c0a4460950e9	208	60	2017-08-28 22:03:57	2017-08-28 22:04:04	-82.4654000000000025	27.3892999999999986	-82.4652999999999992	27.3892999999999986	manual	2017-08-28 22:03:56	2017-08-28 22:04:04	t	t
852	9684470a-daf1-4726-a737-933c784f4571	135	16	2017-08-29 07:00:12	2017-08-29 07:08:46	75.8670687000000044	22.6999999000000017	75.8670742000000047	22.7000050000000009	manual	2017-08-29 07:00:12	2017-08-29 07:08:46	f	f
854	e7dda60a-e395-4af9-89f5-182e09be0822	133	16	2017-08-29 12:19:18	2017-08-29 12:31:14	75.8670974000000058	22.6999834999999983	75.867082300000007	22.7000026000000013	manual	2017-08-29 12:19:17	2017-08-29 12:31:14	f	f
856	30ca4974-0a2f-4558-96e6-f3b44c04e042	135	16	2017-08-29 12:42:20	2017-08-29 15:02:08	75.8670912999999985	22.7000008000000015	75.8670912999999985	22.7000008000000015	geo	2017-08-29 12:42:20	2017-08-29 15:02:08	f	f
846	96412aed-6f7b-4059-89a9-192ba7e5500a	208	60	2017-08-28 15:17:03	2017-08-28 04:00:00	-82.5362999999999971	27.3384	\N	\N	manual	2017-08-28 15:17:02	2017-08-29 20:05:45	f	f
848	a2aec9ee-d70d-4413-acbb-3c8f5519379f	208	60	2017-08-28 23:20:43	2017-08-28 04:00:00	-82.5024999999999977	27.3636000000000017	\N	\N	manual	2017-08-28 23:20:43	2017-08-29 20:05:57	t	f
849	8367a50a-39db-46b2-8f36-0506b8f9ea7f	208	65	2017-08-28 23:21:50	2017-08-28 04:00:00	-82.502600000000001	27.3636000000000017	\N	\N	manual	2017-08-28 23:21:49	2017-08-29 20:06:01	t	f
850	f70a49c5-f947-471d-8d57-a79e00b2c743	208	60	2017-08-28 23:22:03	2017-08-28 04:00:00	-82.5024999999999977	27.3634999999999984	\N	\N	manual	2017-08-28 23:22:02	2017-08-29 20:06:08	t	f
851	c1874e4b-43cc-48a9-b19e-b60ba531742e	208	60	2017-08-28 23:22:41	2017-08-28 04:00:00	-82.502600000000001	27.3636000000000017	\N	\N	manual	2017-08-28 23:22:41	2017-08-29 20:06:15	t	f
855	bcf7473d-a3c3-4322-8300-ecadcec6ef62	135	16	2017-08-29 12:41:04	2017-08-31 06:43:19	75.867075799999995	22.7000026999999989	75.8671139000000068	22.7000256	manual	2017-08-29 12:41:04	2017-08-31 06:43:19	f	f
858	8fedf621-d243-4ca5-b8d1-c42a58c07719	208	60	2017-08-31 14:31:30	2017-08-31 14:31:35	-82.5363811999999939	27.3383399999999988	-82.5363811999999939	27.3383399999999988	geo	2017-08-31 14:31:30	2017-08-31 14:31:35	f	f
857	781ee672-bfc3-4c07-bbe2-e31a2e22771d	135	16	2017-08-31 14:16:19	2017-08-31 14:48:40	75.8668416000000008	22.6995231000000004	75.8668188999999984	22.6994982999999984	geo	2017-08-31 14:16:18	2017-08-31 14:48:40	f	f
861	2150bba3-110c-4938-a9a0-9d9fdbf0c40c	135	16	2017-08-31 14:50:57	\N	75.8668188999999984	22.6994982999999984	\N	\N	geo	2017-08-31 14:50:57	2017-08-31 14:50:57	f	f
859	61a5a555-2543-4c95-80e1-092fbfbd24d9	208	60	2017-08-31 14:31:43	2017-08-31 15:06:03	-82.536395799999994	27.3383250000000011	-82.536402300000006	27.338318300000001	geo	2017-08-31 14:31:42	2017-08-31 15:06:03	f	f
860	cdb380f5-e175-4c12-8b61-61baa1d4d956	226	70	2017-08-31 14:32:47	2017-08-31 15:31:36	-82.5364000000000004	27.3383000000000003	90	90	geo	2017-08-31 14:32:46	2017-08-31 15:31:36	t	t
862	70d6cf4c-cb66-4635-ba70-e00909f326db	210	60	2017-08-31 15:35:13	2017-08-31 15:35:34	-82.536402300000006	27.338318300000001	-82.5365670999999992	27.3377772000000014	geo	2017-08-31 15:35:13	2017-08-31 15:35:34	f	t
863	a066b445-3cc5-4ef0-a752-460499727224	209	60	2017-08-31 15:35:58	2017-08-31 16:10:03	-82.5365536999999989	27.337823199999999	90	90	geo	2017-08-31 15:35:58	2017-08-31 16:10:03	t	t
864	c780cd39-ac68-40a7-9cae-cdffff37c949	226	70	2017-08-31 15:37:23	2017-08-31 16:12:05	-82.5364976000000041	27.3377946999999999	90	90	geo	2017-08-31 15:37:23	2017-08-31 16:12:05	t	t
865	b28dfc16-f71d-4b52-b4f6-ec00f323d7d0	210	60	2017-08-31 16:14:19	2017-08-31 16:52:39	-82.5364030000000071	27.3382490000000011	-82.536402300000006	27.338318300000001	geo	2017-08-31 16:14:18	2017-08-31 16:52:39	f	f
867	8241197d-7f9a-48d8-9e1f-ab08c3b09cb2	208	60	2017-08-31 18:30:37	2017-08-31 18:31:06	-82.5363219000000043	27.3381499000000012	-82.536402300000006	27.338318300000001	geo	2017-08-31 18:30:36	2017-08-31 18:31:06	f	f
866	e90fc7f1-41d1-4ffa-9039-4a1e3a7530d5	210	60	2017-08-31 17:29:10	2017-08-31 18:48:54	-82.5364009999999979	27.3382772000000003	-82.536402300000006	27.338318300000001	geo	2017-08-31 17:29:09	2017-08-31 18:48:54	f	f
871	4c87dcd3-8f27-479d-a71f-ac837092c37e	211	60	2017-08-31 19:52:50	2017-08-31 19:53:46	-82.536402300000006	27.338318300000001	-82.5362884000000037	27.3381709000000015	geo	2017-08-31 19:52:49	2017-08-31 19:53:46	f	f
868	3d356313-34de-4d79-8110-31d9cac59f4a	208	60	2017-08-31 19:21:30	2017-09-01 13:49:43	-82.5363337999999942	27.3382292000000007	-82.5361999999999938	27.3382000000000005	geo	2017-08-31 19:21:29	2017-09-01 13:49:43	f	f
870	8aa17d2c-e441-4c14-b9d8-f8030df2e5ed	209	60	2017-08-31 19:31:33	2017-09-01 14:09:16	-82.536402300000006	27.338318300000001	-82.5364217000000053	27.3383317999999989	geo	2017-08-31 19:31:33	2017-09-01 14:09:16	f	f
869	31415a3c-b33d-449b-ad94-ab4eeef12ec3	210	60	2017-08-31 19:26:30	2017-09-01 14:09:49	-82.536402300000006	27.338318300000001	-82.536402300000006	27.338318300000001	geo	2017-08-31 19:26:29	2017-09-01 14:09:49	f	f
872	f8626016-f2ce-44d1-a16f-cc951fd60475	211	60	2017-08-31 19:53:48	2017-09-01 14:10:10	-82.5362884000000037	27.3381709000000015	-82.5363535000000041	27.3382818000000007	geo	2017-08-31 19:53:48	2017-09-01 14:10:10	f	f
873	730dbc6c-1c40-4e4f-bb76-53ea8130af41	226	70	2017-09-01 13:48:54	2017-09-01 14:11:48	-82.5361999999999938	27.3382000000000005	90	90	geo	2017-09-01 13:48:53	2017-09-01 14:11:48	t	t
874	6cda4bb3-f4a7-4390-bf70-e555e3a6bbda	208	70	2017-09-01 17:12:21	2017-09-01 17:45:13	-82.5362999999999971	27.3383000000000003	-82.5361999999999938	27.3383000000000003	geo	2017-09-01 17:12:20	2017-09-01 17:45:13	t	t
875	82f84e5d-0e5a-4267-a876-4f6271ff232f	208	70	2017-09-01 17:46:13	\N	-82.5361999999999938	27.3383000000000003	\N	\N	geo	2017-09-01 17:46:13	2017-09-01 17:46:13	t	f
\.


--
-- Name: checks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('checks_id_seq', 875, true);


--
-- Data for Name: client_project; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY client_project (id, client_id, project_id, created_at, updated_at) FROM stdin;
27	88	16	2017-06-16 10:42:26	2017-06-16 10:42:26
29	2	17	2017-06-16 14:15:43	2017-06-16 14:15:43
30	119	18	2017-06-30 18:43:35	2017-06-30 18:43:35
31	120	19	2017-07-03 07:39:43	2017-07-03 07:39:43
32	125	20	2017-07-05 19:07:45	2017-07-05 19:07:45
33	127	18	2017-07-05 20:57:10	2017-07-05 20:57:10
34	121	21	2017-07-06 13:19:02	2017-07-06 13:19:02
35	119	22	2017-07-06 14:55:40	2017-07-06 14:55:40
36	127	22	2017-07-06 15:03:05	2017-07-06 15:03:05
37	128	22	2017-07-06 15:21:01	2017-07-06 15:21:01
38	128	18	2017-07-06 15:30:35	2017-07-06 15:30:35
39	126	20	2017-07-06 16:45:26	2017-07-06 16:45:26
40	129	23	2017-07-08 06:04:22	2017-07-08 06:04:22
41	130	24	2017-07-13 12:59:27	2017-07-13 12:59:27
42	132	25	2017-07-17 16:14:59	2017-07-17 16:14:59
43	133	25	2017-07-17 17:52:24	2017-07-17 17:52:24
44	132	27	2017-07-19 15:04:16	2017-07-19 15:04:16
45	132	29	2017-07-19 21:05:44	2017-07-19 21:05:44
46	132	30	2017-07-19 21:05:44	2017-07-19 21:05:44
47	132	31	2017-07-19 21:05:44	2017-07-19 21:05:44
48	132	32	2017-07-19 21:05:44	2017-07-19 21:05:44
49	132	33	2017-07-19 21:05:44	2017-07-19 21:05:44
50	132	34	2017-07-19 21:05:44	2017-07-19 21:05:44
51	132	35	2017-07-19 21:05:44	2017-07-19 21:05:44
52	132	36	2017-07-19 21:05:44	2017-07-19 21:05:44
53	132	37	2017-07-19 21:05:44	2017-07-19 21:05:44
54	137	22	2017-07-26 12:34:28	2017-07-26 12:34:28
55	132	38	2017-07-26 15:14:49	2017-07-26 15:14:49
56	132	39	2017-07-26 17:58:00	2017-07-26 17:58:00
57	88	40	2017-07-27 10:52:28	2017-07-27 10:52:28
58	88	41	2017-07-27 11:05:10	2017-07-27 11:05:10
59	88	42	2017-07-27 11:34:37	2017-07-27 11:34:37
60	88	43	2017-07-27 13:44:03	2017-07-27 13:44:03
61	138	44	2017-07-27 16:24:56	2017-07-27 16:24:56
62	132	45	2017-07-31 16:47:06	2017-07-31 16:47:06
63	133	45	2017-07-31 17:04:32	2017-07-31 17:04:32
64	119	46	2017-07-31 17:11:44	2017-07-31 17:11:44
65	132	47	2017-08-08 18:35:21	2017-08-08 18:35:21
66	88	48	2017-08-10 12:59:05	2017-08-10 12:59:05
67	88	49	2017-08-10 13:03:47	2017-08-10 13:03:47
68	88	50	2017-08-11 12:01:36	2017-08-11 12:01:36
69	88	51	2017-08-11 12:10:01	2017-08-11 12:10:01
70	88	52	2017-08-11 12:12:37	2017-08-11 12:12:37
71	88	53	2017-08-11 12:14:24	2017-08-11 12:14:24
72	88	54	2017-08-11 12:15:53	2017-08-11 12:15:53
73	88	55	2017-08-11 12:18:15	2017-08-11 12:18:15
74	88	56	2017-08-11 12:56:48	2017-08-11 12:56:48
75	88	57	2017-08-11 13:49:54	2017-08-11 13:49:54
76	88	58	2017-08-11 14:02:30	2017-08-11 14:02:30
77	88	59	2017-08-11 14:08:28	2017-08-11 14:08:28
78	132	60	2017-08-11 14:19:57	2017-08-11 14:19:57
79	133	60	2017-08-11 14:23:50	2017-08-11 14:23:50
80	119	61	2017-08-11 14:27:08	2017-08-11 14:27:08
81	121	62	2017-08-11 14:38:49	2017-08-11 14:38:49
82	119	63	2017-08-11 14:39:17	2017-08-11 14:39:17
83	88	64	2017-08-11 14:44:13	2017-08-11 14:44:13
84	132	65	2017-08-11 14:48:13	2017-08-11 14:48:13
85	119	66	2017-08-11 14:53:31	2017-08-11 14:53:31
86	140	67	2017-08-19 07:34:05	2017-08-19 07:34:05
87	121	68	2017-08-21 11:20:51	2017-08-21 11:20:51
88	121	69	2017-08-21 11:26:19	2017-08-21 11:26:19
89	132	70	2017-08-30 15:50:54	2017-08-30 15:50:54
\.


--
-- Name: client_project_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('client_project_id_seq', 89, true);


--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY clients (id, child_of_id, uniq_id, subdomain, name, fein, dba, address, city, state, zip, phone, fax, website, status, jdoc, created_at, updated_at, deleted_at, facelistid) FROM stdin;
1	0	b50b949e-4de7-4d3e-a5da-6e0463fc6039	ihos	IHOS	11111111	\N	\N	\N	\N	\N	\N	\N	\N	active	{}	\N	\N	\N	\N
105	0	a0d983b1-84f0-496d-8ee6-3ea2e7835833	pc003.punchcardllc.com	ParentCompany003	11-1111113	PC 003	PO Box 003	Sarasota	FL	34230	1111111113	1111111113	www.pc003.com	active	{}	2017-06-29 17:30:33	2017-06-29 17:30:33	\N	pc003.punchcardllc.com
106	0	41a7f40d-c0b6-4ea3-9a41-ded480c05796	pc004.punchcardllc.com	ParentCompany004	11-1111114	PC 004	PO Box 004	Sarasota	FL	34230	1111111114	1111111114	www.pc004.com	active	{}	2017-06-29 17:35:29	2017-06-29 17:35:29	\N	pc004.punchcardllc.com
107	0	754c54d2-7184-445d-94e5-ce7d473fdcc9	pc005.punchcardllc.com	ParentCompany005	11-1111115	PC 005	PO Box 005	Sarasota	FL	34230	1111111115	1111111115	www.pc005.com	inactive	{}	2017-06-29 17:37:07	2017-06-29 17:37:07	\N	pc005.punchcardllc.com
108	0	2f166604-8dc4-43f0-923e-43aee84c0e0c	mytesting	mytesting	111666	mytesting	mytesting	mytesting	mp	2323455435	2323455435	2323455435		active	{}	2017-06-30 13:42:28	2017-06-30 13:42:28	\N	mytesting
109	0	223fef2d-ead9-4d55-a116-71f568f31d79	testingagain	testingagain	232399	testingagain	testingagain	testingagain	tt	2323455435	8962535535	5555522222		active	{}	2017-06-30 13:46:18	2017-06-30 13:46:18	\N	testingagain
110	0	8d89644e-a7d9-480b-a058-f63f4a1ebca4	myparentclientharshad	myparentclientharshad	232444	myparentclientharshad	myparentclientharshad	myparentclientharshad	rr	2323455435	8962535535	5555522222		active	{}	2017-06-30 13:47:17	2017-06-30 13:47:17	\N	myparentclientharshad
111	2	0a7e9a03-1139-45f9-8141-6d14698736a0	3abe3291-d8a9-4e95-8239-c78161fb1297	TEST001SC01	123457	TEST001SC01	PO Box 01	Sarasota	FL	34230	2625738979	2625738979	SC01	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
112	2	7a5f4aeb-178e-454b-81cd-9aca1cf8e519	3097e938-bed8-47e6-a742-e5e3b6d16895	TEST001SC02	123458	TEST001SC02	PO Box 02	Sarasota	FL	34230	2625738979	2625738979	SC02	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
113	2	2f614747-8450-4127-9985-0f20ed848f91	389aa20f-1ff4-4c1f-a6fc-b2284bef77b1	TEST001SC03	123459	TEST001SC03	PO Box 03	Sarasota	FL	34230	2625738979	2625738979	SC03	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
114	2	560b6659-71f2-4b58-bd3b-4ef47d51156a	60f89c54-5073-48c5-8562-adbc8876a5e3	TEST001SC04	123460	TEST001SC04	PO Box 04	Sarasota	FL	34230	2625738979	2625738979	SC04	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
115	2	20b1ef61-906d-49f2-9e49-a3507fc5aedc	c2450540-a43d-4e7a-9d98-9b1d648cede5	TEST001SC05	123461	TEST001SC05	PO Box 05	Sarasota	FL	34230	2625738979	2625738979	SC05	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
116	2	a7a381a3-113d-4a48-a559-5b12bf2385ac	2c17a99b-95f1-4b9c-9c2c-348004d6d47f	TEST001SC06	123462	TEST001SC06	PO Box 06	Sarasota	FL	34230	2625738979	2625738979	SC06	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
117	2	13c85230-4761-4314-bef6-1119bbde82f6	198f180d-2c27-41c7-b60e-84f663bc4e10	TEST001SC07	123463	TEST001SC07	PO Box 07	Sarasota	FL	34230	2625738979	2625738979	SC07	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
118	2	c00f1f35-ed42-432a-b4ee-b37fc8a9d6c3	281c3279-a098-4722-8cab-1320546ade34	TEST001SC08	123464	TEST001SC08	PO Box 08	Sarasota	FL	34230	2625738979	2625738979	SC08	Active	{}	2017-06-30 16:54:36	2017-06-30 16:54:36	\N	\N
120	0	10e5a68e-5d5f-41f3-8f7f-a37052e35be0	palashcompany	palash company	555556	palash company	palash company	palash company	mp	4525555344	4525555344	4525555344		active	{}	2017-07-03 07:17:16	2017-07-03 07:17:16	\N	palashcompany
121	0	c620fd23-806a-4c37-bc37-82b9269ffe42	palash3593	palash3593	palash3593	palash3593	palash3593	sss	aa	7896541236	7896541236	7896541236		active	{}	2017-07-03 13:03:58	2017-07-03 13:03:58	\N	palash3593
124	0	d7bd8122-4479-49a3-95d7-1576d3ab43c4	palash35931	palash35931	something	palash35931	palash35931	palash35931	ff	7896541236	7896541236	7896541236		active	{}	2017-07-03 13:05:20	2017-07-03 13:05:20	\N	palash35931
125	0	852b1a9c-5156-4380-9dbd-bced0dcc8211	asma	Asma Consulting, Inc.	0987654321	Asma	PO Box 3423	Sarasota	FL	34230	2625738979	2625738979		active	{"contacts": {"3088f904258e652f547b737672cfcf9c": {"name": "Ted Asma", "email": "tedasma@gmail.com", "phone": "2625738979", "job_title": "Consultant"}}}	2017-07-05 18:43:05	2017-07-05 18:45:49	\N	Asma
126	125	494d4bc8-9b74-44aa-a933-e72ffd757d4b	06276e9e-23f7-43e2-ac8b-e9a286a00f50	Asma SubContracting LLC	0987654322	Asma SC	PO Box 3423	Sarasota	FL	34230	2625738990	2625738990		active	{}	2017-07-05 20:02:08	2017-07-05 20:02:08	\N	\N
129	0	54c92fa9-1732-4472-90c2-6a862ded6e14	punch	harshad testing	123432	harshad testing	harshad testing	harshad testing	ee	2588525883	2588525883	2588525883		active	{}	2017-07-08 05:57:57	2017-07-08 05:57:57	\N	punch
130	0	7cd33718-ef57-40ed-b82f-d10980f9a9c0	palashagrawalk	palash agrawalk	789654	palash agrawalk	2272 Airport Rd. S, indore	indore	ll	452007	2397842475	2397842475		active	[]	2017-07-13 07:39:37	2017-07-13 07:40:14	\N	palashagrawalk
131	0	f834afa8-5ef7-4cf8-be6a-54435c58ecee	rtgre	gsg	445566	rgretg	tgretgre	retgrt	gg	452009	8962535444	5555522244		active	{}	2017-07-14 10:35:38	2017-07-14 10:35:38	\N	rtgre
2	0	90644271-e96d-4fdd-b64e-6586665f3f5b	monikatesting	monika	123456	monika	monika	monika	mp	452009	8962535539	5555522227		active	[]	2017-05-23 06:50:50	2017-07-18 11:17:39	\N	\N
88	0	36585698-2c95-4f4c-81a1-38d8cdf9f53c	testclient	Client123Test	100	Client123Test	TestClient,XYZ	California	US	4000100200	2342342345	2342342345		active	[]	2017-06-16 10:19:10	2017-07-18 11:47:59	\N	TestClient
101	0	79c2c2b3-d964-4b80-b8c8-a3d5a6ce196e	harshadtesting1	harshadtesting1	232333	harshadtesting1	harshadtesting1	harshadtesting1	ee	2323455435	2323455435	2323455435		active	[]	2017-06-22 12:36:38	2017-07-18 12:02:32	\N	harshadtesting1
102	0	272b6253-f993-4017-ae31-4aa3f2800cb4	geeks	Geeks	129900	Geeks	Geeks	Geeks	mp	7878787867	7878787867	7878787867		active	[]	2017-06-28 11:47:14	2017-07-18 12:09:30	\N	Geeks
135	88	e25d7cc5-4da6-4895-b7c6-6f690035d761	5e260bb4-38e3-4c40-898f-f7d3a1608705	harshad test child	0099	harshad test child	harshad test child	indore	mp	4545454545	4545454545	4545454545		active	[]	2017-07-18 12:14:03	2017-07-18 12:46:36	\N	\N
136	0	10f0f40d-2702-43da-b4ca-9d3e5ef20385	pallu	ggggggg	444448	gggggg	ffffffff	fffffff	ww	5858585888	5858585888			active	[]	2017-07-18 12:48:57	2017-07-18 12:49:16	\N	pallu
133	132	a7973d5a-27a2-424f-bce0-ab2b036de8ab	0b4f6b14-2c68-4fdf-a1df-bc7b688a98cd	Demo Child Co.	2625731112	Demo Child Co.	PO Box 3423	Sarasota	FL	34230	2625731112			active	[]	2017-07-17 17:24:19	2017-07-18 14:28:08	\N	\N
119	0	80302b6c-8470-46ea-abd7-94b221b42d9e	ccc	Consolidated Contracting & Consulting, Inc.	20-8137478	CCC, Inc	PO Box 511391	Punta Gorda	FL	33951	9412766925			active	[]	2017-06-30 18:26:13	2017-07-26 15:47:48	\N	ccc
127	119	fc113773-58a7-4684-9603-6692666b68cf	5127c66f-1502-4e80-9845-12be560e824e	Company 1	11-11111111	Co 1	111 Main	PG	FL	111111	9412222221			active	[]	2017-07-05 20:37:47	2017-07-26 15:48:17	\N	\N
128	119	82a0a91c-33f4-4804-911d-1646449219a2	de7f21c4-7738-479e-9235-6c1566573287	Company 2	11-11111112	Co 2	1 Street	Hometown	FL	34236	9412223333			active	[]	2017-07-06 15:11:07	2017-07-26 15:48:37	\N	\N
134	0	0bd8a845-9807-4148-9ae5-a16a0d05b662	harshad	ABCDSH	333333	dddd	sudama nagar	indore	mp	452222	1234567589	1236547896		inactive	[]	2017-07-18 07:15:51	2017-07-27 15:50:50	\N	harshad
103	0	5e5f0266-09ec-46f9-882c-36a7d0fdfa06	pc001.punchcardllc.com	ParentCompany001	11-1111111	PC 001	PO Box 001	Sarasota	FL	34230	1111111111	1111111111	www.pc001.com	inactive	[]	2017-06-29 17:09:00	2017-07-28 07:41:50	\N	pc001.punchcardllc.com
104	0	c20cfa7c-9bb5-4b7c-a06c-ba9ad45ff841	pc002.punchcardllc.com	ParentCompany002	11-1111112	PC 002	PO Box 0021	7Sarasota774Indore	FL	34230	1111111112	1111111112	www.pc002.com	inactive	[]	2017-06-29 17:27:23	2017-07-28 12:06:22	\N	pc002.punchcardllc.com
132	0	958a6503-1422-459e-bc5e-fc7b00860556	demo	Demo Parent Client Co.	2625731111	Demo Co.	PO Box 3423	Sarasota	FL	34230	2625731111			active	[]	2017-07-17 15:46:23	2017-07-18 14:27:24	\N	demo
137	119	a5b1f3da-ca62-46e5-a42f-0ac9a92153c8	86a12e4f-d72f-492f-8f32-db7183220b3b	Company 3	11-11111113	3	456 Main	Punta Gorda	FL	33950	9412223340			active	[]	2017-07-26 12:27:40	2017-07-26 15:49:36	\N	\N
138	0	44fd523b-e9d9-4e91-9cbc-4b509e19aee7	aihc	American Insurance Holding Corp	20-1111111	AIHC	1680 Fruitville Rd #304	Sarasota	FL	34236	9417026070			active	{}	2017-07-27 15:50:19	2017-07-27 15:50:19	\N	aihc
139	0	fcd5990a-f69c-49eb-b083-a2e7c7c17215	august19	palash	1233	12km	indore	indore	mp	4521362563	1234654796			active	{}	2017-08-19 07:23:56	2017-08-19 07:23:56	\N	august19
140	0	b7ee50bc-0aa8-4dd5-bee3-27cdef282b8a	testdemo	demo123	7676767	ghgh	indore	indore	mp	99999999	9999999999			active	{}	2017-08-19 07:27:07	2017-08-19 07:27:07	\N	testdemo
141	0	16392d64-41ac-4edf-b39d-e6e5a63763a3	palashcompany123	test test	2252	aa	aa	indore	mp	452002	1236547896	2365417896		active	{}	2017-09-02 08:06:42	2017-09-02 08:06:42	\N	palashcompany123
\.


--
-- Name: clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('clients_id_seq', 141, true);


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY failed_jobs (id, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('failed_jobs_id_seq', 1, false);


--
-- Data for Name: industries; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY industries (id, name, jdoc, created_at, updated_at) FROM stdin;
1	Industry	{}	\N	\N
\.


--
-- Name: industries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('industries_id_seq', 1, true);


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('jobs_id_seq', 1, false);


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY migrations (id, migration, batch) FROM stdin;
1	1971_12_17_000000_disable_foreign_keys_for_migration	1
2	2014_10_12_000000_create_users_table	1
3	2014_10_12_100000_create_password_resets_table	1
4	2016_06_01_000001_create_oauth_auth_codes_table	1
5	2016_06_01_000002_create_oauth_access_tokens_table	1
6	2016_06_01_000003_create_oauth_refresh_tokens_table	1
7	2016_06_01_000004_create_oauth_clients_table	1
8	2016_06_01_000005_create_oauth_personal_access_clients_table	1
9	2016_09_30_135314_create_clients_table	1
10	2016_09_30_145844_add_client_id_to_users	1
11	2016_09_30_154431_create_sectors_table	1
12	2016_09_30_154455_create_industries_table	1
13	2016_09_30_154456_create_projects_table	1
14	2016_09_30_171235_create_table_checks	1
15	2016_09_30_201622_create_user_logs_table	1
16	2016_10_01_002338_create_project_user_pivot_table	1
17	2016_10_07_152257_add_polypoint_columns_to_projects_table	1
18	2016_10_11_034730_checks_add_datetime_indexes	1
19	2016_10_17_162604_add_users_table_field_username	1
20	2016_10_18_220150_create_permissions_table	1
21	2016_10_18_220202_create_permission_user_table	1
22	2016_10_31_184813_add_permissions_to_users_table	1
23	2016_11_02_213527_add_address_fields_to_project	1
24	2016_11_15_212340_create_client_project_table	1
25	2016_11_22_190453_create_reports_table	1
26	2016_12_12_220312_create_jobs_table	1
27	2016_12_12_224610_create_failed_jobs_table	1
28	2016_12_12_233345_add_soft_deletes	1
29	2016_12_20_065926_add_tos_agree_to_users	1
30	2016_12_27_170151_add_foreign_key_between_user_logs_and_checks	1
31	2016_12_27_194509_add_isexceptions_to_check	1
32	2049_01_01_000001_insert_records	1
33	2050_12_17_000000_enable_foreign_keys_after_migration	1
\.


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('migrations_id_seq', 33, true);


--
-- Data for Name: oauth_access_tokens; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY oauth_access_tokens (id, user_id, client_id, name, scopes, revoked, created_at, updated_at, expires_at) FROM stdin;
7c4b22530ca11ddef3a16aad86b12cfae359f43102fa2b8ebf17193bbb58a65c0a34ffa49cfd48be	1	1	\N	[]	f	2017-01-13 20:03:44	2017-01-13 20:03:44	2018-01-13 20:03:44
accf92bc48c2aefab8a3c6c068dd9fad0f2e6d20f293bc90af9bd318e826080bf4b0afe9fae0567d	1	1	\N	[]	f	2017-01-13 20:04:43	2017-01-13 20:04:43	2018-01-13 20:04:43
ff31347407b2db83aa293da7e5614fcec265619d70b520583a29b54c030e39f0c93b8b84ec6b56cc	2	1	\N	[]	f	2017-01-13 20:08:06	2017-01-13 20:08:06	2018-01-13 20:08:06
e47cdf4d2132fa73987cc67ddd3d51efb73848334ef3e69bb6d0e4d57aa2f62483e1295449b69c3d	3	1	\N	[]	f	2017-01-13 20:12:07	2017-01-13 20:12:07	2018-01-13 20:12:07
156decd6fc502d60b92a0291f180b578d02743297be3f4f9c329facb1bcca822127345d07f454df4	2	1	\N	[]	f	2017-01-13 20:22:18	2017-01-13 20:22:18	2018-01-13 20:22:18
09db3b9fe52591f6260da1b2fe34efd017ea83e1dfafaac2636545c8d11e9f0f0e9b2518f1eefdae	2	1	\N	["*"]	f	2017-01-13 20:22:58	2017-01-13 20:22:58	2018-01-13 20:22:58
054a12991ff3b71d3c302d10d85e20e094a2e48d27ef942e7596b72e8aaaa634e68d364e99a24a78	4	1	\N	["*"]	f	2017-01-13 20:23:31	2017-01-13 20:23:31	2018-01-13 20:23:31
1966a1f6f2be0ce1e19bde0379352bb3fe235f2d2c667c6fd2e94724c7d5237a7650e4acdd6efc0b	4	1	\N	["*"]	f	2017-01-13 20:28:21	2017-01-13 20:28:21	2018-01-13 20:28:21
c52032ed55a7f206230056ccc079c543235e04c0fdbc1f4affc55f0f15dde853658d2185fb3830f3	2	1	\N	["*"]	f	2017-01-13 20:30:12	2017-01-13 20:30:12	2018-01-13 20:30:12
3156d80623849ab16188f5a1dcbffdd07cfaf2d7be54e51098e582d7c4b24219e8166cd79e987f0b	4	1	\N	[]	f	2017-01-13 20:36:49	2017-01-13 20:36:49	2018-01-13 20:36:49
0eec78efc6ff5206a35715a0417c60524643d66820c52692fdaa12e1f183ad884d230ffc4f6697b7	4	1	\N	[]	f	2017-01-13 20:37:28	2017-01-13 20:37:28	2018-01-13 20:37:28
786352dd1d31006ca1385a71c5dae2b3619f0b280812bb43fb18691e32ce7588bc775f6fd290da48	4	1	\N	[]	f	2017-01-13 20:38:12	2017-01-13 20:38:12	2018-01-13 20:38:12
35d2c22d778fc3e70602ebe51e751bd6626da96caeef2b02d660a1c2b092c8cfbee2d7bae5f7d489	1	1	\N	[]	f	2017-01-13 20:38:32	2017-01-13 20:38:32	2018-01-13 20:38:32
08e7466257185c5a3cfa56ed48f94e59165d725cf69b156528533fc06decc8019f1633b87e970ce2	4	1	\N	[]	f	2017-01-13 20:39:27	2017-01-13 20:39:27	2018-01-13 20:39:27
f5f5080c9424d0bbfad985d5e70e6e903d101c7bf00c2bf52d8c11ca95c24787637a35089b3f148a	4	1	\N	["*"]	f	2017-01-13 21:03:39	2017-01-13 21:03:39	2018-01-13 21:03:39
3b929c191fd80f88b5aa7a333a5ec7871492fc5f90a104aa82e92fbd0901c9690046e4e46150b8f3	4	1	\N	["*"]	f	2017-01-13 21:07:51	2017-01-13 21:07:51	2018-01-13 21:07:51
5f03059a4e9ce134c38e44e9f50a85b38eb17d9c7fb2db3eb441f346ffca5ee42e913b7e67693310	2	1	\N	[]	f	2017-01-13 21:09:42	2017-01-13 21:09:42	2018-01-13 21:09:42
5b18c519a1a403ed841cd3f05bc3d1fd5abcb7da5082d4ff6645872bb9a98e8160d4f8878fed5ee2	4	1	\N	["*"]	f	2017-01-13 21:53:24	2017-01-13 21:53:24	2018-01-13 21:53:24
7498b632972148c5c056f848abbb5ce26c53bdafac8a18a4adecaa3201a59d0143527015dde8db8e	1	1	\N	[]	f	2017-01-17 00:11:06	2017-01-17 00:11:06	2018-01-17 00:11:06
083a2111601a780b73299009101d8d8c39a2fa27fcdc99d5216efba862a10bebe2b7461456ead157	5	1	\N	[]	f	2017-01-17 00:17:56	2017-01-17 00:17:56	2018-01-17 00:17:56
eee437cda3e1aa405bd8d3e461b6b909da457c84d7d72f6fc778918a9e2d61b18ed33fdd879918ec	2	1	\N	[]	f	2017-01-17 00:19:50	2017-01-17 00:19:50	2018-01-17 00:19:50
9a83c3dde5cd8dfd388f3e53cac8933383b9e05992b04798f140ed3e147a4d2a6729f34f25d8e7d4	4	1	\N	["*"]	f	2017-01-17 00:27:34	2017-01-17 00:27:34	2018-01-17 00:27:34
ed1f1b776cff1d81e0ffa7fa740fc3a8ddfd04abe12ee50b25f57d0b7b28b795c52da85a2694c34a	1	1	\N	[]	f	2017-01-18 14:38:01	2017-01-18 14:38:01	2018-01-18 14:38:01
1941b3f876b477da2f90575e47a2b534ef91fc4fec6ac92926e7f58160e599549ae5d5f658b403bf	1	1	\N	[]	f	2017-01-19 15:09:59	2017-01-19 15:09:59	2018-01-19 15:09:59
c110ead14c9a9d3f351ce5883125c1d1c3ec802b4d579d3331fbadb23e896a1320c1f1c4ecf39f49	7	1	\N	[]	f	2017-01-19 18:14:22	2017-01-19 18:14:22	2018-01-19 18:14:22
282541cf50c41de629bf87ea813a41ff9e17e78b7fc3872972d744506ceb58e53663454e84222e81	7	1	\N	[]	f	2017-01-20 19:17:19	2017-01-20 19:17:19	2018-01-20 19:17:19
6e7f4f89dc7793c3d2a8b69fd02ed30095be35ad9d53fe3675860a80588c5d1ef7399981a2189118	43	1	\N	[]	f	2017-01-20 19:18:40	2017-01-20 19:18:40	2018-01-20 19:18:40
d6bf6e462e942d6c325a84050867c379dc490589963c664cd89b9eab768824acd00f8ba17584b172	43	1	\N	[]	f	2017-01-20 19:18:42	2017-01-20 19:18:42	2018-01-20 19:18:42
0172712b7d2ab31df060462e8207fc69543742f668a0aa1b0c9165927193ac434e67b746fc404bc3	42	1	\N	[]	f	2017-01-20 19:23:43	2017-01-20 19:23:43	2018-01-20 19:23:43
f5c1b978420af3078559a96e114b7beed8448f8574edeef4901b3a37fa486b527ee3ac0e4d15b752	7	1	\N	[]	f	2017-01-20 19:33:32	2017-01-20 19:33:32	2018-01-20 19:33:32
59fc60f4229fca6032af8c444a4ee056c62981038ecd742dd2634bf66ff553f6d823d6e4177c0e58	41	1	\N	[]	f	2017-01-20 19:37:23	2017-01-20 19:37:23	2018-01-20 19:37:23
bc63fa712aad4080ac800b21749332d5e579e697696db7ace3f41f0c56030548f61991512937f957	42	1	\N	[]	f	2017-01-20 19:37:52	2017-01-20 19:37:52	2018-01-20 19:37:52
96f435701d997e666298bf0b7283277bd99b8560bce8b43bb2b0ee30a38f514073428744acf9f5cc	7	1	\N	[]	f	2017-01-20 19:38:08	2017-01-20 19:38:08	2018-01-20 19:38:08
9390653e87384dec6bb9606aca885ec3d9eeb9ab0d2cffa5f9c800236bf280d1fe11e5f0983f0baa	43	1	\N	[]	f	2017-01-20 19:40:09	2017-01-20 19:40:09	2018-01-20 19:40:09
c46239cb799b464360c54260d4d2231af8d48bca3ea71c3fcf65b45cc2594eab4197518194c96b9d	43	1	\N	["*"]	f	2017-01-20 19:41:10	2017-01-20 19:41:10	2018-01-20 19:41:10
25305eb01979a97bed4bf78b95a439ff9d15ae6288bfc1be5ae718159ae6d30dba628fd7c2298dd1	7	1	\N	[]	f	2017-01-20 19:55:00	2017-01-20 19:55:00	2018-01-20 19:55:00
ddab857be9e0665c981799f2f4d371669d00592f29878aabab2812dff054150c136c5833b1176902	43	1	\N	["*"]	f	2017-01-20 20:01:58	2017-01-20 20:01:58	2018-01-20 20:01:58
34d6dcc4d91e4c3195f656f171b09914aea8240f638cc10eaaf3660e72e362e5820bb498f4cb028b	13	1	\N	[]	f	2017-01-20 20:07:13	2017-01-20 20:07:13	2018-01-20 20:07:13
07cf59418cd1e23068f0a71a43d1d6e0f9c2c508e60e485692945fc9612e7ab35313c9e2d6d77605	12	1	\N	[]	f	2017-01-20 20:08:27	2017-01-20 20:08:27	2018-01-20 20:08:27
d42060f5b0704e449d8808e03df3dfe9c42fddf1a799587e1ab910629d04c8c79c4c056959676eb1	11	1	\N	[]	f	2017-01-20 20:09:43	2017-01-20 20:09:43	2018-01-20 20:09:43
8655d12effbd7403b0b122e021db361aa342f0c201f0875aedff06e3148f0c80ab975bf09b473fb7	1	1	\N	[]	f	2017-01-20 20:32:19	2017-01-20 20:32:19	2018-01-20 20:32:19
bf44f7c8270f63c66264c61a651aa37ff7ca09a5afb2dc1362026b23d9296761938083f777125ec0	4	1	\N	["*"]	f	2017-01-20 23:36:13	2017-01-20 23:36:13	2018-01-20 23:36:13
fbd03a81887f111c3ac7548894e22ae9c96ac84bc2e1bf4184189a815c8665a47d203e2fb4bb355b	1	1	\N	[]	f	2017-01-20 23:41:20	2017-01-20 23:41:20	2018-01-20 23:41:20
17a6a7f3bd3f5786b5b481f6565525aad7cc9dab5f561d770b94f3e81938f1d33633e7459a99430e	45	1	\N	[]	f	2017-01-20 23:43:49	2017-01-20 23:43:49	2018-01-20 23:43:49
0844e51b3b16cd82ec0b5c98a075ced5f40d4d4ecd4fe7a62dd3ff7b65146ed59547109e9d125542	2	1	\N	[]	f	2017-01-20 23:45:04	2017-01-20 23:45:04	2018-01-20 23:45:04
2ef5c3674272eb23b309f3853007cc892c7c60d4b720bf0632d3bb561ed58bd31a621de4eb1947a1	1	1	\N	[]	f	2017-01-21 04:43:58	2017-01-21 04:43:58	2018-01-21 04:43:58
bff238927442cc377d5cce4015938c946514900fa3b75cb4896e96534b3f196e62733b205b17c236	1	1	\N	[]	f	2017-01-21 04:57:39	2017-01-21 04:57:39	2018-01-21 04:57:39
39f5bc57b16a615b1780bbff27fbd4dccb724e17ceabce6d12279ffe06b519b70682e62165040948	1	1	\N	[]	f	2017-01-21 04:58:28	2017-01-21 04:58:28	2018-01-21 04:58:28
b54e543d9be5bb869dffce86da58ceae23befbacd5795f854eda451af6cf0ef050e4f7dd92f063fc	44	1	\N	[]	f	2017-01-21 04:59:14	2017-01-21 04:59:14	2018-01-21 04:59:14
0ac11a63930aeb4eb4a9feb24bb47ae8428a35a93b9ee39883b6899810118ec8cd52b343171de207	44	1	\N	[]	f	2017-01-21 04:59:27	2017-01-21 04:59:27	2018-01-21 04:59:27
d718c3e287dcee1c43ad8d0702a77d933be8fc5e554004cf7a06d694460e53727c5e88ad5c6c71d4	1	1	\N	[]	f	2017-01-21 05:00:08	2017-01-21 05:00:08	2018-01-21 05:00:08
6ac12dda99be1d9012f4eeb248cdbbe38812a172e48a73f9de4e10d4b9df6fe84c29d274aa4479ac	44	1	\N	[]	f	2017-01-21 05:00:43	2017-01-21 05:00:43	2018-01-21 05:00:43
07803f6a0015de0a339ec07932a9f036e2315f367b538fcb7e14a90cb89912b9fc2be4a27a863722	1	1	\N	[]	f	2017-01-23 22:13:52	2017-01-23 22:13:52	2018-01-23 22:13:52
b81b56ab634a89faf8433145383fb53c00f247e58b68086bf731afee105045b8577ef9ca5ed7c35f	46	1	\N	[]	f	2017-01-23 22:20:07	2017-01-23 22:20:07	2018-01-23 22:20:07
d061f97979ebe87c81740c9616e70aadcc8db4f74338cde8e886367f65eabbc4d6154f46d172a143	46	1	\N	[]	f	2017-01-23 22:23:52	2017-01-23 22:23:52	2018-01-23 22:23:52
e60bdc25b0b73c5d2b79379e08a2baa103856710e1b1cb0d1435887a6968f34e087fedd42d844f20	46	1	\N	[]	f	2017-01-23 22:32:58	2017-01-23 22:32:58	2018-01-23 22:32:58
13ef89ecabcfce51e97916e4cd3842f2da0a7a29eeb57e966a77f72105e338729c6f8d3694922d60	1	1	\N	[]	f	2017-02-03 17:57:34	2017-02-03 17:57:34	2018-02-03 17:57:34
0724424748bd17dd76dc8b72933834d63c41a175db667aac7c4a7a797515d0864fdce5e297c8ac27	1	1	\N	[]	f	2017-02-03 17:57:54	2017-02-03 17:57:54	2018-02-03 17:57:54
59a455d8cbfba4ea24f0ee3b019a6de376f2628749606d5d67eba9e41a67221ca27cbbed51541be5	1	1	\N	[]	f	2017-02-03 18:12:32	2017-02-03 18:12:32	2018-02-03 18:12:32
6e111983b40bb63e9b98e5b5a8b4026f6f645781ecbb18827149e74f7870ad925626d889f46d2661	1	1	\N	[]	f	2017-02-03 18:16:00	2017-02-03 18:16:00	2018-02-03 18:16:00
f234b00c345f32d313f6906eb2182be02ccc8dd08636bd536207e1aee205205b048f8f2f80d2378f	1	1	\N	[]	f	2017-02-03 18:23:31	2017-02-03 18:23:31	2018-02-03 18:23:31
2450763d109a3070d3624a0533c347da2d9ab6ea07705775cbb85763f0ecf1df151433fb83395e41	1	1	\N	[]	f	2017-02-03 18:23:39	2017-02-03 18:23:39	2018-02-03 18:23:39
472023e3d153e4a23ecb1759e0d41e565c15ba8d4e59b070f3ccf3803e4f6e35daac14baf91092a1	1	1	\N	[]	f	2017-02-03 18:25:42	2017-02-03 18:25:42	2018-02-03 18:25:42
169f8f66016c30e4e2c5e65ed217684d0cca322d4e23a1729d84594b137dbaa244dd6fc3940b5e55	1	1	\N	[]	f	2017-02-03 18:28:18	2017-02-03 18:28:18	2018-02-03 18:28:18
5778ff0f2df33f857a16458238f032e12b84447adf1e0e0238f39240a5957bb5227fc6f018b5f18c	1	1	\N	[]	f	2017-02-03 18:28:38	2017-02-03 18:28:38	2018-02-03 18:28:38
46d698349f4d6170880f892ee5cf02ee5f781cc2abc9a3e8dd11d6edeffcef90ab3b026bfc133cd1	1	1	\N	[]	f	2017-02-03 18:28:58	2017-02-03 18:28:58	2018-02-03 18:28:58
533b7d185fcff42ea94e417a476586032fb99c272ea1e44c24c3ea4c6c7719abba682b925277f16a	1	1	\N	[*]	f	2017-02-03 18:30:20	2017-02-03 18:30:20	2018-02-03 18:30:20
7fe713dae04f44be330e99c1a90e8c8e07acd96750d37e0c0c3e896b346b214535a0c7e749adb862	1	1	\N	[]	f	2017-02-03 18:32:52	2017-02-03 18:32:52	2018-02-03 18:32:52
e160982a31e66d69cfdbc7dfb56b1baccc27020d9280f49ac02e4a7e7b0f98db15f0b7b8caf867ec	1	1	\N	[]	f	2017-02-03 18:33:12	2017-02-03 18:33:12	2018-02-03 18:33:12
4310f2536e31c1df760840980ff3eb106250d2a031b448cc7fc52e3fc72e740f278b20e1f61ac75e	1	1	\N	[]	f	2017-02-03 18:35:06	2017-02-03 18:35:06	2018-02-03 18:35:06
926b60f6eb6b8ca0abc52c59330694e6dd2bc8f0792d92aaf21ee37521845fb13819b33c10db1bc6	1	1	\N	[]	f	2017-02-09 15:02:15	2017-02-09 15:02:15	2018-02-09 15:02:15
b5e706a6ebff033511e4eac329592d765d2f89bfe66e8ee1e76e3e69d623e021a12ed5901a62e6cf	1	1	\N	[]	f	2017-02-09 15:03:18	2017-02-09 15:03:18	2018-02-09 15:03:18
f0fb3f04549916e1df79be9df175cb09740f781ff3108aad135d2f0ca9140cf30a4ce4f6a74d8b81	1	1	\N	[]	f	2017-02-09 15:11:47	2017-02-09 15:11:47	2018-02-09 15:11:47
e9e709cc22b892d618b43a5ef148c536ed8491fcd834ca2918098ec3b0030d526ad42418c541d557	1	1	\N	[]	f	2017-02-09 15:31:01	2017-02-09 15:31:01	2018-02-09 15:31:01
98dcca11b5411ad27e14660b5be1c47a9b0e257ae35b68acf97db562ec4425f12c541e4b68c3c43a	1	1	\N	[]	f	2017-02-09 15:42:45	2017-02-09 15:42:45	2018-02-09 15:42:45
70340eccae997f3112f1c2a5297ecd7627bf50c53d3f7ec0bda5cf315f56947140837c489fea7a6d	1	1	\N	[]	f	2017-02-10 13:13:22	2017-02-10 13:13:22	2018-02-10 13:13:22
49b8b6b3ec1d5d74c8e9a5205e4b54c11ac8eceaeb1226366c22c5f7e8231c415b4ea61b7b2e14b3	1	1	\N	[]	f	2017-02-10 13:13:30	2017-02-10 13:13:30	2018-02-10 13:13:30
b4763a54dfd1062cebe077a2d7de80979e4f3efa8b984b421a36466f95536cd81ddc3deeb7c2be68	1	1	\N	[]	f	2017-02-10 13:13:42	2017-02-10 13:13:42	2018-02-10 13:13:42
8afda99b48c07379acd11d5c2a1059505edfcd3eb7f42f942e250aeed041c0e4a3dd465bd8d087cc	1	1	\N	[]	f	2017-02-10 13:17:23	2017-02-10 13:17:23	2018-02-10 13:17:23
096ccad8d210f6197fe49f5863eaf3388d969a324dbb1b69883b097983140100bb4dad8be2e68aa6	1	1	\N	[]	f	2017-02-10 13:17:46	2017-02-10 13:17:46	2018-02-10 13:17:46
a18f612b78784ede0a3dcf4a205fa17d4c42ef3f2bef0bf2dad5310a0ae5b4b2c6170ba4b69b6942	1	1	\N	[]	f	2017-02-10 13:18:37	2017-02-10 13:18:37	2018-02-10 13:18:37
458f155fec6a8dd88cb608465fa83b96510e167e931796f45629c1d8671a94a5ec76e5665ffa0e77	1	1	\N	[]	f	2017-02-10 13:22:06	2017-02-10 13:22:06	2018-02-10 13:22:06
27a82e7e7d2eef4b7c491006e0f0107cd91cde04ab4be12b55efd486ca1cc01320ccba58b27ab37c	1	1	\N	[]	f	2017-02-10 13:22:57	2017-02-10 13:22:57	2018-02-10 13:22:57
9ba96ffb39807ba399e62434735bee8e6f1886138ee8d1f0f7a53462a98ce667505057cfb7ddb7c6	1	1	\N	[]	f	2017-02-10 13:36:17	2017-02-10 13:36:17	2018-02-10 13:36:17
0b0cb3c2f62a0e79dbf74fc6dd6328b1337d55024b4e919705c7f6473b2c9d2f95aff1c56593c90b	1	1	\N	[]	f	2017-02-10 13:36:26	2017-02-10 13:36:26	2018-02-10 13:36:26
4ce5e1bb3f2541a8c6f499b8ec72f4544f110df34eb482786ba6c194e9c209df300b070c66d3a0ac	1	1	\N	[]	f	2017-02-10 13:42:53	2017-02-10 13:42:53	2018-02-10 13:42:53
ea697d6f42dc077e8ebb45aae38af40f0d53eddd77ce8eb8d33ca9555cc48ddf74aad703e4b8e8c1	1	1	\N	[]	f	2017-02-10 13:47:32	2017-02-10 13:47:32	2018-02-10 13:47:32
e14d1eac5e4f9b106e30efa5205988a824059ba5da2c2504c519f91c4865add4e4343abf9407cc69	1	1	\N	[]	f	2017-02-10 13:49:16	2017-02-10 13:49:16	2018-02-10 13:49:16
eaa24bf20be4873478a384b2f768fdcfc006a35d588092c02c56b91a26ee7d4dce2573e6f46134bb	1	1	\N	[]	f	2017-02-10 13:54:05	2017-02-10 13:54:05	2018-02-10 13:54:05
f32965a81424eb7639d71226f256e40deb6e0d05f34dc0e882edfafdd4a81afebfac418011d7188a	1	1	\N	[]	f	2017-02-10 14:01:09	2017-02-10 14:01:09	2018-02-10 14:01:09
eab36b69a4d4e3b1c6d55b24124d536ebfc6d4974e462c34eb5d356a89d3ee02c926e5af09e22340	1	1	\N	[]	f	2017-02-10 14:03:09	2017-02-10 14:03:09	2018-02-10 14:03:09
b17c1ab51b5ac44b442c94eda7ac362c88c1ff3f287cab655d8226c8cce2d77644e9bf299f2322f2	1	1	\N	[]	f	2017-02-10 14:03:16	2017-02-10 14:03:16	2018-02-10 14:03:16
b42cfad24ac5b22b78a8fe23110af93f36f34f4d67a97a18cdebe014101995a29fba02799ae45048	1	1	\N	[]	f	2017-02-10 14:18:16	2017-02-10 14:18:16	2018-02-10 14:18:16
b9442e17229f4b902f20824e7673534a449e5f553189fd8a159756d79daae68eaca34a76faa93bd6	1	1	\N	[]	f	2017-02-10 14:20:00	2017-02-10 14:20:00	2018-02-10 14:20:00
15de02a8fe8730431260cacb1b9460d97747e108d2f2743607b5b165d7f6ac6e5fd38467f4fe09b6	1	1	\N	[]	f	2017-02-10 14:25:39	2017-02-10 14:25:39	2018-02-10 14:25:39
9a834c9418bb9add639adaff635fd5810b58d975c9792cf83e7acbeef3c406cd8c98deaf325101f9	1	1	\N	[]	f	2017-02-10 14:34:06	2017-02-10 14:34:06	2018-02-10 14:34:06
3c98dc61300f09b8a1df15a258dff5c983647619a079d926178847f7830c104d5fc99b1f1d508c17	1	1	\N	[]	f	2017-02-10 14:34:07	2017-02-10 14:34:07	2018-02-10 14:34:07
ae0d3688e1966af0e9f0dc284719d848d475c195710a974b2eb9c922eb692bf1742a3a3739c7b50f	1	1	\N	[]	f	2017-02-11 12:22:11	2017-02-11 12:22:11	2018-02-11 12:22:11
10b5df247dad37c2cf9064c5384d0720b46446df6c11e7231c0e84e73be29e9cc324dcc2c3cf4380	1	1	\N	[]	f	2017-02-11 13:03:19	2017-02-11 13:03:19	2018-02-11 13:03:19
89e8f4a648551f3f61e5a1be01b20efbb77b0265ece0f7acab98fd5b4d5d49566b394bf997cc1bc4	1	1	\N	[]	f	2017-02-11 13:05:42	2017-02-11 13:05:42	2018-02-11 13:05:42
e7a77abf2602759137ff4421895ed2de62a6af14d69a0f14dface3c137f2dcfc377ce25456192ec2	1	1	\N	[]	f	2017-02-11 13:49:18	2017-02-11 13:49:18	2018-02-11 13:49:18
6186c74c1c05f0078004cd2c43bea7dd865a4371bab4efce11918970e1dc29ec7b8d660f284c2824	1	1	\N	[]	f	2017-02-11 13:49:41	2017-02-11 13:49:41	2018-02-11 13:49:41
403c6771afeaa01d219f0ca40cbcb026a655254fbf058d79c9ab6bdf7c3137fadc609aacc35959d4	1	1	\N	[]	f	2017-02-16 09:25:20	2017-02-16 09:25:20	2018-02-16 09:25:20
c7362616e921913cfedb004f9f373a9721be6918d1635a004dad5893d122c6b2daf6bedbaf05125c	1	1	\N	[]	f	2017-02-16 09:25:43	2017-02-16 09:25:43	2018-02-16 09:25:43
9f3ca24f34d0bceaec2dd6a66d40538fbf2377d05381746849760a4ca1718c77b5e8727d02b28a72	1	1	\N	[]	f	2017-02-16 09:48:24	2017-02-16 09:48:24	2018-02-16 09:48:24
b6db176b102c8ea2fa7c058bdd38a0cc0ba7e8e709a70e1aeaf934357c245fa309789e0ccb882598	1	1	\N	[]	f	2017-02-16 09:55:40	2017-02-16 09:55:40	2018-02-16 09:55:40
f65a7ae480b20ec224e82ce589e9c367379d5f1e5c934598b47212a860bf49833250b6a1d460b587	1	1	\N	[]	f	2017-02-16 09:56:12	2017-02-16 09:56:12	2018-02-16 09:56:12
f8dd07a6934870f8d49eea4e861b98df5e2fe2be5412cb9c85a19977598a31f831919b2b7d1fe00d	1	1	\N	[]	f	2017-02-16 09:59:52	2017-02-16 09:59:52	2018-02-16 09:59:52
20afbe86e84dbd3ca3d8f37074b3be9dbb7738079575548716fb717622449f069e036768381edf80	1	1	\N	[]	f	2017-02-16 10:10:45	2017-02-16 10:10:45	2018-02-16 10:10:45
18de83c4492d8c71a8a75e88b72d9756843180e7e0429bfd0f2127e401d4fbe2eb27cdeea86fd4fe	1	1	\N	[]	f	2017-02-16 10:55:10	2017-02-16 10:55:10	2018-02-16 10:55:10
1682e9c2b9649faa7ea03b71a4b6d4d3ceceda388d904422d4d0c7c02f8fb34c2276a8ecfc0e75f2	1	1	\N	[]	f	2017-02-16 11:00:49	2017-02-16 11:00:49	2018-02-16 11:00:49
10fc1bda06799ecc75bb53b48c42d3960211647e968ee0c270d696f927ec9e35a220676e10a025a5	1	1	\N	[]	f	2017-02-16 11:02:16	2017-02-16 11:02:16	2018-02-16 11:02:16
72f979391d52dde84cf438f8fa0d487f909dd0e8b30b511152060eda11aeb935e1de9258d26251bc	1	1	\N	[]	f	2017-02-16 11:04:43	2017-02-16 11:04:43	2018-02-16 11:04:43
e81ecd3caf6cd92550be44aced8aee10a69e23cdaeb02af078e514e8bb15ef801f2f73fce0127e8f	1	1	\N	[]	f	2017-02-16 11:06:31	2017-02-16 11:06:31	2018-02-16 11:06:31
7a100e7f206f39b576f591e8b582ba0f142a4108b8409de4f5f424efdc9d903152eaba12ac0b60ef	1	1	\N	[]	f	2017-02-16 11:10:25	2017-02-16 11:10:25	2018-02-16 11:10:25
cec194b41984fe3e2007af75d4e0d60b8d9b1cc0ad16db01a451973f7058c0a8c4b1828b922fadff	1	1	\N	[]	f	2017-02-16 11:14:23	2017-02-16 11:14:23	2018-02-16 11:14:23
694cc0a411cbfadfc04bd8859bed8c75f30b4378f5707a2b4e5eb6e43d419b3e19b2a12d204890c2	1	1	\N	[]	f	2017-02-16 11:32:25	2017-02-16 11:32:25	2018-02-16 11:32:25
9471252cab3ba77fb1c71139b9f335c7664e5d2bb4f52128ed95f35cdaaf69e697153f99337ccca6	1	1	\N	[]	f	2017-02-16 11:41:32	2017-02-16 11:41:32	2018-02-16 11:41:32
6c2bae0338ba9044db551cf5a2be9e7b6bf1c224f2da5dd245b0dafc998b7a7238c85eee78db26e1	1	1	\N	[]	f	2017-02-16 11:41:36	2017-02-16 11:41:36	2018-02-16 11:41:36
eef18c26958e3c2c192ecf68bbf478cc59b4e8650a2c40b87110c1a8002a145d9538358639b500d4	1	1	\N	[]	f	2017-02-16 11:46:54	2017-02-16 11:46:54	2018-02-16 11:46:54
19a37b20d1b37a3157fe9e4fc891c00322a39c92e5c3aab7bc9ef9832d0dd8e1fd94f93ab8e544b2	1	1	\N	[]	f	2017-02-16 12:20:37	2017-02-16 12:20:37	2018-02-16 12:20:37
e5fab270005ed4aac7f9945bd364b7445635132f6d2349565845639130aad7579046fc19e4be07c5	1	1	\N	["*"]	f	2017-02-16 12:23:42	2017-02-16 12:23:42	2018-02-16 12:23:42
4acc44d44a5959bc66b92387e0c450ecf7f076b0aa08e44bf0381d94d48c29a2fe782139a910a1c7	1	1	\N	[]	f	2017-02-16 12:25:31	2017-02-16 12:25:31	2018-02-16 12:25:31
f626ac9f21198c76c86e6ba01cc6547437eb22c2b45ca34423ddd954f5c0a36a4aaf91c625b0353e	1	1	\N	[]	f	2017-02-16 12:36:34	2017-02-16 12:36:34	2018-02-16 12:36:34
3d1248df9d945a95458bea7e6e625b108311577372efb98420881664c8397b5f967cbe77f9384e49	1	1	\N	[]	f	2017-02-16 12:38:12	2017-02-16 12:38:12	2018-02-16 12:38:12
1e8ab49dba7cb50b07e1a2a2a6dccb12ec96669014b7f87447dbf1b873312c251cf053bffa43724b	1	1	\N	[]	f	2017-02-16 12:39:09	2017-02-16 12:39:09	2018-02-16 12:39:09
e66495400df29002759b2700f4f9730d2b41a25f2bd33525551980de519c9a3ebb382a1aebf52699	1	1	\N	[]	f	2017-02-16 12:39:19	2017-02-16 12:39:19	2018-02-16 12:39:19
11377005cc83cb969f11a05e5b07c7e5125ca52e00d94a20d91766a3f23f0f52a3782ce9cad93e58	1	1	\N	[]	f	2017-02-16 12:41:07	2017-02-16 12:41:07	2018-02-16 12:41:07
5e40cea051e475cbe5a70f3772651f4b04de655cddf7922134577cbea9840448cdac6d89053016fe	1	1	\N	[]	f	2017-02-16 12:42:50	2017-02-16 12:42:50	2018-02-16 12:42:50
1f52d50a08573ff2947cc839898964f79b60baf15ac768fcf7e80019e1c66567646a640af039ebbb	1	1	\N	[]	f	2017-02-16 13:07:29	2017-02-16 13:07:29	2018-02-16 13:07:29
3ccb0da353b1c9b44a11595cd454d3cca4d407d069454bb497aabe4bc4dfda1cb4940728ee217465	1	1	\N	[]	f	2017-02-16 13:19:59	2017-02-16 13:19:59	2018-02-16 13:19:59
95e37c763e8d7aacc045f2c8c3103529b3ce3c594effd3b5889e1debaa0283c63154e1b9be7ef3b2	1	1	\N	[]	f	2017-02-16 13:49:57	2017-02-16 13:49:57	2018-02-16 13:49:57
157918e16e256a22dead9c58bbc84892b87000a83764864b5d604460e75d8b53a2ee99ae6aa5fffd	1	1	\N	[]	f	2017-02-16 14:14:35	2017-02-16 14:14:35	2018-02-16 14:14:35
5da002c8bbf3a9ee6e205ed8c6bb869aa8d1641e0fc6988af072b3c5efc56393f747dbc48d9d438b	1	1	\N	[]	f	2017-02-16 14:14:44	2017-02-16 14:14:44	2018-02-16 14:14:44
0a963863b1c9ba7650a2658eb5b79aa63746821aa1dd209e219356581c3d4eb9f9292c3873210bd4	1	1	\N	[]	f	2017-02-16 14:15:13	2017-02-16 14:15:13	2018-02-16 14:15:13
470c03a317374c99e1f69b243773621f8be4e885ffc2122ed38899eccba3f17e13d1b0218d13ea97	1	1	\N	[]	f	2017-02-16 14:26:42	2017-02-16 14:26:42	2018-02-16 14:26:42
9b0988e67cebfc3ea4553af1ed89fb8d04188fc0f2c33ec703a35792a9b01ae76c7cad46b9819cbf	1	1	\N	[]	f	2017-02-16 14:26:59	2017-02-16 14:26:59	2018-02-16 14:26:59
bc8ce58c7e6218c7c0a5092785ca49c2b20cc8f78f4bf2ada952f3ba9c48493e9e620b6ceffc8af6	1	1	\N	[]	f	2017-02-16 14:27:00	2017-02-16 14:27:00	2018-02-16 14:27:00
891ee10ca49e69e326d21126ae2ee649cdd0d0d8e826ec47d6211944e15990e642da980f949b8ca5	1	1	\N	[]	f	2017-02-16 14:27:01	2017-02-16 14:27:01	2018-02-16 14:27:01
1a7eb03ddc870db01b2714c96212796fc2e3bbdaefbd1b71868b607299f21d88e85b5a9837e76560	1	1	\N	[]	f	2017-02-16 14:27:02	2017-02-16 14:27:02	2018-02-16 14:27:02
c1430b53a67ad2124d0bcfe369f116348373fd0b4d72deff8af9613e30dff1db8725ef4705125cc1	1	1	\N	[]	f	2017-02-16 14:27:02	2017-02-16 14:27:02	2018-02-16 14:27:02
34510987672ba3689bd242baf1599275d3443251c37b44d6ef4587e75e14f3d5e35267d5c2e1d2f4	1	1	\N	[]	f	2017-02-16 14:29:29	2017-02-16 14:29:29	2018-02-16 14:29:29
0faaba7c559c1005032766e9e60ab42557a719b77d9103595737c8f03e7c814a944ad96cd4a94372	1	1	\N	[]	f	2017-02-16 16:44:04	2017-02-16 16:44:04	2018-02-16 16:44:04
42a9710c27f2ac36692955f6fa5429fd304cccf75365223f12d2cf653e9deb0738d532c0fc66e250	1	1	\N	[]	f	2017-02-17 07:15:53	2017-02-17 07:15:53	2018-02-17 07:15:53
63946d1a9b574f7ac105aa1702cf2f82f554b4d2bb2371a74ec7a38f1d1d6c5a95d2163601f5a0f2	1	1	\N	[]	f	2017-02-17 07:15:59	2017-02-17 07:15:59	2018-02-17 07:15:59
3bb2344449d59c2af6d95106a9b90f92657bf0656ef6e5938b89892cda81ccc42846d5b75b52413e	1	1	\N	[]	f	2017-02-17 10:36:59	2017-02-17 10:36:59	2018-02-17 10:36:59
152c8dfb6577677a5710c7c3c1c46651d2258916c451819e468e7b730f812061d66d0073e8361ef9	1	1	\N	[]	f	2017-02-17 10:37:07	2017-02-17 10:37:07	2018-02-17 10:37:07
5dffdb8f2ab7772162dfa4c61b11a26bf0ba7b35ff2b1fa0f993aa286e565ac765be72f9c82e6a7d	1	1	\N	[]	f	2017-02-17 10:37:17	2017-02-17 10:37:17	2018-02-17 10:37:17
2887c43eef62af66851864f317cf6239aeb86ab390e4672e14ccd562fac62de1aaece4e94b98d639	1	1	\N	[]	f	2017-02-17 10:39:34	2017-02-17 10:39:34	2018-02-17 10:39:34
921c8151c94aa4f4d0f85027eba0a8c3c0271eaacc190bf6345eddc57939697770385e2e27eb4bef	1	1	\N	[]	f	2017-02-17 10:52:45	2017-02-17 10:52:45	2018-02-17 10:52:45
d7080fed9fe0fa0bc3047c1fa430263eca59e3960e95df3af2a27a9bfc10cb44bcf8362df7fb7eb1	1	1	\N	[]	f	2017-02-17 11:06:00	2017-02-17 11:06:00	2018-02-17 11:06:00
b1cbd0a172ffcb7589cf7bf313ea919aca49e088eca1c2e2a45a5ea86dad585a04e5d0c62ddd5233	1	1	\N	[]	f	2017-02-17 11:23:09	2017-02-17 11:23:09	2018-02-17 11:23:09
2f580f01f689ddbcea62f95ad6b7824d4c12da3ea294fe030cec17ad69dd8111a9126c984b876a46	1	1	\N	[]	f	2017-02-17 11:25:24	2017-02-17 11:25:24	2018-02-17 11:25:24
36ed6bf462c8f754d5c229f93277dd41bc37620324bd598ba5c0572a2dd1331eec1d3a9be4f87333	1	1	\N	[]	f	2017-02-17 11:29:35	2017-02-17 11:29:35	2018-02-17 11:29:35
e5318bde83f0b34d6386ea6cf56b63ab07378e98a9ff8697152c9ff5b1979bf327929fd30ad4c18a	1	1	\N	[]	f	2017-02-17 11:43:48	2017-02-17 11:43:48	2018-02-17 11:43:48
12f48c9d0022ed060d2b7db27b98ef9ed5c43cccdebed7b6c5a2fa18034fcffbe5372ff60a17c634	1	1	\N	[]	f	2017-02-17 11:44:02	2017-02-17 11:44:02	2018-02-17 11:44:02
d94c70b0a7e4e11b204f3ada1adeeef12847b9d1df9f5a12bbf34f794b162b64e197c10fd4352dd4	1	1	\N	[]	f	2017-02-17 11:48:25	2017-02-17 11:48:25	2018-02-17 11:48:25
2f8cf6c445783c345f6a72d8737673b6f54b76adeb1816450c4ce7e90ae0369e4bad8b0f03a1fccf	1	1	\N	[]	f	2017-02-17 11:52:35	2017-02-17 11:52:35	2017-03-04 11:52:35
c4999fcbcae1a2fcf4c4272cda30db03e9108e4d0186d2a12ff59dcc3071c4e2cdd4a9a91aeadf86	1	1	\N	[]	f	2017-02-17 11:52:44	2017-02-17 11:52:44	2017-03-04 11:52:44
d52b7bd9b63a56a5c76866a61295ca9e6f4e3e4708ef375080ce12731026ce94470a1d8a1dab21c1	1	1	\N	[]	f	2017-02-17 11:52:59	2017-02-17 11:52:59	2017-03-04 11:52:59
2735c83e434edbfea85e5652f86f35bd340e1324fddc783d6e52d9927febeabe829695fdbe635eb1	1	1	\N	[]	f	2017-02-17 11:54:43	2017-02-17 11:54:43	2017-03-04 11:54:43
490f49b8ae5884783027eb75c8e96fc73b5cfeb3aa0621bbf1e6608f2e31ade6530ec604e69008e5	1	1	\N	[]	f	2017-02-17 11:55:10	2017-02-17 11:55:10	2017-03-04 11:55:10
0f9ad626d777b5b7edbdb0ede37ed932772448a5c9e1f47a536fb19cf21dd41d833c9ad694e20acc	1	1	\N	[]	f	2017-02-17 11:56:20	2017-02-17 11:56:20	2017-03-04 11:56:20
c803f6ef83a3a8e4fccce0843652f6fb205051c595e9e0d69957b62a597854d97bce70d7c48e12bc	1	1	\N	[]	f	2017-02-17 11:57:36	2017-02-17 11:57:36	2017-03-04 11:57:36
6e7707dd164f1d1357635d25071a41e94b6a008e500839c6afeed7845b59243367970bc7ea7ba287	1	1	\N	[]	f	2017-02-17 11:58:03	2017-02-17 11:58:03	2017-03-04 11:58:03
afa699ff11ca4ce9e5f6f35b08ac766dd6984d3e57c13faca8f2469257a37f5b829500108d078af6	1	1	\N	[]	f	2017-02-17 11:58:16	2017-02-17 11:58:16	2017-03-04 11:58:16
2302f5c9f81ddeff5106a5e9d1446a2d228f10a6d10d54a1eda69bf63147c842575109c345ac1de8	1	1	\N	[]	f	2017-02-17 12:09:37	2017-02-17 12:09:37	2017-03-04 12:09:37
d8c7607c39e9ecf4566cd0432f60c3531b5fd60c00675a2a5b7cd597a96d97a0de74f730a303c9f1	1	1	\N	[]	f	2017-02-17 12:21:43	2017-02-17 12:21:43	2017-03-04 12:21:43
e0be5b227b4e6d311681587699ca0a55b30d7fcb0e3791c3d21b828a9e2092bad08533ff6cfcfd05	1	1	\N	[]	f	2017-02-17 12:48:57	2017-02-17 12:48:57	2017-03-04 12:48:57
9f6fe02c2e3d7268d3f2a315e6f87f9f668521e7f157e4ba3ce3f2dbb2181f8297ad6dc63c9283e6	1	1	\N	[]	f	2017-02-17 12:49:10	2017-02-17 12:49:10	2017-03-04 12:49:10
bc0eb5c1939ab0f2522a77ca301bfce53a16c8cb4fd7df1ec49e0985e38590dcc2faeee2e49735db	1	1	\N	[]	f	2017-02-17 12:49:54	2017-02-17 12:49:54	2017-03-04 12:49:54
1c36575cd8fb4d06d87f16334b387006e85be6754b5cfe00aa73fcc6ada02a7d3ccba6e96a304fef	1	1	\N	[]	f	2017-02-17 12:55:46	2017-02-17 12:55:46	2017-03-04 12:55:46
c239c91b36cd8174a0eb458b0646d396eaa9314ee01864e67cba67dc8212b059c97aca1f4933aa9e	1	1	\N	[]	f	2017-02-17 13:10:21	2017-02-17 13:10:21	2017-03-04 13:10:21
a5dc9baf77d1d44f6606ec969dc0f484c3a4abdafa070733ce05313be57b0704d70f9a12d5484f98	1	1	\N	[]	f	2017-02-17 13:13:32	2017-02-17 13:13:32	2017-03-04 13:13:32
a6fc027b29368e928216df7dc75c0841aa1a0ab3601e5a2c2590657fb7da7969ac2c0349e38effa7	1	1	\N	[]	f	2017-02-17 13:31:18	2017-02-17 13:31:18	2017-03-04 13:31:18
965f67f4ea831e24e9742bca8224d9b2c66c44604c870fbf7a525bf441e5a4f4bfac707e7f8c42d2	1	1	\N	[]	f	2017-02-17 13:31:45	2017-02-17 13:31:45	2017-03-04 13:31:45
51bbc3239eef8166911b644237ec2c1674f60f9f48bbbfa60de8dae6d36217a330a36b90c4c1885e	1	1	\N	[]	f	2017-02-17 14:00:01	2017-02-17 14:00:01	2017-03-04 14:00:01
7a89c4e6e846059bf54aa4476f213a2d70bd2f80c94d51ef22bee16b2efb0d74cb280c5d9d6f870c	1	1	\N	[]	f	2017-02-17 14:03:06	2017-02-17 14:03:06	2017-03-04 14:03:06
7f6d9211273e9123533a77f089983f3c291646d03ece79812ef73738edaa5f024e493efbe7be5fda	1	1	\N	[]	f	2017-02-17 14:06:41	2017-02-17 14:06:41	2017-03-04 14:06:41
4517758325ccf537c1265f883012cf6e361997d2122e72282ca680961dfe823091afbffa3bb47713	1	1	\N	[]	f	2017-02-17 14:07:01	2017-02-17 14:07:01	2017-03-04 14:07:01
e444a2cf6008fc32543715a2d72c9f2c7ec604fdd690a2158597068d7bb2bb8aecee3b877ed56588	1	1	\N	[]	f	2017-02-17 14:09:07	2017-02-17 14:09:07	2017-03-04 14:09:07
a4f43454accb6ed59711fa1633ada9416b4f2cf74968d7a5744025196e0dca92f5b0a5c0c53dd4fc	1	1	\N	[]	f	2017-02-17 14:09:15	2017-02-17 14:09:15	2017-03-04 14:09:15
450472d00e8daf8fe423f3ca8ff2de7d62ed4174474eac2d308ba171bcc042c476e461dbf6761b0d	1	1	\N	[]	f	2017-02-17 14:10:35	2017-02-17 14:10:35	2017-03-04 14:10:35
b0745a628de7ef456ca92b5b9f6076477afcb68e3d241c44118126e772ff5f411530ac099d4490e8	1	1	\N	[]	f	2017-02-17 14:13:44	2017-02-17 14:13:44	2017-03-04 14:13:44
1b93ffcb334b0da52c59667159514b829a1fcc692dcc55341a071ebe0c52047148187cd2b88a2a66	1	1	\N	[]	f	2017-02-17 14:13:46	2017-02-17 14:13:46	2017-03-04 14:13:46
ab823fc58363f073deb5dc754e82cbfb4f4e38fe3167b6c5f525d1f171be3ff2577e48fb0948e244	1	1	\N	[]	f	2017-02-17 14:14:25	2017-02-17 14:14:25	2017-03-04 14:14:25
4f97d7ca5f5da099966d50cfce56d0be2ad9cb0a55824b846287ec794e4e0090a744daf709413405	1	1	\N	[]	f	2017-02-17 14:14:48	2017-02-17 14:14:48	2017-03-04 14:14:48
c45828976e2ff1aa9e9421408d9211d17e9ce24f2bc8eacbb101a104b82f7b788188eb28d45bc598	1	1	\N	[]	f	2017-02-17 14:15:23	2017-02-17 14:15:23	2017-03-04 14:15:23
1313306b978e75e6263d80ed087987345dcf506c87763dbd49762550d785537672518da19b118e7a	1	1	\N	[]	f	2017-02-17 14:15:25	2017-02-17 14:15:25	2017-03-04 14:15:25
0c2bac69afcfce2ba9d8238f4c68627bbb92894e2c1af852d13137bb4540718611bdafaa2038c2dc	1	1	\N	[]	f	2017-02-17 14:15:51	2017-02-17 14:15:51	2017-03-04 14:15:51
97639de41d722167c062bdadfb97b3d40aa6fc0f1841265a9d8e6411d6625a280724d8a186be4f32	1	1	\N	[]	f	2017-02-17 14:19:37	2017-02-17 14:19:37	2017-03-04 14:19:37
c6c31689156b76e179eeda1347003cf2849e7b6907a3aaec9b7e0c176ccbde71f8ed15ef816094f6	1	1	\N	[]	f	2017-02-17 14:19:47	2017-02-17 14:19:47	2017-03-04 14:19:47
2cd6d374c4f10655956a18162fd7c170013bd59253c3ae117a73bb1b6693e43471f009b5a261a486	1	1	\N	[]	f	2017-02-17 14:20:19	2017-02-17 14:20:19	2017-03-04 14:20:19
28d8d04ab7c4ada133aed97e4be5815271f4df3180a97dbe819c5dd230295293cf1fe94378ca9990	1	1	\N	[]	f	2017-02-17 14:20:48	2017-02-17 14:20:48	2017-03-04 14:20:48
769e3269afb7d995360461b2a12935da945b8f2f58e629f919ef483b98ef0d8007178cde193bcbe7	1	1	\N	[]	f	2017-02-17 14:24:06	2017-02-17 14:24:06	2017-03-04 14:24:06
fa15d53e5aefabebb861afce636c8ff23e518fd703663457dfd9dd91c1e4bba96ebf0de8c9e31857	1	1	\N	[]	f	2017-02-17 14:24:08	2017-02-17 14:24:08	2017-03-04 14:24:08
69426b0b44b23e7a565973735a74aa01918fec3b8ec1c54fc52e0039e4da6d5428de8d9750c79e39	1	1	\N	[]	f	2017-02-17 14:24:50	2017-02-17 14:24:50	2017-03-04 14:24:50
539053ae65ede94a848e2e86e0e5f509a18dc7ba27cf9ec10fd57f8bbbaee9aba5fe7ebbc7c36914	1	1	\N	[]	f	2017-02-17 14:48:25	2017-02-17 14:48:25	2017-03-04 14:48:25
f76b153edd2984740b97e78407538e33cc91303c928e4e07a974a9d1872e7ae302b2db1569852988	1	1	\N	[]	f	2017-02-17 14:59:28	2017-02-17 14:59:28	2017-03-04 14:59:28
2f8f1984e7a961a203618706efaa0722929815cb7da2b1b29b78aa7229a16f6a82a64337be4ec542	1	1	\N	[]	f	2017-02-17 15:03:41	2017-02-17 15:03:41	2017-03-04 15:03:41
30bc3ac1018138e942d99e1084344000d31082615c5721b6f73fa1ea0b191eb67c340bd25e0801c8	1	1	\N	[]	f	2017-02-17 15:14:34	2017-02-17 15:14:34	2017-03-04 15:14:34
724dd3689f051968201f9c165345a15851f5f08ff1d176fec53b7f29cdd173a58f3b7fede26dc320	1	1	\N	[]	f	2017-02-17 15:28:51	2017-02-17 15:28:51	2017-03-04 15:28:51
61eb2f59fb156448f6ae285dd9ebb141d08405516c95aa6fef030df12fe7f5391fc32c15f7b3e7f8	1	1	\N	[]	f	2017-02-17 15:29:41	2017-02-17 15:29:41	2017-03-04 15:29:41
b38f5cf9b71e959b84ee94a8a31e96f4f6ca5129f4bd5b4af0efe0f1b6ce71dbf99cec1a3bc30315	1	1	\N	[]	f	2017-02-17 15:37:52	2017-02-17 15:37:52	2017-03-04 15:37:52
3528417bdc013ce0b933946d709b0a0b4d74d749debea561f50a35842a25b5cada4b322bd4fc7189	1	1	\N	[]	f	2017-02-17 15:48:07	2017-02-17 15:48:07	2017-03-04 15:48:07
8f2dcebc9f0a397c50a4e3b5f15afb0927201cab8bfb6b19104ee7d03bba095e4d30be9dc44bc5e2	1	1	\N	[]	f	2017-02-17 16:18:18	2017-02-17 16:18:18	2017-03-04 16:18:18
63ec15c2fcc62c562777d2ff207ff5ca610fc8466b60adf5949fafdc37216433d49a1cefacfe02ea	1	1	\N	[]	f	2017-02-17 16:23:25	2017-02-17 16:23:25	2017-03-04 16:23:25
5eeb62f037a3c94e4643be9f5f334a41f28c754770a666ba604c9b68ac2b83d098e456a91b051346	1	1	\N	[]	f	2017-02-17 16:34:30	2017-02-17 16:34:30	2017-03-04 16:34:30
21e8d9397603783fb883485c714696212c081ffff5df5f350954ddb67d5bffaa79372808c23dd34e	1	1	\N	[]	f	2017-02-17 16:35:55	2017-02-17 16:35:55	2017-03-04 16:35:55
89d85d8ca51f0cc073569ee992567727c2b7a14ba5d2cf3e4f93613001a37eedd78a55a2347116c1	1	1	\N	[]	f	2017-02-17 16:47:08	2017-02-17 16:47:08	2017-03-04 16:47:08
0a74f96d5f5e1483e951dd58279504da828c4a0f8e375e88d358a4c55cbed768c15e8e28490766eb	1	1	\N	[]	f	2017-02-17 16:47:19	2017-02-17 16:47:19	2017-03-04 16:47:19
4b1d71a7f0b0046f26f3d956d1e999e4ced11ac3a52e8d63e00ef8851a9245b7113e508db891efe1	1	1	\N	[]	f	2017-02-17 16:49:05	2017-02-17 16:49:05	2017-03-04 16:49:05
8d09304a483d0f734d07bdb752f40d63144bf5ca334f242c905daf56b02c57e50036137f9a599951	1	1	\N	[]	f	2017-02-17 16:50:45	2017-02-17 16:50:45	2017-03-04 16:50:45
e19603eb07ac1b4e6cd50f1e0d818d220f4f608c8b6518c5198c704caae9ec5f7d1fba52ef146abd	1	1	\N	[]	f	2017-02-17 16:51:12	2017-02-17 16:51:12	2017-03-04 16:51:12
cded102dd382d196964dc8a4065f6c832a08ab97e63b4c9fdfc6d45edfb8f1fb80bce203e605f0aa	1	1	\N	[]	f	2017-02-17 16:55:26	2017-02-17 16:55:26	2017-03-04 16:55:26
2656c591f65117740444e69cfe8c442f1ad9353875f3d4e5de91697add59b0c915e8c1a3de1ae616	1	1	\N	[]	f	2017-02-17 16:56:55	2017-02-17 16:56:55	2017-03-04 16:56:55
548a13efe8f59c32f2d38b4ac7feaf6636cffbcd2202ab9a5309dc2d50569037ebb6f92981b02ab1	1	1	\N	[]	f	2017-02-17 16:59:05	2017-02-17 16:59:05	2017-03-04 16:59:05
57e1fe34e81bf0d0c92b9b06b3cac48f1d8abaa6310aa573168fece9e0d24a6e93cfa384812c3ce8	1	1	\N	[]	f	2017-02-17 17:11:12	2017-02-17 17:11:12	2017-03-04 17:11:12
3aec56c8aeaea5cd2786857c8d7aabe3de7c209d2bbd87862f98da343f4a88a3707b4a776ecae55e	1	1	\N	[]	f	2017-02-18 05:54:35	2017-02-18 05:54:35	2017-03-05 05:54:35
cd2719a7ea16bdd8f74591e6b22e7ebbdfce7fac2a1a26dc99a709a38e0aa24d2df9a6e464304beb	1	1	\N	[]	f	2017-02-18 05:57:23	2017-02-18 05:57:23	2017-03-05 05:57:23
ed214870c7d3a9fdb5e748a6e42f332a9bb07ff76eb74169df564e6b08a36fde5bf742ac6cdff005	1	1	\N	[]	f	2017-02-18 05:58:19	2017-02-18 05:58:19	2017-03-05 05:58:19
01d152aeb16d2050ab9251e1285562a5638619135c39fa65d515602444fccc21250b1dd2b784d6aa	1	1	\N	[]	f	2017-02-18 05:58:43	2017-02-18 05:58:43	2017-03-05 05:58:43
74cd4af73c878f349a2344ba480c47390de16bab372eaf3e80f402892a968d27b1e22cd71c6f491d	1	1	\N	[]	f	2017-02-19 12:26:52	2017-02-19 12:26:52	2017-03-06 12:26:52
eae41b6eadad2ab2c6b4ba1f059542b4e15e71a615839bc2b5f354cb5e3a9f1afce5c6e8d522f562	1	1	\N	[]	f	2017-02-25 16:25:22	2017-02-25 16:25:22	2017-03-12 16:25:22
41b2e962d7c12f0aea952c598c2ae8a981aa50a674f082136f04c8a7a784c8a828cd78339427919e	1	1	\N	[]	f	2017-03-03 12:43:38	2017-03-03 12:43:38	2017-03-18 12:43:38
81d019e3a3d2d431157e7a5ab26bf3076962b9c031f8f4bc73f5174c45f43ed5754c603dc825c699	1	1	\N	[]	f	2017-03-03 13:10:13	2017-03-03 13:10:13	2017-03-18 13:10:13
b544a35a595760f8d3c2f8134c92fe43dca8c365672f2418f69bee1b882e19ab6f2073b16f195639	1	1	\N	[]	f	2017-03-09 16:40:26	2017-03-09 16:40:26	2017-03-24 16:40:26
714e7cead1ae5dccf539cb9abc6d13b47187ad8dee340d2944a2c97c79056b2fce0bd8cd659a8f9f	1	1	\N	[]	f	2017-03-12 18:21:51	2017-03-12 18:21:51	2017-03-27 18:21:51
9792642d0865d09c6e7d265c85e2fa00111ac28eecdc21d82c2d81511c7182da02ecd055be2aa5d2	1	1	\N	[]	f	2017-03-12 18:28:17	2017-03-12 18:28:17	2017-03-27 18:28:17
193db501b963cc5ba5ad2aa49ba7f91c662486410622e43673184151c7b22750eba5122e570975bb	1	1	\N	[]	f	2017-03-12 20:17:37	2017-03-12 20:17:37	2017-03-27 20:17:37
aec88cfa4b3d2e2199416102d8495128cb7eb818e05bde999ac9786a6311fd1d0624e5724cede362	1	1	\N	[]	f	2017-03-12 20:25:00	2017-03-12 20:25:00	2017-03-27 20:25:00
f9d00f0a13df55f13637b5175d3d278a76e862c7b0be0c3c398efc2b50dc557d4caf91379234008e	1	1	\N	[]	f	2017-03-12 21:41:05	2017-03-12 21:41:05	2017-03-27 21:41:05
e89392a933b43d8d0e7bded0be2488135fc31018b0ed0d40676cc7afbeea0fab60426ce6f2bad68f	1	1	\N	[]	f	2017-03-12 21:43:46	2017-03-12 21:43:46	2017-03-27 21:43:46
0b7783b57a5f485b95d12e4c25b84ddcc2cb503bc0fdf493350d24e830bc8a9738f54521ee6486a8	1	1	\N	[]	f	2017-03-12 21:46:02	2017-03-12 21:46:02	2017-03-27 21:46:02
7ff715acf68a735dbb2c73d5d8ff0cea1c22ab661c82795c7ebc67a8a51b19ec9a922c87de4ad3be	1	1	\N	[]	f	2017-03-12 21:57:51	2017-03-12 21:57:51	2017-03-27 21:57:51
62caff89807e20db4fc327513e128311a863fabd8e09c6ce6a49b17ed1e52205b9d98a6ee4851528	1	1	\N	[]	f	2017-03-12 21:59:16	2017-03-12 21:59:16	2017-03-27 21:59:16
f530bfe771fdca9bc28d093125fff6d81cca27e700db92c99972876a05349dd3ba413d73c89838a3	1	1	\N	[]	f	2017-03-12 22:05:52	2017-03-12 22:05:52	2017-03-27 22:05:52
c4bc9dfa983e9e449f2e1230cf07bcb4d656c39ed5f80ca34fc55471ed32f60242b91fb00c326e94	1	1	\N	[]	f	2017-03-12 22:06:04	2017-03-12 22:06:04	2017-03-27 22:06:04
54333fb7b57cc2bd8b15bea969f67ba5610d261e8fefedab0ef61ffccd52577bd42eff0b87663003	1	1	\N	[]	f	2017-03-12 22:07:56	2017-03-12 22:07:56	2017-03-27 22:07:56
a6d7c8d46f6b165cab74536f2c226d8a5574a65ad43940565114b6473fb3d5408025e8cd3be2db82	1	1	\N	[]	f	2017-03-12 22:12:23	2017-03-12 22:12:23	2017-03-27 22:12:23
b0ca9df9bdc02e9005a177f8cdd36d031edd64a4ad5f84bda3414285161dd5e2fd7ec545e3dd6513	1	1	\N	[]	f	2017-03-13 14:08:03	2017-03-13 14:08:03	2017-03-28 14:08:03
59a1fccd2cbcecd6c94877a1bb3895610420d4e45f73ce4f809aed1809d3990c31d40c28fc2b0c91	1	1	\N	[]	f	2017-03-13 15:07:43	2017-03-13 15:07:43	2017-03-28 15:07:43
fd776b88e2b66a5117a487f8346201f26eb50291ba99e823c17e3269d48c53e20d7925fe0862f868	1	1	\N	[]	f	2017-03-13 15:10:22	2017-03-13 15:10:22	2017-03-28 15:10:22
3b7f6352dca3850afbaa8d411a3807ae7e6dd4e92ce25d319a148dbbe25c6a19816758fff7dec193	1	1	\N	[]	f	2017-03-13 15:51:16	2017-03-13 15:51:16	2017-03-28 15:51:16
6299f02e3bef9a02f2fdfb7a535072190e1b3d62832a8722fcc0f8cae567d764b3bf4d97e12d7a30	1	1	\N	[]	f	2017-03-13 15:54:46	2017-03-13 15:54:46	2017-03-28 15:54:46
60ba5156c5f54e5702f51c2ed16dbcc092bf53beae569ed64eebeb0a6058943bfdfeac2b7c407af1	1	1	\N	[]	f	2017-03-14 06:14:01	2017-03-14 06:14:01	2017-03-29 06:14:01
73d3b3d7444ddd54f6125a02e0b1369baab8f422de6970aab08f78daecef714dfa1c54f3dd5b1bcd	1	1	\N	[]	f	2017-03-14 06:14:10	2017-03-14 06:14:10	2017-03-29 06:14:10
abc5cbac390b1cf3d62c17435eb776bb48379c69e760af8ab26073fd0b8c10332280d34be432f855	1	1	\N	[]	f	2017-03-14 07:51:07	2017-03-14 07:51:07	2017-03-29 07:51:07
69e93ca147804c7b0790a9bd3f9f5661786b7b42e9c76b7548268dce4aff3010dcb2394da3afbe2a	1	1	\N	[]	f	2017-03-14 12:45:05	2017-03-14 12:45:05	2017-03-29 12:45:05
14d45fbcb306ec1efdc034b02a1ef954c5ed8e5f75a6fe7c8960a07b4e97c3083fcb132f457fe3dc	1	1	\N	["*"]	f	2017-03-14 12:47:20	2017-03-14 12:47:20	2017-03-29 12:47:20
0eb3d5883c0d665304b2bf2df167f44a96ba53f153e8072a0ec011c6f8ad37da2c2874a14271a370	1	1	\N	[]	f	2017-03-14 14:49:36	2017-03-14 14:49:36	2017-03-29 14:49:36
9eaee651c917cf80a85ad3de4f76843f3d49a2a95d7a6af6980282df004f68b4c7790bb24b30c69b	1	1	\N	[]	f	2017-03-14 15:42:42	2017-03-14 15:42:42	2017-03-29 15:42:42
20ff9d1b745b792df6d5f762faa44b223bcae861956012be35ee37dda28e92bb51f01741bf9e942e	1	1	\N	[]	f	2017-03-14 15:45:14	2017-03-14 15:45:14	2017-03-29 15:45:14
07d504757d7cd5710a6c0e526890cab789b301f1f832d62f30c1d7797e98e66f0ca87a25d104986d	1	1	\N	[]	f	2017-03-14 16:13:19	2017-03-14 16:13:19	2017-03-29 16:13:19
07d5815dc66256479cb6155979e5d50a2ca9c4cb46dfe34865e7d40c9325d11171fa56090abdf7b6	1	1	\N	[]	f	2017-03-14 16:27:24	2017-03-14 16:27:24	2017-03-29 16:27:24
8d06dbc142e10d0fab899b3f3e14b28dbdfc472991c04952c8794f3e399b4b32d65c406796e0534e	1	1	\N	[]	f	2017-03-15 14:58:48	2017-03-15 14:58:48	2017-03-30 14:58:48
b8d9d825807f7a514c0bb03ed875bea6af11f7754db3f8410d02059b0f5c07cfaf7e7518320bb63e	59	4	Punchcard Impersonate	[]	f	2017-03-15 15:26:04	2017-03-15 15:26:04	2027-03-15 15:26:04
bf4696ae21bc3987bb49479bfcda4017a11c2d2a14a19fbe787082975e1bb4367f64e963c78808a2	1	1	\N	[]	f	2017-03-15 15:26:22	2017-03-15 15:26:22	2017-03-30 15:26:22
c21fb70bda51bebb73afa92d75fcc310a5dc3db8fac9cdb1f85e22a79aa83940b8b8bb1196b67609	1	1	\N	[]	f	2017-03-15 15:42:51	2017-03-15 15:42:51	2017-03-30 15:42:51
aa1915f1bd4d044541007566f9cdaecd25e7b8167f10a13f413b47618696b0f6fa678dfc7b2f327f	11	1	\N	[]	f	2017-03-15 16:37:17	2017-03-15 16:37:17	2017-03-30 16:37:17
e7b45679c30cc60f05e8fd8f87980716a234659b1ec35983ef903709b892664981cb1effac50088e	12	1	\N	[]	f	2017-03-15 16:48:44	2017-03-15 16:48:44	2017-03-30 16:48:44
6943dfca75ee0397b27a92575241a8987a17035b0f24bbb5a0f25025d6610a42b7bd4939b40c9ecb	42	1	\N	[]	f	2017-03-15 17:43:30	2017-03-15 17:43:30	2017-03-30 17:43:30
e8246cf98ebfb37668435ca20a25b95388d881702d616dd9f861ce1c4a83039bcc68003e2e60ca19	12	1	\N	[]	f	2017-03-15 17:43:50	2017-03-15 17:43:50	2017-03-30 17:43:50
5487c63c9309719cfb95795b7d0784257f6bad47a462b8135ee6ed25265862c7ffbbdbb4f8f4518c	42	1	\N	[]	f	2017-03-15 17:44:12	2017-03-15 17:44:12	2017-03-30 17:44:12
57f266e183a2c70b2f0bfd467bae709bf78da9cc412a3a717b5e27a36dc1f5b93def0963df17a297	43	1	\N	[]	f	2017-03-15 17:44:27	2017-03-15 17:44:27	2017-03-30 17:44:27
a938ba13567a7ca4c4e3f36b6833e5b2b90c954d1b298d98d8c505da6d2508ec80cb88762ad7aaec	42	1	\N	[]	f	2017-03-15 19:28:10	2017-03-15 19:28:10	2017-03-30 19:28:10
23b10dddfc1c7dec36b2ce76b954376744f10c7bdd5a944a83bf67e26d1f0caace1deebf680ba4b6	1	1	\N	[]	f	2017-03-16 06:07:45	2017-03-16 06:07:45	2017-03-31 06:07:45
783be7ee6856d11e163b485787fbc8d8c649ca85835531c2a7296d8f429e56d31f5d9e277432b0ee	1	1	\N	[]	f	2017-03-16 06:36:04	2017-03-16 06:36:04	2017-03-31 06:36:04
720ee83b010a4427138267669e1b8f4a0b04f89e0051e916b5ef06f61c41f9c23f00980dd96a8060	1	1	\N	[]	f	2017-03-16 06:54:09	2017-03-16 06:54:09	2017-03-31 06:54:09
29295cc3f2c8cdb530c7959d364347a8d866fba98f91fc953f2492a1725093637c646cc430ecf313	1	1	\N	[]	f	2017-03-16 10:38:59	2017-03-16 10:38:59	2017-03-31 10:38:59
26d0e74f35e530bfc61a5c9de26edd26c8b8ff4defebd36e5f9ebd875b8506636e719589184873fa	1	1	\N	[]	f	2017-03-16 15:16:07	2017-03-16 15:16:07	2017-03-31 15:16:07
494721688b14cc47a4923d3786e5e94a7d0a8e8bd145b7adc93b0ec95272fe334c3fac469dd368b1	1	1	\N	[]	f	2017-03-16 19:52:03	2017-03-16 19:52:03	2017-03-31 19:52:03
ab34e243f7e496de2ea3589d428cb1679590521f2e5d384ea9527699bd23fea2766543ed3be41c61	1	1	\N	[]	f	2017-03-20 07:43:21	2017-03-20 07:43:21	2017-04-04 07:43:21
dfddf51baba1f0eaed28a0ddc3812abcee1b800f41822479c01c62517011a24439e8448d8b34bcf6	1	1	\N	[]	f	2017-03-20 10:28:14	2017-03-20 10:28:14	2017-04-04 10:28:14
9a317cd940ed2a99568a2e64529a0bdc202976896e7acc20bf214214d51e8c5f55c11385a9a4a110	1	1	\N	[]	f	2017-03-20 11:17:51	2017-03-20 11:17:51	2017-04-04 11:17:51
f009f0bec7dd1259df581a36c52a384130b3a6cd199aa9b6225097c8d66da52eb6c947ce8ce7e3e3	1	1	\N	[]	f	2017-03-20 11:25:23	2017-03-20 11:25:23	2017-04-04 11:25:23
509ecd93130c26181572e5d5a96220d477b952295fbc2c6c5f20a5d2a39ea4b1d97b81698c36cd21	1	1	\N	[]	f	2017-03-20 11:37:31	2017-03-20 11:37:31	2017-04-04 11:37:31
a1208094b360fa97a623bb203b5576b26cfcf2f79067e1cf35218cfc5cc7a69e806af14af3dc7ab5	1	1	\N	["*"]	f	2017-03-20 14:49:23	2017-03-20 14:49:23	2017-04-04 14:49:23
02777fb91836c8566502fbcb52dfc979eea5971ab1215cc9a6d63b662bf6feba2224d93497940820	1	1	\N	["*"]	f	2017-03-20 14:56:38	2017-03-20 14:56:38	2017-04-04 14:56:38
d7d48425f129cb4dbfb75edd3fda4ee140aca23b60c4875925c0820ad5e377eebe0351e089240061	1	1	\N	[]	f	2017-03-20 16:08:17	2017-03-20 16:08:17	2017-04-04 16:08:17
83cf7939627b25dbd13f44eb1e9cadc7649da57d5da386783dba005432fba8a2260ac49573296eaa	1	1	\N	[]	f	2017-03-21 08:00:14	2017-03-21 08:00:14	2017-04-05 08:00:14
6454ad65b676eb467322a0c658e8b242826691901babcfca57df0d7e9a6d644d9d7adf114977626f	1	1	\N	[]	f	2017-03-21 08:14:43	2017-03-21 08:14:43	2017-04-05 08:14:43
d04c150c699acf878e7cbaec60cd2e4951e5a1c5d89d2875f353836f07833e108da1cd02e3fbe670	64	1	\N	[]	f	2017-03-21 08:18:37	2017-03-21 08:18:37	2017-04-05 08:18:37
b66af112033aec960bdf514545afac8b1818501a673e41e9d2aca8bec5be6611d373ff7ea1f2ff5e	64	1	\N	[]	f	2017-03-21 08:19:19	2017-03-21 08:19:19	2017-04-05 08:19:19
28df11216da1f82b2a5194af75f76de15bab43de03116a98de57ccd7e4ce5788d688d2b5c08d3320	46	1	\N	[]	f	2017-03-21 08:21:19	2017-03-21 08:21:19	2017-04-05 08:21:19
7ea8302b6d64a762788f465aaacbb782d6926005492b102796123485eff47e5beb95d20d02a0f806	64	1	\N	[]	f	2017-03-21 08:22:45	2017-03-21 08:22:45	2017-04-05 08:22:45
b1f5caa20eaa5bfef506a0423e31031fc2ac939032371a7575aa6693c9ee7479c977b8f34de2d207	46	1	\N	[]	f	2017-03-21 08:23:01	2017-03-21 08:23:01	2017-04-05 08:23:01
c3c937d572d7f65253d561b8ba2a237838f0d5e6fd5745a7b3523270922e91b5ce04be9d32302b9c	1	1	\N	[]	f	2017-03-21 08:25:06	2017-03-21 08:25:06	2017-04-05 08:25:06
6f66c9201b1dbe66d0f566412b45511bfaf325bb164449e921568ee0a390e12a91a8b229b6058eef	1	1	\N	[]	f	2017-03-21 11:01:43	2017-03-21 11:01:43	2017-04-05 11:01:43
12491324d26543f362395bb9ce025bc892827642c36e5a6735fa4fbdbbbe72e1a36973bd858e64e6	1	1	\N	[]	f	2017-03-21 12:07:02	2017-03-21 12:07:02	2017-04-05 12:07:02
1b55aacdc5a6b0df33b59f2bb0140e2f1a513c8e2863ad3ebbf9e8409a0dc2d8a6fbd7eae9f7ef4f	1	1	\N	[]	f	2017-03-21 12:18:24	2017-03-21 12:18:24	2017-04-05 12:18:24
27b3512530842c7c592b494b985f9c18b3a77c0f8ce23616f5e8cea019143ff9ebff8b3cdea47589	1	1	\N	[]	f	2017-03-21 12:23:16	2017-03-21 12:23:16	2017-04-05 12:23:16
1eb20eb7e35191263dde7b8e304cf2fb6cfac069c0214725126c8d8e4a47027596dbf0b0977f0a84	43	1	\N	["*"]	f	2017-03-21 18:27:36	2017-03-21 18:27:36	2017-04-05 18:27:36
6e377c3f4d78e18ef3efb8a43daf6eae85584f845b9dd7407cf3e9c186e0722cc80e8e90312b9396	64	1	\N	[]	f	2017-03-21 18:43:30	2017-03-21 18:43:30	2017-04-05 18:43:30
aca1e88030bb3cf073f84992b501041e9f30a7a89f1d1e3ce87f513a3679273c5b4e156bbdc347bc	1	1	\N	["*"]	f	2017-03-22 06:09:33	2017-03-22 06:09:33	2017-04-06 06:09:33
e4d7dcf9f85238e30fb5c0d105d38e858c28fa206b943eba23040ec42a7840b816e66435e0143b4f	1	1	\N	[]	f	2017-03-27 06:10:02	2017-03-27 06:10:02	2017-04-11 06:10:02
d05a4f201d61314f2caa338afe254b3c6c1b3f2786bbcc45ab0c789b7edf640ae34aea31f1416363	73	4	Punchcard Impersonate	[]	f	2017-03-27 06:43:57	2017-03-27 06:43:57	2027-03-27 06:43:57
b1201aa46f36ad663a29f549d373aa3cc979ad76b5178d635ebb0666d37e1ad83b656a7e41fce88b	1	1	\N	[]	f	2017-03-27 06:44:24	2017-03-27 06:44:24	2017-04-11 06:44:24
a3167df9937c420c8f8929d5cb678480b77a8033bb34aa0714b712796c460149cfd163fae22ae35f	74	1	\N	[]	f	2017-03-28 06:10:33	2017-03-28 06:10:33	2017-04-12 06:10:33
82b5c4d252a9a5b90ecabd46b27ff59829fb3ced8315ab3d4025a8a3ec24e9b1606bdd1086e51fe0	1	1	\N	[]	f	2017-03-28 08:21:06	2017-03-28 08:21:06	2017-04-12 08:21:06
216fc92b0305bc479c3bc3590627343eb6f950d4abc43953648ae065b8fd4da87fb5d99e064fe0d2	1	1	\N	[]	f	2017-04-12 07:36:03	2017-04-12 07:36:03	2017-04-27 07:36:03
a3998f568830a4156ce85ba2e2be8ae9507a66dd64053389ff5607eb9f7e9ef1b798de96c15c7b52	1	1	\N	[]	f	2017-04-12 10:20:45	2017-04-12 10:20:45	2017-04-27 10:20:45
946d0200f51c370312210023a9adb9099a9aeedbb990c0f3546168f33ed15c9567b05d58c4124bdd	1	1	\N	[]	f	2017-04-14 10:11:22	2017-04-14 10:11:22	2017-04-29 10:11:22
5669d06f4dbbc056fa7f2dbc089c9bf48bbe00d22391bdc94a040c189a12bc9a263ab5a1d6995116	1	1	\N	[]	f	2017-04-14 10:27:40	2017-04-14 10:27:40	2017-04-29 10:27:40
6e1bf47de66622d3e3d1d3b37bc31b7bf6715d13de3c299523de408cbb563e320d382672daf9c8b9	1	1	\N	[]	f	2017-04-14 11:25:38	2017-04-14 11:25:38	2017-04-29 11:25:38
2c8340c5e70e3533c7468dfbe23c478fd57f025fea2ab27d60c1b7f55d0f2040729f554127d46d69	74	1	\N	[]	f	2017-04-14 12:00:45	2017-04-14 12:00:45	2017-04-29 12:00:45
3e37a09864bcd0dd9ae0d215c9cc16ea851357384689f55d95e7559d054a934dae550c768f415956	1	1	\N	[]	f	2017-04-14 12:55:03	2017-04-14 12:55:03	2017-04-29 12:55:03
86754a498037200c227ebc6d889822775e12b5f473298748018af9791dd2c1b9496be98d160b4928	64	1	\N	[]	f	2017-04-17 18:55:33	2017-04-17 18:55:33	2017-05-02 18:55:33
72a392705d19a64da36c4afba6e1cc4d9355368ea86cedfa575b1fd85c685a3550f94f5ebfe4f091	1	1	\N	[]	f	2017-04-18 16:16:32	2017-04-18 16:16:32	2017-05-03 16:16:32
a3ee1c21d0f97000dfb6231db730ee0b4fcd9e332e05c24f5302c087c8e8cafe05de7698a8b380ed	1	1	\N	[]	f	2017-04-19 07:15:22	2017-04-19 07:15:22	2017-05-04 07:15:22
653e64a65cbc15a46c0431529998d790e3f2b79b4f402e0069a8dc9265dd0c844ba4a90adac755b6	1	1	\N	[]	f	2017-04-19 10:02:03	2017-04-19 10:02:03	2017-05-04 10:02:03
f8298f0f0c387b1690c8ed07a02eddfd4b69fb17e2b1e77124bd0841a65ffd5e8ce36f0d8801a04d	1	1	\N	[]	f	2017-04-20 08:01:23	2017-04-20 08:01:23	2017-05-05 08:01:23
cc95ae0e321529bf565ecb0bbf80de3442cabf54576eb4bdc6275139e84e548f532f66b576801c0d	1	1	\N	["*"]	f	2017-04-25 11:31:22	2017-04-25 11:31:22	2017-05-10 11:31:22
e72efe2354b89a61f9b6e05f799f2454deaf9681a12d6cbfb46b87e6b6300479cb94cfdd8a6764ab	1	1	\N	[]	f	2017-04-25 12:09:04	2017-04-25 12:09:04	2017-05-10 12:09:04
3baa04e260e0a5d968bae045f70d4c511aba3eb9909eed538f34c724cc1ffec05a29416c97f2a152	1	1	\N	["*"]	f	2017-04-25 12:23:01	2017-04-25 12:23:01	2017-05-10 12:23:01
203d7ec3d8fa2e3c8a57039b7bf3cf0ab49032560932e624bb4710efa855105d1700a39e000921c5	1	1	\N	["*"]	f	2017-04-25 12:23:40	2017-04-25 12:23:40	2017-05-10 12:23:40
af544835ac4c62eb75fa58f3d86558b963dd9b1c668a20741bb041b946f4f044f609ec0e0ca5ba42	1	1	\N	[]	f	2017-04-26 07:05:39	2017-04-26 07:05:39	2017-05-11 07:05:39
0dd4de16e156a4ac43e8a4dac51b283bbba18cdae36bd158aa710334e3cf878d2a85386588f9562f	1	1	\N	["*"]	f	2017-04-26 07:08:54	2017-04-26 07:08:54	2017-05-11 07:08:54
ce94dee55872cf3eea6b8dd9958e558c22ec31c1f37cf239d83c76360a03421b46338807a9dd4818	1	1	\N	[]	f	2017-04-26 11:06:59	2017-04-26 11:06:59	2017-05-11 11:06:59
026e56b2faf132584ffa89b8370e97b28128e66e63e251888446d91b83134be8447d9b3d692197b6	46	1	\N	[]	f	2017-04-27 18:21:00	2017-04-27 18:21:00	2017-05-12 18:21:00
302b5d9b409a3014600551f37e86485c2e2f4a4ed6f1992465c5340cf5e9247587619afafb72c984	46	1	\N	[]	f	2017-04-27 18:21:54	2017-04-27 18:21:54	2017-05-12 18:21:54
ce3b7f3863da4fb267346df702a1cfc321b39485bb0fa3a715c4e5c28198ca49cc6d83fd02c4ffbf	64	1	\N	[]	f	2017-04-27 18:23:05	2017-04-27 18:23:05	2017-05-12 18:23:05
1b61dafc1e79aea95ca1efde18193c194f82a462afd91b8faecd6ea9fef227a6d66f78ab0e47ac65	1	1	\N	[]	f	2017-04-27 18:23:41	2017-04-27 18:23:41	2017-05-12 18:23:41
47f16e57cc20db19c7b4c13ffb101ee93eff08bc4efd5bdd068dbc0d0efe2c1e4572af64c7934c58	64	1	\N	["*"]	f	2017-04-27 18:23:56	2017-04-27 18:23:56	2017-05-12 18:23:56
63c07eccd8da56fcce393a467e1dc41d07b6c9a0519cfacb2a4d8ea510397ca3d74929dbfad72af4	1	1	\N	["*"]	f	2017-04-27 18:36:03	2017-04-27 18:36:03	2017-05-12 18:36:03
ffdb495140ae896b9cbf41188db4b01c405e676b2b23f3ada8cb88bf8275143c4748c6a147be4640	72	4	Punchcard Impersonate	[]	f	2017-04-27 18:38:35	2017-04-27 18:38:35	2027-04-27 18:38:35
11eb7156d5fb73352d18e6ce328156816f39340c33dc17fce5ff57b813eb78c24d83fd94a9c0a0d8	1	1	\N	[]	f	2017-04-27 18:39:10	2017-04-27 18:39:10	2017-05-12 18:39:10
45ade95af0cf3d33a61234db2b1eb2930389819f6d537164533d83ca586a72bbb3028eeba419d19e	1	1	\N	["*"]	f	2017-04-27 20:56:15	2017-04-27 20:56:15	2017-05-12 20:56:15
40feb106522b08232f2f24bc39e2ee9dca4c63299245a2683e0a2b2b60746ad39b52c97916eaf16d	1	1	\N	[]	f	2017-04-28 06:44:29	2017-04-28 06:44:29	2017-05-13 06:44:29
c3bea3b3e092c878144de6fa3f3de2b652986414ab2fa4daf0303d8069087342d62efb9c644698fc	1	1	\N	[]	f	2017-04-28 07:34:44	2017-04-28 07:34:44	2017-05-13 07:34:44
266653050e8fa6a491f2e282872802f768f6a1606189e30d52d5a9aa9f25b8f11cd19b4f6e3bbb27	64	1	\N	["*"]	f	2017-05-03 13:07:21	2017-05-03 13:07:21	2017-05-18 13:07:21
b5a3f6e84f11e9c778608a08eaaa9c7437d4d0d141ef47fd95c774c60830b835ea46c280fcb4565d	46	1	\N	["*"]	f	2017-05-03 13:08:23	2017-05-03 13:08:23	2017-05-18 13:08:23
2d2ed8ad975d2fe8a16ad6a909b22aba0e6c47ceb5a71f01113aefdda6e2448257fd7d9fb0903a9f	1	1	\N	[]	f	2017-05-03 13:22:01	2017-05-03 13:22:01	2017-05-18 13:22:01
d7b023cb82259a03c2942a62274d244f5bc214287fa07e4c01e507e2444a3ab4f2c4e9e388283706	74	1	\N	[]	f	2017-05-03 13:26:07	2017-05-03 13:26:07	2017-05-18 13:26:07
8d8caa49494db756c26b3962b04593cfa5c3ee80b903708db384df4199fc7d79fd0d336a7e380feb	74	1	\N	["*"]	f	2017-05-03 13:28:07	2017-05-03 13:28:07	2017-05-18 13:28:07
093d6280122d6df940b4ebc6abd574081f7e03dac3c360581869de43f7c954451dd7668f7890adcf	1	1	\N	[]	f	2017-05-03 13:29:07	2017-05-03 13:29:07	2017-05-18 13:29:07
6d7ca368223d036eaf9f12b06f1f44519272b54255299de4fab0cff6dbe7479a0a3d3ef01cf6ca52	74	1	\N	[]	f	2017-05-03 13:29:39	2017-05-03 13:29:39	2017-05-18 13:29:39
d72298d32efbf71f72819f2e5b54f26a0784d7d0c23ae93ccc323ad7d15b84065ebae4c75d8068bf	1	1	\N	["*"]	f	2017-05-03 14:11:21	2017-05-03 14:11:21	2017-05-18 14:11:21
80567692f31462d7554ce4c47569a09694c12c4f076093d5506bf74cbcc2d91f20fe9a8bfbb873e5	74	1	\N	["*"]	f	2017-05-03 19:35:08	2017-05-03 19:35:08	2017-05-18 19:35:08
28dc798f76fa9bd55973f710995dbc6893781dc5843aebfbbd6743c2d31ff26107a85d20f597cdd0	74	1	\N	["*"]	f	2017-05-04 07:48:35	2017-05-04 07:48:35	2017-05-19 07:48:35
953a8427ebee1dedbd9fc3faeb36068b5a367a8fd9fe2f2623fbac5daf3300a7df67afc99f0bc229	74	1	\N	["*"]	f	2017-05-04 11:49:50	2017-05-04 11:49:50	2017-05-19 11:49:50
c010dc0d36b9665242683d7d13e50aa9a18bade877d964ab95c0c8b9427a78180053d83bfbf1ed2a	1	1	\N	[]	f	2017-05-05 13:25:48	2017-05-05 13:25:48	2017-05-20 13:25:48
8d02a1223ffa72a4d198b635b37de293c4de6b34645569b8f3698a715edd97f05060bebe8ac0691b	1	1	\N	[]	f	2017-05-05 14:05:17	2017-05-05 14:05:17	2017-05-20 14:05:17
9082b4e0db13bf65258a1166313151a8fb5eca8b68f3130fdb89286496556ddb69b0775f05faf691	1	1	\N	[]	f	2017-05-06 08:20:37	2017-05-06 08:20:37	2017-05-21 08:20:37
b66492958eb663cbf5b6b2416858cb5c1f98704c852b947e7adc5b47af601e4145d84bac9221820e	1	1	\N	["*"]	f	2017-05-08 19:21:30	2017-05-08 19:21:30	2017-05-23 19:21:30
3fcdc7b0d4d16ac0879097785e0f074a755d950ee5b43fae1c9929acca84077f83254e1637773046	1	1	\N	["*"]	f	2017-05-08 19:56:43	2017-05-08 19:56:43	2017-05-23 19:56:43
680c65a4068bf1f514156d9b91efcd2a80d931c290214ea8b70253ce26a31098fb8f650a70a638e6	1	1	\N	[]	f	2017-05-09 06:44:33	2017-05-09 06:44:33	2017-05-24 06:44:33
279ae3c261ba4e1d077624596f03a6fcf8059310765057300b9c938df1d0f2cfae68aa2ba33bf280	1	1	\N	["*"]	f	2017-05-09 06:45:43	2017-05-09 06:45:43	2017-05-24 06:45:43
9811c3bd6f367f9c449478396ac3c172749400cbc109dfd206fd3dba42023094d4e629d8e0e2ee3b	1	1	\N	[]	f	2017-05-09 07:56:34	2017-05-09 07:56:34	2017-05-24 07:56:34
5d276426248e67bfd73edf829e03fac5c86a7ec51c2ad40d5f749cc119020a49f68caf707bb9f6ea	1	1	\N	["*"]	f	2017-05-09 11:34:04	2017-05-09 11:34:04	2017-05-24 11:34:04
418dfad0dc07d254b3b71acc27a6ec54c8ab8989c4e7f4ae7bc0665c1dc381b4c01fd2823d7aba1a	1	1	\N	[]	f	2017-05-09 15:36:56	2017-05-09 15:36:56	2017-05-24 15:36:56
8054c55dfe9596ccacf61eb2ac0e3a3635f12e7675eaa0d138883dba7ff8a7ebea39a0da13e24352	1	1	\N	["*"]	f	2017-05-12 15:52:09	2017-05-12 15:52:09	2017-05-27 15:52:09
d8498969c99d09be709bb2ced949d70c541537188c8e17a3dcfe6fcce0788670f6871d3e4db497c7	1	1	\N	[]	f	2017-05-18 14:27:16	2017-05-18 14:27:16	2017-06-02 14:27:16
9564e97a1fafe0aaf2b69b9508b1560e282596583de4dea83a1010729a1dd96a29e19b16d408d49a	1	1	\N	[]	f	2017-05-23 06:49:20	2017-05-23 06:49:20	2017-06-07 06:49:19
24bea7f2a9ef752c2f820f9fca2bd71dba19726a68b6a8409ffb0778f463880ced79052760ab5d6b	128	1	\N	[]	f	2017-05-23 06:57:36	2017-05-23 06:57:36	2017-06-07 06:57:36
3ffc541d8f6f1e08e8951c63be0c4a9fbaa4d86a43af2db7bdcd97c8ea0b0be7377ec6e933b29b4c	128	1	\N	["*"]	f	2017-05-23 07:55:06	2017-05-23 07:55:06	2017-06-07 07:55:06
aa21c33d2b3182a31c6d733d3f40f679d0f243197699110e0739752eb8982a04c65986fa269d1e70	128	1	\N	["*"]	f	2017-05-25 07:41:42	2017-05-25 07:41:42	2017-06-09 07:41:42
29fc8ed52ba4d08ffdeee50fb6c839a3e5d55f8cdc92fdae2455fa4c6331e7241a485475127f9b91	1	1	\N	["*"]	f	2017-05-25 18:04:48	2017-05-25 18:04:48	2017-06-09 18:04:48
5c72acf96d23bceb7106734fb347af8239ece309a29e725db1876277ccc85665d5cc5723b894ff9a	128	1	\N	["*"]	f	2017-05-31 14:09:22	2017-05-31 14:09:22	2017-06-15 14:09:22
e10b2a2918a6b1c4ce2c9327aee0afbf99ae64956e1b64ed0fd9393427011b4e7d67120ed3958a1f	1	1	\N	["*"]	f	2017-05-31 14:10:00	2017-05-31 14:10:00	2017-06-15 14:10:00
8a9798b0cf1733a910fb31b5c09f5ea25bc719621a5d7240bc9e0bb8b45cf986321fd556f3fcf1d7	1	1	\N	["*"]	f	2017-06-01 17:05:08	2017-06-01 17:05:08	2017-06-16 17:05:08
ae5930c745f23bcd8e1cab2d2e747eebfc6f0e3cbf1c96c15b42e2cde4d137984e022ae64ed59ea0	1	1	\N	[]	f	2017-06-07 13:56:43	2017-06-07 13:56:43	2017-06-22 13:56:43
3c18ae6578fd63770229c510bffb533f3fba03d2f6d5036c957ccbaae5203f10352921df6d869947	1	1	\N	[]	f	2017-06-09 10:23:29	2017-06-09 10:23:29	2017-06-24 10:23:29
d633ff4ef1d0a30963fd16cfedfd7390fe052230486af01ba465baaf9f7cc5d283bce57888d46ac6	128	1	\N	[]	f	2017-06-09 11:46:26	2017-06-09 11:46:26	2017-06-24 11:46:26
0595822b1617168c3de6683798ccaa408057e1fb1eae89d9806ec030ce542bd1715852c3c4862483	1	1	\N	[]	f	2017-06-12 10:47:40	2017-06-12 10:47:40	2017-06-27 10:47:40
9de6369f7b0569c4ad0ab45e013c977298fc93982887c27b0a649b93a2f06d7f4a5f7323c1346efc	1	1	\N	[]	f	2017-06-14 10:56:44	2017-06-14 10:56:44	2017-06-29 10:56:44
e4d9653da2686d2154d33d4be9ca5b6530e5ff78f2cc0f09d87da41a47f173b767cb0ef1dc225071	1	1	\N	[]	f	2017-06-14 15:45:19	2017-06-14 15:45:19	2017-06-29 15:45:19
29ab08e132dc18f59b143a39699267856476315f0d957aec67636253fc77ff7216ca7a4f687dba9c	1	1	\N	[]	f	2017-06-14 15:47:06	2017-06-14 15:47:06	2017-06-29 15:47:06
62dcbb7920b388017bd422079cb678bc09129180ea0efd5862d7011d70b39c876e29e4115db58e1d	1	1	\N	["*"]	f	2017-06-14 18:04:32	2017-06-14 18:04:32	2017-06-29 18:04:32
e8a02e0565e0fdb25ba8d0f4afd22f758bd2c57de2c3be08662021932060ae9944a53cda7ce9a88a	1	1	\N	[]	f	2017-06-15 07:03:08	2017-06-15 07:03:08	2017-06-30 07:03:08
d95fa851a23621dbe387c1b0d0a52b59bc64a6e4967a38062914c23f34b4f92216bb2e8fabd260e4	1	1	\N	[]	f	2017-06-15 14:00:01	2017-06-15 14:00:01	2017-06-30 14:00:01
a5306a39291571f8d604cb07dadaf56cc54caa171b7027b1d4408481c250f70884f98eb8d444510e	128	1	\N	["*"]	f	2017-06-16 06:42:30	2017-06-16 06:42:30	2017-07-01 06:42:30
b505edbc17bc0e0644e7729240895985a0da3fb5ad744056f5ddd4c4390286e28ebb5abab0ee71c1	128	1	\N	["*"]	f	2017-06-16 06:45:08	2017-06-16 06:45:08	2017-07-01 06:45:08
c325be1d19046128d7ccb306fce8f841eb9421b9fde7abc0bddc0d1b4ffde1e3a049304afe210b3a	128	1	\N	["*"]	f	2017-06-16 07:22:22	2017-06-16 07:22:22	2017-07-01 07:22:22
838dfccba0ec92edc10b042b64f3236f0d10fd2d23bfdcfba27d6d6cb9d491ec48e904be9c82cadc	1	1	\N	[]	f	2017-06-16 08:26:50	2017-06-16 08:26:50	2017-07-01 08:26:50
dde3e3c78deaed2560ace00d3e92a53d62363cfc0ea63f32c039546e4b86f2616e8ac6c44d964875	1	1	\N	["*"]	f	2017-06-16 08:31:05	2017-06-16 08:31:05	2017-07-01 08:31:05
62b98e716bd87b2ae935d5e5b5035c62863e615c9dc91e8ca1bd8ac84e65370c696f808006ebdd7a	2	1	\N	["*"]	f	2017-06-16 08:31:56	2017-06-16 08:31:56	2017-07-01 08:31:56
cc786fd35c9f83d1b9435f5b6299e17cf8cf4663e5586c6be8f86f4a80c545488fd85420fe2db8e4	2	1	\N	["*"]	f	2017-06-16 08:35:41	2017-06-16 08:35:41	2017-07-01 08:35:41
ac3396db36bb53cec33b1edbffba14836420d100aaef73f4cfecce0ab9e2cbcf6f4892822b6ac466	133	1	\N	[]	f	2017-06-16 10:35:03	2017-06-16 10:35:03	2017-07-01 10:35:03
4d6144cbf3aab2ccd0bdc23166fd60f29c6261113023e54e72605efab4974c187395c2ca22b32af6	134	1	\N	[]	f	2017-06-16 11:46:57	2017-06-16 11:46:57	2017-07-01 11:46:57
39c8ad2d5ee6431580de5d4beabdef24f80bb6ef2485121805ca84dbc78fc8013c176fae5a5898b9	133	1	\N	[]	f	2017-06-16 11:52:46	2017-06-16 11:52:46	2017-07-01 11:52:46
39f15f598c81a433a5b7dd883bf5891847a1089ae08bba7ad30d1c207f0bc430f14f7930e038c696	133	1	\N	[]	f	2017-06-16 12:01:56	2017-06-16 12:01:56	2017-07-01 12:01:56
a9857e3f775f65cb041bdcd16cf92299be26c3ae773b0c8fcc5b6c53e5ebe8ed2639537d476251e3	135	1	\N	["*"]	f	2017-06-16 12:08:44	2017-06-16 12:08:44	2017-07-01 12:08:44
28577ec0b4634295e8dc3e458dc4118df489bbeb7f00352b5b1a2c242eb54105a22d860599a50e3a	135	1	\N	[]	f	2017-06-16 12:08:56	2017-06-16 12:08:56	2017-07-01 12:08:56
f2f58b991d0b3cda9ef3b75fe15962edfed7d0d38c689a0df2ef75188cc68470e9375b92931fc8f9	135	1	\N	[]	f	2017-06-16 12:09:01	2017-06-16 12:09:01	2017-07-01 12:09:01
190b85d2feea180c873115d53859e28d14b668530c99d611c9a77e6b2b78d3134b13c4b1bb40576b	135	1	\N	[]	f	2017-06-16 12:09:10	2017-06-16 12:09:10	2017-07-01 12:09:10
c5a9c281f95254d14161a5a90e8aa3c845990e00cf05c3bbf876391593be81fa848aac3280c534bc	135	1	\N	[]	f	2017-06-16 12:09:26	2017-06-16 12:09:26	2017-07-01 12:09:26
d1155d7e846a2c9becbe71502d2b1dc2a67a6bd6b115c893228637390d53b9e266b8da45665a3ee8	1	1	\N	[]	f	2017-06-16 12:12:17	2017-06-16 12:12:17	2017-07-01 12:12:17
c22a92038589d3cb3a6fccce448bc4731d2980bd81c2531a62ce38636e5d6830807121defb7aa2d6	133	1	\N	[]	f	2017-06-16 12:19:36	2017-06-16 12:19:36	2017-07-01 12:19:36
578f629fe8a1b8a8e1f2af9c45c7b81c5f0c529ddf033b311701c712d9c1721dae8d90cbdfc8aa47	133	1	\N	["*"]	f	2017-06-16 12:26:13	2017-06-16 12:26:13	2017-07-01 12:26:13
4cadb33c049d3316a485fbb4af137eaec730f74e26630e740566434caa861234ab1d61485ef813ea	135	1	\N	["*"]	f	2017-06-16 12:29:13	2017-06-16 12:29:13	2017-07-01 12:29:13
ad2336c8eb0a7bb6839156a4fbafa9b81b84dbda1bd11cf557389ca09c75fe776652096a217d856a	135	1	\N	[]	f	2017-06-16 12:33:15	2017-06-16 12:33:15	2017-07-01 12:33:15
f8891097d28ffc018b7c812a2683fa328a024d716dfa6208e72437dbf34ca066981561194e676b02	135	1	\N	[]	f	2017-06-16 12:33:25	2017-06-16 12:33:25	2017-07-01 12:33:25
05d5c8d95adb89f613993b31598bd030470abf013a3aa1c31d0ac8f3143624bfc7bb59610d60fd0b	135	1	\N	[]	f	2017-06-16 12:33:54	2017-06-16 12:33:54	2017-07-01 12:33:54
eccfb8b0a8d91324cbaae4ffc7bb79df03b1dd4ece9dd2c49eb3cd990570c3e6a715822fc92bd36a	135	1	\N	[]	f	2017-06-16 12:34:10	2017-06-16 12:34:10	2017-07-01 12:34:10
b9bcd9dde1902c583516b2a35054908efe439455cac395e6625319226bacd351ca7707dba726c0e5	135	1	\N	[]	f	2017-06-16 12:35:57	2017-06-16 12:35:57	2017-07-01 12:35:57
b87a405e8728dcae43b7439e117d447e388e3366f0d5b580e434aa3081e9408b4d1822b3e66bfb34	135	1	\N	[]	f	2017-06-16 12:36:51	2017-06-16 12:36:51	2017-07-01 12:36:51
356904daf694476da33cba7bca09cdb09c95353e50021ca0c64e1460ebf9b90c56235b4c5d51794f	135	1	\N	["*"]	f	2017-06-16 12:37:41	2017-06-16 12:37:41	2017-07-01 12:37:41
bc18cc2234eed641ce65dddeb889c9d9553e469561b16951ee87edb4d663f0be60fae82e9592cb48	133	1	\N	["*"]	f	2017-06-16 12:39:15	2017-06-16 12:39:15	2017-07-01 12:39:15
b8294a03a9415d43655abb27807224255a0bbf639287af8bcb3cc7477e5025488eed032cb1303da7	135	1	\N	[]	f	2017-06-16 12:44:23	2017-06-16 12:44:23	2017-07-01 12:44:23
7f525d09b76f8b5daede302f0bb4c0506d3d2f0590a10dfb5730a4e1771971958b33699ce4f2b15a	133	1	\N	[]	f	2017-06-16 12:49:35	2017-06-16 12:49:35	2017-07-01 12:49:35
b491b78f02c631e10b726d8177fa5e91a62185a80380c16c81d3668cea97d5bb08777b65f71ea2bd	133	1	\N	[]	f	2017-06-16 12:49:35	2017-06-16 12:49:35	2017-07-01 12:49:35
d3a750882133c9d53e1865955b7bbfa4ffb96800c7452327700599d517849a901cc8de41876029c9	135	1	\N	[]	f	2017-06-16 13:42:41	2017-06-16 13:42:41	2017-07-01 13:42:40
9c71a85357994f51db1a30716ac343f37ec774a30b3b401b62d43f061bf14ffead9a9a19f497ef7a	135	1	\N	[]	f	2017-06-16 13:42:57	2017-06-16 13:42:57	2017-07-01 13:42:57
ca0b3648832b1a91f7a0d60559b7e472daebedb7e2e1138d658b0f8ff7d1162a09630051a199e548	135	1	\N	["*"]	f	2017-06-16 13:44:06	2017-06-16 13:44:06	2017-07-01 13:44:06
de9e3340f2e7d10434e1bd38052329015e1bc30b7dbe88afd61e6cd3d28a93574c6bcf7fdd15df02	133	1	\N	[]	f	2017-06-16 13:45:42	2017-06-16 13:45:42	2017-07-01 13:45:42
0dade2d38e1950745abfe5ee641e23c7964792ec9ad49c0141512077257b1d28e3289783802225c2	134	1	\N	[]	f	2017-06-16 13:55:10	2017-06-16 13:55:10	2017-07-01 13:55:10
546013b4aa5e14b4c213c61bd51dc02394b0aae5f92de50ab8618131bb487f4cabc1de1bfc4172ec	2	1	\N	[]	f	2017-06-16 14:13:04	2017-06-16 14:13:04	2017-07-01 14:13:04
18f95c3cdad6a52e579104afe036bf7705857a956e34d12661b6e8cd448d774693b315441b0da26a	2	1	\N	["*"]	f	2017-06-16 14:17:01	2017-06-16 14:17:01	2017-07-01 14:17:01
824157021d5975ecdb05308e7d5deb8970a5e897ab7b50235d0daa2dd76e45cff51c8e11e88d2c2b	136	1	\N	[]	f	2017-06-16 20:54:40	2017-06-16 20:54:40	2017-07-01 20:54:40
c0f6713a077a1ab0e11424c82ecf66b853e1f66ae2cba5ef223fbe72d26a6e3b7291882bdd159f99	2	1	\N	["*"]	f	2017-06-17 05:39:32	2017-06-17 05:39:32	2017-07-02 05:39:32
007c07e0b93aed1443e6a8b57f5b0f008f3bcfa3ddf1f3ce05c1c262cb8b7dbecb4a7f38ba29756d	2	1	\N	["*"]	f	2017-06-17 06:44:46	2017-06-17 06:44:46	2017-07-02 06:44:46
98aebb27e99d88eb3667d3f11b9502e299b742818e9aca7cee7fbe72a8ce7e21ca7697358e111ea7	133	1	\N	[]	f	2017-06-17 07:57:10	2017-06-17 07:57:10	2017-07-02 07:57:10
07d40ae484efea841f2024a6d8e956112b533e9f675351fe5c9c093b67f702c8ba3edce9bbfd143d	133	1	\N	[]	f	2017-06-17 07:57:53	2017-06-17 07:57:53	2017-07-02 07:57:53
8e39d093a7f8cfbaeca7fd8878b0f00a4d09e9feb534792078842c322bd128cddfd436b9a1553034	134	1	\N	[]	f	2017-06-17 07:58:42	2017-06-17 07:58:42	2017-07-02 07:58:42
bd678282480524ce4631d4dc9c67fba7fc717a98a842367aaf7ab44a79edb8c56389e5d89d5b1bbd	135	1	\N	[]	f	2017-06-17 07:58:59	2017-06-17 07:58:59	2017-07-02 07:58:59
e6a05fca015edc3a7601dae678df6c46f3778511c3ccf5e6fdbb94faaa3bef8cb75240b2329bbb2f	135	1	\N	[]	f	2017-06-17 07:59:22	2017-06-17 07:59:22	2017-07-02 07:59:22
2fb56d50ace5cb5bf108f1385fa2d50e44643c32f4d734f3c850e6b0715a1a0c8e8dcdcf29a30ebf	133	1	\N	[]	f	2017-06-17 07:59:37	2017-06-17 07:59:37	2017-07-02 07:59:37
7316cb1ccbb5aec72b27e68cf7096968fa7aca65274e64f69e621b91c438b75c42bce5f3969031a9	135	1	\N	["*"]	f	2017-06-17 08:01:24	2017-06-17 08:01:24	2017-07-02 08:01:24
70f7b3b85a56fddb2ee0706eaa1d304bcb9469fe847c3af178a9ef075e0527875373f8c7cc0d7c56	133	1	\N	[]	f	2017-06-17 09:56:52	2017-06-17 09:56:52	2017-07-02 09:56:52
f2e6280fdc715412046531a6f77ab38c789c39f5460a4f349f550d7345ab9087758359809fad57b1	135	1	\N	[]	f	2017-06-17 10:13:18	2017-06-17 10:13:18	2017-07-02 10:13:18
6a3574e00bcd5c540f490e704dff20ae93dac5f02e251d1e6a3368fe89e8f072fafe506ec9ead686	133	1	\N	[]	f	2017-06-17 10:13:35	2017-06-17 10:13:35	2017-07-02 10:13:35
f1efa035a7de0b398f998f4781cafe3b68112f978379c0f2ef48c3e6f9e4e0adbfafc9cb94092063	1	1	\N	[]	f	2017-06-17 10:17:31	2017-06-17 10:17:31	2017-07-02 10:17:31
069cf1a5c77e1e57d9f8faadb11a6479e37ffc648bfc0f57a6915070d9888afa729af6e47044dff0	133	1	\N	[]	f	2017-06-17 12:05:16	2017-06-17 12:05:16	2017-07-02 12:05:16
3bb9ddb996979bf2713328a67fb254affa309741609e3d5e81bc1d50f949eb8a3cf5509d0a27095e	135	1	\N	["*"]	f	2017-06-19 08:22:13	2017-06-19 08:22:13	2017-07-04 08:22:13
4a90b9162ab7d0751b9bb6d8fed74005765fb0d7aa204a56d3bb48ac7b6bf9b7e8e13673576b4e48	135	1	\N	["*"]	f	2017-06-19 08:41:22	2017-06-19 08:41:22	2017-07-04 08:41:22
9ad725e661d4aca0cd090c873c8dcd6abe9752975a72379a418969c619246037300e1b2862d22686	135	1	\N	["*"]	f	2017-06-19 10:00:41	2017-06-19 10:00:41	2017-07-04 10:00:41
47acbfe521bf86a83b77556258bc59d4cd364dfdfe1a625c043adae86e6a9e1141dca8f0ceda6a11	135	1	\N	["*"]	f	2017-06-19 10:44:05	2017-06-19 10:44:05	2017-07-04 10:44:05
e888a046857295562b2c0979965cfc827d83beb72c020214fc4b13b29db05984af95a60bc5748d66	135	1	\N	["*"]	f	2017-06-19 10:52:07	2017-06-19 10:52:07	2017-07-04 10:52:07
96c9bf462f37c630b8c04d5ab727b4311fc8a31d3069527f80936749d0df821f0a5af10832b25e38	135	1	\N	["*"]	f	2017-06-19 13:44:20	2017-06-19 13:44:20	2017-07-04 13:44:20
24ba39304923579bfa9e4ca252e6dcca56b2ab4f91faa3f391d92fb4f3de12208303e5e2172a6357	135	1	\N	["*"]	f	2017-06-19 14:20:16	2017-06-19 14:20:16	2017-07-04 14:20:16
6fc5afffcf6ff48ef63a796f714eb13857141a66cf58fc9ca88938d7fb47ec7fe574e368a85ec7c1	135	1	\N	["*"]	f	2017-06-19 14:34:32	2017-06-19 14:34:32	2017-07-04 14:34:32
fb11e1dbbecadc67b5fd8f2c32d57345abf6a481c9f77a0a8833487e5c34910b88c1b59a75b6ec79	135	1	\N	["*"]	f	2017-06-19 14:43:14	2017-06-19 14:43:14	2017-07-04 14:43:14
054b6426e15ed2abe2d3c5a5dd5b143d5dbecd5136e581afdb00debf3a33fc77188fbeef64ee5837	135	1	\N	["*"]	f	2017-06-19 14:50:55	2017-06-19 14:50:55	2017-07-04 14:50:55
50298f0eb1c7cadfffc9a75b57c83668ece35fb2ddaeb216ea61b6ae5e6351427cd5e1659f8b7786	135	1	\N	["*"]	f	2017-06-19 15:02:56	2017-06-19 15:02:56	2017-07-04 15:02:56
deb173ed254bf4f370e5f2a464bedd67136ff13622a812f136ced5dbf590c0962e6b95e7ec6c37ad	135	1	\N	["*"]	f	2017-06-20 06:12:58	2017-06-20 06:12:58	2017-07-05 06:12:58
9c3af0d41495614805a173fe0379a3daab005d9f095f86490e81608891da2c64f831dd0ffdadaaf2	135	1	\N	["*"]	f	2017-06-20 06:50:44	2017-06-20 06:50:44	2017-07-05 06:50:44
b753ac4484c568f03a89adef7ddd49ea9e4d33e49e9183ce61ef0d07f66ad59bd91eb27d520939f3	135	1	\N	["*"]	f	2017-06-20 07:00:37	2017-06-20 07:00:37	2017-07-05 07:00:37
993b4dfc84a1d11fc9e5f5ff0142ca47efa4bf30e73559a1a95886145660f7ff8e685ef1711bd330	133	1	\N	[]	f	2017-06-20 10:45:31	2017-06-20 10:45:31	2017-07-05 10:45:31
fdff1c0b6fd25da6282117731b8eacf2f1705e8530c44cec9625e9e4a9016719998c03017c01ef45	135	1	\N	["*"]	f	2017-06-20 10:49:04	2017-06-20 10:49:04	2017-07-05 10:49:04
79c4267c82fce6e59084fff00e9ca17171e833dc4e352e19402f4b8733df138be5b10a5e2e1f53ff	135	1	\N	["*"]	f	2017-06-20 11:25:40	2017-06-20 11:25:40	2017-07-05 11:25:40
f7828cbdd1fd150e0753a48273a4c6a33e2bb6d2f15d1488e6636348adbf14142552c1f7623428b0	135	1	\N	["*"]	f	2017-06-21 06:22:15	2017-06-21 06:22:15	2017-07-06 06:22:15
00026176f987202a6af50f3efa2875e978a1790284fb75544bbd08d805fc9068b45d7d89c22c9089	135	1	\N	["*"]	f	2017-06-21 06:58:33	2017-06-21 06:58:33	2017-07-06 06:58:33
f02484dce6cf7e64b455bec634a70ec55e57a03a7fb3faae8635dcb9ff9158eb58beaa76eb6c0f6e	135	1	\N	["*"]	f	2017-06-21 07:29:45	2017-06-21 07:29:45	2017-07-06 07:29:45
1a7b5ff86fd2fedec6282f5325f10361bf5412c147768a4b0b85924fb9ff8b781bda14695775f0c7	135	1	\N	["*"]	f	2017-06-21 07:50:06	2017-06-21 07:50:06	2017-07-06 07:50:06
569f97f26da486c741b58567bc49d3edcd26e0844378c9de6a534cd49db8811a430984e8b59cd931	135	1	\N	["*"]	f	2017-06-21 08:30:12	2017-06-21 08:30:12	2017-07-06 08:30:12
d68a90f8fadd464c5e3960a40ec7ba6f56310c5af8bbc71ab9e5ecff1c5ff90ad1fddd648574a56f	135	1	\N	["*"]	f	2017-06-21 08:54:07	2017-06-21 08:54:07	2017-07-06 08:54:07
2b28f85583e5320aef45ed5e59a7eb02bd4d602a9c4193c0adb5b4ac5693bb8dc4a844de852efeb0	135	1	\N	["*"]	f	2017-06-21 09:41:02	2017-06-21 09:41:02	2017-07-06 09:41:02
2844b71f2cd56f2c354ca756e7897643202cd5fad07aca161723057b7188b1ebbd08cb6295b2295c	135	1	\N	["*"]	f	2017-06-21 10:10:43	2017-06-21 10:10:43	2017-07-06 10:10:43
17e4fe0828afc59ab95694ca8f362fb4a006115235eaae4e013ba4401d4e11e92b897180984c4011	135	1	\N	["*"]	f	2017-06-21 10:20:50	2017-06-21 10:20:50	2017-07-06 10:20:50
180ce942c7ec2857b932f92ce3a9a38227300a4c5a672662f4badc70f0e3f6137d66d5114450a0f1	135	1	\N	["*"]	f	2017-06-21 10:30:16	2017-06-21 10:30:16	2017-07-06 10:30:16
9088e47fc4f8405802aac7cf032bd4e8034a435147e36dbd68cda511662c14785bcfcfd47845ef07	135	1	\N	["*"]	f	2017-06-21 10:43:06	2017-06-21 10:43:06	2017-07-06 10:43:06
0cbe0fe11c9fad6092d70637227282f9693b96b9276dd0764387dd336a8171ccdc5569445a79cb36	135	1	\N	["*"]	f	2017-06-21 10:58:51	2017-06-21 10:58:51	2017-07-06 10:58:51
fdf03943650d14fe5ef42def4fa4e56eaaa5eb175437612e6b84fd22bacafdf6035fb6bba53cc1a5	135	1	\N	["*"]	f	2017-06-21 11:00:20	2017-06-21 11:00:20	2017-07-06 11:00:20
1ccbe5382da27192e90bf8705e9bbfae3727bf6e4ce3dfb76a0078e934fedcf0b96abb5137010932	135	1	\N	["*"]	f	2017-06-21 11:09:37	2017-06-21 11:09:37	2017-07-06 11:09:37
676e7efc45c468e31cbe43081febf3770e2e3aa7c50ca74805bbc9ba95ef6085b310bc096d299db0	135	1	\N	["*"]	f	2017-06-21 11:40:40	2017-06-21 11:40:40	2017-07-06 11:40:40
d1c0a703d902931cea731762a7b7ab5c206616f9ad923aac1dbce36a46b3fefce34541938721b8fd	135	1	\N	["*"]	f	2017-06-21 11:55:59	2017-06-21 11:55:59	2017-07-06 11:55:59
4ec8f9001909c7318c00d435c906c4c32f5d76dd570e9daa56f97f1f3fa51b21e285e067a77d6b7d	135	1	\N	["*"]	f	2017-06-21 12:18:31	2017-06-21 12:18:31	2017-07-06 12:18:31
d003ba2a776034d020417a95736ea4d378d73f53af107c205bcd5d7368b04c5ae32475e5bd71ee38	2	1	\N	["*"]	f	2017-06-22 04:20:35	2017-06-22 04:20:35	2017-07-07 04:20:35
7d033ebee1c05fdee2d37db71b71f74d5348c61d4cafca08425d1a4ff8d23b2a0740c14fb2faf526	2	1	\N	["*"]	f	2017-06-22 04:20:36	2017-06-22 04:20:36	2017-07-07 04:20:36
b1be7f7eeeb931dc83a2239630273f05a10b6bca999bcdc99d13828c051ec75375360df2e4f725b0	2	1	\N	["*"]	f	2017-06-22 04:20:36	2017-06-22 04:20:36	2017-07-07 04:20:36
cae081fd17138e9aa40ac9212a0fb9939366b05da63b462804993e362b95fb942c6fa7a6b06039f2	2	1	\N	["*"]	f	2017-06-22 04:34:59	2017-06-22 04:34:59	2017-07-07 04:34:59
7e781db8fad33788f68c64aef38bccf85b9a02dababbeceba58150863d92aa16695b01b8ba0d45d8	135	1	\N	["*"]	f	2017-06-22 06:28:12	2017-06-22 06:28:12	2017-07-07 06:28:11
2b906c3c02059260c24916ac3d4ce2b5272f851f987393ecb002638d6b79823a5e0bac6f37ff27c5	1	1	\N	[]	f	2017-06-22 07:22:48	2017-06-22 07:22:48	2017-07-07 07:22:48
cab33bf03e7bf424c58f41b5042fc7479ac1871367e7b62dfd031e0742cdf50db3b08ba7c4e34127	138	1	\N	[]	f	2017-06-22 07:50:53	2017-06-22 07:50:53	2017-07-07 07:50:53
6cbe65ca51d0d252d451eaf87c645cd2a9723246bb4eb9c6a6912c684b847743193ce4c290343fe3	1	1	\N	[]	f	2017-06-22 07:59:38	2017-06-22 07:59:38	2017-07-07 07:59:38
410fa5a73738cb3a8b9dedf79b7d26fa25e657908a72f30c0701744323900bb64ad3a968c10dde14	1	1	\N	[]	f	2017-06-22 08:19:22	2017-06-22 08:19:22	2017-07-07 08:19:22
d2282c23aebe5a4b5edf1a3968e0790b3588127cbc8a40963ea9c9a9d48da06bfa6d610c1b9acaa6	1	1	\N	[]	f	2017-06-22 08:32:08	2017-06-22 08:32:08	2017-07-07 08:32:08
a717a1a9832af27997ef4b5183cadb9ce48395d9b2ba623e7f78d3a268fb13dd17ba0e2993f7240a	135	1	\N	["*"]	f	2017-06-22 10:14:25	2017-06-22 10:14:25	2017-07-07 10:14:25
eee1b0bc70f1cdb2c1e790c9bbb5886be019c64c5fc720b90b4c2699d66836b1b3e5d215ab7d27b6	135	1	\N	["*"]	f	2017-06-22 11:25:00	2017-06-22 11:25:00	2017-07-07 11:25:00
18b97ecba9a4b88830c15021ccb7f679b30010c5b9f9df21e52666ba5f98b7cc960d8f4658e259a3	135	1	\N	["*"]	f	2017-06-22 12:03:06	2017-06-22 12:03:06	2017-07-07 12:03:06
a2bc566831df1a6b7e594a1b730d045fddc653de5391b46ac73bb60c5895785d5cd5c4e9890dfad3	135	1	\N	["*"]	f	2017-06-22 12:15:13	2017-06-22 12:15:13	2017-07-07 12:15:13
e47aef20360d3a7af2a3b177f0eafd0caff2260aecd90a27b52b6081556a27eca9a75a9e31df904f	135	1	\N	["*"]	f	2017-06-22 12:30:45	2017-06-22 12:30:45	2017-07-07 12:30:45
1f44cfe3ca5e1112b7b9e775cc8c7fa5c5c3ceccbf4ae344e67b33a4eca5f3145b5d3714f3113e87	1	1	\N	[]	f	2017-06-23 04:28:30	2017-06-23 04:28:30	2017-07-08 04:28:30
01f07c1ead83e8dda20c945ac9cd0b45accdb2c76afb0bb6c80a276c64ec12977e0322a23260fed8	135	1	\N	[]	f	2017-06-27 15:47:40	2017-06-27 15:47:40	2017-07-12 15:47:40
f9d8e9317103cf5a3ea76ec8ead61d3ed47e485df83f5f3a103fba4fed8f379ea6d7cc4068df79b9	135	1	\N	[]	f	2017-06-27 15:48:10	2017-06-27 15:48:10	2017-07-12 15:48:10
d0bb39a7b8836309704acfe85314f0d6889921408a26f7d85476e3d6b1f8e69a7d75a15ce32b00c8	135	1	\N	[]	f	2017-06-27 15:48:42	2017-06-27 15:48:42	2017-07-12 15:48:42
80e437aeea99c5a1df2a6e48acb53258ebaa11ccb1aadcde12ad142b9840287e5f6e33fcaddd09c6	1	1	\N	[]	f	2017-06-27 16:54:28	2017-06-27 16:54:28	2017-07-12 16:54:28
2a2e424db1d782872772f951c64c29072920d626b855669363d402d9f7a9a750d5fdbd527b6f758c	1	1	\N	[]	f	2017-06-27 17:04:53	2017-06-27 17:04:53	2017-07-12 17:04:53
2a23f8a22426a119f7dff94c91d18c3db4ac300fcf1b30857470a03c88811be8d6c329466954d640	1	1	\N	["*"]	f	2017-06-27 22:20:51	2017-06-27 22:20:51	2017-07-12 22:20:51
81264bc4ca49bb7b3f2fb812fcd0a866ee406d9411558b9c84e2970f1b6180a456cbfbe45ec55759	2	1	\N	[]	f	2017-06-28 06:22:25	2017-06-28 06:22:25	2017-07-13 06:22:25
8514d3ad1dbe71946a0b9f8ca80e9b113f7739f6aff5f3314321123ad4c2b8df1197f98beb4900c5	1	1	\N	[]	f	2017-06-28 10:36:32	2017-06-28 10:36:32	2017-07-13 10:36:32
6ba6df96756a97b666d09f8e5d250fb8d50ac9335ffc0493d1d1bbc13b73053f79a2ab5ff66a4ee5	135	1	\N	[]	f	2017-06-28 10:51:19	2017-06-28 10:51:19	2017-07-13 10:51:19
6eb4a062768772baa281ac21174f69bb9143b786195bffb8b87e87bd15ae5dde6eca12136333440c	135	1	\N	[]	f	2017-06-28 10:51:43	2017-06-28 10:51:43	2017-07-13 10:51:43
1ec6d5e4bd9250dc31ccfd4b58acf82465cf691dbfe8134666cb4e78187b16a2b25f6f9bb20d79e6	135	1	\N	[]	f	2017-06-28 11:05:14	2017-06-28 11:05:14	2017-07-13 11:05:14
936d1afe82cb08d6da84322be369a2ead347484be67237ef8f9094412626df487982e938a5162348	1	1	\N	[]	f	2017-06-28 11:45:54	2017-06-28 11:45:54	2017-07-13 11:45:54
06e8d9511365836192b4fa93eda96c94a2a8493720efeb11036e14fe86e34e011bad00ba1e632ead	142	1	\N	[]	f	2017-06-28 11:59:10	2017-06-28 11:59:10	2017-07-13 11:59:10
759c3ca053b457aaee67668a97f15a94359c3f2babb43064533aa0f500a46620e166c9e1d291cae7	144	1	\N	[]	f	2017-06-28 11:59:39	2017-06-28 11:59:39	2017-07-13 11:59:39
1083662b23390e32c40c5447d4337697fb14f5097c36fd8104b80f3a5af2d4c0ebc447872d281b68	143	1	\N	[]	f	2017-06-28 12:03:36	2017-06-28 12:03:36	2017-07-13 12:03:36
5fe01af145daac369ff508b16407a5d23db49d10881b7fad347886dd54659f2a1bc9ba4a5ad8c80e	142	1	\N	[]	f	2017-06-28 12:04:38	2017-06-28 12:04:38	2017-07-13 12:04:38
b4d2bc0923523519270dce044e7e07041ade62f51c71fee4704f5285ffdc3e5e336c7daae2800356	142	1	\N	["*"]	f	2017-06-28 12:07:00	2017-06-28 12:07:00	2017-07-13 12:07:00
07f28f533f8bebc186cb1305adaaeb4033d5b995d224428a1277fbbb2fb5f7cfd5fb6df2e00cac7e	1	1	\N	[]	f	2017-06-28 13:09:37	2017-06-28 13:09:37	2017-07-13 13:09:37
ef4e0be2b5a792a2f98772489d9ce360933f4f9afb563bc54142e5140e5d4c9c11eaa228c4fd2be4	1	1	\N	[]	f	2017-06-28 13:15:58	2017-06-28 13:15:58	2017-07-13 13:15:58
cb2155f7e1e46b62dd585c5488553fb53cd83c80965b8cc1c759dcdb4f08f34394271689a6a2be22	1	1	\N	[]	f	2017-06-28 19:52:54	2017-06-28 19:52:54	2017-07-13 19:52:54
5912413e0e89a687a7eecb37110c4d99a66ac69c3bd9b7aad8f7a1e0a717f39f74f614f7a9008afe	1	1	\N	[]	f	2017-06-29 15:34:18	2017-06-29 15:34:18	2017-07-14 15:34:18
d2fe8812834b8caee1e3643f52a8f40e3f858eb11465147149ae327ac996978fc12b96d831e0ce50	1	1	\N	[]	f	2017-06-29 16:49:56	2017-06-29 16:49:56	2017-07-14 16:49:56
579ddc04cfa9474a7fcaa3155d27406550942dec74f1669e5dfc2a914fb8f3788e37dba632001691	145	4	Punchcard Impersonate	[]	f	2017-06-29 18:45:30	2017-06-29 18:45:30	2027-06-29 18:45:30
1096fb634f1a46af6547f264a2374895413caca7859241c6ddd02527736b3809a0258615a4c1bc60	1	1	\N	[]	f	2017-06-29 18:45:52	2017-06-29 18:45:52	2017-07-14 18:45:52
cdbd11b20330a317d9a6013edea6ba20c776a83512d152c3773dd549e5ba0bb782425b58c6c91a8f	146	1	\N	[]	f	2017-06-29 19:12:37	2017-06-29 19:12:37	2017-07-14 19:12:37
7802d53bfa4d6bcaa8803698edb2f150eaf53af2c3971a9dfd53d7ae38f3957020f19eb8770b201a	1	1	\N	[]	f	2017-06-29 19:25:23	2017-06-29 19:25:23	2017-07-14 19:25:23
0394e79201dd2c9b14101fefa7764e2119f909d6b89171af80c705c17115a57ea924e8151d25a038	147	1	\N	[]	f	2017-06-29 19:28:40	2017-06-29 19:28:40	2017-07-14 19:28:40
59010afaf1b324c20f8b0c9842693f28c9933ac47149fcf16cfb34b30e3947c9c350c2c839193f42	147	1	\N	[]	f	2017-06-29 20:01:24	2017-06-29 20:01:24	2017-07-14 20:01:24
6987831dcc18cd3af2ad9ff2009ed88014277c7c3571365b089461856a99a7b4304e859f7ca268d5	1	1	\N	[]	f	2017-06-30 13:41:35	2017-06-30 13:41:35	2017-07-15 13:41:35
e89032f0d8df1faf2472f490163050387fc7b839adb77a0dd509a756538b74cf36a8101a333b2311	151	1	\N	[]	f	2017-06-30 13:50:02	2017-06-30 13:50:02	2017-07-15 13:50:02
d50dc6bd91f8cd01a3eb903ed0e76124472b350a2c7c7f361a32a2917d4fe8490cf0b07ef7c8cb55	152	1	\N	[]	f	2017-06-30 13:54:22	2017-06-30 13:54:22	2017-07-15 13:54:22
588bb5cc0124c89b8fe1867fa5135b5012d011bd8de64b7b41d883a186744d21910dec15978e1fc7	152	1	\N	[]	f	2017-06-30 13:55:32	2017-06-30 13:55:32	2017-07-15 13:55:32
a397d3c3b2dd71418d5e54622bb7694b210373f04e251e3b9242f9388353fc9438dd460b6e419fe0	146	1	\N	[]	f	2017-06-30 14:13:35	2017-06-30 14:13:35	2017-07-15 14:13:35
68c231cba94ac9fe4e0de3f50243cb0b25dc7851e01b08113b8e08d1caa7957e749181c130e9d659	1	1	\N	[]	f	2017-06-30 18:10:17	2017-06-30 18:10:17	2017-07-15 18:10:17
628053df3735148608a98192f811c773090f989c3ea3c65e5b78b375b8ad58f95f940fa840f2c801	1	1	\N	["*"]	f	2017-06-30 18:16:27	2017-06-30 18:16:27	2017-07-15 18:16:27
8a7034cd15f406e3d322d9e8b3d298ddec113acd8b8c177552dc28ee93d275b06866a2da5b8baba9	157	1	\N	[]	f	2017-06-30 18:41:35	2017-06-30 18:41:35	2017-07-15 18:41:35
fe3205abd2027650f90f9afed827b47306e3373239f9d499d8e87ddd24eb89b6099aabc69f17f8ed	157	1	\N	["*"]	f	2017-06-30 18:45:50	2017-06-30 18:45:50	2017-07-15 18:45:50
c53e85fafa3ec877612835833f517572aa92a057c0039e6291b26e3e88ca32cb9cc7511b7a1e3bee	1	1	\N	[]	f	2017-07-03 06:56:49	2017-07-03 06:56:49	2017-07-18 06:56:49
e43b683d83522df2b829ddff2a86a99fbbeea350ab411897e0cd1e9a002b3c04523100d361cc8ca3	1	1	\N	[]	f	2017-07-03 07:16:01	2017-07-03 07:16:01	2017-07-18 07:16:01
1b8d55af3aeb1b933538046eb3f75f255cc701f524dd1889ff434cdc9ce9b2d4e9da4d3004817dce	158	1	\N	[]	f	2017-07-03 07:21:39	2017-07-03 07:21:39	2017-07-18 07:21:39
e5ba588f0de65ceb778fc3c10fe1c61cfeb044eb3474e72048889529db1212c0d70672881dbe75b6	158	1	\N	[]	f	2017-07-03 07:21:39	2017-07-03 07:21:39	2017-07-18 07:21:39
5f2288f62dfbf1536a6259026803e6d87c1733a253891351fd7fc582c0ab135b99d589b77484b475	159	1	\N	[]	f	2017-07-03 07:32:07	2017-07-03 07:32:07	2017-07-18 07:32:07
861d1cb02eb8e228c4be6aed9e7060867a9be50793bc5885adc73a32532529ca09cc3cf2e9afde66	158	1	\N	[]	f	2017-07-03 07:37:29	2017-07-03 07:37:29	2017-07-18 07:37:29
2e1e0b18c54edac6774e7b65e33f295f70a2340dc581f5274d8065665c5a979f1364c3bcc772e339	158	1	\N	[]	f	2017-07-03 08:14:39	2017-07-03 08:14:39	2017-07-18 08:14:39
fb7b555f2fb4ab780a30778d1d6518b27e31f7038506e9aee8d0fb3e50c08af01738587dae39f976	1	1	\N	[]	f	2017-07-03 13:03:00	2017-07-03 13:03:00	2017-07-18 13:03:00
5d0e19794bcdb2fad9ba8935265ed5ff5904fe7d811ee68bd7898cccd87fc867ab31b2c808c66798	160	1	\N	[]	f	2017-07-03 13:09:39	2017-07-03 13:09:39	2017-07-18 13:09:39
9a9d14de4f3881a6704ee7f0cb2327bc399f5027aabd25410dd858ff2d26eaa7c436b9b2f89de7bc	164	1	\N	[]	f	2017-07-03 13:14:20	2017-07-03 13:14:20	2017-07-18 13:14:20
04c90203c7e36323aa6a20075bcc888609c5a7c0e05bdde29e2756994581b476b74043cc25a92600	164	1	\N	[]	f	2017-07-03 13:14:45	2017-07-03 13:14:45	2017-07-18 13:14:45
54b4a249ee9a0366b241e228e1f178a916235a436f471758e37622c5dd592dc107d9c744b2961def	164	1	\N	[]	f	2017-07-03 13:15:32	2017-07-03 13:15:32	2017-07-18 13:15:32
bea827025cdbf6da3e60a1ec32aa53840c5b16c2cf70ea3d059ab296b7335de4a49b391ae4bd354c	164	1	\N	[]	f	2017-07-03 13:51:10	2017-07-03 13:51:10	2017-07-18 13:51:10
de07d44eea4f844818920ea919687daf189692e5edaa9f83cd21ba8c8ed2774c2f51959beaaae568	1	1	\N	[]	f	2017-07-05 12:43:37	2017-07-05 12:43:37	2017-07-20 12:43:37
f0e6ef5c0190907bd2b152ac6ab3f2b97679c78f6887aead66210639a0156b31ca20bb6919deb014	1	1	\N	[]	f	2017-07-05 17:45:18	2017-07-05 17:45:18	2017-07-20 17:45:18
1a8e0fd44768baca1c99cb20da589a7b25eba8ff6f34298124c2f127529629b887067d7dfefa2886	1	1	\N	[]	f	2017-07-05 17:56:14	2017-07-05 17:56:14	2017-07-20 17:56:14
79777c2cd13436fed22d963d123914bf0a406a958eb513ba1354ea46d063815fcc1a31315e4eebd4	165	1	\N	[]	f	2017-07-05 19:00:08	2017-07-05 19:00:08	2017-07-20 19:00:08
852ef3acf35cf296cde347ae753fa62a2940d9adf87f6824d3333e5a70f4e9bc79198243f675ee32	1	1	\N	[]	f	2017-07-05 19:31:42	2017-07-05 19:31:42	2017-07-20 19:31:42
92c75f029918532db7d314af7d31239b209fa826db34527fdc518bd8d8fe3b4e414311b877f8661f	1	1	\N	[]	f	2017-07-05 19:35:16	2017-07-05 19:35:16	2017-07-20 19:35:16
7eae5991fe79ba720ffeefa13dd315e72bf082164fbdfdadad3febe49ef30b35e62ace994cd61f94	1	1	\N	[]	f	2017-07-05 19:40:47	2017-07-05 19:40:47	2017-07-20 19:40:47
70914c259f1cbc07df3b7ce750c8adaceb20a9727d283dd4a953e68bc1b781f7742adbe56214a688	1	1	\N	[]	f	2017-07-05 19:44:30	2017-07-05 19:44:30	2017-07-20 19:44:30
00a1b7575ec0eda5d7e20eaa062d33c5fd370541227236e667d520ae4a1e67db557e12762d8eb69c	157	1	\N	[]	f	2017-07-05 19:45:11	2017-07-05 19:45:11	2017-07-20 19:45:11
ac1c0d13a8ea1b0ff112bbfa57c537ac685200dc191931d5be2f29e809e3d584b5313b3e845c100b	157	1	\N	[]	f	2017-07-05 19:49:29	2017-07-05 19:49:29	2017-07-20 19:49:29
2245aeb64b49347550301ea3c3f053729e3054048518ff516863c3e522c4a9d9a50f00e5d76bc270	170	1	\N	[]	f	2017-07-05 20:19:10	2017-07-05 20:19:10	2017-07-20 20:19:10
a11be5ffaf0577ccbe82c71e9b9fc8c181740221b24cc6c1e19eda6380ea01bb38dae60e6e02e9be	157	1	\N	[]	f	2017-07-05 20:19:20	2017-07-05 20:19:20	2017-07-20 20:19:20
4967aa5fd3ef902f11707f9bbacf5bdd5410ce0816e22a222c6afa878e839ef164aa5754f785555a	157	1	\N	[]	f	2017-07-05 20:28:30	2017-07-05 20:28:30	2017-07-20 20:28:30
2e3ebf04a162239f4df7315623ab2e775a8c05e747b92270f737c118c8af28ed61d3f32e2d7a54e3	157	1	\N	[]	f	2017-07-05 20:57:04	2017-07-05 20:57:04	2017-07-20 20:57:04
752fb918eccc28d288b949ea5ac757e9e12c0ccde6c3e04a56facb1f29fa9704a8bc22bc23a36ec0	170	1	\N	[]	f	2017-07-05 21:20:12	2017-07-05 21:20:12	2017-07-20 21:20:12
b821e3e5928807cb6b2bfb6ee42f64081c305ee9a10adc3ab18d46531ac75ce6033948e701ea15f7	170	1	\N	["*"]	f	2017-07-05 21:23:20	2017-07-05 21:23:20	2017-07-20 21:23:20
28cd4bd7fbb78d2896c7eb0e9283e22d28d34e822bc3102134eb527f3f65f7bfa8f3839ed1650ded	157	1	\N	[]	f	2017-07-05 21:30:45	2017-07-05 21:30:45	2017-07-20 21:30:45
b65aa734ff100764707bfadfc8561d8a247e62040bcd38230f2ac7813d18bf97e01c2d2f6c2010dc	170	1	\N	[]	f	2017-07-05 21:35:40	2017-07-05 21:35:40	2017-07-20 21:35:40
5e8cf86a4563ee3a8ba8a3d11baddd82a60f0d508b16edbbe66e40013c4d687fc0f7a11ffd384b19	170	1	\N	[]	f	2017-07-05 22:01:43	2017-07-05 22:01:43	2017-07-20 22:01:43
5504e285cf5cf8a54edb276e5f6e240c603bfe5adc5382d4c412115444077cd6cdb8186a58d96945	170	1	\N	[]	f	2017-07-05 22:02:06	2017-07-05 22:02:06	2017-07-20 22:02:06
b71b56c53a35a1d06b7d44f176710dd3188a39f15e761fbc013b9b0ea65cb6a37d6b31355dd0286c	157	1	\N	[]	f	2017-07-05 22:02:42	2017-07-05 22:02:42	2017-07-20 22:02:42
b3b49ecdb395a09c5b68a1ef2477e0efc8dff50d28a747ac8ff70e54dfe741820b3b4571549f9526	1	1	\N	["*"]	f	2017-07-06 04:01:09	2017-07-06 04:01:09	2017-07-21 04:01:09
7eee4275a45e6a244a3ef4f4aac9c893add695bf55d437a5cbd9a32ec2e0dea75cc02d9756248999	1	1	\N	[]	f	2017-07-06 13:08:00	2017-07-06 13:08:00	2017-07-21 13:08:00
af158208a12009231533f231e39f8380e2e772277a1070dd4fbe0c5993baa4ffcef2cc494f6bb22a	160	1	\N	[]	f	2017-07-06 13:08:42	2017-07-06 13:08:42	2017-07-21 13:08:42
dc2eb7a52fce7d1e334c7f75a11e3f28babc6085bc8442acf895e0b14709d5b794be9c58aa68e1d6	164	1	\N	[]	f	2017-07-06 13:46:13	2017-07-06 13:46:13	2017-07-21 13:46:13
35a2a2a1c8b6d9bd9eaf19f2cdb0629bfc5240440d038de702ac24eb1b33c9b636d51861bd2e8c9a	164	1	\N	[]	f	2017-07-06 13:48:37	2017-07-06 13:48:37	2017-07-21 13:48:37
29d0810eb78f19a132030226e25a28919cf552bbbd738037c2a614f17c03179fed83885c705c517c	164	1	\N	[]	f	2017-07-06 13:52:51	2017-07-06 13:52:51	2017-07-21 13:52:51
d64c32a6bca49473a4b733c89a2eeb1d7ef8c8eee649a10a2e2292c37d553e6202ee548c462030c9	160	1	\N	[]	f	2017-07-06 13:55:27	2017-07-06 13:55:27	2017-07-21 13:55:27
df5e887605bae825f3e2348aacf7635a6eb4df3f108ed7bbcddb1f377d80099b86bbeff984caff29	164	1	\N	[]	f	2017-07-06 13:56:14	2017-07-06 13:56:14	2017-07-21 13:56:14
55fc2ca517439deeb559d68d8f46df0144fded361c3810a998034c25db9734abdc6c483a1ddd5567	164	1	\N	[]	f	2017-07-06 13:56:19	2017-07-06 13:56:19	2017-07-21 13:56:19
3a34b2c668929f56cf72c9a25f69342c66f823a9c9e1e43d68d42486b98d11e93c90e46a1b1bb129	164	1	\N	[]	f	2017-07-06 13:56:22	2017-07-06 13:56:22	2017-07-21 13:56:22
32247d1b7be2e01a4c24e9d55b8c7a4210aace5aed4648f8ff2ad15b3fece3d0047e9b16769ad1b1	164	1	\N	[]	f	2017-07-06 13:56:31	2017-07-06 13:56:31	2017-07-21 13:56:31
2f226f85bec199828612ba36fd2e226a5f3ceeafd16e4839daac8213e3461776135557dfca66bef4	165	1	\N	["*"]	f	2017-07-06 14:17:00	2017-07-06 14:17:00	2017-07-21 14:17:00
304b7827778d000d2339034d72644911723865925626f79ac27b5d994eaff13305bb6a33c2fba0a6	1	1	\N	["*"]	f	2017-07-06 14:31:28	2017-07-06 14:31:28	2017-07-21 14:31:28
99d1aeacdc979eb6a1733910c823eedf54f8b9199707f13ba7e5a331a1a217311b746f6e36a851fd	157	1	\N	[]	f	2017-07-06 14:50:52	2017-07-06 14:50:52	2017-07-21 14:50:52
bc05bdf3b3ec44fc2a781075f80f23673e5026a8ce160f3101ba0bc483202049937a0659cd1d1b8c	157	1	\N	[]	f	2017-07-06 15:44:07	2017-07-06 15:44:07	2017-07-21 15:44:07
a06de49efbab77c9c68f5bb55dc87b401b77281a8f08daac34089321ab77eb4548e827fa68047474	170	1	\N	[]	f	2017-07-06 15:49:50	2017-07-06 15:49:50	2017-07-21 15:49:50
1d2f97977263ec8f445ae7924654e2a2de9de2f8aac6b729cba2ee8a23a511952028c479b290e5a6	173	1	\N	[]	f	2017-07-06 15:57:07	2017-07-06 15:57:07	2017-07-21 15:57:07
6d5585d474a1fcfae7e9ba844d93bc16721f504276a2382dfe0d2c5ff12dcfa1d9946f05b6822c83	157	1	\N	[]	f	2017-07-06 15:59:27	2017-07-06 15:59:27	2017-07-21 15:59:27
b58ba962d2b99bed914fc89233d872ed6c311063f2b40f15708110a8a5011acab3fb62b651f36432	1	1	\N	[]	f	2017-07-06 16:22:18	2017-07-06 16:22:18	2017-07-21 16:22:18
8377fda0d2c88e16e14052d8f49d1d3d0cbf8f228cab441c33ff9c723449d96a4d6e5bc21f9d29b5	176	1	\N	["*"]	f	2017-07-06 16:44:39	2017-07-06 16:44:39	2017-07-21 16:44:39
d3a1b0b786de98fc773ce85193da066a3f1ab8535105bdaff9189356fe4553e233c2a903ec2a4c09	174	1	\N	[]	f	2017-07-06 17:50:21	2017-07-06 17:50:21	2017-07-21 17:50:21
fa84462749b021a8965feed5d22537eb1a4dad226aee0a464d29999091429340e819c2cf63efdd24	177	1	\N	[]	f	2017-07-06 17:50:40	2017-07-06 17:50:40	2017-07-21 17:50:40
1f9dc74f0d39d54ffb62286b555cdd74c5532834b65f51e3c5f526a3ab29cfdc0871936ab04e8f51	170	1	\N	[]	f	2017-07-06 17:51:49	2017-07-06 17:51:49	2017-07-21 17:51:49
b62266a13e6f5854095f84410107521ca63e169638bda40c0787db18c9445d92cd3f9595b1f5a0e0	157	1	\N	["*"]	f	2017-07-06 17:57:31	2017-07-06 17:57:31	2017-07-21 17:57:31
c3722936fb92e90dcf2faadf7af83a5f9c7e54f07e134ffc1c85e4d95129f2aee61c933ac4481f7d	176	1	\N	["*"]	f	2017-07-06 18:18:04	2017-07-06 18:18:04	2017-07-21 18:18:04
cca796c31915d06dcc00acd7d3d44f929752b37fb366b22187e965d02bc76b8809a064cf5e0b6b4c	166	1	\N	["*"]	f	2017-07-06 18:58:35	2017-07-06 18:58:35	2017-07-21 18:58:35
b0cdc2d8276ec408b843bcc298a270f5106ae649d551309b39c80719086365c91ea812a343831c76	1	1	\N	[]	f	2017-07-06 19:03:52	2017-07-06 19:03:52	2017-07-21 19:03:52
367f3898cf556244e0f1f1933010e13dc71eb2c6a98cc4875d39c55752918eac36b40c1ee72aba19	166	1	\N	["*"]	f	2017-07-06 19:30:43	2017-07-06 19:30:43	2017-07-21 19:30:43
2e4e342024b33f28d47a5ae930f9a378ff5214bef169f552b45036374ca1071ed2786cd4304b5869	2	1	\N	["*"]	f	2017-07-06 20:15:15	2017-07-06 20:15:15	2017-07-21 20:15:15
2921131e03878f70ab94d1aee89557f7521999d55b2ce3e1303c55bfe8c54bb7a42c93c91eb0a35d	135	1	\N	["*"]	f	2017-07-07 06:14:41	2017-07-07 06:14:41	2017-07-22 06:14:41
877b9520f3792151daef7eaca144e83d1dde0091679e0f2449e7b9006bf2654ca5d98f98d8536351	133	1	\N	[]	f	2017-07-07 06:23:23	2017-07-07 06:23:23	2017-07-22 06:23:23
f9efb57b789397fa47c3decf8784ae05d004ee3b0900448bd7dddcbc8b5b0aa1062069f61809ffce	133	1	\N	["*"]	f	2017-07-07 06:23:42	2017-07-07 06:23:42	2017-07-22 06:23:42
1896a55a7722bfce9a3abb66f6578d25c05be6536dd3a0be8f825f7e70b9ad69862477c1ee34ed28	133	1	\N	["*"]	f	2017-07-07 06:54:03	2017-07-07 06:54:03	2017-07-22 06:54:03
abb419a7457cf507532f2a4067309ded23c71cba8376229195c44b1a2bc3ec735e0339faa6f89a74	133	1	\N	["*"]	f	2017-07-07 07:00:50	2017-07-07 07:00:50	2017-07-22 07:00:50
6e2f54a934e45cab05e8a90c5081a4c28cbc2280802292b2282bd728a95e9557ac4ae18b1821a3a7	133	1	\N	["*"]	f	2017-07-07 07:18:00	2017-07-07 07:18:00	2017-07-22 07:18:00
a6cb050be0a884311535631756a973efc70707ff943747520c13661d73859af79e102ebf246423ad	133	1	\N	["*"]	f	2017-07-07 07:25:46	2017-07-07 07:25:46	2017-07-22 07:25:46
fc7b750d626bc787cd508aad5cff0ac46df268e7e82d5f347be4d0b3c205be8a6ff64a8fa69f650f	133	1	\N	["*"]	f	2017-07-07 10:07:44	2017-07-07 10:07:44	2017-07-22 10:07:44
a2b1ae5bd0543b3db7963a225488c1f9251aec3f6084ab44f101723798062dd65b505fdfb690d131	2	1	\N	["*"]	f	2017-07-07 10:10:38	2017-07-07 10:10:38	2017-07-22 10:10:38
a478dd5d0a5a1a6e04872d2ec4b9f23f77427ab854e39f95f38f69e965a8aaedaf9704b38d3209ec	135	1	\N	["*"]	f	2017-07-07 11:12:34	2017-07-07 11:12:34	2017-07-22 11:12:34
ca0fcf12e993f66d2e6856f5e40f2f42a9c21b5a6d5b6686861b4989290bb9774f88f64de17ee43a	1	1	\N	[]	f	2017-07-08 05:56:42	2017-07-08 05:56:42	2017-07-23 05:56:42
0841072144d41a004718587972f43b2d502e453452587b36490f9a4fc9bd897c74e408eec24d8ac8	185	1	\N	[]	f	2017-07-08 06:00:47	2017-07-08 06:00:47	2017-07-23 06:00:47
97bdf66b042c47154892f752f339f6fb9a7d3f85c04afcc028ecfc878a659a9da8a3b6cf8d06212a	186	1	\N	[]	f	2017-07-08 06:03:39	2017-07-08 06:03:39	2017-07-23 06:03:39
6702a42979ae72788ccfc94d524f4776cc2250f474e185e1263f21dabfc7700fb0330192cc41b177	2	1	\N	["*"]	f	2017-07-10 12:50:35	2017-07-10 12:50:35	2017-07-25 12:50:35
9d0da7a2c1a7e1dd3c5b84f7780efb6ed3d6a837a33bf37160e403d21d99d7a33fba212fdbb48845	135	1	\N	["*"]	f	2017-07-10 13:06:58	2017-07-10 13:06:58	2017-07-25 13:06:58
1128605b4bde1da7c831d8e652c91c4f4476050568ac19d61e8fad62bad27a6cfbc3b79ff2720e9b	133	1	\N	["*"]	f	2017-07-10 13:08:10	2017-07-10 13:08:10	2017-07-25 13:08:10
5cc93de2e16b51bd617a12c420d9834af8e60063dae3ca42fd80f81b1f8e6953e0c28ee33490dee4	2	1	\N	["*"]	f	2017-07-10 13:12:45	2017-07-10 13:12:45	2017-07-25 13:12:45
9aae0426c9aea07857811248d32c2b44611909364d4c440924dca81e3a5e2869cac68110b87e71ec	2	1	\N	["*"]	f	2017-07-11 06:36:34	2017-07-11 06:36:34	2017-07-26 06:36:34
a564e5ddbe367b132dc10b560950c7fad092f06e858051f1cccd57eda37ba840603ee9de06004f7a	133	1	\N	["*"]	f	2017-07-11 06:49:18	2017-07-11 06:49:18	2017-07-26 06:49:18
88edf9a0aea617a9bc516105977d4b1b3c2382204242030d41bfa6648d726ec28bb0792062c08d9b	135	1	\N	["*"]	f	2017-07-11 06:53:11	2017-07-11 06:53:11	2017-07-26 06:53:11
34ace4e4fb19d4fe55e6cd855b403be9cc13995ed98c693e9b36e220e62c3b4fb8f6cd6fb98ceef9	133	1	\N	["*"]	f	2017-07-11 06:55:47	2017-07-11 06:55:47	2017-07-26 06:55:47
1d3c19ccffd8e8349564b6f846014b9db17201d3b72288343f73bf52e844c05c88732d20bba2dff4	2	1	\N	["*"]	f	2017-07-11 07:14:58	2017-07-11 07:14:58	2017-07-26 07:14:58
29705162422a608e5ad5f7abc4e0fa54a35ad7aacd67bf20d72f670ec6f659376913399bf4b97614	2	1	\N	[]	f	2017-07-11 07:16:28	2017-07-11 07:16:28	2017-07-26 07:16:28
b9040f65aceb36272ce1e5eabdf71ce24c5c613b7a8208692593fef7fa9d9c2a50e97353bbabae15	133	1	\N	[]	f	2017-07-11 07:19:21	2017-07-11 07:19:21	2017-07-26 07:19:21
50ad2776ef83b167367a1af6a0b9f898be0f40df931de63c1f3f13ad11933e5f9ed2223597337312	133	1	\N	["*"]	f	2017-07-11 07:23:29	2017-07-11 07:23:29	2017-07-26 07:23:29
15ebc56abeb7e3639b45feaedb8c397d05684f0c6fd9da58c6228d4c68d1938c953923093c4b891a	1	1	\N	[]	f	2017-07-11 10:19:08	2017-07-11 10:19:08	2017-07-26 10:19:08
d6d317b27353a108c460ee7b839cce7a00b47b2bb788ce9dc692eef170c920827ab0695faed17d08	164	1	\N	[]	f	2017-07-11 10:20:30	2017-07-11 10:20:30	2017-07-26 10:20:30
a3ba4f42aee6b0b3087bca62218a3afec717e21ac1c4cd67891dca9fb53cd8239d6e357bf7da46cb	164	1	\N	[]	f	2017-07-11 10:22:00	2017-07-11 10:22:00	2017-07-26 10:22:00
c621e8f7fe841a6778632f4a2269618f147c55c2548a6ab9fd9ce1a1d4b93eda6a6da36e13e14539	164	1	\N	[]	f	2017-07-11 10:34:30	2017-07-11 10:34:30	2017-07-26 10:34:30
f8ae400693f408efd2eb632251297f78f3b9e397d14bede1923b0b455501bb215566b5f6913c89d0	164	1	\N	[]	f	2017-07-11 10:34:37	2017-07-11 10:34:37	2017-07-26 10:34:37
c00b4f7f7ce06603b9d6ea5b97e99b4f68300e940c6e3eb947576bcef501cff86a9cb30bf7492b9c	164	1	\N	[]	f	2017-07-11 10:34:44	2017-07-11 10:34:44	2017-07-26 10:34:44
5b2c9f071f206a15da29d3e3a0cef4f5a6bf29504bdef1061fd4fde1f1a6d731f2e4c6334c70d520	164	1	\N	[]	f	2017-07-11 10:34:54	2017-07-11 10:34:54	2017-07-26 10:34:54
c4e76d56f80ffafe0d85cffdcddbad97e84c7d80f280446133dffbf1cabbbb6609a0a220fbdde891	164	1	\N	[]	f	2017-07-11 10:35:37	2017-07-11 10:35:37	2017-07-26 10:35:37
401a082a2ee657aad8d09d30b8c3dc17714356828c061c6571f3c9e7bc2ac7f891e25ddc4eb158ed	164	1	\N	[]	f	2017-07-11 10:35:50	2017-07-11 10:35:50	2017-07-26 10:35:50
5e89d6b62e4d6cc6cb8e796198c9c749a2397931cf090e509b49f3f6fcafaf25b01eaa8558051804	164	1	\N	[]	f	2017-07-11 10:40:06	2017-07-11 10:40:06	2017-07-26 10:40:06
601f7c550bcf1703eceebf04d5674fa6ecea8c0ffb2fbb51ef70f2757ea5cdb05eeda72957c0448f	164	1	\N	[]	f	2017-07-11 10:41:14	2017-07-11 10:41:14	2017-07-26 10:41:14
ab074626c2f3f3392e9d89c33ead8a49ac135fe8ca99078a69a63fa464684dac47930c7b93880632	164	1	\N	[]	f	2017-07-11 10:51:03	2017-07-11 10:51:03	2017-07-26 10:51:03
42b69022b4dd65c27f163b63b286c45981dc9e456a3ac83dd8fc638ce1c6f4f5fd65e517ba98cd00	160	1	\N	[]	f	2017-07-11 10:51:12	2017-07-11 10:51:12	2017-07-26 10:51:12
c59ebad8f573cb9f6bcf761bbeed99b10120653c4f4bd54b703ed9a48a6f71af0d76ce0b285aa8e0	160	1	\N	[]	f	2017-07-11 11:06:02	2017-07-11 11:06:02	2017-07-26 11:06:02
0c11df22422af8adef127571d19d7a77aca245e2856eeef072e96cfbbc4f93d94b62ec9c84ecd90f	191	1	\N	[]	f	2017-07-11 11:07:45	2017-07-11 11:07:45	2017-07-26 11:07:45
2d772af59a169080e148c7cbfa76b865199ee44c26c17f58465641d489ae2d50df6fb067ef6a737f	191	1	\N	[]	f	2017-07-11 11:27:15	2017-07-11 11:27:15	2017-07-26 11:27:15
95fa4bd17080c1ba7ec828303c7ef96213f7e73fb621161c455c04304addcd6d805d59ac7a823324	160	1	\N	[]	f	2017-07-11 11:37:20	2017-07-11 11:37:20	2017-07-26 11:37:20
985712fec89c1c984ce768ba41507ab32f13a9e584af63ea85cb0e2cc1eba8f8bf26d14d17b78953	191	1	\N	[]	f	2017-07-11 11:42:40	2017-07-11 11:42:40	2017-07-26 11:42:40
556a11d68114b6d82a62e63d76a2ffb6364060843a295a09828bf38d0781c418904423e54bc97e46	160	1	\N	[]	f	2017-07-11 11:51:18	2017-07-11 11:51:18	2017-07-26 11:51:18
22c4c2d8d316f16e0d5fa40cb00ad5893cf8c0d1b6805730848fde88773443eea5302be316e2339c	191	1	\N	[]	f	2017-07-11 11:51:31	2017-07-11 11:51:31	2017-07-26 11:51:31
f3d558088ec2df84f07e8eeeb86a2617d069c08c08aa479b8adea2b4623b8b0d92f0a16dd0db1415	191	1	\N	[]	f	2017-07-11 11:51:43	2017-07-11 11:51:43	2017-07-26 11:51:43
1085ad71fe56fea46cc7e6928852db7e89a5fb1fb3ace18ccd3a23dec40f1030ad7a2de036d9aaab	191	1	\N	[]	f	2017-07-11 11:52:16	2017-07-11 11:52:16	2017-07-26 11:52:16
4d72fcef8cb8cce089ea0d239a35506805c4f5480ec1c2e035f6d48ebe686b9c32a6904972160263	160	1	\N	[]	f	2017-07-11 11:53:03	2017-07-11 11:53:03	2017-07-26 11:53:03
3afc2a96380b1c07dc373a7ecbe3a41646b17fa9d3b6a6847baf7ac1dde40ad30e4e79f587e8d7c5	191	1	\N	[]	f	2017-07-11 11:53:33	2017-07-11 11:53:33	2017-07-26 11:53:33
e04f7c70c5866840a7c407d0da1468827bb95ab30d1fedec5407992e9d50ccc1220ee97b320df793	160	1	\N	[]	f	2017-07-11 11:53:57	2017-07-11 11:53:57	2017-07-26 11:53:57
10b96c3ae9e822d61472b8a5bbbbd7a6e2d2b7ed515c8ccc740df10273055d64aae3e0ee10a05269	191	1	\N	[]	f	2017-07-11 11:54:27	2017-07-11 11:54:27	2017-07-26 11:54:27
ea6826862d1a08eca0236d4f692b89ab06e5429a924eeb847857c2d3fa73df00f938c730df7426d3	191	1	\N	[]	f	2017-07-11 12:44:14	2017-07-11 12:44:14	2017-07-26 12:44:14
8420be0cb30f9d49030eac438b50c31827f5d1029d1f56d7a5d71a2becc178ac3292de07a492103f	191	1	\N	[]	f	2017-07-11 12:55:32	2017-07-11 12:55:32	2017-07-26 12:55:32
3bdc98aab18cc9b4d319c536bb33364d72f66b811720565146aebcf7f7beb7fa566d3b6a1cccba84	191	1	\N	[]	f	2017-07-11 12:56:02	2017-07-11 12:56:02	2017-07-26 12:56:02
185d9536b5ee6c9a9f9d562d3ea11d08ac29d958fec8031f164d13761bf2886a060d9d3fb42cb430	160	1	\N	[]	f	2017-07-11 12:59:30	2017-07-11 12:59:30	2017-07-26 12:59:30
bef27d2f213530a4301901a7e955d3212de9c805de760f074e2c73a8787bcb04a30b28f4b95818f4	160	1	\N	[]	f	2017-07-11 13:01:52	2017-07-11 13:01:52	2017-07-26 13:01:52
400d0efb57599a88fe359c0e5ae23769c1fe7db6feee9716a5bc0ff23b11deba59aae717aadf48de	191	1	\N	[]	f	2017-07-11 13:03:14	2017-07-11 13:03:14	2017-07-26 13:03:14
2d8c14c4d1996dfde7855621991e364c6ff61bb411cf4cb59c6f580e2a7fb8177f9c956c58bb21ee	191	1	\N	[]	f	2017-07-11 13:05:10	2017-07-11 13:05:10	2017-07-26 13:05:10
bb0c15c8ba70fe30e2370364c9ee21210764dfd1241daa9e6d4824f773ea864fc1cacffb5258aa0f	191	1	\N	[]	f	2017-07-11 13:10:51	2017-07-11 13:10:51	2017-07-26 13:10:51
66ebfb8279a2151e61a897ac528f811e70148afcccc2b4ec1c55e28e129de894196c0923c64aa63d	191	1	\N	[]	f	2017-07-11 13:12:23	2017-07-11 13:12:23	2017-07-26 13:12:23
6e06a85c1c7ccec56ab67a06287a62d8688a3bdf3ff17381ce47bbde5bb44dca3f41cdb2df7a85d3	191	1	\N	[]	f	2017-07-11 13:16:01	2017-07-11 13:16:01	2017-07-26 13:16:01
12fd5fc57166141984f5e6f10a24aa20cf8b0a44607f5b3f925ea9cd53ace158ffeabec648b3a617	191	1	\N	[]	f	2017-07-11 13:19:17	2017-07-11 13:19:17	2017-07-26 13:19:17
5857430c0f37e71dae566fd0cb1bfae016814235445e80e663f7561190dae234b91ae45ec6e2717e	191	1	\N	[]	f	2017-07-11 13:21:02	2017-07-11 13:21:02	2017-07-26 13:21:02
b33ee9596cd4cc47129cb753a04a9eedb15c9340592b1aa4373d1c59793a6c9389dd42be3379b211	160	1	\N	[]	f	2017-07-11 13:24:27	2017-07-11 13:24:27	2017-07-26 13:24:27
e0139c2cfe9c287e97e3987f389fba25bd927735f57ea6270a0df0f2529adcc2aeb7cf69aab848f5	191	1	\N	[]	f	2017-07-11 13:25:03	2017-07-11 13:25:03	2017-07-26 13:25:03
4f2a704c68d97c16a2ddb92e81b55295015900c5a7380ee6a5af602f9309318e8a9381d2e15000a6	160	1	\N	[]	f	2017-07-11 13:26:37	2017-07-11 13:26:37	2017-07-26 13:26:37
45b61c9300f2f98b4f16cc2969ce2779ca08592e367c900a0d258e86457a96f16f69dfd64ea6bb01	1	1	\N	[]	f	2017-07-11 13:26:58	2017-07-11 13:26:58	2017-07-26 13:26:58
f079b6371a25c84a93da54accaa9ff831184fef8f1e1fccde6ac0fa093c125b829b38a3773a30f47	191	1	\N	[]	f	2017-07-11 13:27:29	2017-07-11 13:27:29	2017-07-26 13:27:29
3963a7d669176117e411b8211602e304840f0f70eb115d93dbfc6f24db63db13795cc8ef4fef9a3a	191	1	\N	[]	f	2017-07-11 13:33:42	2017-07-11 13:33:42	2017-07-26 13:33:42
904eaf68ad7bc4737abcb093fe29e600f8d15c04ac28aaf8afacd4bf4dbfac81ebda5c0f5781841d	135	1	\N	["*"]	f	2017-07-11 13:35:12	2017-07-11 13:35:12	2017-07-26 13:35:12
6af1b3654ab9d06cf2797663b708c58224659dbdd43321f49f7ef5338cf2b744be67fac0455d2c73	133	1	\N	["*"]	f	2017-07-11 13:42:14	2017-07-11 13:42:14	2017-07-26 13:42:14
cec4285089eb722eec3b0519f03a269e65763a8208909486c4ba337565e3c237b70128b66eabf9ef	191	1	\N	[]	f	2017-07-11 13:51:35	2017-07-11 13:51:35	2017-07-26 13:51:35
c65d061a898234acada1dfa6544d70a569c99b904ade7717e89b6b9ac2d95338c8635893d28eee1d	191	1	\N	[]	f	2017-07-11 14:03:05	2017-07-11 14:03:05	2017-07-26 14:03:05
e7db5d295bb852e31085cf10fe2e3e8cd9e9b4512f4b2f9d700986efb092b8294dc9e0d38f4ff308	135	1	\N	["*"]	f	2017-07-11 14:04:21	2017-07-11 14:04:21	2017-07-26 14:04:21
082595ff5cc6bfd761d1620d560a94cd68897440b98a4c54720e1715d59f5f76a54b8d96f262888b	191	1	\N	[]	f	2017-07-11 14:09:12	2017-07-11 14:09:12	2017-07-26 14:09:12
1bd682011a9e25fe473309a482c9b2b02c053a57d9be58e20adb713854933af6b0c9b60488c4eaf4	133	1	\N	["*"]	f	2017-07-11 14:09:54	2017-07-11 14:09:54	2017-07-26 14:09:54
44d4a24a7bfe7c57a21a9e0d232afda813bd5ec259a84e67a1d27778b1b0b2411a6db5bc4b7c9ac9	133	1	\N	["*"]	f	2017-07-12 06:18:37	2017-07-12 06:18:37	2017-07-27 06:18:37
315ca7ce51aa11ef1cdeb2ef561bca18d09ecae6bdeaf0a7029e067095dacafccba69cdfc68d64e5	191	1	\N	[]	f	2017-07-12 07:38:53	2017-07-12 07:38:53	2017-07-27 07:38:53
125702e499ac3773a55f6ca32904caeba4d9a2995e8b32219354ec6706cb58b3c6c815f6e9f6dea5	191	1	\N	[]	f	2017-07-12 07:38:56	2017-07-12 07:38:56	2017-07-27 07:38:56
63197386cdc9001cffdba2d66eed97f38f8374bf143c9650148271d387a1a32f54bc99f1cc067c6a	191	1	\N	[]	f	2017-07-12 07:38:57	2017-07-12 07:38:57	2017-07-27 07:38:57
a96448bfa7f3770e18040dff1acb25d6cdf88e5672292682989d415095def1ce7bc815e30d716ae0	1	1	\N	[]	f	2017-07-13 07:32:37	2017-07-13 07:32:37	2017-07-28 07:32:37
43a7bc59a6beaa0a18716bebbeaa943c226debb6d89c7f09cc9bf8ac553f147997e4ebb404e8b708	165	1	\N	[]	f	2017-07-13 07:45:32	2017-07-13 07:45:32	2017-07-28 07:45:32
868c9c810d8abe12c2c2473d278fc82b1b2914dd1cc90a60e00015397fd6a4b3def257db25f86ca2	133	1	\N	["*"]	f	2017-07-13 07:58:48	2017-07-13 07:58:48	2017-07-28 07:58:48
6e0269e6204efdd3811dde6ebf8b8c56eab1eeddd4680d12047b2a83e980663fc17fb012ec6cecb9	1	1	\N	[]	f	2017-07-13 12:41:38	2017-07-13 12:41:38	2017-07-28 12:41:38
eb51f13e13f50cb46c38bbee8bcb9493b11d37ec7e7e773ec045cec631924ad846164f78eba8e407	194	1	\N	[]	f	2017-07-13 12:56:57	2017-07-13 12:56:57	2017-07-28 12:56:57
a1b63ed1768161e645bd8cd9728ee1c7faea7fb3a6b1540994d782348a21579cdcadaa26e740e623	194	1	\N	[]	f	2017-07-13 12:57:32	2017-07-13 12:57:32	2017-07-28 12:57:32
fc13082c0fb96b80b267bd1678886422ebfc7037ba6171e71c17f5abd117e55b9df4795963d4837f	193	1	\N	[]	f	2017-07-13 12:57:51	2017-07-13 12:57:51	2017-07-28 12:57:51
329d0e2823ab6691faf54523a43fb8e6bae8e7667aca55288ad7fc1794cb7739a5c17a5073395a1f	1	1	\N	[]	f	2017-07-13 18:34:52	2017-07-13 18:34:52	2017-07-28 18:34:52
75f9fc0ca37d057cbf8ac6c00022c1745c61581d793f42fb596ac0f2b5229b745167cffa9948c45a	157	1	\N	[]	f	2017-07-13 18:35:29	2017-07-13 18:35:29	2017-07-28 18:35:29
0d3aaeeb4acfbda59fae3b76cf05ad03c68081ab60b4104dca666dde2ddb5d5dcd3f73b34b70c018	203	1	\N	[]	f	2017-07-13 18:41:10	2017-07-13 18:41:10	2017-07-28 18:41:10
57b28e7bbfb6fd063226e1f5e03420d476d2b707cda73edbea97fe011cdc7de6c3a93a7dc213e0a9	133	1	\N	["*"]	f	2017-07-14 07:06:35	2017-07-14 07:06:35	2017-07-29 07:06:35
ceff59c1983ee918dd414dd15b7f41cb679d27537e61556688aa87bf32730f370f24444bbfa11d64	133	1	\N	["*"]	f	2017-07-14 10:23:40	2017-07-14 10:23:40	2017-07-29 10:23:40
cbc960e5f3c908389bc1059145d21b237f4727049df2c25137cd3e6dab371eed25b85bc12ec15a2a	1	1	\N	[]	f	2017-07-14 13:08:24	2017-07-14 13:08:24	2017-07-29 13:08:24
5e396123585a2432f8dabc6b88dae2558e8523aa7976578686eb29cc3a323df957efd64a3d152f62	160	1	\N	[]	f	2017-07-14 13:11:33	2017-07-14 13:11:33	2017-07-29 13:11:33
288625e61de072f8fdd0527c28e1faa57a7879443f9aaf7fc5dbd0b08b4d0186c69169228eab260e	160	1	\N	[]	f	2017-07-14 14:40:18	2017-07-14 14:40:18	2017-07-29 14:40:18
30228ef03ae7eebdc4432a4c12b7946f617286b76c87fb8b1b900a39460c72232d119c34ad3d5f3c	202	1	\N	[]	f	2017-07-14 14:49:11	2017-07-14 14:49:11	2017-07-29 14:49:11
0aecbdab0db42099b7ccf08f73ea115924ea6cce90261a89f355a0008cb53082bf0b89556ce38d7a	171	1	\N	[]	f	2017-07-14 14:49:24	2017-07-14 14:49:24	2017-07-29 14:49:24
097a5a6bc95ef737870b5dfc89bc38748a1cf1e6784aa8e929af54d6cc35b88fd69354a7fc809a99	171	1	\N	[]	f	2017-07-14 14:52:08	2017-07-14 14:52:08	2017-07-29 14:52:08
16134f3ed87ee0dbb6afbfb846043273a56a4c0116b22fa6492f1de949f0c134c72f7b69cfd75955	1	1	\N	[]	f	2017-07-14 16:03:20	2017-07-14 16:03:20	2017-07-29 16:03:20
bc164beceadf43c9c52023f331d6dc95b61f0dc77f9e3601fe10e0d9c1921fea217cb9475ca5b58a	165	1	\N	[]	f	2017-07-14 20:16:03	2017-07-14 20:16:03	2017-07-29 20:16:03
33350c42aad6566a44e9e79b2005da8c890e297993655bda0cd99c2280df28736dd8c476d5f4e547	133	1	\N	["*"]	f	2017-07-15 06:49:32	2017-07-15 06:49:32	2017-07-30 06:49:32
d4d3b66582876019c6fc9cff39f65e4662b5ebef3b32a534ca5f59f8ce1b5aeb532c7e8cc733ed46	1	1	\N	[]	f	2017-07-16 22:00:51	2017-07-16 22:00:51	2017-07-31 22:00:51
8c6a62cde751d6f37549f80103e0d7f13b47c30fa8b1bb0b18ea1165352268a930708d648dab5446	133	1	\N	["*"]	f	2017-07-17 07:21:26	2017-07-17 07:21:26	2017-08-01 07:21:26
15045136be96b5db478c34ea58f58a6a9e8f8ceea81ed956035b156987294b24fdd06d78ca9f39a3	1	1	\N	[]	f	2017-07-17 12:17:22	2017-07-17 12:17:22	2017-08-01 12:17:22
68f4f6f9164f11d83a46303053501e8cb0304bcf2f97ba7d5ee87ced0208fa2ec186c5569aa445a4	1	1	\N	[]	f	2017-07-17 12:58:43	2017-07-17 12:58:43	2017-08-01 12:58:43
7a1163719cbada3e7d518d534bb39a12bfa7f9d5186fa66fb594cf65e9dd9e12c246ecd091f06f9c	1	1	\N	[]	f	2017-07-17 12:59:28	2017-07-17 12:59:28	2017-08-01 12:59:28
0e5de3cae01306847bc076e1150b62f0b293d9316274c617ed31e1cebadd1cef925e5e9eaced7fe3	1	1	\N	["*"]	f	2017-07-17 13:09:16	2017-07-17 13:09:16	2017-08-01 13:09:16
10c9ee563deeb86fc3d6e008b236001da01f47d9cc8faed017f546aaa4f534a1d288337588532a2d	166	1	\N	["*"]	f	2017-07-17 13:09:35	2017-07-17 13:09:35	2017-08-01 13:09:35
604da1d86986e3a3a7545d4d59bf8f0dd167901e1679736d044a6176281981a688af65d64cd8036e	165	1	\N	[]	f	2017-07-17 13:56:51	2017-07-17 13:56:51	2017-08-01 13:56:51
2fe1f27b5c66802ef3f07ab4a6426b73cbed1e5d6aef4d41ce5c1f2d2138d8bee75f3a0e260e5420	133	1	\N	[]	f	2017-07-17 14:00:10	2017-07-17 14:00:10	2017-08-01 14:00:10
73c96613aa0e63e6efa28e255f423d454a06bf3dad941a86021f6b1d4895fedc5ea818b69a735637	133	1	\N	[]	f	2017-07-17 14:02:32	2017-07-17 14:02:32	2017-08-01 14:02:32
93f009bb00c61134371294511729af8f7a3df1e1fc2e277b6df09ceefe1825fc189b4ab066e299b4	133	1	\N	[]	f	2017-07-17 14:02:40	2017-07-17 14:02:40	2017-08-01 14:02:40
69cd8ba5cc0e4018e1c11b64ddf1b0648711b815d074f3ced73d569be08c22b1ba88160bc04dcdc9	133	1	\N	[]	f	2017-07-17 14:03:11	2017-07-17 14:03:11	2017-08-01 14:03:11
c4de16ebf70b3e71f03be88b73160a4066a9527dd43953793f225d81bb81787366175b55b9a1d6a2	1	1	\N	["*"]	f	2017-07-17 14:24:56	2017-07-17 14:24:56	2017-08-01 14:24:56
bd05e1a7b1ded56b92b31a85c9e89a072bf465efff76bba3a81215aba43336f28b0a19521f00c039	1	1	\N	[]	f	2017-07-17 14:43:30	2017-07-17 14:43:30	2017-08-01 14:43:30
a85602851c2acee45bcd792756ab07f2b841f9b3902ec7576861a604dfe3ab6e4dea98b410ebf458	1	1	\N	[]	f	2017-07-17 14:49:44	2017-07-17 14:49:44	2017-08-01 14:49:44
820e8638777b44978e723b5f39fb99511b1696fdd538c5b4a9062c88355e2e0bb77d1b6125120c7f	1	1	\N	[]	f	2017-07-17 14:51:54	2017-07-17 14:51:54	2017-08-01 14:51:54
9b23cbafa31d76defb61cd8ad6c4b949a4ad8960296804f61f984da93fc464e9573a20f534dfb36c	157	1	\N	[]	f	2017-07-17 14:52:24	2017-07-17 14:52:24	2017-08-01 14:52:24
c50643c38aa25dd857823159ecf2056c7d870b594489d4ad0fa14489e3520f42daec0b26da8e58cb	1	1	\N	[]	f	2017-07-17 14:53:19	2017-07-17 14:53:19	2017-08-01 14:53:19
59203553030d622a52e092848ce20b0ad80cef9cea03d32889a906019e0ea459abe3aca09a97e57a	1	1	\N	[]	f	2017-07-17 15:03:14	2017-07-17 15:03:14	2017-08-01 15:03:14
3dc26330d7eabd8f1af57054614de7cdf09bde01d02e7cc477cebd00b7501f5c5b2e1243ec0b2a83	208	1	\N	[]	f	2017-07-17 15:56:10	2017-07-17 15:56:10	2017-08-01 15:56:10
d6fcd7adae5a97262138b87658886c36f519fc339c4df3fec56973bad29f2bb809cf6523a4c44c2e	157	4	Punchcard Impersonate	[]	f	2017-07-17 15:59:53	2017-07-17 15:59:53	2027-07-17 15:59:53
01238fbb79a0596193bbecea362736a2e000cacc141b4dec13959474d01f4b30dce60e3a8319e60d	1	1	\N	[]	f	2017-07-17 16:00:16	2017-07-17 16:00:16	2017-08-01 16:00:16
f03fb78d6668aec55810d1146668f0568d7c93bfd9b45b29fd058565b5c18a452582be2f3c7939c9	1	1	\N	[]	f	2017-07-17 16:01:02	2017-07-17 16:01:02	2017-08-01 16:01:02
f78ad0cc9acd99422612ba03273aab941ef224bce88e9e66cec157603a2bf9433412022800a8d6d4	1	1	\N	[]	f	2017-07-17 16:01:08	2017-07-17 16:01:08	2017-08-01 16:01:08
6220f3331e1302bd13d9591ce9ef1b58c67b6aedafa6fbdeb9a5e9c8e8d64ba4bb0f0b3eaa8459ec	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:01:24	2017-07-17 16:01:24	2027-07-17 16:01:24
5bfad86037629de7c9590af32adc97c3695842ce1b865bf78f22bfb43145889808753927698a2244	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:01:31	2017-07-17 16:01:31	2027-07-17 16:01:31
9ce27a054b2ba95d031877b627b799e51e0a57b796ee260d9740b2cda81fe42a79c1c5c512be90aa	1	1	\N	[]	f	2017-07-17 16:02:15	2017-07-17 16:02:15	2017-08-01 16:02:15
4d25dbd9d14864355f185d40cd2b6326e1ef83ce5f1e6d21d2431b1749d05a88c6b4b01b57ce6f8e	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:02:29	2017-07-17 16:02:29	2027-07-17 16:02:29
d50d69c065814292a9d5a89862574e17cd0beede1d15c3a40cc3f035b680676476297facbd3b7175	1	1	\N	[]	f	2017-07-17 16:02:42	2017-07-17 16:02:42	2017-08-01 16:02:42
a7f37f786d003f500366d4a254cc7448f97cf40f5bc4511ff0a687b59388ca6efa74c4031a7019a7	1	1	\N	[]	f	2017-07-17 16:02:43	2017-07-17 16:02:43	2017-08-01 16:02:43
37b3382fa152c52a71aaa97d0334a3a701acda5db0168a4a6716941b9d11ca76bdd2ecdd3d26fb7c	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:03:10	2017-07-17 16:03:10	2027-07-17 16:03:10
b31631f414eccfa98f1eb2bd1f31fe426f644edc940db20c2561719a51a1ae63cdf5443802807b05	1	1	\N	[]	f	2017-07-17 16:31:19	2017-07-17 16:31:19	2017-08-01 16:31:19
a4b748d3c3437acc3e3bcab451d2053dd903198a3e8a2f66d1dff01eff3bd146b53cc86668130978	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:32:57	2017-07-17 16:32:57	2027-07-17 16:32:57
f6c133255e74eeb4ba76b2653688c70c6a69c84e3f42d587f2d9c4e8ff85218c16fc3d447c3b4a6a	1	1	\N	[]	f	2017-07-17 16:35:37	2017-07-17 16:35:37	2017-08-01 16:35:37
6efc4da9d48a153a79a53ad1693c8e9cf9fa89f249c873a6fef6b3bac81421805b90f0091c503046	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:35:46	2017-07-17 16:35:46	2027-07-17 16:35:46
64707cc77594b39e2ccabbb775ad783ab7ab806ada3544a215bbe2caf6357557a95fd67966b839e5	1	1	\N	[]	f	2017-07-17 16:36:29	2017-07-17 16:36:29	2017-08-01 16:36:29
e6a25be78c20de6841408539c9df2fbb69f472e8b761d4070720673b95985e54130d51ad08978769	1	1	\N	[]	f	2017-07-17 16:37:22	2017-07-17 16:37:22	2017-08-01 16:37:22
b6a171b9c96d60a87527e30233729777fb6926a1019ddeb1aeb22dc65e14b9154d0605cf8729f9b9	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:37:30	2017-07-17 16:37:30	2027-07-17 16:37:30
73339a0eeef5580be4a8f961053412f2afbf6e3915da1ecde53e99e3d2aed290bfc65b483bf34d86	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:37:35	2017-07-17 16:37:35	2027-07-17 16:37:35
c4d94e287430b412dbb40e8d4fe3a7dc72fd911738e7c7cb2cfd580bb379722b47574272a16447ba	1	1	\N	[]	f	2017-07-17 16:38:10	2017-07-17 16:38:10	2017-08-01 16:38:10
11629f4816323aeb00f247ce05fef6c43855b1e80f9b1dc4a67280cc371a13d2c81889cfe7a59e2d	157	4	Punchcard Impersonate	[]	f	2017-07-17 16:38:22	2017-07-17 16:38:22	2027-07-17 16:38:22
60b25abdd3f409236e920762fdca40ef03001d5af8be8229cffa0dc48ebc103551e4e6af49b7495a	208	1	\N	[]	f	2017-07-17 16:40:05	2017-07-17 16:40:05	2017-08-01 16:40:05
a881e2ae5ad4bd3f626e02efd1b29ee242054cd4119be630e77598dbd6f6a52c36448bb8b9ef9a3c	1	1	\N	[]	f	2017-07-17 16:42:01	2017-07-17 16:42:01	2017-08-01 16:42:01
14ad69985d9b904d197850df47c85e0f63eb052fc27d3068c0b8b92fb2ec22831bfa0331e6a68e64	2	4	Punchcard Impersonate	[]	f	2017-07-17 16:42:10	2017-07-17 16:42:10	2027-07-17 16:42:10
dac74989f215263a9961589c2092bfdd465d1be75f9d0f803fdf18003bba3bd7d3d883e5e793bfc4	1	1	\N	[]	f	2017-07-17 16:42:31	2017-07-17 16:42:31	2017-08-01 16:42:31
537a4f2e4e951aac67e3f9cabeca005a824874a2ee5e3de3c2796cbca545bd1962074addd4cc7dd6	210	1	\N	[]	f	2017-07-17 16:49:21	2017-07-17 16:49:21	2017-08-01 16:49:21
0d4ebb680954a87d9162fe473dbc225bc3929a0d06e076906143b7f8978718ad0711ed9ca3b6157f	210	1	\N	["*"]	f	2017-07-17 16:50:53	2017-07-17 16:50:53	2017-08-01 16:50:53
624475e44cab0fd91c2b5f15a061c6ce70130c20bf232c677a0426fc71325a14030e203a562a1abe	212	1	\N	["*"]	f	2017-07-17 16:56:00	2017-07-17 16:56:00	2017-08-01 16:56:00
461eddcb3cb2f606648b3189ad9253cb1fdf7f0f2841024831d9c0a2eaa4648894a8c78df17abf90	211	1	\N	["*"]	f	2017-07-17 16:56:14	2017-07-17 16:56:14	2017-08-01 16:56:14
976f4628caa860e4ee058eda2eb58d4ab44ddaf44b1e35f582ce87a346f8d893140b29324f0dd548	210	1	\N	["*"]	f	2017-07-17 19:29:31	2017-07-17 19:29:31	2017-08-01 19:29:31
7c34d9e5f961bd953d026cbb73fa69e2d05ab05f6a6f8e84d26ea3b6ae32e1213b3fb870645403a5	212	1	\N	["*"]	f	2017-07-17 19:31:14	2017-07-17 19:31:14	2017-08-01 19:31:14
559c391828ce6169cfe22c85bfd9116dcd477eb3421a5a2b7a13cf7fd829578264d116c696362fc0	208	1	\N	["*"]	f	2017-07-17 19:32:30	2017-07-17 19:32:30	2017-08-01 19:32:30
e526d63483b6a2a736a1274e026d44f6306bfe99097633cbd6d171ae5c23eb0063158d8806a22ea9	208	1	\N	["*"]	f	2017-07-17 19:33:01	2017-07-17 19:33:01	2017-08-01 19:33:01
303c6e9a3e52e87468e4f42f5e7e375e7907a037eb4c0f529464b9f8c91175faff773990f630d5c8	208	1	\N	["*"]	f	2017-07-17 19:35:05	2017-07-17 19:35:05	2017-08-01 19:35:05
1ce93c5c4e7f73d0fa8b1c3a4b700a11710a9bb9174ab3729509675c1702a661a3b5fe0d724eee73	208	1	\N	["*"]	f	2017-07-17 19:35:32	2017-07-17 19:35:32	2017-08-01 19:35:32
f02a8a16cc46a77a4931c47882d7aa0efaef7d2aea601a157de676c9cab9bb52c623a59d795d8ac6	213	1	\N	[]	f	2017-07-17 19:37:16	2017-07-17 19:37:16	2017-08-01 19:37:16
b71c2a4bc5d8c98f6799b5f265a9e4d4635bbd6ec154e80be7bdac172adce961ae90db41c862413d	208	1	\N	["*"]	f	2017-07-17 19:40:51	2017-07-17 19:40:51	2017-08-01 19:40:51
1f8271f2ab2ce5b05ac64e7582d6f9f93dca9f96926939f57c62b7ea4305fdda420623b68632c6ef	210	1	\N	["*"]	f	2017-07-17 19:41:58	2017-07-17 19:41:58	2017-08-01 19:41:58
52b33f4b19dcd18f849ed5f4a2de57f80580cc581ef001fb187f80aad40ab422cf931c1b93b0e2c7	213	1	\N	[]	f	2017-07-17 19:50:12	2017-07-17 19:50:12	2017-08-01 19:50:12
e48a77c6527997984497fa02fd271f5e6449799d150faa7530861e761818dd172ecea7594381d12b	208	1	\N	["*"]	f	2017-07-17 20:01:08	2017-07-17 20:01:08	2017-08-01 20:01:08
80caa0a51e72c86b7c85286ec088da8cfc28b6795c53a21ddbe4627f19eae973eeb543ef023fdcee	208	1	\N	[]	f	2017-07-17 20:03:49	2017-07-17 20:03:49	2017-08-01 20:03:49
c1aeff990e963975cc831a33ca82689c65ee59123b168595e1555262bc007bb0d443188b7362ebb3	133	1	\N	["*"]	f	2017-07-18 06:20:53	2017-07-18 06:20:53	2017-08-02 06:20:53
1cf9b82aa2cefec80090e5fac186746cc36755b822a07752785c2941a8bfb80d80c7c2388bf6d622	133	1	\N	[]	f	2017-07-18 07:04:59	2017-07-18 07:04:59	2017-08-02 07:04:59
a43af0dba41f942790bd3b7927c498a9290bb85b24ec36c36d4a3062f8bc22c2de1e74a8f4995535	217	1	\N	[]	f	2017-07-18 07:20:53	2017-07-18 07:20:53	2017-08-02 07:20:53
c58b662536c87b2006b3ee6d4b58bae5112909b9736902bc130aa0dece6fcced655162252ac9bfe4	217	1	\N	[]	f	2017-07-18 07:21:48	2017-07-18 07:21:48	2017-08-02 07:21:48
99906b02e47692a848aaf7029c6568f38cd9e9218a4e6bd3af2e7563d063f2be3d8e896ae3a3a43b	217	1	\N	[]	f	2017-07-18 07:48:31	2017-07-18 07:48:31	2017-08-02 07:48:31
fa6771bae982614449c1844e443857ee4415728dc6470eec0d876e906e0dc3871cebeb2a61455cf1	217	1	\N	[]	f	2017-07-18 08:25:26	2017-07-18 08:25:26	2017-08-02 08:25:26
82e10f0420163cc243a95b5e669cb2e4f0fb262827f6862462e69878a8f06b77f22bbd66f59ca01d	217	1	\N	[]	f	2017-07-18 08:25:34	2017-07-18 08:25:34	2017-08-02 08:25:34
d64f44bd63234b54a9d14697a31113014362a0d092f2457216f51910b5526ab5f1a63db3a9176345	217	1	\N	[]	f	2017-07-18 10:25:39	2017-07-18 10:25:39	2017-08-02 10:25:39
59f51a6fa9f7ac07e0404af103e4dfc797c2182ffcb1dd254906dba050ed051a55cad50ba32e3099	217	1	\N	[]	f	2017-07-18 10:25:44	2017-07-18 10:25:44	2017-08-02 10:25:44
2f80d3c50a81ebc0372b69d473a46113180d3926a5d91647735a604785ef9a504d6743bdd1f72b61	217	1	\N	[]	f	2017-07-18 10:32:04	2017-07-18 10:32:04	2017-08-02 10:32:04
4f50e89f4ef8c85ae1ebbff8f7a4352ac9e722b70ef193f4d07b3aa1d511fcb0cfd625eb842e250f	1	1	\N	[]	f	2017-07-18 11:17:05	2017-07-18 11:17:05	2017-08-02 11:17:05
533734d50c5e79537e89167667d8e4f194a7791e25656da8a76b5cb5d9029c77b2ebe86f4696e86c	160	1	\N	[]	f	2017-07-18 11:34:58	2017-07-18 11:34:58	2017-08-02 11:34:58
3a13bfd147f039049c3bb89d5ab5988fe6091fbe4df8b6cd1de708a546a9fdfd747c4b4910fddcbe	165	1	\N	[]	f	2017-07-18 12:03:21	2017-07-18 12:03:21	2017-08-02 12:03:21
54686bc7f5b9a179933247f4a6933f009b6f3589c5ec545dffd0dc6c8e9d296e9ff39b4c0bd9bd90	133	1	\N	["*"]	f	2017-07-18 12:21:23	2017-07-18 12:21:23	2017-08-02 12:21:23
1f684d4db4e47600a68cf7ccbaf20b95c7dcebc50cd51d9b80b247e6085cbea75dce120d815b2e17	1	1	\N	[]	f	2017-07-18 12:48:08	2017-07-18 12:48:08	2017-08-02 12:48:08
62e4adbd239830473b889a141520245fc46f6f0b3ef76c41c022ddce916150afd914c7d3d9b72659	133	1	\N	["*"]	f	2017-07-19 07:35:38	2017-07-19 07:35:38	2017-08-03 07:35:38
516b36021034b6135d4698a0b6f21121a3baa4c63554e4063e3a2083f756c1f154b79aa600696910	133	1	\N	["*"]	f	2017-07-19 09:33:59	2017-07-19 09:33:59	2017-08-03 09:33:59
a8859910397a030fda735d06040936d478beef571d99b260252caa5f543750d4ed46c91d359262ad	160	1	\N	[]	f	2017-07-19 09:52:51	2017-07-19 09:52:51	2017-08-03 09:52:51
513893f6e995fe3093bad29590cc673e7f71e5ebfe1149372e17e3e212270fd42cdad4a454f0a5ea	160	1	\N	[]	f	2017-07-19 10:27:54	2017-07-19 10:27:54	2017-08-03 10:27:54
df481897de415c9899c68da1056b735f7f2a2c547294c2ed222894a38584d89f0e0ea61fac2a8622	133	1	\N	[]	f	2017-07-19 10:29:10	2017-07-19 10:29:10	2017-08-03 10:29:10
4eef584f4bcf1bca04080f4584a7547eefa1d0557a57a3e40dac14a1713fef9214923beefc1c1bf3	133	1	\N	[]	f	2017-07-19 10:41:55	2017-07-19 10:41:55	2017-08-03 10:41:55
f986ff080549394c123a6368d5475362338a48e710993fa8db862ba03a1144c1d551a04599117546	210	1	\N	["*"]	f	2017-07-19 15:22:15	2017-07-19 15:22:15	2017-08-03 15:22:15
875bea88d1fdc80bffd18a9f51aebde1d6fd78cea7c97252e91b4a4ff221fc2754c740096d5d5622	133	1	\N	["*"]	f	2017-07-20 06:43:35	2017-07-20 06:43:35	2017-08-04 06:43:35
9e65b24cb9ba74d67811f4a0d63fd2e8e45d955f69949cc3b3b932829052eb1616268667695564a5	133	1	\N	[]	f	2017-07-20 07:54:28	2017-07-20 07:54:28	2017-08-04 07:54:28
f6a3736402c1057c1a123c661887f768c774b926a8c2e083ce5c6d70d006a340becca755215cc726	133	1	\N	["*"]	f	2017-07-20 11:25:42	2017-07-20 11:25:42	2017-08-04 11:25:42
8f14f8457885e24bc67db89eddbe3d9915b4e92eb33ac7b0835f2687f44763b092289995935da3e1	1	1	\N	[]	f	2017-07-20 13:07:42	2017-07-20 13:07:42	2017-08-04 13:07:42
32d9081b6182eb37f2dcffd88f8b8903b82e1264bb0110ca884b222afdfa2413f29019e5f176bd09	133	1	\N	["*"]	f	2017-07-20 14:28:28	2017-07-20 14:28:28	2017-08-04 14:28:28
90a3159b93929635964cebc3b7f4d62272c0227152a69434f75b8331fc08cdb26586befa5470661c	157	1	\N	["*"]	f	2017-07-20 15:16:35	2017-07-20 15:16:35	2017-08-04 15:16:35
6dfe942ce5828a20f11dc1969fdb40b6035fbc8b2455af29142931c5cc9628355e5a3ec2baa71f20	157	1	\N	[]	f	2017-07-20 15:19:06	2017-07-20 15:19:06	2017-08-04 15:19:06
049db096eccfeeb42c391460ff9bd2d89b98370b5cbe9bdb3fed6457879c7b1697782821a14c5a17	208	1	\N	["*"]	f	2017-07-20 18:23:13	2017-07-20 18:23:13	2017-08-04 18:23:13
76294de5aad40bb7a8136a49f4db70d9f7b3fff2ede12400e2151ee320f71c4a80af7eb28672fa07	210	1	\N	["*"]	f	2017-07-20 18:51:08	2017-07-20 18:51:08	2017-08-04 18:51:08
4b4efb982acba789400ae78aec46bc8ce308c817ad617d8de4e0e9f9d4eec5bf853c2a559c358564	214	1	\N	["*"]	f	2017-07-20 18:52:45	2017-07-20 18:52:45	2017-08-04 18:52:45
4517745aa93c94c6169f5caeed829113168d48ab3dcf68457f57df675f67842aba3286e2ed955a9b	210	1	\N	["*"]	f	2017-07-20 19:03:34	2017-07-20 19:03:34	2017-08-04 19:03:34
879712545db2949c6559ba616688c158660617015686b82576db46d9c1d9bbbcf5ba266af5abb03a	208	1	\N	["*"]	f	2017-07-20 20:35:34	2017-07-20 20:35:34	2017-08-04 20:35:34
95069abf4601c8f24218a6915cf7023c478d855a8a84733e994b69f5e5ba56ab5cc4bb530308a85c	210	1	\N	["*"]	f	2017-07-20 20:40:14	2017-07-20 20:40:14	2017-08-04 20:40:14
740d973816539d30f7a4c2ffa99668dc9c41fe70f82d8b28276e78b911fda0708e5878c23b190ffa	214	1	\N	["*"]	f	2017-07-20 21:22:43	2017-07-20 21:22:43	2017-08-04 21:22:43
ae7d7634cbb0de99646f5bd3d1db4b969dc751e81cda690ab5dc5a688c3089a5de62d17671f3c97d	215	1	\N	["*"]	f	2017-07-20 21:38:33	2017-07-20 21:38:33	2017-08-04 21:38:33
99fd53aae251a1966e0c36f5e37f2b1aef1781afce352058562efe4eba3a63b02458eb374dbbb7fd	216	1	\N	["*"]	f	2017-07-20 21:38:58	2017-07-20 21:38:58	2017-08-04 21:38:58
295d2913aa73ee60b8807851d0cb5eb98e336946b6ba097c6bab09cf30a75239a816e6d9da20c908	213	1	\N	["*"]	f	2017-07-20 21:39:30	2017-07-20 21:39:30	2017-08-04 21:39:30
b360b65886e1c62fbfde28669a618af83ba354f01e6e27d651ff957f37fd5b1c792b3fe60eb4446a	213	1	\N	["*"]	f	2017-07-21 15:18:05	2017-07-21 15:18:05	2017-08-05 15:18:05
021859fe8ef136476e3d50f5f6dbf52f9aa9d6014428a22cedb6767d2e042bbeb27d69d63e318e25	214	1	\N	["*"]	f	2017-07-21 15:19:31	2017-07-21 15:19:31	2017-08-05 15:19:31
cf70c0c03bf40fc3cefc4be03692eb1665c8ad562659d6e8156c38e74679421d7af0bcf106cc3a49	215	1	\N	["*"]	f	2017-07-21 15:20:04	2017-07-21 15:20:04	2017-08-05 15:20:04
a37e53a449297ad2bf2ee996abd2570f40c74bc971f4a3e1c96424e69462157155e91e5bce52942d	216	1	\N	["*"]	f	2017-07-21 15:20:34	2017-07-21 15:20:34	2017-08-05 15:20:34
597ae8bbd7ef7417e089241df7c2331a64bc8f9e556da8b51aa8162fe3316936d1cb994e2be44cc8	208	1	\N	["*"]	f	2017-07-21 15:21:23	2017-07-21 15:21:23	2017-08-05 15:21:23
7fa99ec13d151decfa180fcbed6f5add0e0ae8a383014adefeff0075a8eb0e17f1801fad758c0ef2	210	1	\N	["*"]	f	2017-07-21 15:21:55	2017-07-21 15:21:55	2017-08-05 15:21:55
5aee6441f692ff85c59b700df8f9b5b61065fc909ce003d9cbf2c902633ec2fa193d425fe2e3c211	208	1	\N	["*"]	f	2017-07-21 15:22:59	2017-07-21 15:22:59	2017-08-05 15:22:59
d105a7cff4fa69abdf1462806a5998871accb0b8446d1f3c9e30a200c1d4f3283424ebd15b60d827	216	1	\N	["*"]	f	2017-07-21 20:35:02	2017-07-21 20:35:02	2017-08-05 20:35:02
b77800117f0b03a1fff12e5fb87b131cca7c26da7ccc8a73754faada848ff7aae3a3732dcc13e40d	208	1	\N	[]	f	2017-07-21 20:50:02	2017-07-21 20:50:02	2017-08-05 20:50:02
5ae27e1aa3d967bd10ca87d6c94f0ae37b7c576befeb2ae659c86bbb809ea90fe1975f8bb0658062	133	1	\N	["*"]	f	2017-07-22 07:00:50	2017-07-22 07:00:50	2017-08-06 07:00:50
ea59344edb3ae999b7c6e1cd1cea03e27b26fc0e63373d979ce75e748f2caf2f76f0e318d625dc14	208	1	\N	["*"]	f	2017-07-22 15:17:46	2017-07-22 15:17:46	2017-08-06 15:17:46
c4e1be355caf80e8e6835045019c2674b1970f38e0a6be3dacfe49b6b7ba886d1f8b40ef10d55130	208	1	\N	["*"]	f	2017-07-23 20:57:28	2017-07-23 20:57:28	2017-08-07 20:57:28
7987825114b653496e1c791fc606f989a97882695559e6ca35f93932291cd2e78601b12700de8744	133	1	\N	["*"]	f	2017-07-24 06:37:47	2017-07-24 06:37:47	2017-08-08 06:37:47
6e1bff08a4a5411c9528964a79fe5243febca660d93f3edc6d6a9ccc38e4c8991517d4bde32fdfc3	133	1	\N	["*"]	f	2017-07-24 10:14:28	2017-07-24 10:14:28	2017-08-08 10:14:28
eaa0037cad179f0d68bc386db0ace0e6b0e494375c787be285c896fabcdfb085ff3788481454ba40	2	1	\N	["*"]	f	2017-07-24 12:10:16	2017-07-24 12:10:16	2017-08-08 12:10:16
e00b440f2cc7a307b7970ebab0cc202fa46ab1a2cb23e4e083cef7967fcd44bc6a3d98e7110eab79	210	1	\N	["*"]	f	2017-07-24 14:18:40	2017-07-24 14:18:40	2017-08-08 14:18:40
b0aab4fa61b2b8fb35d39221ba71c66d54d02c5ddc54e76318b5d2a6781344e1d8d87257a1fd95ba	208	1	\N	["*"]	f	2017-07-24 14:19:03	2017-07-24 14:19:03	2017-08-08 14:19:03
a7dc555db0472f468f36d68cd51e379b9126a53edfa18b97908def4f47db54d2f02992f5aa774e03	2	1	\N	["*"]	f	2017-07-24 17:40:19	2017-07-24 17:40:19	2017-08-08 17:40:19
560a6371a70dc184dd7f0bf0c1c3d157e9c925c9238b108d494753f8b3630d87bb6533035c8573cd	208	1	\N	["*"]	f	2017-07-24 20:46:55	2017-07-24 20:46:55	2017-08-08 20:46:55
47da7fcbdd2312c4cf65b0b52054814b4cf1ee2c0c755c0e1dbe6b1d097a47cac6314df8e4141800	133	1	\N	["*"]	f	2017-07-25 06:56:42	2017-07-25 06:56:42	2017-08-09 06:56:42
421143a89f091daef031927e6101c12dbb6c74ea3ddbb3781c0f807c68dd2b5c3acb079250435702	133	1	\N	["*"]	f	2017-07-25 13:56:15	2017-07-25 13:56:15	2017-08-09 13:56:15
9fe3b0c696752079160d138fac2bf000f2a1948be3a7c3b62c04b48bbb462a333d8334710d61bb56	1	1	\N	[]	f	2017-07-25 15:35:16	2017-07-25 15:35:16	2017-08-09 15:35:16
eb4718abf758ab9395cd8f3b63f0178fe2e518786424d1c7a92b770c25bb5306c36fb36dbafd380b	157	1	\N	["*"]	f	2017-07-25 21:25:48	2017-07-25 21:25:48	2017-08-09 21:25:48
6b2620900cb2c1d771e785f0c86983a50d848f5ccd1300309039a0bed1c6045ad3c157a8e9461cd7	157	1	\N	["*"]	f	2017-07-25 21:42:08	2017-07-25 21:42:08	2017-08-09 21:42:08
6dd36ad31df8ba3abd3484bf90b40492d512352d053df9400da150f777a3a425c43175ea559a074d	208	1	\N	["*"]	f	2017-07-26 01:35:44	2017-07-26 01:35:44	2017-08-10 01:35:44
9658fae0725cb67e43b5ccce86af81d5bc38704d5514f9b312d0213451f1bc5a451e6989ee07cf1e	208	1	\N	["*"]	f	2017-07-26 01:45:55	2017-07-26 01:45:55	2017-08-10 01:45:55
db76c67d5630aa3d4e8d1224a4c8552fda6f0cb9f5883a1c9fc1303e4cff19904a2537e2f95446e3	157	1	\N	["*"]	f	2017-07-26 01:55:29	2017-07-26 01:55:29	2017-08-10 01:55:29
eb9cb951139603cd75280f2706d5cfa8f0b04aeaedf8fdbb1e14871beb9a78c6e0650a7268fecbb9	1	1	\N	[]	f	2017-07-26 08:04:50	2017-07-26 08:04:50	2017-08-10 08:04:50
91db60006353621b93202afed0c38b6025c374906b34e3ea7a79c294050ead79b992c4f1a35ad88c	133	1	\N	["*"]	f	2017-07-26 08:20:41	2017-07-26 08:20:41	2017-08-10 08:20:41
0d462ffa30e0f198d24a0553b17eacb419bdd5f327319b20d5d0c945a7c0a6b948b5c5408f3bd0e7	133	1	\N	[]	f	2017-07-26 09:51:49	2017-07-26 09:51:49	2017-08-10 09:51:49
22039af1ab768ca582e900ad19b78e0ecc9f446c126720b15f9ffa082fde5e2b5e2c6cf27b9da392	1	1	\N	[]	f	2017-07-26 12:24:40	2017-07-26 12:24:40	2017-08-10 12:24:40
4a3f50df12e9eb886780e9c22027efaf0006a257763195fb1a307026d99e0414a637b9fe9eb28d0c	210	1	\N	["*"]	f	2017-07-26 13:11:32	2017-07-26 13:11:32	2017-08-10 13:11:32
f5f061c2236afd5067558e2d68f6dbb3a89f2e0e90b69ed67cfbc05c856aeb7e4c65aeebc774554f	211	1	\N	["*"]	f	2017-07-26 13:11:52	2017-07-26 13:11:52	2017-08-10 13:11:52
c5fbd279f7a24084ec5b36a9ff6210e1841b9513d547e1429d8142a3687dc982bb4b68442fdcfd8a	212	1	\N	["*"]	f	2017-07-26 13:12:26	2017-07-26 13:12:26	2017-08-10 13:12:26
01f1fc2c3319b6bd6168638eb4729ba561997a5256d4f1c48e3365ded36c12db0c163ada23f019f6	209	1	\N	["*"]	f	2017-07-26 13:12:59	2017-07-26 13:12:59	2017-08-10 13:12:59
8e93c726bb6412794cb25d87e698f1988f33bd303333d374dc19e4bc927add4e3a15285d32e9ed49	209	1	\N	["*"]	f	2017-07-26 13:13:12	2017-07-26 13:13:12	2017-08-10 13:13:12
242d4bf0d1db8b91dbcce21333fe0b045100675d223203d3697143a00e80768c113210605c4ded1d	133	1	\N	["*"]	f	2017-07-26 14:28:25	2017-07-26 14:28:25	2017-08-10 14:28:25
ed3f0f3d385882c68d5ee11288964c76792d868dae9b269b8b0ac9b306e3abcd5d8c5c4080e8a10f	135	1	\N	["*"]	f	2017-07-26 14:30:17	2017-07-26 14:30:17	2017-08-10 14:30:17
836f6eead946a7dd0f8497205bff5a7e7a91b65c2a5d8687ba6db671c0d4bfb0b93664a8d3ef476e	209	1	\N	["*"]	f	2017-07-26 15:40:53	2017-07-26 15:40:53	2017-08-10 15:40:53
dc624b492d6a8201a23dc80b06976c4237cf17556b779c10cd7642aa003bfc009dbbb0c960354f46	157	1	\N	["*"]	f	2017-07-26 15:59:07	2017-07-26 15:59:07	2017-08-10 15:59:07
a7463955febfbde3c88a8ff421e1f9dbc225ca368ca98b1d21a99cea8f43277ead1921a1feb9a31c	208	1	\N	["*"]	f	2017-07-26 19:50:33	2017-07-26 19:50:33	2017-08-10 19:50:33
85557ba589f9fe0fa2fcff25a6424beba9c9b93924e9a21a237adca30e5750e8c46453a88f38d8c6	208	1	\N	["*"]	f	2017-07-26 19:54:27	2017-07-26 19:54:27	2017-08-10 19:54:27
659a6b62326cffae19051e1a358c385f3e7e9602b5c79791e1d7ecd5d6b2bb8cd8284af9e2cf8ee9	209	1	\N	["*"]	f	2017-07-26 21:32:16	2017-07-26 21:32:16	2017-08-10 21:32:16
fbfb41bde67f886e9797a2b70e1160b06101454aab313f0fd1757521396a7cd963bcc351004c115a	210	1	\N	["*"]	f	2017-07-26 21:32:33	2017-07-26 21:32:33	2017-08-10 21:32:33
36ccf684be7c7001994dcc766a9007f3ebbf07fc7f59712f192ba393b8a747d8f6ef385058c0336d	211	1	\N	["*"]	f	2017-07-26 21:32:51	2017-07-26 21:32:51	2017-08-10 21:32:51
e314abd12d1bf04e1c9f9390c456b874a448c3c6ce60541098d424c62f601de6e443812ed255b592	212	1	\N	["*"]	f	2017-07-26 21:33:09	2017-07-26 21:33:09	2017-08-10 21:33:09
0435b62fa24212919cbf712a226f7aaeb3f5d577964c5956f7732862c47d2d7aceeda940fcc4ed5e	212	1	\N	["*"]	f	2017-07-26 21:36:52	2017-07-26 21:36:52	2017-08-10 21:36:52
c869559a9876b8e3e1895bec3c419cffa17deb0a06926e1681db4f45eece626ebab651d5b9d2488b	157	1	\N	["*"]	f	2017-07-26 23:41:54	2017-07-26 23:41:54	2017-08-10 23:41:54
9bee695e4bc802d081169824dc313d5d025b49ab1ef94d57da5076a0a4158050efa8b34fe61902e2	133	1	\N	["*"]	f	2017-07-27 06:32:45	2017-07-27 06:32:45	2017-08-11 06:32:45
b3b2fc4005c69f70a210269ec417be856c68a6216520fb8e384f9df5a7d4815f6728724aa30e180b	133	1	\N	["*"]	f	2017-07-27 06:42:27	2017-07-27 06:42:27	2017-08-11 06:42:27
a842929165c23062de2b48dbdd33d0b986fe4511c36a810962020c393562cd9612e797f7d5692632	133	1	\N	["*"]	f	2017-07-27 06:53:23	2017-07-27 06:53:23	2017-08-11 06:53:23
7f4089b9c326f5a575748dd47fd5b5166a81ebd9aa33d84fa8c0872016f6aad4c1fa7a946088d1d0	133	1	\N	["*"]	f	2017-07-27 07:09:49	2017-07-27 07:09:49	2017-08-11 07:09:49
510e111e6c131cf26ebe3243c8cc99e3bc62a9eca6c448ab2d973f822cc167f4769e9ca49e041586	133	1	\N	["*"]	f	2017-07-27 07:20:27	2017-07-27 07:20:27	2017-08-11 07:20:27
1eabe621dfdd6f3a54649b862e8b09b81b91db5231966506f75bb1a5a4be5519d8a6cc063c7bc190	133	1	\N	["*"]	f	2017-07-27 07:41:31	2017-07-27 07:41:31	2017-08-11 07:41:31
312a50ea88db9027d91cb30f4d373ae7107b26f37b9f4c67407e0614c1e23358326084c4dc7c2a0e	133	1	\N	["*"]	f	2017-07-27 07:47:18	2017-07-27 07:47:18	2017-08-11 07:47:18
8e3a8c8e7b25b97c8839c88a6aacd67d23587862c7b45bdee915730ca7468e0af87d65ade6e6a1ca	160	1	\N	[]	f	2017-07-27 07:52:31	2017-07-27 07:52:31	2017-08-11 07:52:31
9a3127d81d9e742fc94d81e7b78c751946ced68d3073bc52eee9fe71c022a91ed701e275bb2f25f8	133	1	\N	["*"]	f	2017-07-27 07:54:58	2017-07-27 07:54:58	2017-08-11 07:54:58
12e1acb2000beb4cbcad00cc4cf80cbbece9efec0de68a19ecc58e4dd02336c9adbf20e70f984a87	133	1	\N	["*"]	f	2017-07-27 08:17:18	2017-07-27 08:17:18	2017-08-11 08:17:18
81515d3539082ee4de1172cbf97d12c5948267bbba557d4a6149a174765eb8af57b5b960051293ba	133	1	\N	["*"]	f	2017-07-27 08:20:58	2017-07-27 08:20:58	2017-08-11 08:20:58
c40abbd4bc9b7f6fdd088bb8cc9ae2c47ac1a721ac2f2836c94d8ee664431fe52781711efc0d9816	133	1	\N	["*"]	f	2017-07-27 09:44:16	2017-07-27 09:44:16	2017-08-11 09:44:16
45a723a2f479e056782e9c11d1569782ad1339463cb69532361108e5ed088ad86576b90a4021766a	133	1	\N	[]	f	2017-07-27 13:08:57	2017-07-27 13:08:57	2017-08-11 13:08:57
7a2ba52bb3e6d97c3049cbe9b5073f7c3558216ac743d68b77c7ea46ff96a08c4787a945c5253557	208	1	\N	["*"]	f	2017-07-27 14:03:11	2017-07-27 14:03:11	2017-08-11 14:03:11
1266d1969c34b3450ef8c1e440539220db157cc31b027413e33b295f133564d012a5b9dc3db58b6b	1	1	\N	[]	f	2017-07-27 15:32:46	2017-07-27 15:32:46	2017-08-11 15:32:46
1cb6c3da03ca916525925fe1eced035e1d7ac1c8429aa44ae7d2ee86882e217f7df17922de37f9fa	222	4	Punchcard Impersonate	[]	f	2017-07-27 16:09:13	2017-07-27 16:09:13	2027-07-27 16:09:13
e60e363f1c39ec90e532f32e8543c9da111492ed8e9a24e541852b6082a4c8dbbde4d332d4a813dc	1	1	\N	[]	f	2017-07-27 16:11:40	2017-07-27 16:11:40	2017-08-11 16:11:40
cb169c327e6ba59c6d6b683ae102db340de93254b20c6149276597a707a591aaa4a5e019edec3d32	222	4	Punchcard Impersonate	[]	f	2017-07-27 16:16:20	2017-07-27 16:16:20	2027-07-27 16:16:20
044d01df02ba0b329b6321d3ae35a59d66c03500111dfb77531f07ba2bbe083df04fc05410268ce5	157	1	\N	[]	f	2017-07-27 16:21:53	2017-07-27 16:21:53	2017-08-11 16:21:53
6053e29d9716d6be03b065d3d4f266b2e43b52b883562f0aaa7b1e37b2f1477ee6ad6b68674f4a52	222	1	\N	[]	f	2017-07-27 16:32:35	2017-07-27 16:32:35	2017-08-11 16:32:35
ab37fbc92f13cfeeb6f55ce69fb031b09808a459188614941d5e3b105a89d7ecb7b10f62b05bc71f	222	1	\N	["*"]	f	2017-07-27 16:44:00	2017-07-27 16:44:00	2017-08-11 16:44:00
fee9b379022bbb1c3b0df791852500f4d52fb18dab9c20d4f0d85000e1c68417e59e05474f1c0a72	222	1	\N	["*"]	f	2017-07-27 16:45:36	2017-07-27 16:45:36	2017-08-11 16:45:36
2dd7df53eb65d56cfbfbbbb69b3a53094dc0746d47388fdfdfed808b883243f076742521efe1317e	157	1	\N	["*"]	f	2017-07-27 16:48:19	2017-07-27 16:48:19	2017-08-11 16:48:19
5d16b68922424a963b34ccc5c50b390e6b9c20d5fa0c3787f928d85f37b9d0ffbca56ffcc35c3e0e	133	1	\N	["*"]	f	2017-07-28 07:00:55	2017-07-28 07:00:55	2017-08-12 07:00:55
a39bd234d18aab5bb4d866077bcb02b0010ddc571dbb792cf5564f147b6c651186363e5761593c03	1	1	\N	[]	f	2017-07-28 07:41:19	2017-07-28 07:41:19	2017-08-12 07:41:19
97310ce1ae9198c0845f294be9328db8c5b9bcd8172ce5ee62399d19ec0bdcbeef8cd2ff30264695	1	1	\N	[]	f	2017-07-28 09:49:06	2017-07-28 09:49:06	2017-08-12 09:49:06
1982f409f447876c2152537a27c8e5abd08e96422d1cba89e2bb80f385c5e1572f67005ee100e8fb	133	1	\N	["*"]	f	2017-07-28 10:24:30	2017-07-28 10:24:30	2017-08-12 10:24:30
b14c076346d18718c2fe59bca51090a1fd2a2e6068a7f1aa749586481987a094327873d7bb41db63	135	1	\N	["*"]	f	2017-07-28 11:03:11	2017-07-28 11:03:11	2017-08-12 11:03:11
a13413da4e2eabd9b9d865689def31a80b26f3d5192276b2334fead9f0c3c816c856bbf342c34572	160	1	\N	[]	f	2017-07-28 12:25:18	2017-07-28 12:25:18	2017-08-12 12:25:18
02164bc096a97e3478dd401c300212da72518e64dabe0714041e513ac3caf81f3f167c00b9701365	157	1	\N	[]	f	2017-07-28 12:31:42	2017-07-28 12:31:42	2017-08-12 12:31:42
749d8a48c59e010615305d443b50d8f305aad1350460df84775c3d156286debd3519c6f018f03e56	157	1	\N	[]	f	2017-07-28 12:33:24	2017-07-28 12:33:24	2017-08-12 12:33:24
0cd6a0fe991d99de1d040cc403e419bb1401059a65e6fdb8f5bef34261a23a9576d979f65018fe20	208	1	\N	["*"]	f	2017-07-28 16:43:30	2017-07-28 16:43:30	2017-08-12 16:43:30
549ad9109411d2cf4222cf3ee8fb99f5e486a0212a506eca7adcc41c28ea7513725c6567010d69c8	157	1	\N	["*"]	f	2017-07-28 18:09:43	2017-07-28 18:09:43	2017-08-12 18:09:43
37b5e6ced2520d346dffc26b993ac1237269f8ac3d8442480b3d808ed7c4ea23f718dcea1075780d	135	1	\N	["*"]	f	2017-07-29 06:08:07	2017-07-29 06:08:07	2017-08-13 06:08:07
38466759775d5c1e5f43baae33e07391ee52735889aff93587749adde6ee7fb22f11650400f36536	135	1	\N	["*"]	f	2017-07-29 06:22:59	2017-07-29 06:22:59	2017-08-13 06:22:59
3fc3e091b16243187f89eb6db7c8f77a0dc73778b9e78b4fd2667cc0107aaa05e879c57b990a8528	135	1	\N	["*"]	f	2017-07-29 06:37:56	2017-07-29 06:37:56	2017-08-13 06:37:56
89df59037c94d257b2e19de72bdde42381d343ae7b6acbb5126bc7c4d7e08eb3191f67c3a09dd467	135	1	\N	["*"]	f	2017-07-29 06:46:08	2017-07-29 06:46:08	2017-08-13 06:46:08
00aaa027e5033a914ef86726a777e545c34e5f3a6ac3c01c1c93731dd3838e151eb99e6829ba20c9	157	1	\N	["*"]	f	2017-07-31 00:20:24	2017-07-31 00:20:24	2017-08-15 00:20:24
53b0aeb7042114f849d94a704136319b03aec20a5a35b670061f4906404eba858ac0967361265caf	133	1	\N	["*"]	f	2017-07-31 06:33:19	2017-07-31 06:33:19	2017-08-15 06:33:19
f248f734a93cecdfc8d76573bd9dc57db0700b5db5a58a1dcb1e4bfd190458f4757c9e3b0d3e5265	208	1	\N	["*"]	f	2017-07-31 16:57:38	2017-07-31 16:57:38	2017-08-15 16:57:38
e80f00b24bd414f6ec6c854ed657c79f714a30eeb74967ae7ca6b4ab7b82c9efdcd4795fb2abe274	157	1	\N	[]	f	2017-07-31 17:12:01	2017-07-31 17:12:01	2017-08-15 17:12:01
6cb3978509962186c54cf6ac4f36cb78bbc1289fb07c07b401e58ccbbd2b94b7405b0ff06cf09e83	208	1	\N	["*"]	f	2017-07-31 18:11:37	2017-07-31 18:11:37	2017-08-15 18:11:37
1ea4bfc5cd1f844f99981a79d25b000f40dd81308f6741929cb62d4eee0295d878339e396a00051e	208	1	\N	["*"]	f	2017-07-31 18:12:28	2017-07-31 18:12:28	2017-08-15 18:12:28
003ea5d7c1f0c97d2200103caa93360b482ade363c9f517c177a177258133f8ea4c2f161dbf349a1	208	1	\N	["*"]	f	2017-07-31 19:24:40	2017-07-31 19:24:40	2017-08-15 19:24:40
887cf1607199a80bfdd7c85c074cae60cf048d2b8bae55b50e03631b53a5b8147f01fb42b673e90a	208	1	\N	["*"]	f	2017-07-31 19:25:14	2017-07-31 19:25:14	2017-08-15 19:25:14
17946d71540945116c9bf15c7c61f53631c1376aaabb9dda8177549c03b7e41c16ce4088ab8a205c	223	1	\N	["*"]	f	2017-07-31 19:30:14	2017-07-31 19:30:14	2017-08-15 19:30:14
0a25905ac43da5bab89e78331433876c9846360d5ddac09ba94129be69d4fea00cc1f6d7a46aefd6	133	1	\N	["*"]	f	2017-08-01 06:54:31	2017-08-01 06:54:31	2017-08-16 06:54:31
d854cc37eb930194d50ef8ee025023bcdf6085014f99e5fb989839d68227fc0d7923f856bb264b1a	135	1	\N	["*"]	f	2017-08-01 09:28:33	2017-08-01 09:28:33	2017-08-16 09:28:33
1851c8db28c97e0d21a3739d6dd9050f1658cd0e60911dfb0305f2ba52e824f50cc4beedc7cd9395	208	1	\N	[]	f	2017-08-01 16:30:03	2017-08-01 16:30:03	2017-08-16 16:30:03
e7b76e6350801f14097422316d9bf87c19995a62f13c1ac1b9a70fbb7f9617a5e62b4c93a45464ef	223	1	\N	["*"]	f	2017-08-01 17:09:38	2017-08-01 17:09:38	2017-08-16 17:09:38
31675fb85f1a4d8735fa8f3ac8399d8a9c36165ab4b082058065b483d100c270a8aeff6754b9aae6	223	1	\N	["*"]	f	2017-08-01 18:09:50	2017-08-01 18:09:50	2017-08-16 18:09:50
6f549c3f638ad73f8dc5f75da934a44d5b0d1de212d850204abdf32d5f1004b794fa95df608c4578	223	1	\N	["*"]	f	2017-08-01 22:00:39	2017-08-01 22:00:39	2017-08-16 22:00:39
a6b50e8ef39bee4165b8abac877f6be5f0dbfa6811405b6f39a6756dba0dda9eba537515103116ac	223	1	\N	["*"]	f	2017-08-01 22:20:24	2017-08-01 22:20:24	2017-08-16 22:20:24
5758cb30245d0ac2857f7edcce75f83af9d4206c149ac87cde9420aa36dc60d85222eb98d5265de6	223	1	\N	["*"]	f	2017-08-01 22:21:29	2017-08-01 22:21:29	2017-08-16 22:21:29
cf0f799ca6e824b257dd3fe9ddc01a1a5540aeec763d7710f0a9d5d308c03b1f9050dcd5f1fcf530	160	1	\N	[]	f	2017-08-03 08:36:34	2017-08-03 08:36:34	2017-08-18 08:36:34
0176cbc846f60a93e7d1126c009258114c9cbc2be2afb586b460cd796b685930c215515449af49f7	135	1	\N	["*"]	f	2017-08-03 09:54:16	2017-08-03 09:54:16	2017-08-18 09:54:16
3f36121ea632fd973536f1f5191bd1f40261af8d3e31ae7f2932c990e9e1a2e97e3c4cc3ad565765	133	1	\N	["*"]	f	2017-08-03 11:05:59	2017-08-03 11:05:59	2017-08-18 11:05:59
61e5ca716b9e75e30647a8db87f2a006582f5cb021f1daef8cc27dbe37cc83f05984251e71dbc977	135	1	\N	["*"]	f	2017-08-03 11:08:12	2017-08-03 11:08:12	2017-08-18 11:08:12
76115d1ae82006138eff8dc6af15f265cc5ff9fca3784a8cdd12be68b942f630dda4ce7d0064e359	133	1	\N	["*"]	f	2017-08-03 14:02:56	2017-08-03 14:02:56	2017-08-18 14:02:56
395828d8733b30b27af5b5c71d7186df8eaca242f33424c1fc4abf3344af9f6a100bda870f605acd	208	1	\N	["*"]	f	2017-08-03 14:21:05	2017-08-03 14:21:05	2017-08-18 14:21:05
cf9a136f6d54dd7b15dc90ae253753c062b09c695a9e1d531665f967df9655c1571c41b9d878da87	135	1	\N	["*"]	f	2017-08-04 10:29:50	2017-08-04 10:29:50	2017-08-19 10:29:50
024f038a6c42b6ff826993f0157824b9a560198ce5e6a909a8d3756a84fd1b23b7b85841746c5d84	2	1	\N	[]	f	2017-08-04 13:55:04	2017-08-04 13:55:04	2017-08-19 13:55:04
f1fb33d0b945362bc656f08e9f4d7a69b65e04db9f3ddfc4f4c90348e1b673b8b0222c8fb7b982ff	2	1	\N	[]	f	2017-08-04 13:57:47	2017-08-04 13:57:47	2017-08-19 13:57:47
0a4e4bf7efd1c11bdb4d59dd4296c9417f9fb131a004860093efebdcb1fd5ee0c4ef8dd71ff2b68c	135	1	\N	["*"]	f	2017-08-04 14:00:12	2017-08-04 14:00:12	2017-08-19 14:00:12
92ddbc21a4d26b79195dd76b06fa9000fd190b4f179c45bc61f83a4861e11de8dc21316060a9bc7c	160	1	\N	[]	f	2017-08-05 07:19:24	2017-08-05 07:19:24	2017-08-20 07:19:24
07c122173cbe4c512cbac482152d762f959ed09108a46de517a124ac8e1ccf8cd87fb5ede6aef8c0	208	1	\N	["*"]	f	2017-08-07 13:14:39	2017-08-07 13:14:39	2017-08-22 13:14:39
971f51692a89c55d03a77d2a0dde1d6ad0f5127a5c0adf697eb93adafac617025cbbf6ebf45cad69	208	1	\N	["*"]	f	2017-08-07 13:15:06	2017-08-07 13:15:06	2017-08-22 13:15:06
a5c377307f5255e540235339a9168a9a8f806adb3977d8cf5e48c8fdfaf5c80f923101bba839ee50	223	1	\N	["*"]	f	2017-08-07 13:23:09	2017-08-07 13:23:09	2017-08-22 13:23:09
f88fc68381d3a8e4b5bb1ab446179e7a295c69696fb607204b05c653c6e9535ce272c3b374c7b325	223	1	\N	["*"]	f	2017-08-08 18:53:10	2017-08-08 18:53:10	2017-08-23 18:53:10
86c59b04852f2bc418e257e1874beae5ddce893764f4cbfe3f62c1f85832244d64f68c5685b6bf85	223	1	\N	["*"]	f	2017-08-08 19:01:00	2017-08-08 19:01:00	2017-08-23 19:01:00
adb65b0ea48d0cae7abbd68bf24249b483407bf94f133a60fc86b363ffa6777831996ec75ff7087b	223	1	\N	["*"]	f	2017-08-08 19:01:57	2017-08-08 19:01:57	2017-08-23 19:01:57
0c8f7a898f0b4f9e2797f2f84a91f1489246073f0cf728686f441db8390b37f883158d3e11546715	135	1	\N	["*"]	f	2017-08-09 12:14:17	2017-08-09 12:14:17	2017-08-24 12:14:17
3ee5e815d1f78b3d8859a18f0293dd6ada56d7b84611f1dffe9c81f1fe8ce2693d05cf42d9c2ce73	135	1	\N	["*"]	f	2017-08-09 14:10:19	2017-08-09 14:10:19	2017-08-24 14:10:19
433d6de1dd054625a3783fb0ecf1e92a8f998fa0361787089e5ad23908137732f03837b8855cf7a9	223	1	\N	["*"]	f	2017-08-09 14:28:20	2017-08-09 14:28:20	2017-08-24 14:28:20
4ea00bc6977f4a89e960fb3e72ca2d8fa31c195a8a78963578489d4b205d9488cf3875d1d0be1d37	157	1	\N	["*"]	f	2017-08-09 15:18:27	2017-08-09 15:18:27	2017-08-24 15:18:27
377254ba3f6b70d660b04b398096555e037ca2e777c4707ead4cac3f36ccba5a8ed828d151439876	170	1	\N	[]	f	2017-08-09 15:20:02	2017-08-09 15:20:02	2017-08-24 15:20:02
913064bf159ce2e3cd3eca730c4643c949e3fd155587b9fa09b21c09c11ad11ad936b8fc7b57f299	173	1	\N	[]	f	2017-08-09 15:20:19	2017-08-09 15:20:19	2017-08-24 15:20:19
d9558206b8bb190f99dfde05dbe223fcc1c59fc7d7f3d669a662b48f9b994c7d9850df3839a47aa1	173	1	\N	["*"]	f	2017-08-09 15:25:27	2017-08-09 15:25:27	2017-08-24 15:25:27
3ac2cf914f25b148b8d62f080bdf75f58841e2f207f6491ffd2cd98eac931d9b3b7c3b145bc404f9	157	1	\N	[]	f	2017-08-09 15:26:03	2017-08-09 15:26:03	2017-08-24 15:26:03
5bca9d4472dcdfbb01ce8a0e116e5cb5af22195a0edf4da270b0c63dcc90e87c1a50712250398b18	157	1	\N	["*"]	f	2017-08-09 15:26:39	2017-08-09 15:26:39	2017-08-24 15:26:39
d1f61c17edfc234334415fd048c0da60e9d91d23bd4d2c5d5c1e72816ea96632b87868c88815f807	170	1	\N	[]	f	2017-08-09 15:27:08	2017-08-09 15:27:08	2017-08-24 15:27:08
0c1fcd355576561905c1f4cd5f0330b9bd147ee3325b351c7c735eb9802eb3d61b0a91f81af48c56	170	1	\N	["*"]	f	2017-08-09 15:27:52	2017-08-09 15:27:52	2017-08-24 15:27:52
d2965da26543cfb09be65d5a0e01ed81922125ef63c9daa31cafd67c58fff5ae187e77a8c10be699	203	1	\N	["*"]	f	2017-08-09 15:28:51	2017-08-09 15:28:51	2017-08-24 15:28:51
bb6f71f618e18210f49eb6e451635e524a0a0d0a962c89140016999bdb490059ca08e9d19bd45c28	157	1	\N	[]	f	2017-08-09 15:29:52	2017-08-09 15:29:52	2017-08-24 15:29:52
374c0f37b449229a39ac60dfd81be4594725efc98d6712e6fff61f4414e78c0dc303834c48951a92	157	1	\N	["*"]	f	2017-08-09 15:31:49	2017-08-09 15:31:49	2017-08-24 15:31:49
94eb573917be2521c86b2de4d8f5468b7df800ae5554354f1c7dd293c51c4afe767d7dc3d19eb167	173	1	\N	[]	f	2017-08-09 15:32:33	2017-08-09 15:32:33	2017-08-24 15:32:33
34d5a2c00880770703b4b5ca598d5e9d892ccc9e9287d193c075659f64d81600db775488c3eeab75	223	1	\N	["*"]	f	2017-08-09 16:50:38	2017-08-09 16:50:38	2017-08-24 16:50:38
08a54a4fe134416c32c2846e042dc54e7db57573efbc9ab5c3a598753bd59ba2182c0c17c243227c	135	1	\N	["*"]	f	2017-08-10 06:47:28	2017-08-10 06:47:28	2017-08-25 06:47:28
a5b6b16a16f6f5cabf0014891099938da6c7af15bba494aced3d1d25217ecec1b036b49e759c7760	135	1	\N	["*"]	f	2017-08-10 07:06:37	2017-08-10 07:06:37	2017-08-25 07:06:37
8fdb2586e4ec45ce1ccf14aa1f2476e9e2fede34ebce3a3284f82dcaa7d043151e5413a7a0fc2b97	133	1	\N	[]	f	2017-08-10 13:33:56	2017-08-10 13:33:56	2017-08-25 13:33:56
10ae82d3610dd0006f4d768a0d83fb658a820622ab3f0e7ebecf9166b19b806522013d982b8bbf68	135	1	\N	["*"]	f	2017-08-11 06:45:59	2017-08-11 06:45:59	2017-08-26 06:45:59
380ed91dcb45594b8a6af2f66b66927e377b9595735279bb0492d2050374719634d214b136d15bf0	208	1	\N	[]	f	2017-08-11 14:23:42	2017-08-11 14:23:42	2017-08-26 14:23:42
e01631dd79916f5cb11cd396b3f1c3a44acf0ae97a7ab60601cfff8972c9c7492dcd97208bcf5753	157	1	\N	[]	f	2017-08-11 14:24:09	2017-08-11 14:24:09	2017-08-26 14:24:09
7b8301abba3eeb42947aea30cdec02746cc104a04b6094b7dbea76bc82f4fcf3c8d5fe3b36cb2969	208	1	\N	[]	f	2017-08-11 14:24:14	2017-08-11 14:24:14	2017-08-26 14:24:14
a9fbeb77ccc0392b5b13b00cb24da10c3ae24ddf64b8ed45b5fc5359d12c8ac610789c5f3e334222	173	1	\N	[]	f	2017-08-11 14:24:54	2017-08-11 14:24:54	2017-08-26 14:24:54
7d8706af961c8a7e928d8aae0e1e4fded91b2f787537b847261eadc3c3943bc0294379b0dafb698e	157	1	\N	[]	f	2017-08-11 14:25:10	2017-08-11 14:25:10	2017-08-26 14:25:10
0e3f5ac812ba5a6660a362c6e6a4ed6a298d83a3fb1a6d27cf75c5452906807a9764561e37ce4e31	157	1	\N	["*"]	f	2017-08-11 15:13:35	2017-08-11 15:13:35	2017-08-26 15:13:35
c7795325310b4d4ac9db127b6712b27313fa32b3879f654fed31663ac3e40d68272a52c80c448614	173	1	\N	[]	f	2017-08-11 15:14:52	2017-08-11 15:14:52	2017-08-26 15:14:52
2a818e041b0a0a925b69f408cdbd12f3a5806f015e75cf15e7ac5a762cf75eaa1333e7b9040adf20	157	1	\N	[]	f	2017-08-11 15:17:03	2017-08-11 15:17:03	2017-08-26 15:17:03
1236101f4f0e37b28654bc3a17576ca20cebff3fd683d3b59f8eb6485a3462ea8b24b0d6cc7edaa3	173	1	\N	["*"]	f	2017-08-11 15:19:19	2017-08-11 15:19:19	2017-08-26 15:19:19
c52eb69a6b78a1afd328e2bdea96fcd304ba89d9bae7caa037bce38cce8576cdc018bffa92cffb22	157	1	\N	["*"]	f	2017-08-11 15:20:19	2017-08-11 15:20:19	2017-08-26 15:20:19
3a756b977dd4510a696d574b7b2f32bc0098d01d42700786b5b07c7336a40f70ad7274e88a832a6e	223	1	\N	["*"]	f	2017-08-11 15:21:11	2017-08-11 15:21:11	2017-08-26 15:21:11
0ad5b84c745d908a69d004ecd684e33b33a89e8540b9dba9ada620564a5941a90f877c0e6426d24c	223	1	\N	["*"]	f	2017-08-11 15:22:58	2017-08-11 15:22:58	2017-08-26 15:22:58
bfecaef8f52d212ef254242b2174b473f25dcc6226dcf79d5a0584b4363f89a37d827aa066121ffc	157	1	\N	[]	f	2017-08-11 15:36:08	2017-08-11 15:36:08	2017-08-26 15:36:08
d7568d4366a52f871c2488d0632906209a59b798d29ffbe21bf728f621c8ef537b1e4080f5a6503a	157	1	\N	["*"]	f	2017-08-11 15:36:46	2017-08-11 15:36:46	2017-08-26 15:36:46
6a248bbb8a3ffb32515d9de16166bac9fdc744d81322668c748b967b2c28288b3d7dc7b07b9bba7b	203	1	\N	[]	f	2017-08-11 15:38:35	2017-08-11 15:38:35	2017-08-26 15:38:35
3d86c61d2b7aba491b59be4977c29edcfb5bd5af98046ffc86aff666688d79a40687342d76db2136	203	1	\N	[]	f	2017-08-11 15:40:42	2017-08-11 15:40:42	2017-08-26 15:40:42
ec88178229121305b27792ef9dc4f719e55df0629d2c191bb6c84a421d5681fc31388de4d220bfb0	157	1	\N	["*"]	f	2017-08-11 15:46:47	2017-08-11 15:46:47	2017-08-26 15:46:47
2c9245516a3927d1e1c46ba24d2124e6c68c778022bb29be0b5ae8d2c12d5bada407f75da6f27155	157	1	\N	["*"]	f	2017-08-11 15:50:20	2017-08-11 15:50:20	2017-08-26 15:50:20
0f7d0cbddec84ba1b677dfdb6f0d900e099472d828c174fe07afcbd1720351bb2e08f35bf085ce6b	203	1	\N	["*"]	f	2017-08-11 15:52:21	2017-08-11 15:52:21	2017-08-26 15:52:21
f2d50d3a7c204cb3796deaee74cf844ecc8038ca9f237b2292570aac82cea9c5063802abefa183d7	157	1	\N	[]	f	2017-08-11 15:57:02	2017-08-11 15:57:02	2017-08-26 15:57:02
b1ccdadf0a57197e71e2c2dcb96eb689b22014344e006424297e342fd810126188230f6ea984c16e	203	1	\N	[]	f	2017-08-11 21:22:07	2017-08-11 21:22:07	2017-08-26 21:22:07
8efcfcfa59d2358330434203d62a7456e962dfdf96f6a84568cef15bb4f4f3b7e1e9d69e8eea0e2a	157	1	\N	["*"]	f	2017-08-11 21:24:00	2017-08-11 21:24:00	2017-08-26 21:24:00
dcb1335f12d9bc149ea650f27180cc8553166309aa5dcaed83add9d5c246ac63d3ff3ef104b47eb6	157	1	\N	[]	f	2017-08-11 21:27:15	2017-08-11 21:27:15	2017-08-26 21:27:15
8dbb1aa9576160302e2116000084be44c4b809a52d50814d62fea4f75a64e9f401db2c6e8fc6d4f7	133	1	\N	["*"]	f	2017-08-16 11:54:55	2017-08-16 11:54:55	2017-08-31 11:54:55
db0a5c88894652caecec769664ceea49a0d2154775e1677dc4454cc88275ea02587ce85940bcf32f	203	1	\N	[]	f	2017-08-16 15:39:02	2017-08-16 15:39:02	2017-08-31 15:39:02
bdbfdea3c223e911b852eec4124b7afd73cf8e1d366ca40b29e1a524787009c909d769045927cf6e	157	1	\N	[]	f	2017-08-16 15:39:19	2017-08-16 15:39:19	2017-08-31 15:39:19
18bc6373811f23123f5f13fa5761fc29ece3279c284791f3a495d2e5d1073aefb871b7fc8231773b	157	1	\N	["*"]	f	2017-08-16 15:42:12	2017-08-16 15:42:12	2017-08-31 15:42:12
297ebfd6f7cfaaef7ea81a7ee355110e924199908b3e6dcc7fe7e902676dd94cd32a940090104bdb	208	1	\N	[]	f	2017-08-16 16:32:00	2017-08-16 16:32:00	2017-08-31 16:32:00
983f8c78652b9f2226a36a361d8c88edfb98fdd82f04ad7940a799ae90eb90508c5b3dcbe03ac883	133	1	\N	["*"]	f	2017-08-17 06:42:39	2017-08-17 06:42:39	2017-09-01 06:42:39
c9433a79dc0fab0f657699b5c459fe06938fe661ff7deaa9313b72689525e402cc078848093f06a6	135	1	\N	["*"]	f	2017-08-17 06:59:58	2017-08-17 06:59:58	2017-09-01 06:59:58
f4091a9e00e2f45a84cada0cbbdf24b9f9d6686515ba868238a5a6aad4aec08175c4329d7276770e	133	1	\N	["*"]	f	2017-08-17 07:01:35	2017-08-17 07:01:35	2017-09-01 07:01:35
d3fe0c6e021bc3ae301263895e158195d83b871f200af9cf11c028d147f306e5a56e0d7596abfd6d	135	1	\N	["*"]	f	2017-08-17 07:04:07	2017-08-17 07:04:07	2017-09-01 07:04:07
53d9a652e3353ecc8b8d922b42c9746755f4816fb8e8c38e078b6684f16902138a4b611c534edb31	135	1	\N	["*"]	f	2017-08-17 07:13:20	2017-08-17 07:13:20	2017-09-01 07:13:20
ca146af47969553753195dc92161111bc0529adb51e1771f4eb0b54f7882f4edabc968708c0c569c	133	1	\N	["*"]	f	2017-08-17 07:29:32	2017-08-17 07:29:32	2017-09-01 07:29:32
c0352b8f7360cae02635c647913cebef47c38b73527a8e5d4c68e00406ad021bf1a71eed0ace5b8a	133	1	\N	["*"]	f	2017-08-17 11:04:23	2017-08-17 11:04:23	2017-09-01 11:04:23
b248dfed4e5132d7f8827fde78fad34539d80047a874e02844e59b63f980fb8a9b955825c811dab6	157	1	\N	[]	f	2017-08-17 13:31:02	2017-08-17 13:31:02	2017-09-01 13:31:02
543fef5a53de34f20a12d57b6ab2ceb881494bdb6a4b6f45da2157d3212e9b2a5e6312133e913c0a	1	1	\N	[]	f	2017-08-17 13:44:35	2017-08-17 13:44:35	2017-09-01 13:44:35
9bdfad983f0f00090f6809c219bf604e1dbac5c333fdb9e1e98649c4b379999d36a8e07cddcef71b	222	1	\N	[]	f	2017-08-17 13:45:15	2017-08-17 13:45:15	2017-09-01 13:45:15
f7f74e9c6fbbfc9d2d105d966d0e277a8fd0ab4919bdebe909801706d50927b22394ec246c3bbc52	157	1	\N	[]	f	2017-08-17 13:49:08	2017-08-17 13:49:08	2017-09-01 13:49:08
9eb17449925133d66ebba02d34e70d5bb573bf309f9fcdf15d4270b1c4025841fa0cf93c700395bb	157	1	\N	["*"]	f	2017-08-17 14:14:39	2017-08-17 14:14:39	2017-09-01 14:14:39
28527938c6ca566db0bea37158c4c956d65de101178ae5b89977e6982d43075c9f45ed965bc479f5	208	1	\N	["*"]	f	2017-08-17 14:32:09	2017-08-17 14:32:09	2017-09-01 14:32:09
e391d9d9a6ac4519ff14ef64968e017b6855940fff59f91a7b12ed1af29580065e879e86a67be035	223	1	\N	["*"]	f	2017-08-17 14:33:20	2017-08-17 14:33:20	2017-09-01 14:33:20
15608152006cb44532841e557dcf196530da797240cfb8491c1225756f172ee449e8c421304a9fc7	223	1	\N	["*"]	f	2017-08-17 14:33:41	2017-08-17 14:33:41	2017-09-01 14:33:41
a4c040b335aa9f1442422aeb4d290944b8da5a97f47ae2c19a61f073a97d1cf1f43ca75950560f9f	208	1	\N	[]	f	2017-08-17 14:42:47	2017-08-17 14:42:47	2017-09-01 14:42:47
af161fa3f084a7ea76d970d76d20a876b00560ebba7cda8f300d98f2c734d2a07112cc4592535934	170	1	\N	["*"]	f	2017-08-17 14:44:54	2017-08-17 14:44:54	2017-09-01 14:44:54
81ba47a5d9fcc67d3667ae0c50752155d83f79e1030f5564b309ae8345fac534b38b6642571b1f27	173	1	\N	["*"]	f	2017-08-17 14:45:20	2017-08-17 14:45:20	2017-09-01 14:45:20
aa81c13dc749c4967168fbf3ef0bccc44ab00f43f27d389f0f5c6379493abc3b3ba72cc5476044eb	178	1	\N	["*"]	f	2017-08-17 14:45:53	2017-08-17 14:45:53	2017-09-01 14:45:53
f84f3bd9636d9321f33cc1cd196a76e1a3e55020239360b3e42043f7ccd2053ee9ece683a621ee8d	183	1	\N	["*"]	f	2017-08-17 14:46:22	2017-08-17 14:46:22	2017-09-01 14:46:22
1bef5be2e3cda7237c24cd9f5ebddc06f2d2575ee1f09686491a4775df5e3b2296f760cdb6f96461	210	1	\N	["*"]	f	2017-08-17 14:47:36	2017-08-17 14:47:36	2017-09-01 14:47:36
89df721971951bb1d16cc78e35cd4e6f545cb98d7237db66a464575e69c561768eb6bef4a724894c	183	1	\N	["*"]	f	2017-08-17 14:48:16	2017-08-17 14:48:16	2017-09-01 14:48:16
8c49207552db352da6516c66d38e72e971373eb39f8c28ccadc5a1c14030fb0902a68c8220c03093	183	1	\N	["*"]	f	2017-08-17 15:08:40	2017-08-17 15:08:40	2017-09-01 15:08:40
07d4e1208b1ac8c0fa8a9dfea9989985eeee5861f7690134f4e8e578b9f578757e022ba761a23166	183	1	\N	["*"]	f	2017-08-17 15:12:21	2017-08-17 15:12:21	2017-09-01 15:12:21
6452e28f9ff74a2759fd93191fb055911ffd1c78ec7d006b587ffbd75c7f094eee8311b56aa78ae2	183	1	\N	["*"]	f	2017-08-17 15:18:22	2017-08-17 15:18:22	2017-09-01 15:18:22
b054553760e8fae087fc0f4a61cd2f7fb952a686fc877d2e0a0b4269b0608d4b08355671b75dea11	157	1	\N	["*"]	f	2017-08-17 15:19:12	2017-08-17 15:19:12	2017-09-01 15:19:12
7348b23f7806ec634502e031c72c2655645fbf821a88ea5a9bb0568b715ed4a37d4be3675432a483	183	1	\N	["*"]	f	2017-08-17 15:26:55	2017-08-17 15:26:55	2017-09-01 15:26:55
49f6cda702d1a1a74b0ecff852b51fba4d8f776bd0414cf6d00f612ccf000db729b828f19b1d6c5d	183	1	\N	["*"]	f	2017-08-17 15:28:44	2017-08-17 15:28:44	2017-09-01 15:28:44
0da80ae2ef417fa0330744d5e0ff611f28f0891f96f3b71b331e4fa4b2e8c487c39d297a9a96a738	183	1	\N	["*"]	f	2017-08-17 15:29:30	2017-08-17 15:29:30	2017-09-01 15:29:30
b4b9f595c033ea9143ba7a61864f9f7377433681d5f67a5ac48d18d6a34da8c2ae04756e2f190307	183	1	\N	["*"]	f	2017-08-17 15:30:26	2017-08-17 15:30:26	2017-09-01 15:30:26
35172ffc879d1427e2d90e1e5d0f7c43cba30ce33152e3eed1aba8fe6b349f6b67f432ee32c9bf14	183	1	\N	["*"]	f	2017-08-17 15:30:55	2017-08-17 15:30:55	2017-09-01 15:30:55
877a4ac17ece80a73c6db8382f34573aedd3f882cc77f1056ba54b93d20a16ae947f02f4a65ddc1f	183	1	\N	["*"]	f	2017-08-17 15:31:23	2017-08-17 15:31:23	2017-09-01 15:31:23
c15d9fc0142980500c116e85b116e6b8b054b16e3e23dce414f5b36b1dd5d6771b618ff24f2644a3	183	1	\N	["*"]	f	2017-08-17 15:31:51	2017-08-17 15:31:51	2017-09-01 15:31:51
8e9680bc83f4ceaef39e4a466ae18f2b1625a201b85a167318a1f5eeabfb800ac9018c3663385162	183	1	\N	["*"]	f	2017-08-17 15:39:28	2017-08-17 15:39:28	2017-09-01 15:39:28
88d04c030adbc6bed38c28c44adf520b074fb7a3f33f2183c4d5aa95902bf3be4fba10710659e668	210	1	\N	["*"]	f	2017-08-17 15:42:02	2017-08-17 15:42:02	2017-09-01 15:42:02
f591074c44fdd915fcb4bc482eb74f894664e00b44ca7d0c5115978193dd34f836709367d7c46c37	210	1	\N	["*"]	f	2017-08-17 15:45:07	2017-08-17 15:45:07	2017-09-01 15:45:07
54d3c2616c1c5d8d950f220b3d6325a284501afd2ad5cbe704ba4f9cc51e790b0cff87b67850a02f	183	1	\N	["*"]	f	2017-08-17 15:47:23	2017-08-17 15:47:23	2017-09-01 15:47:23
072c4d67b7785022da32287c509a1bb1d7226d64ceef05dd2be67c0859ed9a9aa46b06f6a6c619b7	183	1	\N	["*"]	f	2017-08-17 15:50:02	2017-08-17 15:50:02	2017-09-01 15:50:02
86309f121ef3123c2249a095cd3e3ab7f6559a02a4a74519aaad42e15febb2058fe27cb857ecfc1c	210	1	\N	["*"]	f	2017-08-17 16:34:48	2017-08-17 16:34:48	2017-09-01 16:34:48
c6a16711f37a34c79fc3cba0276d70dee9b3e1f8e81130ee06a26cd2a7fd18f9ab868504d831f4f7	210	1	\N	["*"]	f	2017-08-17 16:41:52	2017-08-17 16:41:52	2017-09-01 16:41:52
1b833690b2cfbd743c88bd1922891502cb592189f896b88d22bbf899d10c9ccfbdb62e908988e555	210	1	\N	["*"]	f	2017-08-17 17:08:15	2017-08-17 17:08:15	2017-09-01 17:08:15
54ac886c918a5f86acef9cb1ca89b961e5a8153898b84e80074b23cc58726b211d10d9f04aad83e5	210	1	\N	["*"]	f	2017-08-17 17:09:55	2017-08-17 17:09:55	2017-09-01 17:09:55
14ce9e9d1650766119e68e7e9087e4ab89383ed3f288acd00f3249c34101ebdd82133f133891fa3e	135	1	\N	["*"]	f	2017-08-18 06:57:41	2017-08-18 06:57:41	2017-09-02 06:57:41
cecc868e7f597f47cf24a8dcfbee41b07531921fd6f27a9b9220add62ca8e3a9aeea46ccfe52f013	210	1	\N	["*"]	f	2017-08-18 18:38:16	2017-08-18 18:38:16	2017-09-02 18:38:16
3a1de670044ca5d7f25cc9f67b90dc5a0d49b8c4e89a20779b97e5954cc6b4a328f59efd5fd005af	1	1	\N	[]	f	2017-08-19 07:22:13	2017-08-19 07:22:13	2017-09-03 07:22:13
a16482f198ff5f47e5542736f4f30e38dd87ec0b7b9894a66bbee58cde2fd35580259829af4e882b	1	1	\N	[]	f	2017-08-19 07:24:56	2017-08-19 07:24:56	2017-09-03 07:24:56
064870647bdb52293998205a6ee3d1792b89bcb38fdf6742b8a51a49ecf5cadefb00b18c72a77871	224	1	\N	[]	f	2017-08-19 07:31:26	2017-08-19 07:31:26	2017-09-03 07:31:26
3ca54cbff5e5acad3994dfe149e0a83189ab561cf1a2d7b0168bfd496353d851c2fd7975bd19776d	135	1	\N	[]	f	2017-08-19 11:17:47	2017-08-19 11:17:47	2017-09-03 11:17:47
8a6756d5b075d75f7e407ab7e72dc72ddb806d49e2ca33ecc41c0fc2edd5f046c031f7e46ba0f1c1	135	1	\N	[]	f	2017-08-19 11:18:54	2017-08-19 11:18:54	2017-09-03 11:18:54
3eb52a176f23ffc43dc90c9804209ffb32bfa2ef0384adec81ed5a3fd0c612b66936dab8f9bd9bb5	135	1	\N	["*"]	f	2017-08-19 11:21:04	2017-08-19 11:21:04	2017-09-03 11:21:04
c4cbbe7fa38c51e10772c439f42ec750b88f209211b784b5c4f4b40f01edccba6c5a36a26a29e0d4	135	1	\N	["*"]	f	2017-08-19 11:34:44	2017-08-19 11:34:44	2017-09-03 11:34:44
a7368493ba880e89bdab518e8793c17cfb0da056ff592c5f55e624c1ae479ba3b56f021549ef81d4	160	1	\N	[]	f	2017-08-21 10:17:53	2017-08-21 10:17:53	2017-09-05 10:17:53
81754238ab77381d5efd9710cbe1e269c4624fd8b886f049461ed54c3a9db7a1ec805aaff6a9d8c9	1	1	\N	[]	f	2017-08-21 13:02:01	2017-08-21 13:02:01	2017-09-05 13:02:01
108f99a04521dc5cd00bda09cb6df25a7aff92955c00875bad5d5c1ed26f7669e12d4e611a8bc94c	1	1	\N	[]	f	2017-08-21 13:02:37	2017-08-21 13:02:37	2017-09-05 13:02:37
23337fcf626d21acd0eafa19136578c2cc92f1e1d95ab76b6cb859ae458b7829b8a0e3906864053b	1	1	\N	[]	f	2017-08-21 13:04:24	2017-08-21 13:04:24	2017-09-05 13:04:24
6c2f80c88eac44e195ef32c3bb8185486398c1a295aa2af9956a520b09ecbdc39d6cfc9a20f97ada	160	1	\N	[]	f	2017-08-21 13:05:40	2017-08-21 13:05:40	2017-09-05 13:05:40
04e894efaa357c81f27d8996ada0b2f61550f10e0f8a37316f881d463fd6278a22048f0ede61874b	160	1	\N	[]	f	2017-08-21 13:05:43	2017-08-21 13:05:43	2017-09-05 13:05:43
ee85a3be8f69661202bc62a85586e8b462715f0ea9473e4c166aa3a4edf28089e8946bb6850494dc	1	1	\N	["*"]	f	2017-08-21 17:48:45	2017-08-21 17:48:45	2017-09-05 17:48:45
cf6a7fc46e379b66426ec51ad5dee280cc1d7d309e85781fd3bbfc8f8e898199a5b5cd58094faf4e	1	1	\N	["*"]	f	2017-08-21 17:48:46	2017-08-21 17:48:46	2017-09-05 17:48:46
7a91d1df0756b5ad0b437c0d167daa01490d71303ef5b81dea19bd8c69eee56ccb3ae6902d3976b3	133	1	\N	[]	f	2017-08-22 06:52:04	2017-08-22 06:52:04	2017-09-06 06:52:04
0d833615da32819153dcada7e2cecd0df1b564a2b0106fa088e00f131edc0536d31a6d8941828632	133	1	\N	[]	f	2017-08-22 06:52:05	2017-08-22 06:52:05	2017-09-06 06:52:05
04e5fd1d2df61c1f94b7782d23f6c14ca3aee33c130f668ee9594de1eded04d242645a11040affdb	160	1	\N	[]	f	2017-08-22 08:22:39	2017-08-22 08:22:39	2017-09-06 08:22:39
a403a526735f259985b741311f22161fa35b54a89a6f8a0002de5df5f48f2504cabe31ddb20ca93a	135	1	\N	["*"]	f	2017-08-23 11:31:23	2017-08-23 11:31:23	2017-09-07 11:31:23
18945a6e0d6b90d8743490ff530f5c71a7ad5432b00d358d097cc9082f972143cddd08ee0ad2aace	135	1	\N	["*"]	f	2017-08-23 13:02:34	2017-08-23 13:02:34	2017-09-07 13:02:34
cbef03fb5d2f28c67511ef5257d08f160451d549315b5a0e1a1060221f0c1856c37f3b8fe1c7c43c	135	1	\N	["*"]	f	2017-08-23 13:40:05	2017-08-23 13:40:05	2017-09-07 13:40:05
0c6a99f0c591351769327b5683a6a648286349e5bfcb34419474e577d2f1c0f630b711a78477484c	135	1	\N	["*"]	f	2017-08-23 13:46:28	2017-08-23 13:46:28	2017-09-07 13:46:28
4acc08de1a2f37f435db1ffd1de70f06a4d311783da65df0e108d0be2617f30beed6b86d1478a34f	135	1	\N	["*"]	f	2017-08-23 14:00:00	2017-08-23 14:00:00	2017-09-07 14:00:00
15a2fd7ee162f90e05eeccb0471c65abd6e84e8373efc21938abd66d409ad0a17593471ccb56114c	135	1	\N	["*"]	f	2017-08-23 17:06:52	2017-08-23 17:06:52	2017-09-07 17:06:52
a00955f09c828388d29be3d7d2dfb572fa1c2a7b4200bd0ba763746778c68781066035d9e63d64a4	135	1	\N	["*"]	f	2017-08-23 17:31:12	2017-08-23 17:31:12	2017-09-07 17:31:12
49985e71281dcf6d2fab632fcb15fdaf84b2fc90f6e5d3c220eed292d3cf4ed773031d3e9127c5b8	160	1	\N	[]	f	2017-08-24 08:58:09	2017-08-24 08:58:09	2017-09-08 08:58:09
baf1cc66456c729c2ad08125fd84ef2560e112adc7bb080f387eae0682337439dfd798126d75997a	160	1	\N	[]	f	2017-08-24 12:34:25	2017-08-24 12:34:25	2017-09-08 12:34:25
393596c161306aaaeadd48c78c104b3d31f302b42825cd7fbcc9c93c8a49a81012435d5ba2e1ccdc	160	1	\N	[]	f	2017-08-24 12:44:56	2017-08-24 12:44:56	2017-09-08 12:44:56
bf6717e5aebb0481443784aca3a8eecefbda3655b4eb1098501c56721b96b225796203ba74cb582e	135	1	\N	["*"]	f	2017-08-24 18:25:46	2017-08-24 18:25:46	2017-09-08 18:25:46
70277330b9a0e80d5513f76aba0eeeab17e8c6120d9861eec564acd374d32bb68d239857b56f90f7	160	1	\N	[]	f	2017-08-25 09:48:14	2017-08-25 09:48:14	2017-09-09 09:48:14
0a7aa23699e65718b1de7b3b8b2b6c506279bed9cedac92b73f37c7c0960c98ef4964570b9591755	135	1	\N	["*"]	f	2017-08-25 12:57:41	2017-08-25 12:57:41	2017-09-09 12:57:41
9ff0b381ca76cb6569f15dc8d47053c5846c019e926298debb0802f350622489f9f57214b816ca81	135	1	\N	["*"]	f	2017-08-25 17:38:29	2017-08-25 17:38:29	2017-09-09 17:38:29
fadb4e31ff1b2a5e820678d8ed271dcefd5814eed6ac56c1fda00bd4e6872861d6b0b959a99415c3	135	1	\N	["*"]	f	2017-08-26 06:21:48	2017-08-26 06:21:48	2017-09-10 06:21:48
f45ba709271ab52a816fea46253f569ce30e3a1ac05166dadb27ba65ed5c954d84ed330f02f9eff5	135	1	\N	["*"]	f	2017-08-26 06:26:53	2017-08-26 06:26:53	2017-09-10 06:26:53
98dd65c63df5e9c815d8857d08aa98e9de0fcc00e02c450ab90faad597eda28bddb044f0832a674b	135	1	\N	["*"]	f	2017-08-26 06:30:18	2017-08-26 06:30:18	2017-09-10 06:30:18
1ce846eb4e6f7c870f8d334ea9cfe6fce5bcb0a86329c8a98d9251b31adf81572350db6a2bd0b808	135	1	\N	["*"]	f	2017-08-26 06:30:30	2017-08-26 06:30:30	2017-09-10 06:30:30
9e290d6587c7e72448e0aa1075866a88cd677b0318574538ab134e7ca6916c34896c07474cf39d74	135	1	\N	["*"]	f	2017-08-26 06:31:45	2017-08-26 06:31:45	2017-09-10 06:31:45
a825b0423640336f022bb468d63effe1b524e60447b86952d6fb5d7943806eb5ef58736d4b77b8e0	135	1	\N	[]	f	2017-08-26 06:56:24	2017-08-26 06:56:24	2017-09-10 06:56:24
06e32e87464b1673824b5b905950b7350691df9d2dcd6dd53d7ecb832cb7975549e117e9049fd79b	133	1	\N	[]	f	2017-08-26 07:04:49	2017-08-26 07:04:49	2017-09-10 07:04:49
f2c0f6c65079522f5cb86d5ff476828a84ecc939fe2f60af4b8ea01fd8f2354b37be72d7ef3ef6b5	133	1	\N	[]	f	2017-08-26 07:15:33	2017-08-26 07:15:33	2017-09-10 07:15:33
c4534346ee9ec83bc54060314943932de4f435c96cb389841f7e8e6eb46eccdc2b2c67959869e83f	135	1	\N	["*"]	f	2017-08-26 07:23:16	2017-08-26 07:23:16	2017-09-10 07:23:16
d7c2a0396d114ff7e2835834364a8afa89bea5a638f97e1491d9561337679897510aed417878becd	135	1	\N	["*"]	f	2017-08-26 09:48:17	2017-08-26 09:48:17	2017-09-10 09:48:17
c1e77144cc2fdbdcaaf58fa0388f223fd75648cd5c5234a3d71a69caa36fc87cce3dd0606781de8b	135	1	\N	["*"]	f	2017-08-27 12:51:45	2017-08-27 12:51:45	2017-09-11 12:51:45
2a9d16a33fee78045b6ce1f86ba78e0da24c0262dbb215307ac3901169d30297ac671f18469a293c	160	1	\N	[]	f	2017-08-28 06:54:27	2017-08-28 06:54:27	2017-09-12 06:54:27
6fa7ca5a9112f20f294a134f90e7392f4949ff836be456f610bd62a1aa318bc1911b5e22ed017934	1	1	\N	[]	f	2017-08-28 07:39:49	2017-08-28 07:39:49	2017-09-12 07:39:49
2eb6141547362a2348566ff987c90e11609aec9b82d859e6545870db5530997aac6839f34a05d947	208	1	\N	[]	f	2017-08-28 08:33:56	2017-08-28 08:33:56	2017-09-12 08:33:56
1ccfd439a192d4fa17222922e0162d9538bef6530cc333cd880e98aa1b4d8a99b81c196ecd60e4a8	135	1	\N	["*"]	f	2017-08-28 11:36:56	2017-08-28 11:36:56	2017-09-12 11:36:56
31f4ae53243a398265c2ca80222d7f1991755130954687df6ef83ad88164644fa6979da42abe2f65	208	1	\N	["*"]	f	2017-08-28 15:14:42	2017-08-28 15:14:42	2017-09-12 15:14:42
d71ab5f97a3352492c658e3d451dc50c7f026f9cda3255199a5fbd9a93de4e18e968696c0232780d	133	1	\N	["*"]	f	2017-08-29 06:53:44	2017-08-29 06:53:44	2017-09-13 06:53:44
551e56e1ac39bacb961a72f26491535cf9c56addbb2eabfd05118eac1c5fff7ced98e7e5148b3d4e	135	1	\N	["*"]	f	2017-08-29 06:58:24	2017-08-29 06:58:24	2017-09-13 06:58:24
4c1a45bd6795cbc291549d277e6d6bb3b7acc700b253210901258d994f084a78f71c90a644c7474a	133	1	\N	["*"]	f	2017-08-29 12:04:03	2017-08-29 12:04:03	2017-09-13 12:04:03
8e10c1bc5109cea3161260c327f7ef5685edcf5b9280470948d64d4092724eb32f5998cec793829e	135	1	\N	["*"]	f	2017-08-29 12:31:53	2017-08-29 12:31:53	2017-09-13 12:31:53
288a2b1f60a9d9b2ade3dbce59a7c59d65f568a21b0d8611668dcd11ad9466bcf0d8543d278d4f27	208	1	\N	["*"]	f	2017-08-29 12:59:14	2017-08-29 12:59:14	2017-09-13 12:59:14
1f2f8a1fe09b77335cd0cb057c6dc3838c22862f54998ece510f252ff3de8f82315db1186665ee36	208	1	\N	["*"]	f	2017-08-29 14:11:46	2017-08-29 14:11:46	2017-09-13 14:11:46
4dd18581bd1e4f59f26fe5dbae1fd011af08e49c14f503590e92e56691773213ff63fa0394092a8c	210	1	\N	["*"]	f	2017-08-29 14:52:36	2017-08-29 14:52:36	2017-09-13 14:52:36
1778e3fe54d7b997ffc2d5c0ff38b8ae705e823b2576265afa6faa5a9efca8a77255cc98fae5e5ce	210	1	\N	["*"]	f	2017-08-29 14:55:43	2017-08-29 14:55:43	2017-09-13 14:55:43
db3fbc9de8e2086e6f9610b28e68bb6275ca0c180608d50d20cb4e7ddd78a24be634373f5d154007	208	1	\N	["*"]	f	2017-08-29 15:31:40	2017-08-29 15:31:40	2017-09-13 15:31:40
9e00e6b3a6b9765f9ca1c479a7681429937f2f6d2c705425bbc4bae57280344d36c41770bdb2068e	208	1	\N	["*"]	f	2017-08-29 15:49:45	2017-08-29 15:49:45	2017-09-13 15:49:45
fec4723fa6498e72669f111031e977eaaae180884c5ca2a3f5efdb06a200107b86964139081e0fbe	208	1	\N	["*"]	f	2017-08-29 15:50:02	2017-08-29 15:50:02	2017-09-13 15:50:02
7641c40e14bb22e14d83e021224fed3bd726a3374f3d42d2b1bedad6d70c35c668f6f60c484cd7dd	135	1	\N	["*"]	f	2017-08-30 07:09:50	2017-08-30 07:09:50	2017-09-14 07:09:50
74dca87cccfb593117cf811391d476d3ce0f19503ed3fe3e119fb71a97897eb29017239f9854d8f1	135	1	\N	["*"]	f	2017-08-30 08:08:02	2017-08-30 08:08:02	2017-09-14 08:08:02
93eb85474a3be21977dc6d4791135dd5da214783b0541726eadd9a6fdccc42724272fc4fcaf4cf6e	135	1	\N	["*"]	f	2017-08-30 08:08:25	2017-08-30 08:08:25	2017-09-14 08:08:25
e76f3518b11228869eefc094bb9b6652d96ae32ec67cb90797d9cb3c7509f04b7c3cea5ac610fd0b	133	1	\N	["*"]	f	2017-08-30 08:09:22	2017-08-30 08:09:22	2017-09-14 08:09:22
c6f1264e8607c7698d1da907c5b1757864cd1079f9698d5bc7ab242f5ee3c75e73ecdec5fc499964	135	1	\N	[]	f	2017-08-30 08:39:57	2017-08-30 08:39:57	2017-09-14 08:39:57
68ed7a62ecfcc20f0cb6075e547c04f07c192da6793089bb4ed05c03211a1b9486cbc2ac3292ddf6	135	1	\N	["*"]	f	2017-08-30 09:20:33	2017-08-30 09:20:33	2017-09-14 09:20:33
b17415fca5d75e4debb6f45d92d5704d7359b0409e19509029e037bb2612d029c666381bd871e04c	133	1	\N	["*"]	f	2017-08-30 09:20:49	2017-08-30 09:20:49	2017-09-14 09:20:49
f31dda8d947f158e00ad588c74078e3223096526a8b173a2cf2d30b38c5473086d7ae5f2d3979341	135	1	\N	[]	f	2017-08-30 10:26:08	2017-08-30 10:26:08	2017-09-14 10:26:08
d34d099dac1f69f5b94519ce956a861d7760b8f5128f81f363da33b6f29bcede96d5f839d5cabc5b	133	1	\N	[]	f	2017-08-30 10:33:12	2017-08-30 10:33:12	2017-09-14 10:33:12
ac0ee6d7dada6910e9dac6edae0e417d1d86f92f07f6766519e0becf483269f100bdbf036d1e5736	135	1	\N	["*"]	f	2017-08-30 10:34:02	2017-08-30 10:34:02	2017-09-14 10:34:02
3ef1bdbbff246ca65b18442c4e87734563ad2d00241a1ce517c119d1423d17eb53b2b8f9ab97022d	133	1	\N	[]	f	2017-08-30 10:35:41	2017-08-30 10:35:41	2017-09-14 10:35:41
b25a43528385ffed2455cf1d18dfa75c3a230d3ecb58ee11c55e8c4e93a6a996ea491c7f3a02a489	135	1	\N	["*"]	f	2017-08-30 11:33:57	2017-08-30 11:33:57	2017-09-14 11:33:57
31ae168b516f7dcf9616889eaf0274c26036f2cadffc347270da33663aa86221ea431546a1a44130	157	1	\N	[]	f	2017-08-30 12:56:18	2017-08-30 12:56:18	2017-09-14 12:56:18
b7fdf7bc7d96add63507cdfeb6e6808b31925acb7b946186c7c8683740a77053a98d93ec25b279e6	157	1	\N	["*"]	f	2017-08-30 12:58:20	2017-08-30 12:58:20	2017-09-14 12:58:20
ba482d22973c86e9afa001de3ee6a85c907c63b54c9bb06595095cfdadef6147eaee83432f11918c	157	1	\N	["*"]	f	2017-08-30 13:03:04	2017-08-30 13:03:04	2017-09-14 13:03:04
06df0c30bc3f246f9e6f4e2d5693c75aa11cef8cdd834e83250e66b560f92cf9aaa3630780eaf601	133	1	\N	["*"]	f	2017-08-30 13:43:39	2017-08-30 13:43:39	2017-09-14 13:43:39
9b211e35e6e4f72fb4c40d55b172abd7a41bbab9eb9dc14e662a9ff2e32f22cd3750c210a59dc351	157	1	\N	["*"]	f	2017-08-30 13:47:31	2017-08-30 13:47:31	2017-09-14 13:47:31
c6eb3743959f58078f48a8347dcbbf8173f41a8899c7e941bfa3304203b370f26e558f33f8c9fdac	135	1	\N	["*"]	f	2017-08-30 13:54:21	2017-08-30 13:54:21	2017-09-14 13:54:21
64e0d02e4052dd6649384168f627dc0ff8eff8b55370ab5cd0bbaa6af13805aa41b27d4ecffb1bff	135	1	\N	["*"]	f	2017-08-30 14:09:26	2017-08-30 14:09:26	2017-09-14 14:09:26
6ba7e17be6434b3edffdeb22f11ad95e397eeca64c09ee84d13e25347627b015e74bd3c77a3ed789	226	1	\N	["*"]	f	2017-08-30 16:03:39	2017-08-30 16:03:39	2017-09-14 16:03:39
a7ca06cccd2e7460b2e26a466c488052a76c5f02e9e2881a382dfe55d01a72b67b11aca21f309ee8	135	1	\N	["*"]	f	2017-08-31 06:36:48	2017-08-31 06:36:48	2017-09-15 06:36:48
e8eac16ad59d7b38137e146910b98011e232d0744413d55d36f6e77f120f32e9aaf5e56281bc8be3	135	1	\N	["*"]	f	2017-08-31 06:40:53	2017-08-31 06:40:53	2017-09-15 06:40:53
902852b7be68e2cdd42741c81ff103bfd44d9ff19c1e4dcbb87633657c3859344d315f3ca89a567b	135	1	\N	["*"]	f	2017-08-31 14:16:01	2017-08-31 14:16:01	2017-09-15 14:16:01
b049eeaf2e081be914e024f91ed763ebb0799ace508a831aece8cd106409367b0acaaac0aaf60f23	135	1	\N	["*"]	f	2017-08-31 14:50:44	2017-08-31 14:50:44	2017-09-15 14:50:44
bfdc2bb5fde735fb526c87d438d622bcfc089c7159a1ab46f44cac9c61c83d9758d153bc07409422	208	1	\N	["*"]	f	2017-08-31 15:05:48	2017-08-31 15:05:48	2017-09-15 15:05:48
885574a609385afafb923891ccbd33e1bef591d83b361ced1c530f7753371e70de07f8ebc57c5b06	208	1	\N	["*"]	f	2017-08-31 15:09:55	2017-08-31 15:09:55	2017-09-15 15:09:55
6353aa5b997aaf1052f130dc08a5597196abbefb8686f98f45f88f31e425340dc2952a0828d479d0	226	1	\N	["*"]	f	2017-08-31 15:32:48	2017-08-31 15:32:48	2017-09-15 15:32:48
a9466fbedde26f8f6c50b510206d640591b3c3c5125093325c815845a5dd697f84ab235311fbe4b1	209	1	\N	["*"]	f	2017-08-31 15:34:09	2017-08-31 15:34:09	2017-09-15 15:34:09
417e7eb23c5cdae8384f1df0e560921c69352cd082b7827c6756af14f7fdb6dbf305a4acec3d86b0	210	1	\N	["*"]	f	2017-08-31 15:35:06	2017-08-31 15:35:06	2017-09-15 15:35:06
5fdd2e62c20bfbf25cbe836a2ecd8daea8e2e644f643fb32e22e9911667754d33245709fed43ef60	209	1	\N	["*"]	f	2017-08-31 15:35:47	2017-08-31 15:35:47	2017-09-15 15:35:47
86186491a86558d32ae0171339e302e348dddbef79c2d55603333ef21917dc062f58cd13830a5ad7	226	1	\N	["*"]	f	2017-08-31 15:36:50	2017-08-31 15:36:50	2017-09-15 15:36:50
1f259938b6552bef0f245da15021647f64ac8e6fc50bebe247f50bbe807085a83e800bccf393d248	210	1	\N	["*"]	f	2017-08-31 16:13:19	2017-08-31 16:13:19	2017-09-15 16:13:19
dcf035b9d5cf63678356e39134440422d16023884ac02f084d7710c2ea0179cd74b9ee929863b608	208	1	\N	["*"]	f	2017-08-31 18:18:37	2017-08-31 18:18:37	2017-09-15 18:18:37
ab491019ce661d68e4ae0e2f46dcc73172a41c7eeb2e9e55c78c16aef5f0a5b01530cd0da3dfcf51	208	1	\N	["*"]	f	2017-08-31 18:50:58	2017-08-31 18:50:58	2017-09-15 18:50:58
2f80a512268d915ae45fdac4938a089afe2540e4a551794e5dfb01b5fef153feb6591c5fe3de27b1	210	1	\N	["*"]	f	2017-08-31 19:26:23	2017-08-31 19:26:23	2017-09-15 19:26:23
37816a106a7baafa2f6aa8478eef2e2ee8d3b7cdc8d8cd898ba87035b64e9ae868d0d060263a8a70	209	1	\N	["*"]	f	2017-08-31 19:31:26	2017-08-31 19:31:26	2017-09-15 19:31:26
cd5c8c5317dc8189ccb90b8d9f975ae744efc283eb23eae36326349927702b7e2cc43c13c69f3f39	211	1	\N	["*"]	f	2017-08-31 19:52:41	2017-08-31 19:52:41	2017-09-15 19:52:41
eb8387d853ab2f6da5e51f5937a4e8bec70b06b3261c1d2985463cb2146ce205dbc1dec0496ebb48	1	1	\N	[]	f	2017-09-01 12:45:41	2017-09-01 12:45:41	2017-09-16 12:45:41
230ccf85e86d8e920a3b1009ca188add371a429d71e0597ca85762fdd1b6ed7309557d2fcbcccfce	1	1	\N	[]	f	2017-09-01 12:50:23	2017-09-01 12:50:23	2017-09-16 12:50:23
6c6081a2c650b47b308176e8e4cf7291c595f6f3ccdd43dc942fa0b69eac23d6136f019ce8e3414f	1	1	\N	[]	f	2017-09-01 12:55:38	2017-09-01 12:55:38	2017-09-16 12:55:38
84ad18258a4dfff588af88b561e7858059f90aa42abbaad5fe14e933de0aece3a1573b7473ace920	226	1	\N	["*"]	f	2017-09-01 13:48:20	2017-09-01 13:48:20	2017-09-16 13:48:20
fc23479aa275156b8c4c3554d576b7d0abb3dc925eb7608bba5e56cd3f37ee72fe37a3f35e9d871e	208	1	\N	["*"]	f	2017-09-01 13:49:32	2017-09-01 13:49:32	2017-09-16 13:49:32
87d3330cc145eda97843ec0d0e23be6bd793b001e11e30f4a17f27975049f9b23b9e7d41bbd6181f	1	1	\N	[]	f	2017-09-01 14:02:21	2017-09-01 14:02:21	2017-09-16 14:02:21
7fcc82aa4ecc9deed17ce8d91026b3b67a0d62a5e1f7529066865c71209b5a9de6097018c733356c	209	1	\N	["*"]	f	2017-09-01 14:11:26	2017-09-01 14:11:26	2017-09-16 14:11:26
68f8d1e95496b7bbc89bcfef9d3b63f7f664df7e15e32c91874b5f38bf75857df11332af4b4eaf53	226	1	\N	[]	f	2017-09-01 15:44:12	2017-09-01 15:44:12	2017-09-16 15:44:12
5e6d83ad08d1c6eaff7465f9ae1cfe37410676c2e1f204c0a61fa40598ab8beec7cb4a677c39b07c	208	1	\N	["*"]	f	2017-09-01 17:11:31	2017-09-01 17:11:31	2017-09-16 17:11:31
a226963c9d468953e67bd50d5e4faeac7a9767adeeece7d767b2e8c18bbdbe7e1ac0c05355d173f6	1	1	\N	[]	f	2017-09-02 06:01:12	2017-09-02 06:01:12	2017-09-17 06:01:12
\.


--
-- Data for Name: oauth_auth_codes; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY oauth_auth_codes (id, user_id, client_id, scopes, revoked, expires_at) FROM stdin;
\.


--
-- Data for Name: oauth_clients; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY oauth_clients (id, user_id, name, secret, redirect, personal_access_client, password_client, revoked, created_at, updated_at) FROM stdin;
2	\N	Punchcard iOS	yhrgpwQBdIpOYnVmAj2OeStyuTzLcvBRWnwVwpUM	https://punchcardinc.com/	f	t	f	\N	\N
3	\N	Punchcard Android	HkZA9toqv6tGfeMcOV9Hzk05bvUGwiW8jpdAislP	https://punchcardinc.com/	f	t	f	\N	\N
4	\N	Punchcard Impersonate	Pk3zLc0fjiJEbxXIbhkYvnV2YbJRWwd6mfPa9jlu	https://punchcardinc.com/	t	f	f	\N	\N
1	1	Punchcard Webapp	w1kReIyXz09b6BmPleS9bIpHDUwfqdWBrUKJww5R	http://punchcardllc.com/	f	t	f	\N	\N
\.


--
-- Name: oauth_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('oauth_clients_id_seq', 1, true);


--
-- Data for Name: oauth_personal_access_clients; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY oauth_personal_access_clients (id, client_id, created_at, updated_at) FROM stdin;
1	4	\N	\N
\.


--
-- Name: oauth_personal_access_clients_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('oauth_personal_access_clients_id_seq', 1, true);


--
-- Data for Name: oauth_refresh_tokens; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY oauth_refresh_tokens (id, access_token_id, revoked, expires_at) FROM stdin;
a9969e1b9891876af904ac4f0ddc186f45693ae4c8232f2c523556615ccfc4bcf57422b786b77441	7c4b22530ca11ddef3a16aad86b12cfae359f43102fa2b8ebf17193bbb58a65c0a34ffa49cfd48be	f	2018-01-13 20:03:44
dc4f24e0f5e429b7992c14ef4f9d42604d86fa84634126dbd245044a61c903c670b066b0c64632b1	accf92bc48c2aefab8a3c6c068dd9fad0f2e6d20f293bc90af9bd318e826080bf4b0afe9fae0567d	f	2018-01-13 20:04:43
65af45026c75a4de8fe4b5e25566e162224293371f87a2fd45c5dfd2897b669573cf4ef50302f792	ff31347407b2db83aa293da7e5614fcec265619d70b520583a29b54c030e39f0c93b8b84ec6b56cc	f	2018-01-13 20:08:06
5576a0a9b357fbe5473fec43a1b0828277749ea41c56ac40a3c7e9687b877fe221b6014d5dcd6dbf	e47cdf4d2132fa73987cc67ddd3d51efb73848334ef3e69bb6d0e4d57aa2f62483e1295449b69c3d	f	2018-01-13 20:12:07
17b97e63824163aa1b4dcfe8bf66d51c96bf2ef129c7ac1bdb61803411d63f7a92807886525ccdd8	156decd6fc502d60b92a0291f180b578d02743297be3f4f9c329facb1bcca822127345d07f454df4	f	2018-01-13 20:22:18
7c8bbe87379c1afe62bd63783db89f044916f93e572e4929c83409ebf1cfa7a479e2a3fe2485e561	09db3b9fe52591f6260da1b2fe34efd017ea83e1dfafaac2636545c8d11e9f0f0e9b2518f1eefdae	f	2018-01-13 20:22:58
735b5eb4cb50623da80e619c25d75b82d51042ce7388154a6cefaeac379f3a11e451e68b79dbc082	054a12991ff3b71d3c302d10d85e20e094a2e48d27ef942e7596b72e8aaaa634e68d364e99a24a78	f	2018-01-13 20:23:31
faea0fe656460925b2924f20081ffd21d775b867001858d3024542c722c92425f0b349e029ad0911	1966a1f6f2be0ce1e19bde0379352bb3fe235f2d2c667c6fd2e94724c7d5237a7650e4acdd6efc0b	f	2018-01-13 20:28:21
72686e3a4a92ed62be051b8cbd74bbdf6f56d1b24c231384a4615d314ff95a71c430daacc6ad8416	c52032ed55a7f206230056ccc079c543235e04c0fdbc1f4affc55f0f15dde853658d2185fb3830f3	f	2018-01-13 20:30:12
43214f1471629a76d4a37730e93effb75cf632a7faa03b7395a8bf60f6e6bf607875a0a725aa1d37	3156d80623849ab16188f5a1dcbffdd07cfaf2d7be54e51098e582d7c4b24219e8166cd79e987f0b	f	2018-01-13 20:36:49
edd242c26b528fe12a776f5a6b29d7d4e4586b6d283ec6fbb8e47633712e5448f90a3bd5c12ade8c	0eec78efc6ff5206a35715a0417c60524643d66820c52692fdaa12e1f183ad884d230ffc4f6697b7	f	2018-01-13 20:37:28
bec565539c6d99196783896f67ee3f608b3be5522da56f12fad02f6f9e47cee18cb8501853e42f9b	786352dd1d31006ca1385a71c5dae2b3619f0b280812bb43fb18691e32ce7588bc775f6fd290da48	f	2018-01-13 20:38:12
5854829a88f5138606a5cd408298cbfe5e287d8b616406b97d727b13c1bfbb3dbc5184a3e96efccb	35d2c22d778fc3e70602ebe51e751bd6626da96caeef2b02d660a1c2b092c8cfbee2d7bae5f7d489	f	2018-01-13 20:38:32
b9a1c229a9a87e3aba1f491d1da45069805dd09e0c45ff537d4bb80400db4fabecd6355492789a6d	08e7466257185c5a3cfa56ed48f94e59165d725cf69b156528533fc06decc8019f1633b87e970ce2	f	2018-01-13 20:39:27
d1fcebc1979ae871b4424eaecbf09834c8ece9b93b79a4eccfed26bedbb740843b650f133f7d6c5d	f5f5080c9424d0bbfad985d5e70e6e903d101c7bf00c2bf52d8c11ca95c24787637a35089b3f148a	f	2018-01-13 21:03:39
d49642c4eb621e5bb1add578d4ae78468ac60096366fd80d0e162e2e466b1af2f7be62696e355b26	3b929c191fd80f88b5aa7a333a5ec7871492fc5f90a104aa82e92fbd0901c9690046e4e46150b8f3	f	2018-01-13 21:07:51
7b9b305495af1f62f754e4ff8118fa56968fc7bffccdebee97d8593b153c62881faab8f0370f1932	5f03059a4e9ce134c38e44e9f50a85b38eb17d9c7fb2db3eb441f346ffca5ee42e913b7e67693310	f	2018-01-13 21:09:42
545a115b4de345f2109836d98db55cf2a9dbdb5558bdcb394629cbc876bb924b9c010d368864ff11	5b18c519a1a403ed841cd3f05bc3d1fd5abcb7da5082d4ff6645872bb9a98e8160d4f8878fed5ee2	f	2018-01-13 21:53:24
e958b853723592fd97c9bde8824bfa46e6fe94ef0f1ce4871791bf1154cab8c6230c928588a19e30	7498b632972148c5c056f848abbb5ce26c53bdafac8a18a4adecaa3201a59d0143527015dde8db8e	f	2018-01-17 00:11:06
7429cfdece0c0ab462533b9b26bab1dbf1314b900f6d14d1be65039607297e73dbee6346805c1924	083a2111601a780b73299009101d8d8c39a2fa27fcdc99d5216efba862a10bebe2b7461456ead157	f	2018-01-17 00:17:56
67fb4fd57ec23e010c0ff60e55b1175730af8ed854883eafa31cc940482f02ead4fb304ead26df73	eee437cda3e1aa405bd8d3e461b6b909da457c84d7d72f6fc778918a9e2d61b18ed33fdd879918ec	f	2018-01-17 00:19:50
b10e9ec2b181973020bd337acc870d338e23c0fa2241f11e86a75755ab2e22d165f49458f2cfe774	9a83c3dde5cd8dfd388f3e53cac8933383b9e05992b04798f140ed3e147a4d2a6729f34f25d8e7d4	f	2018-01-17 00:27:34
5c651b331f0b18ad8ba274673cc68a2259c0408ab5f33d950a4789171f55aea79317e784cf37e49f	ed1f1b776cff1d81e0ffa7fa740fc3a8ddfd04abe12ee50b25f57d0b7b28b795c52da85a2694c34a	f	2018-01-18 14:38:01
e4448f0683f263bdcdc7431040483835d2ba10ff1fb6217629057b1829ade04965c40f0c0487c94d	1941b3f876b477da2f90575e47a2b534ef91fc4fec6ac92926e7f58160e599549ae5d5f658b403bf	f	2018-01-19 15:09:59
9c2e3c4d78ecb2ff15fa37f355394a3cca566bf6baa34a03b29dc710926b0dec7ecf62cc8f3e9c9e	c110ead14c9a9d3f351ce5883125c1d1c3ec802b4d579d3331fbadb23e896a1320c1f1c4ecf39f49	f	2018-01-19 18:14:22
aa0ba50547aacfbf6bb0676b72c45e2d028f21ea9492770b02d8f2f3e8e20f1d0f4b54558f08204c	282541cf50c41de629bf87ea813a41ff9e17e78b7fc3872972d744506ceb58e53663454e84222e81	f	2018-01-20 19:17:19
de1d7018767330bcccb20a47bf7a95c9559dead04d6aaefa90b762f8de6d052492daea8b92bc0933	6e7f4f89dc7793c3d2a8b69fd02ed30095be35ad9d53fe3675860a80588c5d1ef7399981a2189118	f	2018-01-20 19:18:40
d25e92010dca24cc62d9d616880a2e4de025d396abd35777065cc498d50e977d1f660fa6bbeb3784	d6bf6e462e942d6c325a84050867c379dc490589963c664cd89b9eab768824acd00f8ba17584b172	f	2018-01-20 19:18:42
3c8bd4bfa9dc9c448134d4fb5f903b92421acad61c8a518dbcb5c6ca199dc703244281cd03dbc883	0172712b7d2ab31df060462e8207fc69543742f668a0aa1b0c9165927193ac434e67b746fc404bc3	f	2018-01-20 19:23:43
e6020397eb7537f2ee274dc2093af4290a863a3f872f0cd2e1268e0c23171a1777088f8c7188f4bc	f5c1b978420af3078559a96e114b7beed8448f8574edeef4901b3a37fa486b527ee3ac0e4d15b752	f	2018-01-20 19:33:32
23982097102caf5a4dd845d263239b0b1f86504d70dbf446c3fc72312462c5e263cb181c6b605012	59fc60f4229fca6032af8c444a4ee056c62981038ecd742dd2634bf66ff553f6d823d6e4177c0e58	f	2018-01-20 19:37:23
801a85025828cba6d16d95bc5e93949006fe07aa5a43109b0adfd7c644de0253101cd05f18f823b7	bc63fa712aad4080ac800b21749332d5e579e697696db7ace3f41f0c56030548f61991512937f957	f	2018-01-20 19:37:52
190f305309d5f24d196f92c19081f0fae75a4928876a5d1df63c37781309c7f230723dbede984a64	96f435701d997e666298bf0b7283277bd99b8560bce8b43bb2b0ee30a38f514073428744acf9f5cc	f	2018-01-20 19:38:08
2e7a8e0b85cce8781bcc293fd38d64ef92bac5d2bb0b7f4b37f05e896c7acc9698d549dc4812a74f	9390653e87384dec6bb9606aca885ec3d9eeb9ab0d2cffa5f9c800236bf280d1fe11e5f0983f0baa	f	2018-01-20 19:40:09
cd8f7cb467b11de1eadc76ee118e7626f4fac792966419b3ea31c866f0ba8e4f8d24fa13e771b821	c46239cb799b464360c54260d4d2231af8d48bca3ea71c3fcf65b45cc2594eab4197518194c96b9d	f	2018-01-20 19:41:10
397f7c2e24ecf3d08e4ca4bb6bb6f922fb3af9a07d6374b4d9a5abe2ce164f5df0e501845baf26d5	25305eb01979a97bed4bf78b95a439ff9d15ae6288bfc1be5ae718159ae6d30dba628fd7c2298dd1	f	2018-01-20 19:55:00
d956d987f033acf70718dca8460718fe12487492a2fe31fb215f7e2fbeaec8306c5af3c501c8eb6b	ddab857be9e0665c981799f2f4d371669d00592f29878aabab2812dff054150c136c5833b1176902	f	2018-01-20 20:01:58
0af8abe18b63c4c570dae3683e34a2939f2f338daa074736e689cf8fd06787c053084ac2196ba4e5	34d6dcc4d91e4c3195f656f171b09914aea8240f638cc10eaaf3660e72e362e5820bb498f4cb028b	f	2018-01-20 20:07:13
eca76fa2989fb49b01d03e95932ee2e653312679f6a4dae1088d105036d53272f70d8731f91211b5	07cf59418cd1e23068f0a71a43d1d6e0f9c2c508e60e485692945fc9612e7ab35313c9e2d6d77605	f	2018-01-20 20:08:27
2df43d4eb46d2afab86245bfbbfb5b4f0aa072ec178a00516ccff05b0ad5ff2d15fc2f74bb7b1639	d42060f5b0704e449d8808e03df3dfe9c42fddf1a799587e1ab910629d04c8c79c4c056959676eb1	f	2018-01-20 20:09:43
30e79e3bfa2333b7524f935357d6e4718da3565621e265137958d21893c221fb7aea3f34ea2f4371	8655d12effbd7403b0b122e021db361aa342f0c201f0875aedff06e3148f0c80ab975bf09b473fb7	f	2018-01-20 20:32:19
42f97a81620bb3d0bdff59c5225029278a31395c630280c058a119ae537cde6a486f9a3177386e7c	bf44f7c8270f63c66264c61a651aa37ff7ca09a5afb2dc1362026b23d9296761938083f777125ec0	f	2018-01-20 23:36:13
76940cd13a1b9cc4655def79e16289db1a56eb3065b8a9092ac74b5d49f950cab848c7eab7885979	fbd03a81887f111c3ac7548894e22ae9c96ac84bc2e1bf4184189a815c8665a47d203e2fb4bb355b	f	2018-01-20 23:41:20
496bb04c66eba36345826a38ef2a82faee29f796d5169f0706321a34f4cbfc54facf2bcb46c002d8	17a6a7f3bd3f5786b5b481f6565525aad7cc9dab5f561d770b94f3e81938f1d33633e7459a99430e	f	2018-01-20 23:43:49
48733369643e917970be1338fd21df911f8de7a8afa4a38b83a4bc1f3e19320c667629ded42fee3e	0844e51b3b16cd82ec0b5c98a075ced5f40d4d4ecd4fe7a62dd3ff7b65146ed59547109e9d125542	f	2018-01-20 23:45:04
41c07f3ff987742cea758c8c3dd82036884dff3104c3ab11c628376417605611a7e5bbc75a9b7bf3	2ef5c3674272eb23b309f3853007cc892c7c60d4b720bf0632d3bb561ed58bd31a621de4eb1947a1	f	2018-01-21 04:43:58
5a2321dc19c91ecff1acda20ea5f660370154fe8db1aeef2fabb94369c39a7329eeee773e9330b47	bff238927442cc377d5cce4015938c946514900fa3b75cb4896e96534b3f196e62733b205b17c236	f	2018-01-21 04:57:39
aab3f930bcd32b165560eda79d0defe1a5331245f3e2596270ea34f87cfe974e247b867f5290bfd5	39f5bc57b16a615b1780bbff27fbd4dccb724e17ceabce6d12279ffe06b519b70682e62165040948	f	2018-01-21 04:58:28
8c3c839fd8b77e503fb11a3524ee50b486d1c85b2a57b45cfac45eb445667b113099663eab53e4dd	b54e543d9be5bb869dffce86da58ceae23befbacd5795f854eda451af6cf0ef050e4f7dd92f063fc	f	2018-01-21 04:59:14
60c9b8712b6ed8cc3aca6ac63de2f13c386486ac929e8916cfebb0c845c3f504f48eecf9dc0fe537	0ac11a63930aeb4eb4a9feb24bb47ae8428a35a93b9ee39883b6899810118ec8cd52b343171de207	f	2018-01-21 04:59:27
8ee38602441c8094a87f6aee4bf4dcea44431efa7af8d06a92237b1b54b9bca96cfd4af582b63233	d718c3e287dcee1c43ad8d0702a77d933be8fc5e554004cf7a06d694460e53727c5e88ad5c6c71d4	f	2018-01-21 05:00:08
cc5fe53aad38a3ee5a62076d8f744a7d8e1e76fcb457704369576f7977d499eb7a6b1e63f9d3ef3c	6ac12dda99be1d9012f4eeb248cdbbe38812a172e48a73f9de4e10d4b9df6fe84c29d274aa4479ac	f	2018-01-21 05:00:43
3938e76bf4fc229fe805c160244b4d23e91e6c6e3f3fc8c11166467a6c8e21455ef55fed363d2bdb	07803f6a0015de0a339ec07932a9f036e2315f367b538fcb7e14a90cb89912b9fc2be4a27a863722	f	2018-01-23 22:13:52
da443f1ad4c01c0e3c2b919d9d998caa28a29c55e2386bb4bf7ba90fd0e3a35ec8a1b348651270bb	b81b56ab634a89faf8433145383fb53c00f247e58b68086bf731afee105045b8577ef9ca5ed7c35f	f	2018-01-23 22:20:07
6f38ec377b5f9f1464a86c99a9761b5d6770fbb4b9136b9258276c2ce9c9f07436b485c469bf401e	d061f97979ebe87c81740c9616e70aadcc8db4f74338cde8e886367f65eabbc4d6154f46d172a143	f	2018-01-23 22:23:52
4d2d8c02e5f8d3cee0ec1ebe6ea21c2c95c594368c11b1f27845e942c899555d32f513887d53c9c8	e60bdc25b0b73c5d2b79379e08a2baa103856710e1b1cb0d1435887a6968f34e087fedd42d844f20	f	2018-01-23 22:32:58
e89804acb136ed3a481cec62abaeb340893e29da6c76c45700751b72840d58ba374b08fdaa59358f	13ef89ecabcfce51e97916e4cd3842f2da0a7a29eeb57e966a77f72105e338729c6f8d3694922d60	f	2018-02-03 17:57:34
b2fe5aaec221d0422766e67e2d51639afe782754a3d67ad745ca9bc575eef428f8cc803d2939344e	0724424748bd17dd76dc8b72933834d63c41a175db667aac7c4a7a797515d0864fdce5e297c8ac27	f	2018-02-03 17:57:54
3fd31161bf0e4e1f1e1d8f6cd59c47f9eb759ae42740e62ae3cbddc61c95600a89394f645052c391	59a455d8cbfba4ea24f0ee3b019a6de376f2628749606d5d67eba9e41a67221ca27cbbed51541be5	f	2018-02-03 18:12:32
9bba94ae2e4e1368b777313b39e0009876a42a739197be420c9fd274bfedaf67792f603cea44b636	6e111983b40bb63e9b98e5b5a8b4026f6f645781ecbb18827149e74f7870ad925626d889f46d2661	f	2018-02-03 18:16:00
225ae99249051038e0422ac521b6395f258f8f2579db0ebfce6c2c7439d59e99a90317c36d911a10	f234b00c345f32d313f6906eb2182be02ccc8dd08636bd536207e1aee205205b048f8f2f80d2378f	f	2018-02-03 18:23:31
6ccf38873284e51ec44ec6ce4993035b08220d7339823e860e38c64d481318633bebc35c047bf46a	2450763d109a3070d3624a0533c347da2d9ab6ea07705775cbb85763f0ecf1df151433fb83395e41	f	2018-02-03 18:23:39
0d65b6fac47ee7e17a471c9703ed59d88114afbc4926cf053c57d524891e834d7ff629b7b0b0626d	472023e3d153e4a23ecb1759e0d41e565c15ba8d4e59b070f3ccf3803e4f6e35daac14baf91092a1	f	2018-02-03 18:25:42
50a3c2dd6bfc436f05eb85df6e5cc82e47ae19b88fc451c4ad011d7f5ce68c0e979696602c36bab9	169f8f66016c30e4e2c5e65ed217684d0cca322d4e23a1729d84594b137dbaa244dd6fc3940b5e55	f	2018-02-03 18:28:18
3cdb4150065172ddb1d581a0af83311974915d3dc5cdf5cd8c97132123cf8f2e008ac99f582f87c8	5778ff0f2df33f857a16458238f032e12b84447adf1e0e0238f39240a5957bb5227fc6f018b5f18c	f	2018-02-03 18:28:38
f931dbf426388f3b4435dab2646bae3de14f9589c4dbb32a02dcbf4cc6269275fb66ac731bfba338	46d698349f4d6170880f892ee5cf02ee5f781cc2abc9a3e8dd11d6edeffcef90ab3b026bfc133cd1	f	2018-02-03 18:28:58
7485a06cf772224d4a7f4b7f06d94ff6a70694d4dbd42a7e60837b0fbf9d17476c097b717e5aab76	533b7d185fcff42ea94e417a476586032fb99c272ea1e44c24c3ea4c6c7719abba682b925277f16a	f	2018-02-03 18:30:20
bfc461e359192196fcf5dbd6173040e5e26088003163a888bdc332bdb24a71176793c04f93b54283	7fe713dae04f44be330e99c1a90e8c8e07acd96750d37e0c0c3e896b346b214535a0c7e749adb862	f	2018-02-03 18:32:52
5cbe833fb75ddee3af9772553cf0756e7f078e3b46a55a9af81e204d5bedddd90fc23c1bfcf88b1f	e160982a31e66d69cfdbc7dfb56b1baccc27020d9280f49ac02e4a7e7b0f98db15f0b7b8caf867ec	f	2018-02-03 18:33:12
1585102392aa1adcf772b7f142c701f984fd46454905656b5637b978660d96ba929d0e24fcfeedb6	4310f2536e31c1df760840980ff3eb106250d2a031b448cc7fc52e3fc72e740f278b20e1f61ac75e	f	2018-02-03 18:35:06
e769c147378d68542cd9721917e46efb0e6c589f183a34cd55fb0f5d864a8d26f1968fe85aef85d1	926b60f6eb6b8ca0abc52c59330694e6dd2bc8f0792d92aaf21ee37521845fb13819b33c10db1bc6	f	2018-02-09 15:02:15
281857c054ebc01c54e4a190efd50b52307ad9d343089af91c1140b210ba541fc95a453458fc6c48	b5e706a6ebff033511e4eac329592d765d2f89bfe66e8ee1e76e3e69d623e021a12ed5901a62e6cf	f	2018-02-09 15:03:18
2b11d64254488498281e66d6b692b0cd16c3f72d5b16d46c717c228db59dc600fcca2dc96520a1dd	f0fb3f04549916e1df79be9df175cb09740f781ff3108aad135d2f0ca9140cf30a4ce4f6a74d8b81	f	2018-02-09 15:11:47
26c9e4f00e50c80643d88e778ac1d0b424a10353d5d0beab2ca79519d4ddd8b222316324ca034fac	e9e709cc22b892d618b43a5ef148c536ed8491fcd834ca2918098ec3b0030d526ad42418c541d557	f	2018-02-09 15:31:01
29a8e1f8101a76408115f704e2df90345d760bfae4269dd10177b17c358b9c6524c965a0b818fc8a	98dcca11b5411ad27e14660b5be1c47a9b0e257ae35b68acf97db562ec4425f12c541e4b68c3c43a	f	2018-02-09 15:42:45
1a627c91f22fd6ab75a6d15aa2f1afbb3480a4cee1bb37a54d83caf8c6cc81a45209d5271bdc44d8	70340eccae997f3112f1c2a5297ecd7627bf50c53d3f7ec0bda5cf315f56947140837c489fea7a6d	f	2018-02-10 13:13:22
1fd2f793d8771cc645d7503f26fc33bc12e530ffb8c14bf40ae4fdf7e3126f67de3918fad3e7a232	49b8b6b3ec1d5d74c8e9a5205e4b54c11ac8eceaeb1226366c22c5f7e8231c415b4ea61b7b2e14b3	f	2018-02-10 13:13:30
82eedd89cd782675d8f513b2e0d2b0088269b6bc1b7443c46a3baaafad9e4dfa389035ccb5d38c5e	b4763a54dfd1062cebe077a2d7de80979e4f3efa8b984b421a36466f95536cd81ddc3deeb7c2be68	f	2018-02-10 13:13:42
adefd1d4c7ce84f439eec84160e5165268b7a0ea71060001fa21d0dccdfd6b2c83f7e122989f9bdd	8afda99b48c07379acd11d5c2a1059505edfcd3eb7f42f942e250aeed041c0e4a3dd465bd8d087cc	f	2018-02-10 13:17:23
bf42dbca76d5c480c6b9933e878a624b49fbddc1f60f9b72bf2e6377c0dd634dda415dbc8be2cfe6	096ccad8d210f6197fe49f5863eaf3388d969a324dbb1b69883b097983140100bb4dad8be2e68aa6	f	2018-02-10 13:17:46
d3619764a18fefc3f3eb85f5de8c99f446b9cbe4992ac0bc4bf82789a61f7158d37a9ee36766a9f1	a18f612b78784ede0a3dcf4a205fa17d4c42ef3f2bef0bf2dad5310a0ae5b4b2c6170ba4b69b6942	f	2018-02-10 13:18:37
e7de16a67f82f3df5b32ec7d76d8a4e4565be1c8f5a5a1b4a689862ec9eb79632112ae288597a855	458f155fec6a8dd88cb608465fa83b96510e167e931796f45629c1d8671a94a5ec76e5665ffa0e77	f	2018-02-10 13:22:06
f83f44dffeb556238d4dc5f5dba241aac4a98455ca7c7764b595289f6b675031a05ef0f3fd4a8dfd	27a82e7e7d2eef4b7c491006e0f0107cd91cde04ab4be12b55efd486ca1cc01320ccba58b27ab37c	f	2018-02-10 13:22:57
99e05b23428fffec5be883f592ee5bc18305c9a98a0879316edc326487a431b86fb4057498f8d237	9ba96ffb39807ba399e62434735bee8e6f1886138ee8d1f0f7a53462a98ce667505057cfb7ddb7c6	f	2018-02-10 13:36:17
474a63b285eb070a4cd93dd11ccbff0718263974dd5aa2dee42956e5a8b44bca453d09f2fb1e1c86	0b0cb3c2f62a0e79dbf74fc6dd6328b1337d55024b4e919705c7f6473b2c9d2f95aff1c56593c90b	f	2018-02-10 13:36:26
1c5d6aa728699dc76f2d8ce7ccb2e889045d678255935e8bbcf6bbbef96d238f0c98b58b3a953db4	4ce5e1bb3f2541a8c6f499b8ec72f4544f110df34eb482786ba6c194e9c209df300b070c66d3a0ac	f	2018-02-10 13:42:53
2647228e0d5b935184f2cebb37d0ad646d98f7940f74c9ab34f5ce065467443515726124caae1538	ea697d6f42dc077e8ebb45aae38af40f0d53eddd77ce8eb8d33ca9555cc48ddf74aad703e4b8e8c1	f	2018-02-10 13:47:32
1ba5192faed22a79a99a34f969bda26d7e6f738d0617c6bc0d05eab0dd9c35455e267ebb5aa41a8f	e14d1eac5e4f9b106e30efa5205988a824059ba5da2c2504c519f91c4865add4e4343abf9407cc69	f	2018-02-10 13:49:16
3f810c3b15b5a2521b006909be0d1f8493a4d1a917ac5ee2ff5db5c96896830393bc8b6fefbbed9c	eaa24bf20be4873478a384b2f768fdcfc006a35d588092c02c56b91a26ee7d4dce2573e6f46134bb	f	2018-02-10 13:54:05
5ce7d456ad9570e015a6a4b07ce72950a4b0a0122cf9a1841b6828822d81f821fff8f853d001fd60	f32965a81424eb7639d71226f256e40deb6e0d05f34dc0e882edfafdd4a81afebfac418011d7188a	f	2018-02-10 14:01:09
0ea83f0b14e8ecd78e0996ebbc70510d30320a7ed94a31d8807cad5f2f5416cc90c349981e162ec1	eab36b69a4d4e3b1c6d55b24124d536ebfc6d4974e462c34eb5d356a89d3ee02c926e5af09e22340	f	2018-02-10 14:03:09
ad8f70c1a61cfa218db48461ff4274a696a8411ec6ba61d24ae6e06f3336cb4fb2f83dcfcf2ac38a	b17c1ab51b5ac44b442c94eda7ac362c88c1ff3f287cab655d8226c8cce2d77644e9bf299f2322f2	f	2018-02-10 14:03:16
d46b429eeabbac2cc83b6766d42f96db17d36bc9d47a2fcba145a863e72180ae4f917cb407e2b543	b42cfad24ac5b22b78a8fe23110af93f36f34f4d67a97a18cdebe014101995a29fba02799ae45048	f	2018-02-10 14:18:16
e80f7369f01a4e5ce1cbc492df181e8d1df6223526c25c9890004c5285ab1fd3eac69d1fbb461720	b9442e17229f4b902f20824e7673534a449e5f553189fd8a159756d79daae68eaca34a76faa93bd6	f	2018-02-10 14:20:00
1d27434c78171657e5981f95f2110601f8c3431eb5b63dce4185599c53495b95cf7a03001633a344	15de02a8fe8730431260cacb1b9460d97747e108d2f2743607b5b165d7f6ac6e5fd38467f4fe09b6	f	2018-02-10 14:25:39
fcd24ca023c4070d40893185cbe943db7f131a3f22f0040499c0be51076b7174788a91e90dd1cd76	9a834c9418bb9add639adaff635fd5810b58d975c9792cf83e7acbeef3c406cd8c98deaf325101f9	f	2018-02-10 14:34:06
df94b45f9f75c71f353c8292911d1e5c2daefbea2c3771a3990c8ae3ca4f28ed8ac10aee0eca9562	3c98dc61300f09b8a1df15a258dff5c983647619a079d926178847f7830c104d5fc99b1f1d508c17	f	2018-02-10 14:34:07
f81c1762907edf5efdba9cc60d0564c844bdac2549244ca154b7109dd5c73ea4c17e67b02cfb2332	ae0d3688e1966af0e9f0dc284719d848d475c195710a974b2eb9c922eb692bf1742a3a3739c7b50f	f	2018-02-11 12:22:11
cc0b16f5b5ab0230533b28a1b0883cddd5cabfe371964759228a3eaa5a419959ca5d2501cb4e9eea	10b5df247dad37c2cf9064c5384d0720b46446df6c11e7231c0e84e73be29e9cc324dcc2c3cf4380	f	2018-02-11 13:03:19
634296a995b4303e8ad6cb7d299c5b09ecd899dbf4f5553aed4778448b5c0cf0f8165ab74892f4fd	89e8f4a648551f3f61e5a1be01b20efbb77b0265ece0f7acab98fd5b4d5d49566b394bf997cc1bc4	f	2018-02-11 13:05:42
30f79157a6cfc521d19e2428c4b52c6a732845e118290ffc0ebae174094fb1d3a85692a6aeb07c7f	e7a77abf2602759137ff4421895ed2de62a6af14d69a0f14dface3c137f2dcfc377ce25456192ec2	f	2018-02-11 13:49:18
9ae65fad44b23d9e3d2de053df4cc9e4d1c33d364236111c5de5b400aae4da37eb32f8a3dd999ca9	6186c74c1c05f0078004cd2c43bea7dd865a4371bab4efce11918970e1dc29ec7b8d660f284c2824	f	2018-02-11 13:49:41
c5ed71ea56c46a9f665c080d0683646b52ac007ee9eb161e719008af7b0ca0c46fff60129360b65a	403c6771afeaa01d219f0ca40cbcb026a655254fbf058d79c9ab6bdf7c3137fadc609aacc35959d4	f	2018-02-16 09:25:20
2095675519b182051a6751598fe83c7ac24f7b7a07913d371c72da103bf9459d45bde2a5e64c4385	c7362616e921913cfedb004f9f373a9721be6918d1635a004dad5893d122c6b2daf6bedbaf05125c	f	2018-02-16 09:25:43
904b5195599125b002b2720751e60c2548492d4178b806e4e23492d5cd196c7d6df7b5f801ea757d	9f3ca24f34d0bceaec2dd6a66d40538fbf2377d05381746849760a4ca1718c77b5e8727d02b28a72	f	2018-02-16 09:48:24
7156d9385a6413d549dc5e96b6472334dac95d194a6c9af0793465c765d4a8a77297879ec4067d25	b6db176b102c8ea2fa7c058bdd38a0cc0ba7e8e709a70e1aeaf934357c245fa309789e0ccb882598	f	2018-02-16 09:55:40
e20646c0571c3f409fa59b8d7d861d9e02a1cb6fb176f1841e1fa96d5627f10cf337d38e40618445	f65a7ae480b20ec224e82ce589e9c367379d5f1e5c934598b47212a860bf49833250b6a1d460b587	f	2018-02-16 09:56:12
3eaae49703024274991f74cbe9c8b8e8619135409d95125b70967ad93d2b764c2c85f11352b8edb4	f8dd07a6934870f8d49eea4e861b98df5e2fe2be5412cb9c85a19977598a31f831919b2b7d1fe00d	f	2018-02-16 09:59:52
65717049b15b16621bedf9e5fddc91fe656152c74bc538787d5ec84e89ef346bbf5c7b9a9261b1a8	20afbe86e84dbd3ca3d8f37074b3be9dbb7738079575548716fb717622449f069e036768381edf80	f	2018-02-16 10:10:45
78df52839a9cea2d1514da8e96d8ba1876b16997f8625e3fa1e6ed005bdde70fe4b3963684ca303a	18de83c4492d8c71a8a75e88b72d9756843180e7e0429bfd0f2127e401d4fbe2eb27cdeea86fd4fe	f	2018-02-16 10:55:10
cc4907aa842d41f0f49992adc801946217e46f43500171e3398a1367975eb016c1571d8302e20965	1682e9c2b9649faa7ea03b71a4b6d4d3ceceda388d904422d4d0c7c02f8fb34c2276a8ecfc0e75f2	f	2018-02-16 11:00:49
3f1ea590d12137889df093a71459c7a1f9e1127b0ab985ffa173b38e9baa4fa6f78d135c61d1349e	10fc1bda06799ecc75bb53b48c42d3960211647e968ee0c270d696f927ec9e35a220676e10a025a5	f	2018-02-16 11:02:16
03eff12336bfa9d522486054df2fa6d8ce93cff1b9b0c9d9a404ef2dda9bb5d0a89abd8dabec19ac	72f979391d52dde84cf438f8fa0d487f909dd0e8b30b511152060eda11aeb935e1de9258d26251bc	f	2018-02-16 11:04:43
e715c0e6806a7b52a2b7c7fb2da0a24d350877d1b26c257093ca5a6007a8a4f352fbc049f4c7f12b	e81ecd3caf6cd92550be44aced8aee10a69e23cdaeb02af078e514e8bb15ef801f2f73fce0127e8f	f	2018-02-16 11:06:31
d6bcdd11c5f40beb3df83d123a62d1956952f0d2f9c1e31b89fc7ab94067b80560d18821a5f6e55c	7a100e7f206f39b576f591e8b582ba0f142a4108b8409de4f5f424efdc9d903152eaba12ac0b60ef	f	2018-02-16 11:10:25
b4af4a3c00afaf2e8b59ea979d5cb6136f862309edfc22403a8161d8c59f8cfa90be1d2a4043a9ce	cec194b41984fe3e2007af75d4e0d60b8d9b1cc0ad16db01a451973f7058c0a8c4b1828b922fadff	f	2018-02-16 11:14:23
1deb0c64453c3ae2a8c683d6699eb3124e3f9917dfaaa8bb9027b6c2ac8fb2b0ad900f90e987ddc8	694cc0a411cbfadfc04bd8859bed8c75f30b4378f5707a2b4e5eb6e43d419b3e19b2a12d204890c2	f	2018-02-16 11:32:25
1734058f2abe1a266b9f5603139ef611042d23d513e7d67358a4c6bc964899fce4589fd7073445ce	9471252cab3ba77fb1c71139b9f335c7664e5d2bb4f52128ed95f35cdaaf69e697153f99337ccca6	f	2018-02-16 11:41:32
c5c162565b2bf2d0a3136c31878fb0f65c38ac9e226a455be768b964c335345516aab7412bcb78d5	6c2bae0338ba9044db551cf5a2be9e7b6bf1c224f2da5dd245b0dafc998b7a7238c85eee78db26e1	f	2018-02-16 11:41:36
d2d594a97ccd72db5306378cf20840807f7c3fa2b2c914160c75e14aaef82055d927744fffc593ea	eef18c26958e3c2c192ecf68bbf478cc59b4e8650a2c40b87110c1a8002a145d9538358639b500d4	f	2018-02-16 11:46:54
94d2b063167498f8917337eff3932500236fabb3aa02555d80620080b800348428b6e8ed02c1d1d5	19a37b20d1b37a3157fe9e4fc891c00322a39c92e5c3aab7bc9ef9832d0dd8e1fd94f93ab8e544b2	f	2018-02-16 12:20:37
57807cc00af1d2b191533f4f19639ce5d37187c55c2127f135293e0031b73214b82c4f1889252cc2	e5fab270005ed4aac7f9945bd364b7445635132f6d2349565845639130aad7579046fc19e4be07c5	f	2018-02-16 12:23:42
413039cfd29569bcafce218cb3bacaeb29b2f6e31eb26060875e386a2d6a283f8043320844db39fe	4acc44d44a5959bc66b92387e0c450ecf7f076b0aa08e44bf0381d94d48c29a2fe782139a910a1c7	f	2018-02-16 12:25:31
5d10989d4bfd198ea390663d712478a18d997e7b80f1e3ae1a16ccc3c90976c83c3bc81169e230e9	f626ac9f21198c76c86e6ba01cc6547437eb22c2b45ca34423ddd954f5c0a36a4aaf91c625b0353e	f	2018-02-16 12:36:34
62b0fc477d5a9e4ce3d23b58dacc33fa0a5a17d266145a654b58d1524640b0ab3d1440cdb65f586a	3d1248df9d945a95458bea7e6e625b108311577372efb98420881664c8397b5f967cbe77f9384e49	f	2018-02-16 12:38:12
9fcc8aaac452c724c54c7f77d5af1b575e178872b157d7c91b1c02c0fc095063b4d110f679599678	1e8ab49dba7cb50b07e1a2a2a6dccb12ec96669014b7f87447dbf1b873312c251cf053bffa43724b	f	2018-02-16 12:39:09
5afac0445ce130077261ff89dba12cd14937fea90ac3e8204c859c92285b7b4ffbd1d57d92c015a3	e66495400df29002759b2700f4f9730d2b41a25f2bd33525551980de519c9a3ebb382a1aebf52699	f	2018-02-16 12:39:19
7449d8b2dacb637c18a62181c6d8c5c786fd713fc808fd87983e2a21703e89792ee49f0b9495b53e	11377005cc83cb969f11a05e5b07c7e5125ca52e00d94a20d91766a3f23f0f52a3782ce9cad93e58	f	2018-02-16 12:41:07
f5b7234fb3bf22633726b2ce292e49ac8c936c4980310cc9d6d8abdfad13fee443b752ddea0024c2	5e40cea051e475cbe5a70f3772651f4b04de655cddf7922134577cbea9840448cdac6d89053016fe	f	2018-02-16 12:42:50
715814f7ad138c6c17b226dae3a57167ffe89b65e1c79f0eb86ffce09c18369bdf93cc50e66f9a2b	1f52d50a08573ff2947cc839898964f79b60baf15ac768fcf7e80019e1c66567646a640af039ebbb	f	2018-02-16 13:07:29
5e8ce785d5d1452be5d3489e89c057ad441810fd2622fbfe8208c0e7be807c58af2361eb1ed44d66	3ccb0da353b1c9b44a11595cd454d3cca4d407d069454bb497aabe4bc4dfda1cb4940728ee217465	f	2018-02-16 13:19:59
c2f0452165f06ca607f2db79fb4e3aa9f17ba0b91874cbaebb16f144039afcb991fab22bf4188a00	95e37c763e8d7aacc045f2c8c3103529b3ce3c594effd3b5889e1debaa0283c63154e1b9be7ef3b2	f	2018-02-16 13:49:57
0b486860b6fb6d4a75e6544c8a78a335c613cb3276cf0d6697dc4cd1ddfa9c352aefb222eb179253	157918e16e256a22dead9c58bbc84892b87000a83764864b5d604460e75d8b53a2ee99ae6aa5fffd	f	2018-02-16 14:14:35
cabbe5b58dafacf7947d360d9c09cfff8ceedceab5a9ceb3545fb345618252096c5466796da4eb11	5da002c8bbf3a9ee6e205ed8c6bb869aa8d1641e0fc6988af072b3c5efc56393f747dbc48d9d438b	f	2018-02-16 14:14:44
f792abed0b46aac5a52d25777d78a870aa7ba6280cc8823996f902e2161e7961003b7833b355ea41	0a963863b1c9ba7650a2658eb5b79aa63746821aa1dd209e219356581c3d4eb9f9292c3873210bd4	f	2018-02-16 14:15:13
1fc760fcd7f9f859b57b9e9f21b0e6aac9bfd7ed27b719ac4785659f51bec44fceadbc18f000dd0c	470c03a317374c99e1f69b243773621f8be4e885ffc2122ed38899eccba3f17e13d1b0218d13ea97	f	2018-02-16 14:26:42
3f39408c99031337a220494def85f0595fb56f9d74b3ff6b696f2a94a31b6441e5bdb4ea6b888e79	9b0988e67cebfc3ea4553af1ed89fb8d04188fc0f2c33ec703a35792a9b01ae76c7cad46b9819cbf	f	2018-02-16 14:26:59
b93288b1caf11e6b173cad068e0611131ebaa32b7e1ebb99e73fea6d12a5dd2a32f990fc52d39aea	bc8ce58c7e6218c7c0a5092785ca49c2b20cc8f78f4bf2ada952f3ba9c48493e9e620b6ceffc8af6	f	2018-02-16 14:27:00
ddac87feeb12d997b66abb9c2293017d139eec664c161a077c1c739b071c0a631d095ea07dcdfb6f	891ee10ca49e69e326d21126ae2ee649cdd0d0d8e826ec47d6211944e15990e642da980f949b8ca5	f	2018-02-16 14:27:01
90055edcf25177ec0dff1986c92a10061bba86823edac903a256f71e401aee276988f38d9454ab90	1a7eb03ddc870db01b2714c96212796fc2e3bbdaefbd1b71868b607299f21d88e85b5a9837e76560	f	2018-02-16 14:27:02
1e775b99fa9a6ffb07add8fec04b4170db2950f1fd5f247bfeda693ef391f3eba90c17ae5fcda425	c1430b53a67ad2124d0bcfe369f116348373fd0b4d72deff8af9613e30dff1db8725ef4705125cc1	f	2018-02-16 14:27:02
e9de4a8bf40723f05944eae9f418f679a4a1a2c00c1eb0eb0c67d42c1cc4c37ea60c84609e860ea6	34510987672ba3689bd242baf1599275d3443251c37b44d6ef4587e75e14f3d5e35267d5c2e1d2f4	f	2018-02-16 14:29:29
e76239efeba44435cf07c3f1d7965647ee1327d676c982ccf87b9bcd6ce33bbe440e7d424c654aaf	0faaba7c559c1005032766e9e60ab42557a719b77d9103595737c8f03e7c814a944ad96cd4a94372	f	2018-02-16 16:44:04
376b5eaa0b5418d9b941cff57776d8d9510aba2e3020c078f9643450881e02f85b6e0e916e1921ca	42a9710c27f2ac36692955f6fa5429fd304cccf75365223f12d2cf653e9deb0738d532c0fc66e250	f	2018-02-17 07:15:53
aaa3d62bdf411e84cf7de463085624c3133408af37a28ca763088e967b8d7a64f7b2080c7f892dbb	63946d1a9b574f7ac105aa1702cf2f82f554b4d2bb2371a74ec7a38f1d1d6c5a95d2163601f5a0f2	f	2018-02-17 07:15:59
5e4b316a1fbcac1c63c9a30dd2f51c27c3a21445ec0e4becfc895f8b48f82729e6bca16722f26d7d	3bb2344449d59c2af6d95106a9b90f92657bf0656ef6e5938b89892cda81ccc42846d5b75b52413e	f	2018-02-17 10:36:59
42a0da487ac6d8e2d1148294e94c125aa94a88ef43c5cfc2d5e74402105611fb2c0d927775d0a6bf	152c8dfb6577677a5710c7c3c1c46651d2258916c451819e468e7b730f812061d66d0073e8361ef9	f	2018-02-17 10:37:07
87ff9f07c76cd9ebca05e48b38b1e246460d242b6375e5caed011c22d050a355773c7cc957785ca3	5dffdb8f2ab7772162dfa4c61b11a26bf0ba7b35ff2b1fa0f993aa286e565ac765be72f9c82e6a7d	f	2018-02-17 10:37:17
895d7a0bb9e2ff33afa9a7dbedfc858d54e7c4fe59449da9e661c414d91d0a30ecf8ef02419ba7c2	2887c43eef62af66851864f317cf6239aeb86ab390e4672e14ccd562fac62de1aaece4e94b98d639	f	2018-02-17 10:39:34
66d0f89c002292acd1c70fd8fb76a14f91ffb967818974eb19ece9a940d1352c3507a12384a17abc	921c8151c94aa4f4d0f85027eba0a8c3c0271eaacc190bf6345eddc57939697770385e2e27eb4bef	f	2018-02-17 10:52:45
007c3ea591cdeae6fea3f0b17665eb6aabf3eaaf9055d8d2a21dd30c7d879b1649707c2fdb5c42ad	d7080fed9fe0fa0bc3047c1fa430263eca59e3960e95df3af2a27a9bfc10cb44bcf8362df7fb7eb1	f	2018-02-17 11:06:00
8d2a55286a0667209d6d52b02c945dff6c16a55671ac654d1bfebbcd97ea8e977f9023881c957f2b	b1cbd0a172ffcb7589cf7bf313ea919aca49e088eca1c2e2a45a5ea86dad585a04e5d0c62ddd5233	f	2018-02-17 11:23:09
32862bb19c24bab098910c6afa7ceb5ccfc2af9f81849503d2a3ab16c050671736bf8fa0a8b04efc	2f580f01f689ddbcea62f95ad6b7824d4c12da3ea294fe030cec17ad69dd8111a9126c984b876a46	f	2018-02-17 11:25:24
18f9fafa810562c50fc2bfd018cc4610a90faab94d0e7712ff56602a1c34a8923e3dbdc22237bfee	36ed6bf462c8f754d5c229f93277dd41bc37620324bd598ba5c0572a2dd1331eec1d3a9be4f87333	f	2018-02-17 11:29:35
11cba1ea80235484b11eadca22ebf3688abb1cb481a1c36ba21eee3b53a93e5bbfe68eba4ad05ec1	e5318bde83f0b34d6386ea6cf56b63ab07378e98a9ff8697152c9ff5b1979bf327929fd30ad4c18a	f	2018-02-17 11:43:48
85e8280681a4f2a17e32d00c1d4e28327e518c1bd1af070f0a572600572437c63b8336e9c919026e	12f48c9d0022ed060d2b7db27b98ef9ed5c43cccdebed7b6c5a2fa18034fcffbe5372ff60a17c634	f	2018-02-17 11:44:02
3a4f09b38c428beb720eff894da7a424559ee8c4f2c25443bbfb66ecab3dd56908db8e09fde25140	d94c70b0a7e4e11b204f3ada1adeeef12847b9d1df9f5a12bbf34f794b162b64e197c10fd4352dd4	f	2018-02-17 11:48:25
9906270a839d936657b05afbce0f4f503f19eafcc109bf41b7327d7b3d3cedf778345623ce13f14a	2f8cf6c445783c345f6a72d8737673b6f54b76adeb1816450c4ce7e90ae0369e4bad8b0f03a1fccf	f	2017-03-19 11:52:35
1b9ff98403f324bccdf1ea2793dc2b95dee643702e55526bb611e90aa202b647143606ddbb249aff	c4999fcbcae1a2fcf4c4272cda30db03e9108e4d0186d2a12ff59dcc3071c4e2cdd4a9a91aeadf86	f	2017-03-19 11:52:44
144287dc77b2290f1f735736baa0085547d62ea44c76e8fb97a1ebb86e8fe57a209fb65da0d9cc36	d52b7bd9b63a56a5c76866a61295ca9e6f4e3e4708ef375080ce12731026ce94470a1d8a1dab21c1	f	2017-03-19 11:52:59
9f34245cfb7682ea4a84effceff0e2d72cbc160ca0512efb04ced36f94896058bf807aa6db84e034	2735c83e434edbfea85e5652f86f35bd340e1324fddc783d6e52d9927febeabe829695fdbe635eb1	f	2017-03-19 11:54:43
46b6792a20fbacedfd0728346e36cde4fa92ed5d732978bf7c2b962b9af6126e554c96e80708a5ec	490f49b8ae5884783027eb75c8e96fc73b5cfeb3aa0621bbf1e6608f2e31ade6530ec604e69008e5	f	2017-03-19 11:55:10
3e8374554679ff342be6b4af9ae87db00b79f1d43b387e9ff0382b6c1b54f26d59f465f460a297ca	0f9ad626d777b5b7edbdb0ede37ed932772448a5c9e1f47a536fb19cf21dd41d833c9ad694e20acc	f	2017-03-19 11:56:20
71b62c0392d850a350f564d67ac3f7ef421eddc3d117af9963e43f08466f195cc597809706399e66	c803f6ef83a3a8e4fccce0843652f6fb205051c595e9e0d69957b62a597854d97bce70d7c48e12bc	f	2017-03-19 11:57:36
44cbf0a597a9b01d63958091d4d416a3ef14e6e2aa795295413ebc1f87bfca5bbb793291ed55d910	6e7707dd164f1d1357635d25071a41e94b6a008e500839c6afeed7845b59243367970bc7ea7ba287	f	2017-03-19 11:58:03
7a119d814c361cabb1d74fb62e795f6ea1c500b83cfec1228b2d9af547944b167939ac9d91eabfeb	afa699ff11ca4ce9e5f6f35b08ac766dd6984d3e57c13faca8f2469257a37f5b829500108d078af6	f	2017-03-19 11:58:16
ba59b6c1706c5eb80483e851d391911f0904d20e7ea9baf4c38d615df0c746c9caab1380b3b0c53d	2302f5c9f81ddeff5106a5e9d1446a2d228f10a6d10d54a1eda69bf63147c842575109c345ac1de8	f	2017-03-19 12:09:37
fd1d15fc459d15fca6996f75fa388a616642140bd1902466f1babab3cff84fa97f8a40b231e907be	d8c7607c39e9ecf4566cd0432f60c3531b5fd60c00675a2a5b7cd597a96d97a0de74f730a303c9f1	f	2017-03-19 12:21:43
9db9e4fd018e620222fe4b04a575693c575b940e4ebf1c262a57bf137d82ae005421baec185a551c	e0be5b227b4e6d311681587699ca0a55b30d7fcb0e3791c3d21b828a9e2092bad08533ff6cfcfd05	f	2017-03-19 12:48:57
2b45c9da4716005173fffdd9d6b29d7091eb0a8250f4f1a7172f667a73c0dd81473057977c17f468	9f6fe02c2e3d7268d3f2a315e6f87f9f668521e7f157e4ba3ce3f2dbb2181f8297ad6dc63c9283e6	f	2017-03-19 12:49:10
7753047f81ddc6ecbe12dcd53d837791baa5bf87efe373e563c8ae542790138d9b7e53b45e7de71e	bc0eb5c1939ab0f2522a77ca301bfce53a16c8cb4fd7df1ec49e0985e38590dcc2faeee2e49735db	f	2017-03-19 12:49:54
a31c1f0d8f2f557f6bbdc2c76d83da718b574d9b0691404c7bb3a4ff582d4742d66fe14aef38f1f4	1c36575cd8fb4d06d87f16334b387006e85be6754b5cfe00aa73fcc6ada02a7d3ccba6e96a304fef	f	2017-03-19 12:55:46
82be199aa67b9a487e09eaf6b21c95d5706fd48382a4bb0583f0825abab5c356df2c8dc81cb2dd5c	c239c91b36cd8174a0eb458b0646d396eaa9314ee01864e67cba67dc8212b059c97aca1f4933aa9e	f	2017-03-19 13:10:21
90fbc47a44b46acd1df6d6400b956fefa5b4739add8fce503c11646226119d680347d2f3c4dc7ae2	a5dc9baf77d1d44f6606ec969dc0f484c3a4abdafa070733ce05313be57b0704d70f9a12d5484f98	f	2017-03-19 13:13:32
62f2562564f4c2b3a0c8a960e69ea4773a17a7112ffa6f14d0a0847adac595f1dcfa81744395bf21	a6fc027b29368e928216df7dc75c0841aa1a0ab3601e5a2c2590657fb7da7969ac2c0349e38effa7	f	2017-03-19 13:31:18
8af334a55032e9a04e040649425f4da2584564b0edb5b994228280ff1ed2f92f5cc5fb7541228467	965f67f4ea831e24e9742bca8224d9b2c66c44604c870fbf7a525bf441e5a4f4bfac707e7f8c42d2	f	2017-03-19 13:31:45
ec1d024cf7b108a6c5a4be6a2622d4f0c1bb315ba766e6c8fb4be12216e681ec63c92b3c54bbb213	51bbc3239eef8166911b644237ec2c1674f60f9f48bbbfa60de8dae6d36217a330a36b90c4c1885e	f	2017-03-19 14:00:01
cd884d74d12a1d1f5f31144801d6a05bc233b8ce721805d108af7b685c825639805f3f498c93194e	7a89c4e6e846059bf54aa4476f213a2d70bd2f80c94d51ef22bee16b2efb0d74cb280c5d9d6f870c	f	2017-03-19 14:03:06
154063c33e132813ca8491ca8bd763d4fac6c0362d6a3417822e2c920dcb5031919d5c3e52d96271	7f6d9211273e9123533a77f089983f3c291646d03ece79812ef73738edaa5f024e493efbe7be5fda	f	2017-03-19 14:06:41
eaf7945771c41eb4dcd379389561ef60bccef5701e9e3405c9610243ea021e1cc07d4ad7b60c9443	4517758325ccf537c1265f883012cf6e361997d2122e72282ca680961dfe823091afbffa3bb47713	f	2017-03-19 14:07:01
0203743f28e501e4290aecd3b94e3696ab91bd5ac7df1a3a7c1f78524d63b7e274d0ad301a4789a1	e444a2cf6008fc32543715a2d72c9f2c7ec604fdd690a2158597068d7bb2bb8aecee3b877ed56588	f	2017-03-19 14:09:07
42e2952a05c7aa00d3da322f13d7547174600c435a317ce13c9b725d3405891e36741e86b37b908c	a4f43454accb6ed59711fa1633ada9416b4f2cf74968d7a5744025196e0dca92f5b0a5c0c53dd4fc	f	2017-03-19 14:09:15
28b450128bc01e0c8db543871de6632b854377dac91c28dc14458c6c9502d462cf8ad7da2a3124a2	450472d00e8daf8fe423f3ca8ff2de7d62ed4174474eac2d308ba171bcc042c476e461dbf6761b0d	f	2017-03-19 14:10:35
c1d549d480263d48a1914d58536605f48ddb3d40c54dd0d947d79c56623777144a2b722ff4475ea3	b0745a628de7ef456ca92b5b9f6076477afcb68e3d241c44118126e772ff5f411530ac099d4490e8	f	2017-03-19 14:13:44
92fa1261f4682c6a39bce3c6aa35fb5bb84e99202b3153f9cfecaaf6b5ad5d39fd4984de72bfd6dc	1b93ffcb334b0da52c59667159514b829a1fcc692dcc55341a071ebe0c52047148187cd2b88a2a66	f	2017-03-19 14:13:46
c180ca85f81628dae00547c6576019223aa5bb8245abf70f33501d2d696b5897e3b752984895cdfb	ab823fc58363f073deb5dc754e82cbfb4f4e38fe3167b6c5f525d1f171be3ff2577e48fb0948e244	f	2017-03-19 14:14:25
e96c0b4beec1684596087a8ede6fc68eac35c1b2597146bb675924bc380f725d64db4bfc13d96b2a	4f97d7ca5f5da099966d50cfce56d0be2ad9cb0a55824b846287ec794e4e0090a744daf709413405	f	2017-03-19 14:14:48
ced66041c6870da0d46b2e8f571d36efee3fba0154e3821047749b6e34800c867cfe376033a2e309	c45828976e2ff1aa9e9421408d9211d17e9ce24f2bc8eacbb101a104b82f7b788188eb28d45bc598	f	2017-03-19 14:15:23
ca9f719407efeeea326c2841dd0087f0eb9dd80b5d7ad7eee6bb6b4f192a3cc25d593cebeb1292b2	1313306b978e75e6263d80ed087987345dcf506c87763dbd49762550d785537672518da19b118e7a	f	2017-03-19 14:15:25
e4813220d9222f4aac73062f9b20d0dab739dfec2520bd2d1405600bc5436f831cd9ada1fcf51a39	0c2bac69afcfce2ba9d8238f4c68627bbb92894e2c1af852d13137bb4540718611bdafaa2038c2dc	f	2017-03-19 14:15:51
f204e02e326e88d1d987e724b02d945280ccf1c77698a09718d296165bdb15de9f8987ebe39db18c	97639de41d722167c062bdadfb97b3d40aa6fc0f1841265a9d8e6411d6625a280724d8a186be4f32	f	2017-03-19 14:19:37
8e9f45e824544ef8d508231a68fcef20227f90aadb2871b0af62413c8cd4ad4cec0f34e774a7f551	c6c31689156b76e179eeda1347003cf2849e7b6907a3aaec9b7e0c176ccbde71f8ed15ef816094f6	f	2017-03-19 14:19:47
43465c8cb4e5a5f44728b02fd6c56668e5dd6f41c999b99fd99b2dc12df8eb9c839c53d4a07ff096	2cd6d374c4f10655956a18162fd7c170013bd59253c3ae117a73bb1b6693e43471f009b5a261a486	f	2017-03-19 14:20:19
9921e31a1c6d4521277b193e3dddf2725fcd4c67efc440e9fa701367e8717cdd9222d356ca71afa5	28d8d04ab7c4ada133aed97e4be5815271f4df3180a97dbe819c5dd230295293cf1fe94378ca9990	f	2017-03-19 14:20:48
a87080fdc63d2afc35eed0e2d54760f3978bb7770db293183e63d65a12a9d7629b067a867afd54af	769e3269afb7d995360461b2a12935da945b8f2f58e629f919ef483b98ef0d8007178cde193bcbe7	f	2017-03-19 14:24:06
576f7f284636a5c0c4345827e987106fbc16170f8d7999ed040c7d51b7928b25d60158e7194842ae	fa15d53e5aefabebb861afce636c8ff23e518fd703663457dfd9dd91c1e4bba96ebf0de8c9e31857	f	2017-03-19 14:24:08
fd6abeac975232ae387f5618593d029e6c0b9369d2a8d59ee85cd40c1d3cb44c3df060a99d7c24dd	69426b0b44b23e7a565973735a74aa01918fec3b8ec1c54fc52e0039e4da6d5428de8d9750c79e39	f	2017-03-19 14:24:50
f817e73db3ba2e82d6fe4324b6a8477c1fe2b8dfaadc215a25e93852d211973a213096342c5551bf	539053ae65ede94a848e2e86e0e5f509a18dc7ba27cf9ec10fd57f8bbbaee9aba5fe7ebbc7c36914	f	2017-03-19 14:48:25
d4bc773e92db3e865184057976341617a940ba66ea643e1ac65f811828fd02cdd176200872858d04	f76b153edd2984740b97e78407538e33cc91303c928e4e07a974a9d1872e7ae302b2db1569852988	f	2017-03-19 14:59:28
bb594025e0d9dee7b883b234ad8dc0f09e6121e7fd1e56b7239ea145987747cb2ca6fd3bfedd9c1a	2f8f1984e7a961a203618706efaa0722929815cb7da2b1b29b78aa7229a16f6a82a64337be4ec542	f	2017-03-19 15:03:41
f20fff21a79ad0be5456999441ea1c783b2e41ce19628825e096baf8849773e32e6bbb426dcc40c4	30bc3ac1018138e942d99e1084344000d31082615c5721b6f73fa1ea0b191eb67c340bd25e0801c8	f	2017-03-19 15:14:34
09cdcc59473e4d61044da43ec1ea782dab4cb82377ca0dc64a9fa720628687831845e092edff6138	724dd3689f051968201f9c165345a15851f5f08ff1d176fec53b7f29cdd173a58f3b7fede26dc320	f	2017-03-19 15:28:51
b168b1eb3a1f63c578725dfa5823b22b847b530c6eeae0645250d2ed0e69b54fe88293bc217417de	61eb2f59fb156448f6ae285dd9ebb141d08405516c95aa6fef030df12fe7f5391fc32c15f7b3e7f8	f	2017-03-19 15:29:41
27d6489234ef06a39d4b8f345feb660101ec3c33442676963ed43576432166babd324cebd28e71c0	b38f5cf9b71e959b84ee94a8a31e96f4f6ca5129f4bd5b4af0efe0f1b6ce71dbf99cec1a3bc30315	f	2017-03-19 15:37:52
941153c1dce6aefa6bb909862e642ee95afead434f0eebe807682c49a217044c49e0da5b1cd3f105	3528417bdc013ce0b933946d709b0a0b4d74d749debea561f50a35842a25b5cada4b322bd4fc7189	f	2017-03-19 15:48:07
ce850776d435c327a46db5b99c2c09257c0b2fb1dd6d4bfea7113fb0f2c28cc920de32fb3d6518ef	8f2dcebc9f0a397c50a4e3b5f15afb0927201cab8bfb6b19104ee7d03bba095e4d30be9dc44bc5e2	f	2017-03-19 16:18:18
e51a524863061ccb1f9252efe039c4742f648ebd60946d016fc78977e5a3c8313faa7d2e49363018	63ec15c2fcc62c562777d2ff207ff5ca610fc8466b60adf5949fafdc37216433d49a1cefacfe02ea	f	2017-03-19 16:23:25
d2532e2743be27b7081090bd22db0bd64850cca54f67f4a54d996ddfd88d74c4a4baffc4f8409cea	5eeb62f037a3c94e4643be9f5f334a41f28c754770a666ba604c9b68ac2b83d098e456a91b051346	f	2017-03-19 16:34:30
f9fbe4a477ece196b87785a442310c03e1ea6987cc996b209177c6005ef6a44ff5f463692cb6130a	21e8d9397603783fb883485c714696212c081ffff5df5f350954ddb67d5bffaa79372808c23dd34e	f	2017-03-19 16:35:55
b4f76e774dda0f3492ef60b689554a8b059f01e26bdbca282324495d87b5d10cf3094b37da4a285f	89d85d8ca51f0cc073569ee992567727c2b7a14ba5d2cf3e4f93613001a37eedd78a55a2347116c1	f	2017-03-19 16:47:08
4b5defc157ee6a037e903bb764d1450a59f313dc3b94e93adb860a25f1fc035fb9107f8d79c25581	0a74f96d5f5e1483e951dd58279504da828c4a0f8e375e88d358a4c55cbed768c15e8e28490766eb	f	2017-03-19 16:47:19
d84518440a75135f558f40a63fe6ad4a98d9f8551b835387d5e1970e09eaed3e904dba8123169b20	4b1d71a7f0b0046f26f3d956d1e999e4ced11ac3a52e8d63e00ef8851a9245b7113e508db891efe1	f	2017-03-19 16:49:05
89fd9da8eca627eea8a97ae5cdd4a2f1e2ea8e880ad530542b930753a315d32028312e58e24cdb9e	8d09304a483d0f734d07bdb752f40d63144bf5ca334f242c905daf56b02c57e50036137f9a599951	f	2017-03-19 16:50:45
fce23370fdac4993809dfa13f86c81d42fa38ba0cd4fe916bf211ea22e93a0d5c4f60370f43f2f83	e19603eb07ac1b4e6cd50f1e0d818d220f4f608c8b6518c5198c704caae9ec5f7d1fba52ef146abd	f	2017-03-19 16:51:12
9550f19823f0c9258d8304db9619d368b9373b16f160efec0336fdaad88b3be109f6c2ff2106d3bd	cded102dd382d196964dc8a4065f6c832a08ab97e63b4c9fdfc6d45edfb8f1fb80bce203e605f0aa	f	2017-03-19 16:55:26
73f8e94b28630b1ade965bfbdbde25a7951a7eff09e79f60f5058228ae87e2d2b1a16ce1fddb5e2a	2656c591f65117740444e69cfe8c442f1ad9353875f3d4e5de91697add59b0c915e8c1a3de1ae616	f	2017-03-19 16:56:55
7f3438781ea7f456c300d09ed5fca27860342e2c2d84c3b9b1ecd5f0721b8e8cb3982e6a6ff43025	548a13efe8f59c32f2d38b4ac7feaf6636cffbcd2202ab9a5309dc2d50569037ebb6f92981b02ab1	f	2017-03-19 16:59:05
c271d766cb601c734a1db14017d39cc05046b5262c63d619af3be0f7e70ef91ee92865dc216548ee	57e1fe34e81bf0d0c92b9b06b3cac48f1d8abaa6310aa573168fece9e0d24a6e93cfa384812c3ce8	f	2017-03-19 17:11:12
80be762f960288a1594ec62b408910395fefcf6bfcef9b4c81f290a1cd021109d5859caf1b316a44	3aec56c8aeaea5cd2786857c8d7aabe3de7c209d2bbd87862f98da343f4a88a3707b4a776ecae55e	f	2017-03-20 05:54:35
2a2d568454b5350b827ace7eb6f8ec5928c23034f7b2b8a07b6f60b346578340d5777eb53f1ea5e5	cd2719a7ea16bdd8f74591e6b22e7ebbdfce7fac2a1a26dc99a709a38e0aa24d2df9a6e464304beb	f	2017-03-20 05:57:23
c717fc0618cf63245244a9a8f3a43a94d294b3989148672d80f0c5bd83762e948f322f8eb25fb3ec	ed214870c7d3a9fdb5e748a6e42f332a9bb07ff76eb74169df564e6b08a36fde5bf742ac6cdff005	f	2017-03-20 05:58:19
3326776d336093b4fcdc166f9a88d0c97434b1e43b467076e4c2b030b95a341c50bf55c90cb465d2	01d152aeb16d2050ab9251e1285562a5638619135c39fa65d515602444fccc21250b1dd2b784d6aa	f	2017-03-20 05:58:43
c0749bd44a280c21e087a27490aeb39a0333c7e2d270f595a9ac991566f883b40c72c98fadbf35ee	74cd4af73c878f349a2344ba480c47390de16bab372eaf3e80f402892a968d27b1e22cd71c6f491d	f	2017-03-21 12:26:52
ef6cfa6c957e6dbc9b08b771f41638fbf56c922859cedcb2616c82f14d08f2acb4b010739cb5c12f	eae41b6eadad2ab2c6b4ba1f059542b4e15e71a615839bc2b5f354cb5e3a9f1afce5c6e8d522f562	f	2017-03-27 16:25:22
8fc3c9722c2f239e59e33f75d44b6b858c2459357ed09a4fe44fe46c05642dd6a0f1f1d6a85df2ea	41b2e962d7c12f0aea952c598c2ae8a981aa50a674f082136f04c8a7a784c8a828cd78339427919e	f	2017-04-02 12:43:38
b15a7084d678f8e17378dc3ef0e72f0c9ab2dfe6b5fe7c9f80f1fa0effd7763b8ed0fd1fabf9bbda	81d019e3a3d2d431157e7a5ab26bf3076962b9c031f8f4bc73f5174c45f43ed5754c603dc825c699	f	2017-04-02 13:10:13
53ce433abf44b59284073226171d57722c08b49c7d08cc667143a38007ceac461b7f83cdaf789054	b544a35a595760f8d3c2f8134c92fe43dca8c365672f2418f69bee1b882e19ab6f2073b16f195639	f	2017-04-08 16:40:26
6ea7ce5af91d3660d4b391ff722b4bb552f01b0e1dee95fa39004cb60061ccc1606803be28272e3b	714e7cead1ae5dccf539cb9abc6d13b47187ad8dee340d2944a2c97c79056b2fce0bd8cd659a8f9f	f	2017-04-11 18:21:51
cd13888fb89c5aaf3d6da722562f8083fe5e9e7409cc6404dc2fc307b89d9820298cd481fa2d7e0e	9792642d0865d09c6e7d265c85e2fa00111ac28eecdc21d82c2d81511c7182da02ecd055be2aa5d2	f	2017-04-11 18:28:17
452e58fe263ea5b4c05275e42b70bf74e97177ab9e062ad44639161544333b7fee2c62ac6a2be545	193db501b963cc5ba5ad2aa49ba7f91c662486410622e43673184151c7b22750eba5122e570975bb	f	2017-04-11 20:17:37
caf81139e41e544c8cf0fbacd31b6435b7b57f8d4cf2d8ec4b7affaed9b30b1100bbf688f2827129	aec88cfa4b3d2e2199416102d8495128cb7eb818e05bde999ac9786a6311fd1d0624e5724cede362	f	2017-04-11 20:25:00
36ea09fe398eb5a5cbbd5a94847420ff02597963b73cf8f86f318eb325525d1c8ea2903545db3186	f9d00f0a13df55f13637b5175d3d278a76e862c7b0be0c3c398efc2b50dc557d4caf91379234008e	f	2017-04-11 21:41:05
b79ff14c5d164d3af47edd3baa89fa9916596b6cf2d05334c6605f9ba092560f4c08fbc5461c9b78	e89392a933b43d8d0e7bded0be2488135fc31018b0ed0d40676cc7afbeea0fab60426ce6f2bad68f	f	2017-04-11 21:43:46
873616e3cbce36ab92530efa46ca25ddd88ad9d6455bd3d43f739ffa6335aa91f2f09547feb43970	0b7783b57a5f485b95d12e4c25b84ddcc2cb503bc0fdf493350d24e830bc8a9738f54521ee6486a8	f	2017-04-11 21:46:02
787c9a775ef651b31b11e72adf878d411b4fa3bdc001406af06d9ab3aefcc743a782e689fd730a57	7ff715acf68a735dbb2c73d5d8ff0cea1c22ab661c82795c7ebc67a8a51b19ec9a922c87de4ad3be	f	2017-04-11 21:57:51
a291532fca49d538adbb77555958a130ff64e46c4c3f82f9c22eaf8fc4af2c0c7b6e9abe6bc0243c	62caff89807e20db4fc327513e128311a863fabd8e09c6ce6a49b17ed1e52205b9d98a6ee4851528	f	2017-04-11 21:59:16
1343a83531e77848df8f324b9f7a491b66bbb20e1c79f3852620981ee5174ad1070a37a91b2fd7fb	f530bfe771fdca9bc28d093125fff6d81cca27e700db92c99972876a05349dd3ba413d73c89838a3	f	2017-04-11 22:05:52
cd3e15ba9fd950717c72edbd14e0b2cafb41dc1d203714572a8fd5df400fc615b65847af847c90a5	c4bc9dfa983e9e449f2e1230cf07bcb4d656c39ed5f80ca34fc55471ed32f60242b91fb00c326e94	f	2017-04-11 22:06:04
88b95547f0a655a74e3d831cefff5435471541bdf338f0bceddb3c22e71fcc5c511fe95671c4efd5	54333fb7b57cc2bd8b15bea969f67ba5610d261e8fefedab0ef61ffccd52577bd42eff0b87663003	f	2017-04-11 22:07:56
1d03de92b6725aea446bc27dd8f42be6a5bc3cfbcb46a869c66643e3e739c60079c07e3ad0253f09	a6d7c8d46f6b165cab74536f2c226d8a5574a65ad43940565114b6473fb3d5408025e8cd3be2db82	f	2017-04-11 22:12:23
62523645cf4e393cf66df29130658f1638999f03b5ddda5583887cc6eddf880d152f41c06c38674b	b0ca9df9bdc02e9005a177f8cdd36d031edd64a4ad5f84bda3414285161dd5e2fd7ec545e3dd6513	f	2017-04-12 14:08:03
ee15f588bea23cafe7e8db9bbe155da0b7e5dd2ee73e9e537341798a19a319c20400c66a4a2631bf	59a1fccd2cbcecd6c94877a1bb3895610420d4e45f73ce4f809aed1809d3990c31d40c28fc2b0c91	f	2017-04-12 15:07:43
d434c92bd827f6d743f046b9f2f641fac88b51ddd03033ac7805acc7de05af3107ff0d692c287c8e	fd776b88e2b66a5117a487f8346201f26eb50291ba99e823c17e3269d48c53e20d7925fe0862f868	f	2017-04-12 15:10:22
01e49df4afc3660d14adf86efbb050654f8dee113940273fbde27f0115cfd2b14d4d18b3909ae974	3b7f6352dca3850afbaa8d411a3807ae7e6dd4e92ce25d319a148dbbe25c6a19816758fff7dec193	f	2017-04-12 15:51:16
681f5d48570d839fd3dec6fe1215618b95ff9a827e879b203c1c3235f5774b70110175496eee5fbe	6299f02e3bef9a02f2fdfb7a535072190e1b3d62832a8722fcc0f8cae567d764b3bf4d97e12d7a30	f	2017-04-12 15:54:46
5606a6e61d1881acff1ead1ee3dce7488a8ae124047da1909a660553d0b238d404e24dad2cbfacc8	60ba5156c5f54e5702f51c2ed16dbcc092bf53beae569ed64eebeb0a6058943bfdfeac2b7c407af1	f	2017-04-13 06:14:01
827e194d5615a77aa8e52b577d7a0cead3c2881037b98031d4019f4962d47fd8c14def2da2754c79	73d3b3d7444ddd54f6125a02e0b1369baab8f422de6970aab08f78daecef714dfa1c54f3dd5b1bcd	f	2017-04-13 06:14:10
7767bcd7ad5a971267f4a0ba9fba3d955b7a0598181d8a060692ff3fd98e4c19f2f2114c7e79354c	abc5cbac390b1cf3d62c17435eb776bb48379c69e760af8ab26073fd0b8c10332280d34be432f855	f	2017-04-13 07:51:07
378fbaed35e0a753ade8deb213d838908d04a9d960cfee92a4ab913bd79e976a129b75c310f1407c	69e93ca147804c7b0790a9bd3f9f5661786b7b42e9c76b7548268dce4aff3010dcb2394da3afbe2a	f	2017-04-13 12:45:05
289daaeedc5f36adb549096982cf467c4fb15f2aea1f3d98835bc4ec46c6dd90c0f2c6cab36dc78f	14d45fbcb306ec1efdc034b02a1ef954c5ed8e5f75a6fe7c8960a07b4e97c3083fcb132f457fe3dc	f	2017-04-13 12:47:20
b4e3630b63276b519b8e43e5a956b5c53b982af19ed8603c49e7143abbd74822df4d3b5797892394	0eb3d5883c0d665304b2bf2df167f44a96ba53f153e8072a0ec011c6f8ad37da2c2874a14271a370	f	2017-04-13 14:49:36
a4e308003db656113aba5ec54ffc79ddc1e233718f3490efaa4ed79bb9cf2ab6b0a8f3576cebf0d1	9eaee651c917cf80a85ad3de4f76843f3d49a2a95d7a6af6980282df004f68b4c7790bb24b30c69b	f	2017-04-13 15:42:42
34bd59813695984f206c193ff1c8cfc64edade5f5d86bc8d88267841b44836fb66793e7df7b5bd5e	20ff9d1b745b792df6d5f762faa44b223bcae861956012be35ee37dda28e92bb51f01741bf9e942e	f	2017-04-13 15:45:14
ecfeaf7e848ecd0ed011b53bc0092734e05fab3d2e097a704aa6ed5cfef7917ebd91091c7383f496	07d504757d7cd5710a6c0e526890cab789b301f1f832d62f30c1d7797e98e66f0ca87a25d104986d	f	2017-04-13 16:13:19
76ff94a2e38364987fb80676240fe6c7322ae35ed7390b04f785441b217459ed9fde585534e9f6b6	07d5815dc66256479cb6155979e5d50a2ca9c4cb46dfe34865e7d40c9325d11171fa56090abdf7b6	f	2017-04-13 16:27:24
aadd98ce4617f5fe147baf2f4048c5a8bb6999f8f566151943ce12766c0d162a5d3abb4fb986ff68	8d06dbc142e10d0fab899b3f3e14b28dbdfc472991c04952c8794f3e399b4b32d65c406796e0534e	f	2017-04-14 14:58:48
d371589032f970330c2f0f848dd022a5107fa5d7dca840caf27f1c7c1461204c10cc504f610ad300	bf4696ae21bc3987bb49479bfcda4017a11c2d2a14a19fbe787082975e1bb4367f64e963c78808a2	f	2017-04-14 15:26:22
b7860b32ee237963c2a04f4ad7287a6b15ba1a2fb39d620695b559bd9839a071772b6a09c97f66f7	c21fb70bda51bebb73afa92d75fcc310a5dc3db8fac9cdb1f85e22a79aa83940b8b8bb1196b67609	f	2017-04-14 15:42:51
d1b54714feb22c4e0e9cff9f10c826de41329d64e1405b7f76957f8ee3623d2ecadd5e54b061119f	aa1915f1bd4d044541007566f9cdaecd25e7b8167f10a13f413b47618696b0f6fa678dfc7b2f327f	f	2017-04-14 16:37:17
bd10458f8b17fa0619b71af86bec2ec64f81c2d4b777239f5f58b9bc0cb6915dd5a3c70a7e803077	e7b45679c30cc60f05e8fd8f87980716a234659b1ec35983ef903709b892664981cb1effac50088e	f	2017-04-14 16:48:44
cde72ed30adcdd484aa728d5f2654b27a479acd006715d0c6e10d0cdbd5b00f38c0ae5c2a074a608	6943dfca75ee0397b27a92575241a8987a17035b0f24bbb5a0f25025d6610a42b7bd4939b40c9ecb	f	2017-04-14 17:43:30
f8212b35850b1aefcd1918aeef025eb94c98748e0e4e37c1eddebe8cdef921431948747f723752d6	e8246cf98ebfb37668435ca20a25b95388d881702d616dd9f861ce1c4a83039bcc68003e2e60ca19	f	2017-04-14 17:43:50
4c1bc5020a185d02f627d7943f5e0a97e84acb24cd004ba31205da29a4dda44e2ddcac048ac04f8c	5487c63c9309719cfb95795b7d0784257f6bad47a462b8135ee6ed25265862c7ffbbdbb4f8f4518c	f	2017-04-14 17:44:12
2f39bd3d76624b6b3ad58bcdbccae75a40ad8be642a39c15d908bf51259da34bc79dcb1ef30a6ebd	57f266e183a2c70b2f0bfd467bae709bf78da9cc412a3a717b5e27a36dc1f5b93def0963df17a297	f	2017-04-14 17:44:27
0d8a1c4702843d679637e46a420c21b826aab490411d84c7302a8087d752005478064e45068a7660	a938ba13567a7ca4c4e3f36b6833e5b2b90c954d1b298d98d8c505da6d2508ec80cb88762ad7aaec	f	2017-04-14 19:28:10
b32a877564095804983e2e36ce2aa91ef1dffd44a48d41c7df21761d3b7c0552da455cbcf805772d	23b10dddfc1c7dec36b2ce76b954376744f10c7bdd5a944a83bf67e26d1f0caace1deebf680ba4b6	f	2017-04-15 06:07:45
09b32b814fa1f0236c21fca0a0a1f2046dcd7d130aa7a4ce62a3e755eadec0f9d50d96aa150709b6	783be7ee6856d11e163b485787fbc8d8c649ca85835531c2a7296d8f429e56d31f5d9e277432b0ee	f	2017-04-15 06:36:04
37af7103061e5a38763485e44fe7711acf9a6da6f3fb6a7dc938c03bb9d9612f349163473c062f11	720ee83b010a4427138267669e1b8f4a0b04f89e0051e916b5ef06f61c41f9c23f00980dd96a8060	f	2017-04-15 06:54:09
73252f34918537d1b00ea439e2342492c5530120303e5fe33613e777b1f026cb3692c1db987e16dd	29295cc3f2c8cdb530c7959d364347a8d866fba98f91fc953f2492a1725093637c646cc430ecf313	f	2017-04-15 10:38:59
c68a9fdc3fe9fc9c7abc43b5ca3c35b680dcad56d2fd47133aae5369911068c54c75b46ffebd7044	26d0e74f35e530bfc61a5c9de26edd26c8b8ff4defebd36e5f9ebd875b8506636e719589184873fa	f	2017-04-15 15:16:07
882fef32b565b5c95548554b4f41bd8d880822a7f4b734588b5012559c522c61e846788b8b5cb89c	494721688b14cc47a4923d3786e5e94a7d0a8e8bd145b7adc93b0ec95272fe334c3fac469dd368b1	f	2017-04-15 19:52:03
65c770f4c9b67b6c122ff0dd018817ac52dad6549b1b60aaf5fdaa04a8e078ffd5bdbb6f8821a7cc	ab34e243f7e496de2ea3589d428cb1679590521f2e5d384ea9527699bd23fea2766543ed3be41c61	f	2017-04-19 07:43:21
1e839321fb12767a2086c9a915a66888b00109a498df201bcee9c86075c54e49e37496e5f2ca72ac	dfddf51baba1f0eaed28a0ddc3812abcee1b800f41822479c01c62517011a24439e8448d8b34bcf6	f	2017-04-19 10:28:14
a8eccabaa21a5d4420612d11000c91df2fd1b9314e0f5c36c217d48326580a0a4c54c56311532edd	9a317cd940ed2a99568a2e64529a0bdc202976896e7acc20bf214214d51e8c5f55c11385a9a4a110	f	2017-04-19 11:17:51
df470966ae6530ff8f9da2f3cc46615ad9e685781e073358da7d34247f692d6ceeea9ddc01894acf	f009f0bec7dd1259df581a36c52a384130b3a6cd199aa9b6225097c8d66da52eb6c947ce8ce7e3e3	f	2017-04-19 11:25:23
019dc13a90bf5e9677f2f789644eb39ca68762f4786c751a09062393c68dea4119314bd2b2242c7d	509ecd93130c26181572e5d5a96220d477b952295fbc2c6c5f20a5d2a39ea4b1d97b81698c36cd21	f	2017-04-19 11:37:31
479115130890a56aeb1465bff620590c34009935e976fcb83df0f870a9f8851dbcceb04b998d7908	a1208094b360fa97a623bb203b5576b26cfcf2f79067e1cf35218cfc5cc7a69e806af14af3dc7ab5	f	2017-04-19 14:49:23
c658aecffebc4c4d76fc635de6d3850562f542efb6b07a48aaab292ddad9565ab80dc6943695c6ba	02777fb91836c8566502fbcb52dfc979eea5971ab1215cc9a6d63b662bf6feba2224d93497940820	f	2017-04-19 14:56:38
150e183bd1358c5356100825e671f899d698960b3a5937a755d6b69d0013ce15503b6ef7b4b88792	d7d48425f129cb4dbfb75edd3fda4ee140aca23b60c4875925c0820ad5e377eebe0351e089240061	f	2017-04-19 16:08:17
c1706b38e57df10279dc8d7daa55d4764ec04d994a65a08555e1a44248e31ed20a15e2631120bfe0	83cf7939627b25dbd13f44eb1e9cadc7649da57d5da386783dba005432fba8a2260ac49573296eaa	f	2017-04-20 08:00:14
4ec08effe73aff8c17ce1872235a9ab6c9856eb98bfd17821452d4e285dbaa5b5771fca148a259f9	6454ad65b676eb467322a0c658e8b242826691901babcfca57df0d7e9a6d644d9d7adf114977626f	f	2017-04-20 08:14:43
b7bf6f52bf3f3ca255469c1e95b636feb803ba26cb5adac8de0182fc23e4e00d71ce2dbe5904f761	d04c150c699acf878e7cbaec60cd2e4951e5a1c5d89d2875f353836f07833e108da1cd02e3fbe670	f	2017-04-20 08:18:37
7486b97de8d826b908b0496c6154632d61b8262f829914fd1e6b180ddd1a9bff2da7153bdbefc754	b66af112033aec960bdf514545afac8b1818501a673e41e9d2aca8bec5be6611d373ff7ea1f2ff5e	f	2017-04-20 08:19:19
6d139af563c598cabc8266725cedaed32d80a10f57c742fd4501fe48b38d176b2594a2c893207c53	28df11216da1f82b2a5194af75f76de15bab43de03116a98de57ccd7e4ce5788d688d2b5c08d3320	f	2017-04-20 08:21:19
650f4b6dcde936e284054c05c108a5bbfaeaee7342576b59920cb31e0325441d3bf132519d4b7de8	7ea8302b6d64a762788f465aaacbb782d6926005492b102796123485eff47e5beb95d20d02a0f806	f	2017-04-20 08:22:45
17a99a38a41a54232598f212b29b43698e5003607fe232922ee7739c4b1c181e1235de141109658d	b1f5caa20eaa5bfef506a0423e31031fc2ac939032371a7575aa6693c9ee7479c977b8f34de2d207	f	2017-04-20 08:23:01
8e52daadfc800a8e1b378d196325fc25e817c2cae31c3609b1a5ca47246645714cae8962c651545f	c3c937d572d7f65253d561b8ba2a237838f0d5e6fd5745a7b3523270922e91b5ce04be9d32302b9c	f	2017-04-20 08:25:06
b4b0ba0a31f813014fd588aee14ca59c246dfbd3f902c1add489edcebddb5d80e050c14c5e4ffb0b	6f66c9201b1dbe66d0f566412b45511bfaf325bb164449e921568ee0a390e12a91a8b229b6058eef	f	2017-04-20 11:01:43
0c6002d5be0a9554c1f951bed2be8d26311724f82d2a35944165341da24b952bdac67d5252d75239	12491324d26543f362395bb9ce025bc892827642c36e5a6735fa4fbdbbbe72e1a36973bd858e64e6	f	2017-04-20 12:07:02
2e4ed96d92cf924ce011bbd018fe75b3c8fad5659fa55fd0f9f64c573d8353e0426974583831eb8c	1b55aacdc5a6b0df33b59f2bb0140e2f1a513c8e2863ad3ebbf9e8409a0dc2d8a6fbd7eae9f7ef4f	f	2017-04-20 12:18:24
64acba580101379ade129c976e1038e14fee37e8f40822341e013e733c1bc29a35377038ffbf9b82	27b3512530842c7c592b494b985f9c18b3a77c0f8ce23616f5e8cea019143ff9ebff8b3cdea47589	f	2017-04-20 12:23:16
aa2caf5719d655747af7f33ab7c60c1da1c33b0627ecec64fd39a3bbfb57fa7ea8d31790b67ffb2d	1eb20eb7e35191263dde7b8e304cf2fb6cfac069c0214725126c8d8e4a47027596dbf0b0977f0a84	f	2017-04-20 18:27:36
d6f75262c9e4c578bd81669d048c0b0dace032196fc5d5996dd05df2e57b9dc0e84cf215a6c1d00d	6e377c3f4d78e18ef3efb8a43daf6eae85584f845b9dd7407cf3e9c186e0722cc80e8e90312b9396	f	2017-04-20 18:43:30
c573080ae1baf8f51798fb4adbbd35cd3535f911e40b8a97ef1a6ee9eab80ba8487a27f2a43daba5	aca1e88030bb3cf073f84992b501041e9f30a7a89f1d1e3ce87f513a3679273c5b4e156bbdc347bc	f	2017-04-21 06:09:33
7f354b6b160825ed155d245af1781fffb0d61750099dfb8b97b08eb675a8536cbb77dc37fe817745	e4d7dcf9f85238e30fb5c0d105d38e858c28fa206b943eba23040ec42a7840b816e66435e0143b4f	f	2017-04-26 06:10:02
013040eb1c8d266a7743a7a0d642621bd48adfd77e4159685a6e572597c35f51318f8bcfbc758b2a	b1201aa46f36ad663a29f549d373aa3cc979ad76b5178d635ebb0666d37e1ad83b656a7e41fce88b	f	2017-04-26 06:44:24
264cde9b7afb82bbe7c279594a32c982e9992f69a81ef2c7ac3d83506b225a7a69a2bef080f97c93	a3167df9937c420c8f8929d5cb678480b77a8033bb34aa0714b712796c460149cfd163fae22ae35f	f	2017-04-27 06:10:33
6f377004a09290f609c94e99fd521176abd7d17eb6b9b6621db2383d23eec03fa899eba15be9a15a	82b5c4d252a9a5b90ecabd46b27ff59829fb3ced8315ab3d4025a8a3ec24e9b1606bdd1086e51fe0	f	2017-04-27 08:21:06
3d12cf03a43cf6c8b079918722d3598b9ec77ffcad8aebf194d2f4ea7114ada8db4ade861054b62d	216fc92b0305bc479c3bc3590627343eb6f950d4abc43953648ae065b8fd4da87fb5d99e064fe0d2	f	2017-05-12 07:36:03
cbe8c8a09348a4470c7f7b05c6b6e01e546657d1170944ac9c9ecd7448cea9340b0a1642a19a9181	a3998f568830a4156ce85ba2e2be8ae9507a66dd64053389ff5607eb9f7e9ef1b798de96c15c7b52	f	2017-05-12 10:20:45
6c2e615dbc22fd6a2f69601da983c41437e4a6ce9feb86cef82f5786e796c506fda950e1b61aacb8	946d0200f51c370312210023a9adb9099a9aeedbb990c0f3546168f33ed15c9567b05d58c4124bdd	f	2017-05-14 10:11:22
dd514e645d5a1586d2bbe2f3ef21ee0044e80140ccf14678e078da491fbfeb42f248ad497bc99db5	5669d06f4dbbc056fa7f2dbc089c9bf48bbe00d22391bdc94a040c189a12bc9a263ab5a1d6995116	f	2017-05-14 10:27:40
879c73c850a48161cac5158d87ab1a445f8b2b2a928d046e3ce41df5612054e7d42584c5dcd9be0a	6e1bf47de66622d3e3d1d3b37bc31b7bf6715d13de3c299523de408cbb563e320d382672daf9c8b9	f	2017-05-14 11:25:38
fb11a630580b363bb39691cdaf710ab7570bd5abcef7bbdc8584d3dddf90463881dc6f4a8d4a83e6	2c8340c5e70e3533c7468dfbe23c478fd57f025fea2ab27d60c1b7f55d0f2040729f554127d46d69	f	2017-05-14 12:00:45
58b96a20e7ea33a400d7b3cfab1ef84ab2a8af81e9dc7bfe8b1e84e6ba7757a104f0b92afa6e40a6	3e37a09864bcd0dd9ae0d215c9cc16ea851357384689f55d95e7559d054a934dae550c768f415956	f	2017-05-14 12:55:03
59f30eb7ff1b68e9af9b7f73168caeb0e43185c676a31e7061731ce3a58ec01e056f0d92b39cecf7	86754a498037200c227ebc6d889822775e12b5f473298748018af9791dd2c1b9496be98d160b4928	f	2017-05-17 18:55:33
2a4341859b44e6c472a84f9a499d028e61f38b025f9e67c0f17dacd964e45f93e0fa70aab84dcb38	72a392705d19a64da36c4afba6e1cc4d9355368ea86cedfa575b1fd85c685a3550f94f5ebfe4f091	f	2017-05-18 16:16:32
05e29a9739fed620cb955d0515a47227a0fc51539854053b776b911cd99783ebbc2c5ad740b6ca28	a3ee1c21d0f97000dfb6231db730ee0b4fcd9e332e05c24f5302c087c8e8cafe05de7698a8b380ed	f	2017-05-19 07:15:22
8f6d2c521db5dfe9844db28787fd8874156c0d88805733c2c88b5848cff09fd8610d91bca8dab466	653e64a65cbc15a46c0431529998d790e3f2b79b4f402e0069a8dc9265dd0c844ba4a90adac755b6	f	2017-05-19 10:02:03
890c7bd51a088c09d9ce481fae9abfed7f8fda95bb3dfca0a26734a4073a37b961f15669b1334782	f8298f0f0c387b1690c8ed07a02eddfd4b69fb17e2b1e77124bd0841a65ffd5e8ce36f0d8801a04d	f	2017-05-20 08:01:23
75e4ca56f53922d3cdcca0fd787a6e1490e9a067a7c893e91762e9ed2b97b1146bf7c5ce11fdd273	cc95ae0e321529bf565ecb0bbf80de3442cabf54576eb4bdc6275139e84e548f532f66b576801c0d	f	2017-05-25 11:31:22
b1b0f3dadf07b49c9901b1b09badbdb3cc17a57881ef60e4d96a94998d0fe1a30ad2ea9600271a07	e72efe2354b89a61f9b6e05f799f2454deaf9681a12d6cbfb46b87e6b6300479cb94cfdd8a6764ab	f	2017-05-25 12:09:04
81edaaffa463a27107c1ba2871c9d9e690de0ffc6304db1331c8f13cc93282f54539ea6026636d2a	3baa04e260e0a5d968bae045f70d4c511aba3eb9909eed538f34c724cc1ffec05a29416c97f2a152	f	2017-05-25 12:23:01
c71b3fa6710690917238dbcdea90d16f3d03ad7ec49798dd5781b19f77255090f7cb8d9e9877796c	203d7ec3d8fa2e3c8a57039b7bf3cf0ab49032560932e624bb4710efa855105d1700a39e000921c5	f	2017-05-25 12:23:40
039602fdc4d337235aced2f33e043f2d2440860e9aa74add946505e53dcea1ff848a1286a4671f86	af544835ac4c62eb75fa58f3d86558b963dd9b1c668a20741bb041b946f4f044f609ec0e0ca5ba42	f	2017-05-26 07:05:39
17928e8a4cf7f76a1ec9eb00041c86cfbc677ba351e90d69d6277dc7d3a17acaed3388419c512770	0dd4de16e156a4ac43e8a4dac51b283bbba18cdae36bd158aa710334e3cf878d2a85386588f9562f	f	2017-05-26 07:08:54
86270c4c28d7c98c1167dc1ba24cdca1aca3097939c164779577106297eecf5aae4cdfe490ffe95a	ce94dee55872cf3eea6b8dd9958e558c22ec31c1f37cf239d83c76360a03421b46338807a9dd4818	f	2017-05-26 11:06:59
13ff2fcc1098fe19965c48a26629f3871b7b3ffb4cd6fdc53314a6be04062a6e8b1f9096ab4abcc2	026e56b2faf132584ffa89b8370e97b28128e66e63e251888446d91b83134be8447d9b3d692197b6	f	2017-05-27 18:21:00
50429da1188e1dc48474e937ed0116e656094adbebdf54b65609a7df61a2f83f2f8ac05b7afaabb2	302b5d9b409a3014600551f37e86485c2e2f4a4ed6f1992465c5340cf5e9247587619afafb72c984	f	2017-05-27 18:21:54
adadcd6c149c49ec617cb10aa2105d4b4f941d43d96131657539ef24304c9ee34d33170d9c05d085	ce3b7f3863da4fb267346df702a1cfc321b39485bb0fa3a715c4e5c28198ca49cc6d83fd02c4ffbf	f	2017-05-27 18:23:05
5aa9d427f2a30c4d6af589dd2e3b62d9f39ca3556ca30cb6f580dec4c9320c6bf5eec47cbd808ed2	1b61dafc1e79aea95ca1efde18193c194f82a462afd91b8faecd6ea9fef227a6d66f78ab0e47ac65	f	2017-05-27 18:23:41
dd16178d5ba7e7fd23d41ba072d98619dfcc88646b38581baba0cd176e97fa2d60ef11aafa414850	47f16e57cc20db19c7b4c13ffb101ee93eff08bc4efd5bdd068dbc0d0efe2c1e4572af64c7934c58	f	2017-05-27 18:23:56
a07a03de18d885d082eb62988ced7d0d7ce901ab7059091b5796861e2ee4c8b1b903326c1d1fb0dd	63c07eccd8da56fcce393a467e1dc41d07b6c9a0519cfacb2a4d8ea510397ca3d74929dbfad72af4	f	2017-05-27 18:36:03
1b6290bbd0d023ba429c8ad0b4f858fa01ed4df863a19d0495b20e3565a5894727d037ba453001c1	11eb7156d5fb73352d18e6ce328156816f39340c33dc17fce5ff57b813eb78c24d83fd94a9c0a0d8	f	2017-05-27 18:39:10
64b100e9eb20784f32fd7a14363ad92e326c66346059773d9785eabed023105ac991dc990ec02c85	45ade95af0cf3d33a61234db2b1eb2930389819f6d537164533d83ca586a72bbb3028eeba419d19e	f	2017-05-27 20:56:15
a67b43690128333b3d55a6526b808459148740b3b99965a3cfcd839c3757be0b022a88b377969341	40feb106522b08232f2f24bc39e2ee9dca4c63299245a2683e0a2b2b60746ad39b52c97916eaf16d	f	2017-05-28 06:44:29
74a017e60048d83ee7a1dd056fbe6ea7526d45bfddc403301ad5c8d92556bf1dc1fd7e068235ea53	c3bea3b3e092c878144de6fa3f3de2b652986414ab2fa4daf0303d8069087342d62efb9c644698fc	f	2017-05-28 07:34:44
1ecbb20f2c8556d2a99e1d29be074a2cb8b52657210a9ad49af4cf038e8065b651a8b0b9ff903822	266653050e8fa6a491f2e282872802f768f6a1606189e30d52d5a9aa9f25b8f11cd19b4f6e3bbb27	f	2017-06-02 13:07:21
cab31dbe61d1ab87418ae3eb8244ad50427d5e5470a97d054d4107f9a1d4e4561d5b86456352e46a	b5a3f6e84f11e9c778608a08eaaa9c7437d4d0d141ef47fd95c774c60830b835ea46c280fcb4565d	f	2017-06-02 13:08:23
1f8b8290f794bc68be841184ebf07072571c49549b1d9016325a8056303c447eb1b2db307ffc8c82	2d2ed8ad975d2fe8a16ad6a909b22aba0e6c47ceb5a71f01113aefdda6e2448257fd7d9fb0903a9f	f	2017-06-02 13:22:01
a4636e89150fd3685e16efb2ceeaf4796b2ee8931eaa8a5de618ad0aab4eeb72f06fe471f5555345	d7b023cb82259a03c2942a62274d244f5bc214287fa07e4c01e507e2444a3ab4f2c4e9e388283706	f	2017-06-02 13:26:07
41c8e1b80c2ee0ef6fc97b5912c5d6caab1bd5710aaa7f36e00d0ac4af883a6da40eeb117971ff35	8d8caa49494db756c26b3962b04593cfa5c3ee80b903708db384df4199fc7d79fd0d336a7e380feb	f	2017-06-02 13:28:07
972929c3a1d6bf12515f9e403f5dfbc3015946a9f4bc2bd4afecad1a34988441576741314d2e09ef	093d6280122d6df940b4ebc6abd574081f7e03dac3c360581869de43f7c954451dd7668f7890adcf	f	2017-06-02 13:29:07
b00568aa793df4ddb9b8db60136545f27a8bae76a8d8cf4323bb1ffc5211441a2cc5201861a43004	6d7ca368223d036eaf9f12b06f1f44519272b54255299de4fab0cff6dbe7479a0a3d3ef01cf6ca52	f	2017-06-02 13:29:39
6093c375ba7630751d1d232301d6a7f506db4724515f43a9a9429cbf8186603da32ef58bc9f78f70	d72298d32efbf71f72819f2e5b54f26a0784d7d0c23ae93ccc323ad7d15b84065ebae4c75d8068bf	f	2017-06-02 14:11:21
0eb2a932bcb199295b58de5b33211a7fae2863d5506aa5e0bdb4f3c45260d990f1e7a94a50e7760c	80567692f31462d7554ce4c47569a09694c12c4f076093d5506bf74cbcc2d91f20fe9a8bfbb873e5	f	2017-06-02 19:35:08
09dc8ca4c8aebacdceaed56c96d4b6e4668bbce501258aa7c9a5bef2dd231397ee516d70ce6151d6	28dc798f76fa9bd55973f710995dbc6893781dc5843aebfbbd6743c2d31ff26107a85d20f597cdd0	f	2017-06-03 07:48:35
41a05a27540e7ae8abcd08aea5e417ce572283dc241362514ec0129b4eb3eb594240e6ab4da38656	953a8427ebee1dedbd9fc3faeb36068b5a367a8fd9fe2f2623fbac5daf3300a7df67afc99f0bc229	f	2017-06-03 11:49:50
026863473934fb5fb509be9123dcc12afb88f543e9333ec4825aeb9f303dd2c2222bcde1ff0dc513	c010dc0d36b9665242683d7d13e50aa9a18bade877d964ab95c0c8b9427a78180053d83bfbf1ed2a	f	2017-06-04 13:25:48
b9a25bbc7f1d1ef810801242dbe831de65dd63b6b93215ca345614cb1a5492c82f29516b2e070605	8d02a1223ffa72a4d198b635b37de293c4de6b34645569b8f3698a715edd97f05060bebe8ac0691b	f	2017-06-04 14:05:17
f3cecf913d578ab65eaabf5440178f089aee14d87cfaa8fadeca771045b795795579a427d85a4c92	9082b4e0db13bf65258a1166313151a8fb5eca8b68f3130fdb89286496556ddb69b0775f05faf691	f	2017-06-05 08:20:37
77204f5b2bf9fa3b273754c13351cca987d487464168918ac9532f5502de4594222e4be7499ef166	b66492958eb663cbf5b6b2416858cb5c1f98704c852b947e7adc5b47af601e4145d84bac9221820e	f	2017-06-07 19:21:30
3e0488924fbfe638ca2254c7ff2086e6b5ca1fef26483c3bee0118714add991465bf3df14150168c	3fcdc7b0d4d16ac0879097785e0f074a755d950ee5b43fae1c9929acca84077f83254e1637773046	f	2017-06-07 19:56:43
8d552c25cc811958973b8ec4dfe2648c36966dd2a31b623ce35a888fe5ce8de607ff4465351a7578	680c65a4068bf1f514156d9b91efcd2a80d931c290214ea8b70253ce26a31098fb8f650a70a638e6	f	2017-06-08 06:44:33
7363c8466e08bfc81e8febb418f0afad722ee706279619ac7990e066dcde4a019ad7cfae51527425	279ae3c261ba4e1d077624596f03a6fcf8059310765057300b9c938df1d0f2cfae68aa2ba33bf280	f	2017-06-08 06:45:43
98393a745abe748a6a82a120a6e9f4c458ded27e40208756dc908b1d165b01ef996c833baec7b4a6	9811c3bd6f367f9c449478396ac3c172749400cbc109dfd206fd3dba42023094d4e629d8e0e2ee3b	f	2017-06-08 07:56:34
c2fffc14c7b8eedcf6aa37f639f12c86079079bbcf970e293b97cc129b0201529d11c964a688cfc4	5d276426248e67bfd73edf829e03fac5c86a7ec51c2ad40d5f749cc119020a49f68caf707bb9f6ea	f	2017-06-08 11:34:04
f7753dd82c5b8ba83afab819c5b9a69057cd9f4fb50dfa9be67bc7e026debc6a420181aced880054	418dfad0dc07d254b3b71acc27a6ec54c8ab8989c4e7f4ae7bc0665c1dc381b4c01fd2823d7aba1a	f	2017-06-08 15:36:56
2dbaf323bde60dd7b21c029640bc67af48c040e82af06f26268d851c3d4c004befa9c2d0e000652e	8054c55dfe9596ccacf61eb2ac0e3a3635f12e7675eaa0d138883dba7ff8a7ebea39a0da13e24352	f	2017-06-11 15:52:09
6c9cb1466fe55b2a00458876bb4c1d1f1427575d88f5f6b225a5608211f207fcb19fbaf6b8fa743e	d8498969c99d09be709bb2ced949d70c541537188c8e17a3dcfe6fcce0788670f6871d3e4db497c7	f	2017-06-17 14:27:16
789f06f0771f36ab00343bb2d5300ae239a1595e8e6365e1d4c975702bb8c0dd0a861d314025c044	9564e97a1fafe0aaf2b69b9508b1560e282596583de4dea83a1010729a1dd96a29e19b16d408d49a	f	2017-06-22 06:49:19
f0fded73fc0b4e194d9023b0137f61fbcd4b583eaef240376aca4d1e66c2b3b87e7c87c392f22389	24bea7f2a9ef752c2f820f9fca2bd71dba19726a68b6a8409ffb0778f463880ced79052760ab5d6b	f	2017-06-22 06:57:36
16c918ddfcbf3cf9e3b4caba0c81607415e539dee9d17fd48a4d73f88ec8081dd1789bf7053826c4	3ffc541d8f6f1e08e8951c63be0c4a9fbaa4d86a43af2db7bdcd97c8ea0b0be7377ec6e933b29b4c	f	2017-06-22 07:55:06
5be66efa29af5185b0f52023754d4620ba39560fcd10114dcb9fec6995359a351370e871b9347dca	aa21c33d2b3182a31c6d733d3f40f679d0f243197699110e0739752eb8982a04c65986fa269d1e70	f	2017-06-24 07:41:42
b2d03c2af89274de5d2e4ea0de778801adf875b5b42392f50e82b3da36318e1ee1a4117493b52e30	29fc8ed52ba4d08ffdeee50fb6c839a3e5d55f8cdc92fdae2455fa4c6331e7241a485475127f9b91	f	2017-06-24 18:04:48
5c7dc98cd5f070e3ffb86ff327fbaeb858afcda28334d1dea0af52c7d10e727474913e20eae76d00	5c72acf96d23bceb7106734fb347af8239ece309a29e725db1876277ccc85665d5cc5723b894ff9a	f	2017-06-30 14:09:22
f167dab2646482a4cbbde6d09a3fbc787c59ce8c8162923b1e13e31cd468bf4805cf0ff77905b323	e10b2a2918a6b1c4ce2c9327aee0afbf99ae64956e1b64ed0fd9393427011b4e7d67120ed3958a1f	f	2017-06-30 14:10:00
8b8f7aac0dea613f3c32d2ffa00527b81c5c727f7680a65b5ac59dd8ea656529719b416216a79c6e	8a9798b0cf1733a910fb31b5c09f5ea25bc719621a5d7240bc9e0bb8b45cf986321fd556f3fcf1d7	f	2017-07-01 17:05:08
f34d64bb1f8eae0bb589a8fe4a21a0cea13b03595a5a6722faf1e8dfff2575513d5963c0512fe698	ae5930c745f23bcd8e1cab2d2e747eebfc6f0e3cbf1c96c15b42e2cde4d137984e022ae64ed59ea0	f	2017-07-07 13:56:43
c3667f0ead915a67058e6392408ef6aa00d534d0602bc7d52faf980b99d8eea136192742c8ad7d88	3c18ae6578fd63770229c510bffb533f3fba03d2f6d5036c957ccbaae5203f10352921df6d869947	f	2017-07-09 10:23:29
68b62399788221801b32ecfa74ef03d777518ac6d8329cef344b3d87032c6b22cd43d8c6fa5cbbc1	d633ff4ef1d0a30963fd16cfedfd7390fe052230486af01ba465baaf9f7cc5d283bce57888d46ac6	f	2017-07-09 11:46:26
9e2b07c0085dbdceec843d43bbbf2cf2778f40891c5796b9665170ffedc322b13dcf0e948b011917	0595822b1617168c3de6683798ccaa408057e1fb1eae89d9806ec030ce542bd1715852c3c4862483	f	2017-07-12 10:47:40
fae00e71268baec7cb4944ce607371f5a928c88085d0b0509e46f08dc697e8eec70090f55874b4f9	9de6369f7b0569c4ad0ab45e013c977298fc93982887c27b0a649b93a2f06d7f4a5f7323c1346efc	f	2017-07-14 10:56:44
aa98461d1be26e34e75879f91437609ceeb8091ec80fe1621ead3e4c8f6195552ed81f324cf5555d	e4d9653da2686d2154d33d4be9ca5b6530e5ff78f2cc0f09d87da41a47f173b767cb0ef1dc225071	f	2017-07-14 15:45:19
8fe1df360b8988d3513e6eb01db64fcf31e1d0f83382cf805ffaae94af67571e60b5713949f40f71	29ab08e132dc18f59b143a39699267856476315f0d957aec67636253fc77ff7216ca7a4f687dba9c	f	2017-07-14 15:47:06
31d2766b494167142fac75460c7c3df1e8802602220365e9eaa4dd9feb98af99471c8f9ef503f263	62dcbb7920b388017bd422079cb678bc09129180ea0efd5862d7011d70b39c876e29e4115db58e1d	f	2017-07-14 18:04:32
de796eebc9723a09eafd580a0878033ef65ad4135cfcfb31748c52e60f7a54aa365c5e937929da73	e8a02e0565e0fdb25ba8d0f4afd22f758bd2c57de2c3be08662021932060ae9944a53cda7ce9a88a	f	2017-07-15 07:03:08
d6c6954080e606037a601ec78be21ef5808f7710e5991850d5869e28425b28451efb680286dd5b35	d95fa851a23621dbe387c1b0d0a52b59bc64a6e4967a38062914c23f34b4f92216bb2e8fabd260e4	f	2017-07-15 14:00:01
e952361ac8cadeea9449c44fffe48df84f7a9fdf6f36b6e9c9ea68be0cfe2ad1aaac33257445973d	a5306a39291571f8d604cb07dadaf56cc54caa171b7027b1d4408481c250f70884f98eb8d444510e	f	2017-07-16 06:42:30
e03cad191e36042cfe397bc3361013c6e23c22abfb52193232476371f59147e6e638fe14b0816241	b505edbc17bc0e0644e7729240895985a0da3fb5ad744056f5ddd4c4390286e28ebb5abab0ee71c1	f	2017-07-16 06:45:08
5415b05a00d34aec32b32bbe64a8e0c3b070d4e354e8acbfa72366835db96038b2add7c366319041	c325be1d19046128d7ccb306fce8f841eb9421b9fde7abc0bddc0d1b4ffde1e3a049304afe210b3a	f	2017-07-16 07:22:22
e9a4ea64ecd1df21ef8c0cc3913cd0db9e16584355071a0dc87ef700be639f55f34931de3debdc27	838dfccba0ec92edc10b042b64f3236f0d10fd2d23bfdcfba27d6d6cb9d491ec48e904be9c82cadc	f	2017-07-16 08:26:50
0a8e9307262b3add3fdd932620121c4db7c6d336cfdbd0dd3bf59f20964c51cf025995f535803aef	dde3e3c78deaed2560ace00d3e92a53d62363cfc0ea63f32c039546e4b86f2616e8ac6c44d964875	f	2017-07-16 08:31:05
b6453e043c6a98fc84775b95af48aa6041bd5d80e0eccedbf5d8c3e1ccf9eff30912d3b6c7846c91	62b98e716bd87b2ae935d5e5b5035c62863e615c9dc91e8ca1bd8ac84e65370c696f808006ebdd7a	f	2017-07-16 08:31:56
6dbf14d5efc743006fdadba4b7d7f863e4eb0f4890226636d8ee2ebe84b395e4331e93504d7be532	cc786fd35c9f83d1b9435f5b6299e17cf8cf4663e5586c6be8f86f4a80c545488fd85420fe2db8e4	f	2017-07-16 08:35:41
88c72e425ef36f8c40aebeca54af09f43bb6624415bb0f13e19aa3ee4c9f5425978d8739c5730c80	ac3396db36bb53cec33b1edbffba14836420d100aaef73f4cfecce0ab9e2cbcf6f4892822b6ac466	f	2017-07-16 10:35:03
1b2fb42eac6484cbcfad0c70ad3ef8943ce3f6ef4d70d71efd01488046b3264ad0851b55932da23c	4d6144cbf3aab2ccd0bdc23166fd60f29c6261113023e54e72605efab4974c187395c2ca22b32af6	f	2017-07-16 11:46:57
d49440dde64301e50c258736759bb4a82963e497723cabbc4a98877e93459e02d981e849c4a916fb	39c8ad2d5ee6431580de5d4beabdef24f80bb6ef2485121805ca84dbc78fc8013c176fae5a5898b9	f	2017-07-16 11:52:46
7b650253be4cfffdbcc9fb84505ee4cd5718590a9209f2baa8efeb89cb77f9a349a5c76e9cd8ed86	39f15f598c81a433a5b7dd883bf5891847a1089ae08bba7ad30d1c207f0bc430f14f7930e038c696	f	2017-07-16 12:01:56
5d9ddc80acfc2e1049b211653a948f623a9112292bfbcce08ba0d0f349ee0565971587004a9ef29e	a9857e3f775f65cb041bdcd16cf92299be26c3ae773b0c8fcc5b6c53e5ebe8ed2639537d476251e3	f	2017-07-16 12:08:44
41f51b56dfaa956984f0c9e0562257add651a3a22040aadf55b771862a983d3371b0942175cf1105	28577ec0b4634295e8dc3e458dc4118df489bbeb7f00352b5b1a2c242eb54105a22d860599a50e3a	f	2017-07-16 12:08:56
3ba3f51895a10b7e9282bd3bd6d14a85395990ccf09ab893b222e06559aa0cdd3fd305764adcae60	f2f58b991d0b3cda9ef3b75fe15962edfed7d0d38c689a0df2ef75188cc68470e9375b92931fc8f9	f	2017-07-16 12:09:01
ed7b4207d32e19bf9cebb6e436ec389ac2b1db831429488435f41512f6eed86512ddd5437b7e492b	190b85d2feea180c873115d53859e28d14b668530c99d611c9a77e6b2b78d3134b13c4b1bb40576b	f	2017-07-16 12:09:10
8605f8be435053ce045d10be1acf5009d53091cac2eec268e4ee91eab8659f20172f97079e72d733	c5a9c281f95254d14161a5a90e8aa3c845990e00cf05c3bbf876391593be81fa848aac3280c534bc	f	2017-07-16 12:09:26
0065b250ccc139cfcda50a123a37a5fdd1c91d0f8b746927ed7ab9d0bc5fd00c1e9c258e51491d48	d1155d7e846a2c9becbe71502d2b1dc2a67a6bd6b115c893228637390d53b9e266b8da45665a3ee8	f	2017-07-16 12:12:17
f5d9fcfc3ba94d899cd810208d7ebea4bfe6d31539c6979cc2ab7bc8808a3432844357718f928502	c22a92038589d3cb3a6fccce448bc4731d2980bd81c2531a62ce38636e5d6830807121defb7aa2d6	f	2017-07-16 12:19:36
cce01ef4ec8642c054bca92e3ceab6bcfe927f2041db76d90eebb97eb9877e0813df3dd383913ad4	578f629fe8a1b8a8e1f2af9c45c7b81c5f0c529ddf033b311701c712d9c1721dae8d90cbdfc8aa47	f	2017-07-16 12:26:13
d4439c6a7994e108d1b4fe4ce43ef825d9251e1ade4eb8b77c98fe39a513d609a683dd20acddf532	4cadb33c049d3316a485fbb4af137eaec730f74e26630e740566434caa861234ab1d61485ef813ea	f	2017-07-16 12:29:13
e9f25ab9742d6d270fdd29b78e4d0a877316eef6073a1734bf548d9905ae30b72517f87c721d0fe1	ad2336c8eb0a7bb6839156a4fbafa9b81b84dbda1bd11cf557389ca09c75fe776652096a217d856a	f	2017-07-16 12:33:15
9159b7915c7e0090a0130e5a22b0ac3af45a5118fb2daca9394cc90bd9929253b17221bf9171881a	f8891097d28ffc018b7c812a2683fa328a024d716dfa6208e72437dbf34ca066981561194e676b02	f	2017-07-16 12:33:25
5236336b02a1a996338142e595b122e399a6e8a1a12153e72f3274f0daaeb6347d67e5dd0ef3cb5e	05d5c8d95adb89f613993b31598bd030470abf013a3aa1c31d0ac8f3143624bfc7bb59610d60fd0b	f	2017-07-16 12:33:54
a43315969e245b23fb878e7043f23fe4808e0455f6d045dcb759ee55bb99d2f4c036cdd65dd594d1	eccfb8b0a8d91324cbaae4ffc7bb79df03b1dd4ece9dd2c49eb3cd990570c3e6a715822fc92bd36a	f	2017-07-16 12:34:10
cd0647cb6feb178caab283a3a0ba2b43efd10e86d87dbd2ec3cfe1b20a52006de2a05831c11c9dc7	b9bcd9dde1902c583516b2a35054908efe439455cac395e6625319226bacd351ca7707dba726c0e5	f	2017-07-16 12:35:57
1a03f70a5e655ad2021923384d09d1d56c22bed8e4892d1146b4ba5f970f1269d057abe71e610aa8	b87a405e8728dcae43b7439e117d447e388e3366f0d5b580e434aa3081e9408b4d1822b3e66bfb34	f	2017-07-16 12:36:51
8f745f7441fb5b320188d4ff52583bbdba91482187050d41b204ec20405b53acc73b36fce8fcef78	356904daf694476da33cba7bca09cdb09c95353e50021ca0c64e1460ebf9b90c56235b4c5d51794f	f	2017-07-16 12:37:41
e399e7b3426a5dd3c914f10efc38114da513254551e3c67fe532a018b637cc22bd2b0ad420dba813	bc18cc2234eed641ce65dddeb889c9d9553e469561b16951ee87edb4d663f0be60fae82e9592cb48	f	2017-07-16 12:39:15
39c26e27b281c1a7c618036ed6d4a69f6316196e8c89bb368b639c7415281cbdad70332a85de5280	b8294a03a9415d43655abb27807224255a0bbf639287af8bcb3cc7477e5025488eed032cb1303da7	f	2017-07-16 12:44:23
9f4ca5e2ee4bd0c52387f8ccebd452dd86a86691f051df605aef4a4edb42fb1cab8b13fe5175620e	7f525d09b76f8b5daede302f0bb4c0506d3d2f0590a10dfb5730a4e1771971958b33699ce4f2b15a	f	2017-07-16 12:49:35
d474b2b1156a063424ad50af89b307524b9de5e0ef1325a9d7b0ff4865eeecabc85c534ea11495b7	b491b78f02c631e10b726d8177fa5e91a62185a80380c16c81d3668cea97d5bb08777b65f71ea2bd	f	2017-07-16 12:49:35
8a427df1cfbc9fb31d3b9bfa297446d7a503fd7338dd962ea2b3a7a79c17a865756d80d1e5b50c6c	d3a750882133c9d53e1865955b7bbfa4ffb96800c7452327700599d517849a901cc8de41876029c9	f	2017-07-16 13:42:40
b3246b817bd91b6dbc8f4706b704d96ca9419aa106920e0ebc2a2d45545fa3e5bef9989e8edaf486	9c71a85357994f51db1a30716ac343f37ec774a30b3b401b62d43f061bf14ffead9a9a19f497ef7a	f	2017-07-16 13:42:57
1aff3be7234abec0c57c266af26fcaa8151a6eab255cfd9a5b898c890ffdb337035a58c34053ffbd	ca0b3648832b1a91f7a0d60559b7e472daebedb7e2e1138d658b0f8ff7d1162a09630051a199e548	f	2017-07-16 13:44:06
df062069a690f04b34be681728ae6008e6fb733904ac550f96430540b7cd09d0dc71fbb9a463c946	de9e3340f2e7d10434e1bd38052329015e1bc30b7dbe88afd61e6cd3d28a93574c6bcf7fdd15df02	f	2017-07-16 13:45:42
3380add02ceb2aba665fd7ae87af6ff7f6a8930b13f3756614d135d7bf3814a4624133d91ce72237	0dade2d38e1950745abfe5ee641e23c7964792ec9ad49c0141512077257b1d28e3289783802225c2	f	2017-07-16 13:55:10
0bb620942753bdfeabd1e270a307e6cbf14af9d4b437ce4734233cd5dab3da046cf940613233f147	546013b4aa5e14b4c213c61bd51dc02394b0aae5f92de50ab8618131bb487f4cabc1de1bfc4172ec	f	2017-07-16 14:13:04
3a5e2e2c10388adb06dc41ce4f0540c2203ef199c309611ce37f47e8bf149f58cd3f955cc4f4cc73	18f95c3cdad6a52e579104afe036bf7705857a956e34d12661b6e8cd448d774693b315441b0da26a	f	2017-07-16 14:17:01
5a11c1ca78bfcf4d6cccacbdf7b5d822bf5936e707e22547fda6f13c2064e60b3746cb1c6417864a	824157021d5975ecdb05308e7d5deb8970a5e897ab7b50235d0daa2dd76e45cff51c8e11e88d2c2b	f	2017-07-16 20:54:40
9c64f33f84fe0a1fc1445001d43013ff8dafd62f9c6d823409df27207e5a16a15080323c023b750a	c0f6713a077a1ab0e11424c82ecf66b853e1f66ae2cba5ef223fbe72d26a6e3b7291882bdd159f99	f	2017-07-17 05:39:32
6643228bc87bb8679985df61c84f85da7739cb9c490e7ee408e0f38eba0162d48a24e3cf68e45a47	007c07e0b93aed1443e6a8b57f5b0f008f3bcfa3ddf1f3ce05c1c262cb8b7dbecb4a7f38ba29756d	f	2017-07-17 06:44:46
58016ac06d84e99feeb04264bfc53592ac985bd550563d3fc679568eb0d8eb2670bd0d6345fe9e8c	98aebb27e99d88eb3667d3f11b9502e299b742818e9aca7cee7fbe72a8ce7e21ca7697358e111ea7	f	2017-07-17 07:57:10
318e044e9ed23afb75f2fe375fdc0cd60ac992cd00eeef23e05da1db79844d8135644b448fb469e7	07d40ae484efea841f2024a6d8e956112b533e9f675351fe5c9c093b67f702c8ba3edce9bbfd143d	f	2017-07-17 07:57:53
8c60f8dbe4da06d886cb7e3c7a83463d18f7f21fa7728a2537d868e2c54d4448daf9db39eae3ebe4	8e39d093a7f8cfbaeca7fd8878b0f00a4d09e9feb534792078842c322bd128cddfd436b9a1553034	f	2017-07-17 07:58:42
44c2201ac660b6cdee6af1a0a4c48bd993493d4af0fe380a634dcdcaaa1d3590e6274b71cda597cb	bd678282480524ce4631d4dc9c67fba7fc717a98a842367aaf7ab44a79edb8c56389e5d89d5b1bbd	f	2017-07-17 07:58:59
198c1f96a5b2ed380f5bbc85bb6252813eeb9d5fe32c74c64ca7980b3817f2b1d81ec37261739abe	e6a05fca015edc3a7601dae678df6c46f3778511c3ccf5e6fdbb94faaa3bef8cb75240b2329bbb2f	f	2017-07-17 07:59:22
708f08314b15060f1a837e4ab617dc92fb566095be37ea7a9bd743224f0226dea1795fff89e9863d	2fb56d50ace5cb5bf108f1385fa2d50e44643c32f4d734f3c850e6b0715a1a0c8e8dcdcf29a30ebf	f	2017-07-17 07:59:37
345f27c77f7c293079d32ad6f0f52b4c482c50791bd9f94d904ef8e657994d9f1b59e58f606ad77b	7316cb1ccbb5aec72b27e68cf7096968fa7aca65274e64f69e621b91c438b75c42bce5f3969031a9	f	2017-07-17 08:01:24
91636dfdabb46203e43a0b136a37cc8457d012cff40dc358120d44ea7da41f5f8da8e764c8f7b6e7	70f7b3b85a56fddb2ee0706eaa1d304bcb9469fe847c3af178a9ef075e0527875373f8c7cc0d7c56	f	2017-07-17 09:56:52
9f2d1d2e8472353a521dcc522c5da15f154b8d9f1bd8708b2aa18632937391d09c746f203e7bfbbd	f2e6280fdc715412046531a6f77ab38c789c39f5460a4f349f550d7345ab9087758359809fad57b1	f	2017-07-17 10:13:18
50260cb86e6610f4ef449e3fefa2066bded20b08e010aab7c992b3f19a10575a5b0887129fa89c91	6a3574e00bcd5c540f490e704dff20ae93dac5f02e251d1e6a3368fe89e8f072fafe506ec9ead686	f	2017-07-17 10:13:35
c307b185f5370e45cf8b8538f57d02c229f3054e334686832f97b7cd9d7c86881c18f62ecb6ceb6f	f1efa035a7de0b398f998f4781cafe3b68112f978379c0f2ef48c3e6f9e4e0adbfafc9cb94092063	f	2017-07-17 10:17:31
32d99e6ee60c47ec56a5c362b424c06f98a4c641cb59ee4b3d6d9db90d35ccfa87b035d1e5a04076	069cf1a5c77e1e57d9f8faadb11a6479e37ffc648bfc0f57a6915070d9888afa729af6e47044dff0	f	2017-07-17 12:05:16
9b00617942d3b9daff6265d5f30ddccc120bb2ef8e6cf355230446462e4ae991a4c3c50c03073d7c	3bb9ddb996979bf2713328a67fb254affa309741609e3d5e81bc1d50f949eb8a3cf5509d0a27095e	f	2017-07-19 08:22:13
1cff5b0950c695e316868595b7b969c3a8cf2cb90b85228c85f422fde203ab2e9d2798ff36f0f53f	4a90b9162ab7d0751b9bb6d8fed74005765fb0d7aa204a56d3bb48ac7b6bf9b7e8e13673576b4e48	f	2017-07-19 08:41:22
be20580c22fe8e787dcca123d120311b6cf544d6ee945eb48fd7f834e1b74813cf15b3451d68e78d	9ad725e661d4aca0cd090c873c8dcd6abe9752975a72379a418969c619246037300e1b2862d22686	f	2017-07-19 10:00:41
16e1be9dedbc64b9e671f206b1df41d6b5caea90b163ae5ec5a8d11d2a5030a104e3fe71997a6026	47acbfe521bf86a83b77556258bc59d4cd364dfdfe1a625c043adae86e6a9e1141dca8f0ceda6a11	f	2017-07-19 10:44:05
5961136e93cf38c617556f73457cb21fd2a2ba6d7916aaa8cdd5d2caccfcd214b17c71a08812aa3a	e888a046857295562b2c0979965cfc827d83beb72c020214fc4b13b29db05984af95a60bc5748d66	f	2017-07-19 10:52:07
dd219cf3a12d250290d3499dee9d7aefb28598f2b677dea18560b0ca9d5861186e9b4cc044074f91	96c9bf462f37c630b8c04d5ab727b4311fc8a31d3069527f80936749d0df821f0a5af10832b25e38	f	2017-07-19 13:44:20
71dabb6cdf5177ed429adee46577143b6c954d34c12441f7883f36d7c80d143f839c871f41034700	24ba39304923579bfa9e4ca252e6dcca56b2ab4f91faa3f391d92fb4f3de12208303e5e2172a6357	f	2017-07-19 14:20:16
1c656a9c156ec1e47df62d26b08df5cd2e11d449d206851cfc221ad25b57fa4b8a2800012ddc6d7a	6fc5afffcf6ff48ef63a796f714eb13857141a66cf58fc9ca88938d7fb47ec7fe574e368a85ec7c1	f	2017-07-19 14:34:32
7e50841fed14222e1333ec2d407785ca70ffc36eb5c0b9c2fc1319549cf7e257ca60421d1c366c93	fb11e1dbbecadc67b5fd8f2c32d57345abf6a481c9f77a0a8833487e5c34910b88c1b59a75b6ec79	f	2017-07-19 14:43:14
2fca8a6d4e4fc07b44e074a0b9c414a89417d7312fcb0c8f940bada72cc19ae38333d5831605f31d	054b6426e15ed2abe2d3c5a5dd5b143d5dbecd5136e581afdb00debf3a33fc77188fbeef64ee5837	f	2017-07-19 14:50:55
e9373e0b8a2bb06cf525e7b3526df789965e6a23894851c1d49e364cf5ec4cabef2fc9e44363331c	50298f0eb1c7cadfffc9a75b57c83668ece35fb2ddaeb216ea61b6ae5e6351427cd5e1659f8b7786	f	2017-07-19 15:02:56
92b6175cbe5aa2da02dee25791ac2a88622642f398197a4c8960e20eeb91865c08d452cb42ccc2e4	deb173ed254bf4f370e5f2a464bedd67136ff13622a812f136ced5dbf590c0962e6b95e7ec6c37ad	f	2017-07-20 06:12:58
f8afa423b6a3f4caffc9fa155cafc8d8c2349c069e390d440ab4add2484151215bd0513efdc24a15	9c3af0d41495614805a173fe0379a3daab005d9f095f86490e81608891da2c64f831dd0ffdadaaf2	f	2017-07-20 06:50:44
c9e6998b343bb0fa2b910c644f234b31b91f0c169b8f4ad8a4556bcd9812a8d12e9705224862c9be	b753ac4484c568f03a89adef7ddd49ea9e4d33e49e9183ce61ef0d07f66ad59bd91eb27d520939f3	f	2017-07-20 07:00:37
b49d77321550dd529789418d320c22076cd73889093fe90d1c593b575bf7aaa8595c522b3be3a3d5	993b4dfc84a1d11fc9e5f5ff0142ca47efa4bf30e73559a1a95886145660f7ff8e685ef1711bd330	f	2017-07-20 10:45:31
62f2b091851c97f91d650211a1d7958c3d3b0ccc89ee85dcaf3034da22a6b655d9bfee268c3f301d	fdff1c0b6fd25da6282117731b8eacf2f1705e8530c44cec9625e9e4a9016719998c03017c01ef45	f	2017-07-20 10:49:04
0a9164f6db8b2ca1a9b3704f7e43ef82b5456c50f6c24de731041acb80fa9dbf8bccd1df363ff227	79c4267c82fce6e59084fff00e9ca17171e833dc4e352e19402f4b8733df138be5b10a5e2e1f53ff	f	2017-07-20 11:25:40
386719e19a65be52a23e616f31c8108aebba06688985cefb08af8148b116f4ef3a4b11da95d3b936	f7828cbdd1fd150e0753a48273a4c6a33e2bb6d2f15d1488e6636348adbf14142552c1f7623428b0	f	2017-07-21 06:22:15
1c1fd6e2040697fc2e58801d5b9938aad4e7b020c76d8f537e02b3c3b4dd19c8fca786d5f5ceb198	00026176f987202a6af50f3efa2875e978a1790284fb75544bbd08d805fc9068b45d7d89c22c9089	f	2017-07-21 06:58:33
7b891602afebef4e5eb04195a00db561eef4a5c8e5a0ce6655a278f9b1fe06b064995c67c6c77b55	f02484dce6cf7e64b455bec634a70ec55e57a03a7fb3faae8635dcb9ff9158eb58beaa76eb6c0f6e	f	2017-07-21 07:29:45
01b6addc48e3ca02485b0ef9bbf71b90788e383f6bd792ed345d167b301fb376d6e16598627758a3	1a7b5ff86fd2fedec6282f5325f10361bf5412c147768a4b0b85924fb9ff8b781bda14695775f0c7	f	2017-07-21 07:50:06
456c0e47ad7a8dda13e8a01094472129450263c79ba9c0be85a0be3de84770de02b1efd24162a80a	569f97f26da486c741b58567bc49d3edcd26e0844378c9de6a534cd49db8811a430984e8b59cd931	f	2017-07-21 08:30:12
3240966ac67a4bc15ea1bab735575856e387a76dbf8b584b0f453bcc37ad7bcabce79f4b41ff7a41	d68a90f8fadd464c5e3960a40ec7ba6f56310c5af8bbc71ab9e5ecff1c5ff90ad1fddd648574a56f	f	2017-07-21 08:54:07
d623299582530d2e37f3c597ef4ec0f7f5c47ae719e85fb3f16d82d5fb2248c46994e7440f2fce26	2b28f85583e5320aef45ed5e59a7eb02bd4d602a9c4193c0adb5b4ac5693bb8dc4a844de852efeb0	f	2017-07-21 09:41:02
337df354fa1e72db7d609769ccf3018e1e267869da369eb84309a425aec3b7a98e16d5eb3c594350	2844b71f2cd56f2c354ca756e7897643202cd5fad07aca161723057b7188b1ebbd08cb6295b2295c	f	2017-07-21 10:10:43
d70d8fa73fc265468fa39b57c6c4cf849a560693865886bb646e971b225f35e6423ca5ef4607a898	17e4fe0828afc59ab95694ca8f362fb4a006115235eaae4e013ba4401d4e11e92b897180984c4011	f	2017-07-21 10:20:50
7fd0b3f5c98d530adc580fbb45a5cc98fdd6fade76830c186200d2fdc5143574300cfb5bfffc3903	180ce942c7ec2857b932f92ce3a9a38227300a4c5a672662f4badc70f0e3f6137d66d5114450a0f1	f	2017-07-21 10:30:16
e74cc9a0ab9e734c11cf26d002216d979c0e4c4c485562426b5affb4512d7aa634edde9243721165	9088e47fc4f8405802aac7cf032bd4e8034a435147e36dbd68cda511662c14785bcfcfd47845ef07	f	2017-07-21 10:43:06
b94644c2ef38b929cdf5364a7462eebd710da1c4bcf70b6efc8e9a4db6e8d4b7781e0ee896dea6d9	0cbe0fe11c9fad6092d70637227282f9693b96b9276dd0764387dd336a8171ccdc5569445a79cb36	f	2017-07-21 10:58:51
4f62333e5d81a2a388b2ccb1bdcb90e08fdd4ace23becf0d8c864c303414d0ab2ceb0b0e243c5d85	fdf03943650d14fe5ef42def4fa4e56eaaa5eb175437612e6b84fd22bacafdf6035fb6bba53cc1a5	f	2017-07-21 11:00:20
ed3e96c9db56d9c158b7b8d1a20ff80d60fb8092f5908cd87c1e667bc0083201a5f2265bc386db3e	1ccbe5382da27192e90bf8705e9bbfae3727bf6e4ce3dfb76a0078e934fedcf0b96abb5137010932	f	2017-07-21 11:09:37
4d75bf727e5c951a3def96103565360d1441ded2cadf1dcbf240484f2d09015b8bc227d59834dc51	676e7efc45c468e31cbe43081febf3770e2e3aa7c50ca74805bbc9ba95ef6085b310bc096d299db0	f	2017-07-21 11:40:40
8d869e9613131a29655b855c9fb968d087d48e62599f6805a0d18ca0cbb131809311be924d8fd6de	d1c0a703d902931cea731762a7b7ab5c206616f9ad923aac1dbce36a46b3fefce34541938721b8fd	f	2017-07-21 11:55:59
cd7880de8347c468ea8dfdfafe8be57a4860ce973a975872b097c3edb91ffa717fd187ab4c0202a0	4ec8f9001909c7318c00d435c906c4c32f5d76dd570e9daa56f97f1f3fa51b21e285e067a77d6b7d	f	2017-07-21 12:18:31
091b6bb39ed44408c8503ba11fbdd1c2c41e3fbd32681f89cb59b962febbfcad8b5e5d154e3aa051	d003ba2a776034d020417a95736ea4d378d73f53af107c205bcd5d7368b04c5ae32475e5bd71ee38	f	2017-07-22 04:20:35
b17ca93bf37ccc965e218470e1d77ea4838e4f6125d634188489688d59a98ed1157ba37b2b95220e	7d033ebee1c05fdee2d37db71b71f74d5348c61d4cafca08425d1a4ff8d23b2a0740c14fb2faf526	f	2017-07-22 04:20:36
28caa12a84b51d0f325f05be6bc3bf72c1fb20c73266b62cbddf7ba864fdf245c13fdebb3b005bb6	b1be7f7eeeb931dc83a2239630273f05a10b6bca999bcdc99d13828c051ec75375360df2e4f725b0	f	2017-07-22 04:20:36
37923da0e518b0cc2429de423a5c7e1c83ea448e273623374df68dea372bc7c1d8516e882f20a10d	cae081fd17138e9aa40ac9212a0fb9939366b05da63b462804993e362b95fb942c6fa7a6b06039f2	f	2017-07-22 04:34:59
ca14ab3dcbb81042cce3ebeb03089777d23e5b3427447cffab7c07db3b90b5138ec72d81175e7916	7e781db8fad33788f68c64aef38bccf85b9a02dababbeceba58150863d92aa16695b01b8ba0d45d8	f	2017-07-22 06:28:11
052a7e556f44284e7c826d86b9d06c5c9d0e6798da49a464d31a016bff7b01f5975beeee039f5800	2b906c3c02059260c24916ac3d4ce2b5272f851f987393ecb002638d6b79823a5e0bac6f37ff27c5	f	2017-07-22 07:22:48
1a236c77df1914fb4183bad0f53943a347e493a8704cc17e7a4c2c0580caa6d3e0f2273b0f8ad66e	cab33bf03e7bf424c58f41b5042fc7479ac1871367e7b62dfd031e0742cdf50db3b08ba7c4e34127	f	2017-07-22 07:50:53
820405030625af11aee97cb5ce5eac645140f958191258df5c8e1b156a176d52e2dee5e3b14e763c	6cbe65ca51d0d252d451eaf87c645cd2a9723246bb4eb9c6a6912c684b847743193ce4c290343fe3	f	2017-07-22 07:59:38
a31d65e1e7dd924d77b61eda1c1cde290ce9cd1b8bec24a18387afc28055cdd78e61a17d63657244	410fa5a73738cb3a8b9dedf79b7d26fa25e657908a72f30c0701744323900bb64ad3a968c10dde14	f	2017-07-22 08:19:22
05955981067e14d19348e4e4baf460f7d79f63dd3fc72e3b9f0bd1a1a9daac058a1a4f982a5c430f	d2282c23aebe5a4b5edf1a3968e0790b3588127cbc8a40963ea9c9a9d48da06bfa6d610c1b9acaa6	f	2017-07-22 08:32:08
4c43387faf69da4a1048114e371cdc8d9d61fe616e32fe2ec09a2fa90a51426b5e04f2300e6557cf	a717a1a9832af27997ef4b5183cadb9ce48395d9b2ba623e7f78d3a268fb13dd17ba0e2993f7240a	f	2017-07-22 10:14:25
900948413439f2fb3fd4beae2e2e337d7a966cc7529ec66a82db8938b7122a4f7c3f2a65fba56894	eee1b0bc70f1cdb2c1e790c9bbb5886be019c64c5fc720b90b4c2699d66836b1b3e5d215ab7d27b6	f	2017-07-22 11:25:00
74358960e60526f777837c54c62229a45792022d8023c22ba85ecbea6e021359ea38a949a5c69945	18b97ecba9a4b88830c15021ccb7f679b30010c5b9f9df21e52666ba5f98b7cc960d8f4658e259a3	f	2017-07-22 12:03:06
286756ee3365a4843b076b08bcfc99238940a104a8513bcb5638105ce77cb7c1aee0c57eb1e449fc	a2bc566831df1a6b7e594a1b730d045fddc653de5391b46ac73bb60c5895785d5cd5c4e9890dfad3	f	2017-07-22 12:15:13
f62c26f755518ed848182921811ea1f32810f1e016bb99d2481fd5f6e9b89bab640e4175167504a1	e47aef20360d3a7af2a3b177f0eafd0caff2260aecd90a27b52b6081556a27eca9a75a9e31df904f	f	2017-07-22 12:30:45
ee43109845337c31f50134f4b9cc6a6dd449b0591cdcfecac97752b0e9f8bd691c03ebc663d3a390	1f44cfe3ca5e1112b7b9e775cc8c7fa5c5c3ceccbf4ae344e67b33a4eca5f3145b5d3714f3113e87	f	2017-07-23 04:28:30
76d1d93467b2393700afb4be5a8b5e16f8c7b402a58b0c413020e401f1342a6553d5215d6f0dc471	01f07c1ead83e8dda20c945ac9cd0b45accdb2c76afb0bb6c80a276c64ec12977e0322a23260fed8	f	2017-07-27 15:47:40
e0cfcab5116763f35b53e07187d4205de65275c9dc8eac3270326237a3773f9a3731f460bba0f9f7	f9d8e9317103cf5a3ea76ec8ead61d3ed47e485df83f5f3a103fba4fed8f379ea6d7cc4068df79b9	f	2017-07-27 15:48:10
089d4bcb2b0297a57092e3606b524209c5763f48b03d003300c9b7ba53c53c9a7f0368bc524d8e84	d0bb39a7b8836309704acfe85314f0d6889921408a26f7d85476e3d6b1f8e69a7d75a15ce32b00c8	f	2017-07-27 15:48:42
33c3b3da00793ae377f5db2735a96a4ba235cf5ac4d1d6d94a32b9f9bbb7e59cdbd4694a8869472e	80e437aeea99c5a1df2a6e48acb53258ebaa11ccb1aadcde12ad142b9840287e5f6e33fcaddd09c6	f	2017-07-27 16:54:28
d70408c6a812581615079082837630f1c02bb51ab36886bf5575cb805237ac7a40e8801cdff73a1a	2a2e424db1d782872772f951c64c29072920d626b855669363d402d9f7a9a750d5fdbd527b6f758c	f	2017-07-27 17:04:53
822dfcf15c56ce6456bbaae8022be481a05c209ee75beb31ed1eb2c7b98c6bd106e54520b827f582	2a23f8a22426a119f7dff94c91d18c3db4ac300fcf1b30857470a03c88811be8d6c329466954d640	f	2017-07-27 22:20:51
f88ec4049c2a3e6f53883898a2040ffc56daa9d9f1b05069e22ca50af6fb283c5c57dacc782d19f2	81264bc4ca49bb7b3f2fb812fcd0a866ee406d9411558b9c84e2970f1b6180a456cbfbe45ec55759	f	2017-07-28 06:22:25
cfeb8a6d357a9399750476f6505087a3d0e5ed367e1e2c4ab313a7cca432d92e1c248f4770d4e610	8514d3ad1dbe71946a0b9f8ca80e9b113f7739f6aff5f3314321123ad4c2b8df1197f98beb4900c5	f	2017-07-28 10:36:32
9431c4d42db303225dc11799b50778e7f1dda8bef11b52020ad58b0b6562450b0e29937c1d6a20f6	6ba6df96756a97b666d09f8e5d250fb8d50ac9335ffc0493d1d1bbc13b73053f79a2ab5ff66a4ee5	f	2017-07-28 10:51:19
299a7a78ad8a57b16256e1d628c00831689565148487531a63e355faf06cdb17b1240c528f969cbe	6eb4a062768772baa281ac21174f69bb9143b786195bffb8b87e87bd15ae5dde6eca12136333440c	f	2017-07-28 10:51:43
e2d768fe2e9c3c1410b9144b7e7df011dd654fd5b6bc0bd49319c3a83f6670e52d141397279108f7	1ec6d5e4bd9250dc31ccfd4b58acf82465cf691dbfe8134666cb4e78187b16a2b25f6f9bb20d79e6	f	2017-07-28 11:05:14
d1407b8dff249329ccbaf60e2512c1e4bc723ff1cf3046dcf22face635861760d43e1ef5360df61b	936d1afe82cb08d6da84322be369a2ead347484be67237ef8f9094412626df487982e938a5162348	f	2017-07-28 11:45:54
c19282ffaa19284824ef1cbef6f418a584155f38778c51669eb92040f6098b261272cffccbb2a383	06e8d9511365836192b4fa93eda96c94a2a8493720efeb11036e14fe86e34e011bad00ba1e632ead	f	2017-07-28 11:59:10
bd854ca4cf4142ba27a5ed66793243ced70c3d6fefb3a14d375f4d9c910dcf4476c983863ed33421	759c3ca053b457aaee67668a97f15a94359c3f2babb43064533aa0f500a46620e166c9e1d291cae7	f	2017-07-28 11:59:39
ad102994a4a6d53369c7ba5906bad80b52658a04981236a90744819475c19f601a86f97417164508	1083662b23390e32c40c5447d4337697fb14f5097c36fd8104b80f3a5af2d4c0ebc447872d281b68	f	2017-07-28 12:03:36
4fd0a7637732933b5dc6ec88f67cd388a8dc9718aaa4a24aff5a78f9f44b775bccdca9c1a8356746	5fe01af145daac369ff508b16407a5d23db49d10881b7fad347886dd54659f2a1bc9ba4a5ad8c80e	f	2017-07-28 12:04:38
5f0437e01cb86ae22cb949ed8c30bfb248e406b60987d689fdb0c15d69403cfc22ff26cda2a28d25	b4d2bc0923523519270dce044e7e07041ade62f51c71fee4704f5285ffdc3e5e336c7daae2800356	f	2017-07-28 12:07:00
8cf0da22c4522ce95ce35573c6e15b720d21ce1a12d4df708dd7dd642988188fd4714627166a3e29	07f28f533f8bebc186cb1305adaaeb4033d5b995d224428a1277fbbb2fb5f7cfd5fb6df2e00cac7e	f	2017-07-28 13:09:37
3a90ba96ca4790c3b4a31db2abbce2090434839062ab21db594492cefc804f04414820bef4dde6b9	ef4e0be2b5a792a2f98772489d9ce360933f4f9afb563bc54142e5140e5d4c9c11eaa228c4fd2be4	f	2017-07-28 13:15:58
88324722421ca34135ceb77c3afd296c34ff514b9a6880579464af67b3c19126c96c077f1f4b9b07	cb2155f7e1e46b62dd585c5488553fb53cd83c80965b8cc1c759dcdb4f08f34394271689a6a2be22	f	2017-07-28 19:52:54
ace8d5029eccd4aa1c3e0ac02d36823414d9e25be0589c896e9dbbcf170abb6090c1f93d843cf31d	5912413e0e89a687a7eecb37110c4d99a66ac69c3bd9b7aad8f7a1e0a717f39f74f614f7a9008afe	f	2017-07-29 15:34:18
18f2c375fb4c20449593faa9451b6513391f464856e226e293a15c414d288a55cd1d6c45512ba16d	d2fe8812834b8caee1e3643f52a8f40e3f858eb11465147149ae327ac996978fc12b96d831e0ce50	f	2017-07-29 16:49:56
74efea2dfcb533a6da0f3acd0f77b49387d7bbac805ad1cfd3a1103a5eb09e2e9861a466ad0b4ecf	1096fb634f1a46af6547f264a2374895413caca7859241c6ddd02527736b3809a0258615a4c1bc60	f	2017-07-29 18:45:52
aa33607612a559b2e72780f69b9919e2f6adfcb72e4557bd089e65618914303f99e677f6f3a6a212	cdbd11b20330a317d9a6013edea6ba20c776a83512d152c3773dd549e5ba0bb782425b58c6c91a8f	f	2017-07-29 19:12:37
6af3b5127f3b63ed7624b6641f6d87e5710a72309ddc6aa72e177483c6c93b7f851c7bc8a64b3ea6	7802d53bfa4d6bcaa8803698edb2f150eaf53af2c3971a9dfd53d7ae38f3957020f19eb8770b201a	f	2017-07-29 19:25:23
5baeb2daae25ecbc9f87d310437639c53cb36081d59d631e07d862526ec7d6ffc2beba2104a8cbb4	0394e79201dd2c9b14101fefa7764e2119f909d6b89171af80c705c17115a57ea924e8151d25a038	f	2017-07-29 19:28:40
d7c67b1a177cf1ed699243f894f9c3949897ba4067e7f63df22dacc2e775dc62dc3a1c5c5d957a2d	59010afaf1b324c20f8b0c9842693f28c9933ac47149fcf16cfb34b30e3947c9c350c2c839193f42	f	2017-07-29 20:01:24
baeb272cc8a165bb9f4bacf4d7a37b69754d33064e07d4b9dd6633c7b840484d715e93ecc41b1d43	6987831dcc18cd3af2ad9ff2009ed88014277c7c3571365b089461856a99a7b4304e859f7ca268d5	f	2017-07-30 13:41:35
f349a8ee3a9e7fc83d119ae3c8b6c775c4a08de1cd515b6ef5fe25b51f80ee75304695c9616da9a3	e89032f0d8df1faf2472f490163050387fc7b839adb77a0dd509a756538b74cf36a8101a333b2311	f	2017-07-30 13:50:02
154f8beed9374d1d3b8544a64ae047e25f6b1c570a0e99143cef3dc9ac221cbc055864987f079605	d50dc6bd91f8cd01a3eb903ed0e76124472b350a2c7c7f361a32a2917d4fe8490cf0b07ef7c8cb55	f	2017-07-30 13:54:22
c42810bb8eec8dca8e746f73dcd8545f1d80ecccccf2d3fed8ef4ae7512dceb761315c8459dc9de9	588bb5cc0124c89b8fe1867fa5135b5012d011bd8de64b7b41d883a186744d21910dec15978e1fc7	f	2017-07-30 13:55:32
0599ccf7819bb9cd3bd5daa887d91eb55d164b3e6f0c9c22885b409206e6ca640eb6efb13e585ae3	a397d3c3b2dd71418d5e54622bb7694b210373f04e251e3b9242f9388353fc9438dd460b6e419fe0	f	2017-07-30 14:13:35
4ca767d6d883cbef976fa68c9edfa02b0eec8f103e1e78634fe9e69173a5b541ce1c7684774b3647	68c231cba94ac9fe4e0de3f50243cb0b25dc7851e01b08113b8e08d1caa7957e749181c130e9d659	f	2017-07-30 18:10:17
5ec989bd944b30f015c24d04f59712f4bfe41e37a3177a75ad3211d1319a5b082e56f78c5e3876c4	628053df3735148608a98192f811c773090f989c3ea3c65e5b78b375b8ad58f95f940fa840f2c801	f	2017-07-30 18:16:27
5bd47c52c23d450641e1a12e1b1f35357a599de5b094f39b70e89e0f869b8892c24d9d31a322f3c5	8a7034cd15f406e3d322d9e8b3d298ddec113acd8b8c177552dc28ee93d275b06866a2da5b8baba9	f	2017-07-30 18:41:35
0abc498d4a10cb3ee20712112d6cfe36128ec933e559353fa1ed132c659d76bd3d1f7d529dbac40b	fe3205abd2027650f90f9afed827b47306e3373239f9d499d8e87ddd24eb89b6099aabc69f17f8ed	f	2017-07-30 18:45:50
6d29d3c5b28cdc574fe1ac9a3f433d717ba8dfbec101b2e1421208b3b03fe5cceb8dea89e9e60964	c53e85fafa3ec877612835833f517572aa92a057c0039e6291b26e3e88ca32cb9cc7511b7a1e3bee	f	2017-08-02 06:56:49
bff346246e129b539ab7a1e109b86509e574efa9fd9c370cc45d75b50ebf5218ee077c50a08c96b5	e43b683d83522df2b829ddff2a86a99fbbeea350ab411897e0cd1e9a002b3c04523100d361cc8ca3	f	2017-08-02 07:16:01
5284097bccf8d16a960cbe38d85532eb638ee9aab393b53efdf47ba9be780fc314b4880e23dab2fa	1b8d55af3aeb1b933538046eb3f75f255cc701f524dd1889ff434cdc9ce9b2d4e9da4d3004817dce	f	2017-08-02 07:21:39
9e0ab4331f8f1f76ddecec084fcdc71230c9d2a7dddbad0b285ff84d655049c35e9fbe65c85d9336	e5ba588f0de65ceb778fc3c10fe1c61cfeb044eb3474e72048889529db1212c0d70672881dbe75b6	f	2017-08-02 07:21:39
926d678acc07b56168bf080a04484c227304d8ebc1b48f03b2d8a61e7e0dfaf363a40649ab3d2d6e	5f2288f62dfbf1536a6259026803e6d87c1733a253891351fd7fc582c0ab135b99d589b77484b475	f	2017-08-02 07:32:07
dbeb1d02c2a6b8c2879f01806f603e61d3708afd1d5d90e55f40d5d78dc41be232994eb28260a0f4	861d1cb02eb8e228c4be6aed9e7060867a9be50793bc5885adc73a32532529ca09cc3cf2e9afde66	f	2017-08-02 07:37:29
fbbcf4ff245067ba9dc385b21977a0250ad83a3fb5e051f8a9e0dde9bf7638677efb10b095b56fca	2e1e0b18c54edac6774e7b65e33f295f70a2340dc581f5274d8065665c5a979f1364c3bcc772e339	f	2017-08-02 08:14:39
bc57866fc0fb392bf238a7464302d64688c555072227e2f59cdd83c5a20392d58f8bf2f353ef600f	fb7b555f2fb4ab780a30778d1d6518b27e31f7038506e9aee8d0fb3e50c08af01738587dae39f976	f	2017-08-02 13:03:00
24ff8b78203a691b4727e097b240e8cd6100face6c0a61313a9d1107a4d1318a7a0009374668f23b	5d0e19794bcdb2fad9ba8935265ed5ff5904fe7d811ee68bd7898cccd87fc867ab31b2c808c66798	f	2017-08-02 13:09:39
01d78ec171347b2e83fbee2bbe037a075c6e329bfb8cccd931e9b2056f0a4dbf778f845b8958f9f7	9a9d14de4f3881a6704ee7f0cb2327bc399f5027aabd25410dd858ff2d26eaa7c436b9b2f89de7bc	f	2017-08-02 13:14:20
b24fb1a750047248f333827908e78f2c0a5a0b8a84070d586fa1a0debb967b1ba18be48cf50f8fec	04c90203c7e36323aa6a20075bcc888609c5a7c0e05bdde29e2756994581b476b74043cc25a92600	f	2017-08-02 13:14:45
ef0c9cc0bb55f4c60520d74001ff6fa6d2e823938fd260f66c04916812e410dd421d2a6ad58bd9a3	54b4a249ee9a0366b241e228e1f178a916235a436f471758e37622c5dd592dc107d9c744b2961def	f	2017-08-02 13:15:32
5ffd947c2514c9ce3a6446eb71c505985ca386be2998d98ddd5e195f656a84b8a180ca00e3f3fbc5	bea827025cdbf6da3e60a1ec32aa53840c5b16c2cf70ea3d059ab296b7335de4a49b391ae4bd354c	f	2017-08-02 13:51:10
c1941e2589887fd1d13ad3f3986ba3d626e12484b2e31b69c63397f73bb2c8233da53d3643a0271d	de07d44eea4f844818920ea919687daf189692e5edaa9f83cd21ba8c8ed2774c2f51959beaaae568	f	2017-08-04 12:43:37
02adca08b9ac7bdb0e664e0cd18258c3cb146d03f6e5415d6c82184ca09e9208eb22623ecc8d325f	f0e6ef5c0190907bd2b152ac6ab3f2b97679c78f6887aead66210639a0156b31ca20bb6919deb014	f	2017-08-04 17:45:18
08ec4aa856a0043f4452b94346452fb7423f6be7be1c520047590274b2882b164a91aee39f550e44	1a8e0fd44768baca1c99cb20da589a7b25eba8ff6f34298124c2f127529629b887067d7dfefa2886	f	2017-08-04 17:56:14
72ef59d6123738ecad393f3e90f071c4acb8c2b250cb8679452addbf4fa071cacdf034afd9f41d95	79777c2cd13436fed22d963d123914bf0a406a958eb513ba1354ea46d063815fcc1a31315e4eebd4	f	2017-08-04 19:00:08
a886bd9f979746f844542506d1f1896feceb77209c8eae982b14b113ab03b9817521f37273f613ef	852ef3acf35cf296cde347ae753fa62a2940d9adf87f6824d3333e5a70f4e9bc79198243f675ee32	f	2017-08-04 19:31:42
f4ef5b0dde3d377741f03595d4f7997f528eb6a03469620d8226b2d53a60ef28a91db827fbd977a4	92c75f029918532db7d314af7d31239b209fa826db34527fdc518bd8d8fe3b4e414311b877f8661f	f	2017-08-04 19:35:16
e40eafe54b55a866da28cb92e8d148bf4de34e310765052171ef51ed37f340d7be16c48356a69679	7eae5991fe79ba720ffeefa13dd315e72bf082164fbdfdadad3febe49ef30b35e62ace994cd61f94	f	2017-08-04 19:40:47
ac4c61ba74ddcf64c680b424ee7b929c84bb01b950b565c234485f5f01b353e02f380e3aab5a141b	70914c259f1cbc07df3b7ce750c8adaceb20a9727d283dd4a953e68bc1b781f7742adbe56214a688	f	2017-08-04 19:44:30
6dad933eec3c10665fc40b781cae14b4db4a27135bb49766c3aab0baa72405bebf2669b14181800e	00a1b7575ec0eda5d7e20eaa062d33c5fd370541227236e667d520ae4a1e67db557e12762d8eb69c	f	2017-08-04 19:45:11
333bcc60e4ac4a0a6fa27c84c969c94fd0031c57f76c02f46d31c0dcf10695dc4ec3ee8fcd571a45	ac1c0d13a8ea1b0ff112bbfa57c537ac685200dc191931d5be2f29e809e3d584b5313b3e845c100b	f	2017-08-04 19:49:29
146f6d38135c90676b04051ad66373a4fc467a650eb46c2335d21a7e5b060bd44997bc1f47618cdf	2245aeb64b49347550301ea3c3f053729e3054048518ff516863c3e522c4a9d9a50f00e5d76bc270	f	2017-08-04 20:19:10
cf227f35c7d5e14fab01367dcfb1c47a16c9d99ba2ee1826b06c06d447783f5de59994a198f9bd6c	a11be5ffaf0577ccbe82c71e9b9fc8c181740221b24cc6c1e19eda6380ea01bb38dae60e6e02e9be	f	2017-08-04 20:19:20
b2871d3ed25fb112620c02c8ec2a5d21a09296ca0afaafa2fef432b12c86a280e394f231520c457d	4967aa5fd3ef902f11707f9bbacf5bdd5410ce0816e22a222c6afa878e839ef164aa5754f785555a	f	2017-08-04 20:28:30
02c5b8fd0aafded5b7c8195e869c1ec2489470be78363a0155f41aac3bb684df7f2d4fa2a5c19fb1	2e3ebf04a162239f4df7315623ab2e775a8c05e747b92270f737c118c8af28ed61d3f32e2d7a54e3	f	2017-08-04 20:57:04
245d2c0ca770cebc43bfe4e3313430868cb82c5cd815b79b00c66008ed5f36fa94a9db660c68cda7	752fb918eccc28d288b949ea5ac757e9e12c0ccde6c3e04a56facb1f29fa9704a8bc22bc23a36ec0	f	2017-08-04 21:20:12
f90aa6043e3880172e8f6c9207550bb711502af447f87be039d7695807d5f1c4949778fec4eba398	b821e3e5928807cb6b2bfb6ee42f64081c305ee9a10adc3ab18d46531ac75ce6033948e701ea15f7	f	2017-08-04 21:23:20
55587f752a98c7050d7134abe5e3499aa37ba4c75f557238a98ad814eef81666ccbcda04e8f45ffe	28cd4bd7fbb78d2896c7eb0e9283e22d28d34e822bc3102134eb527f3f65f7bfa8f3839ed1650ded	f	2017-08-04 21:30:45
d54e391892b93c9599b25bc2ab1a16986237e6cedea2e820bd08fb087ad3237e326674af75dbbc26	b65aa734ff100764707bfadfc8561d8a247e62040bcd38230f2ac7813d18bf97e01c2d2f6c2010dc	f	2017-08-04 21:35:40
9a9529e3142c8dd7081939789c6b1f8d14035e0a898d12fdcb2d161be4998bc19b967cc6d8f45240	5e8cf86a4563ee3a8ba8a3d11baddd82a60f0d508b16edbbe66e40013c4d687fc0f7a11ffd384b19	f	2017-08-04 22:01:43
be35c375ad7d0904e5a205c813917806f1696a47ddbd95d46174ae77f28b0ed7cd1eddef0dee8f0b	5504e285cf5cf8a54edb276e5f6e240c603bfe5adc5382d4c412115444077cd6cdb8186a58d96945	f	2017-08-04 22:02:06
d37a8f31efd05107af108b0d4cc04d8ae953c899e37a5fa1d2ee7c4c6475b1c084db3e91fa69e041	b71b56c53a35a1d06b7d44f176710dd3188a39f15e761fbc013b9b0ea65cb6a37d6b31355dd0286c	f	2017-08-04 22:02:42
cd2251db9bd72c20754edd4f5fc6704a7f0a3b90e1c160cf795e5c57b40eb6ebb73002df35d158ad	b3b49ecdb395a09c5b68a1ef2477e0efc8dff50d28a747ac8ff70e54dfe741820b3b4571549f9526	f	2017-08-05 04:01:09
9ed57414d3b0caa763c1c7d55727ee21742ff4f8d84512ae0ee26b6504bde2746067697176d691b3	7eee4275a45e6a244a3ef4f4aac9c893add695bf55d437a5cbd9a32ec2e0dea75cc02d9756248999	f	2017-08-05 13:08:00
ac43ee74d5e1be651de6d9ef88d85a0f6bcb7c1e94732cea5200522875fc409a9702f5197f41ec49	af158208a12009231533f231e39f8380e2e772277a1070dd4fbe0c5993baa4ffcef2cc494f6bb22a	f	2017-08-05 13:08:42
c4c431002072ea0baed47d9bd91317545581222f885eed0b316dff5327931fe864401c5c1055a056	dc2eb7a52fce7d1e334c7f75a11e3f28babc6085bc8442acf895e0b14709d5b794be9c58aa68e1d6	f	2017-08-05 13:46:13
89d3fd6129257cf91339c9e8bf87929c3cb152836194ef7e1c1e15497fcdcfb487fc557d6b53db92	35a2a2a1c8b6d9bd9eaf19f2cdb0629bfc5240440d038de702ac24eb1b33c9b636d51861bd2e8c9a	f	2017-08-05 13:48:37
e079ac3bd57dc71255f88642b65bc6023bc7c4b3039aff755c78be74651770a00dbef482530f2c83	29d0810eb78f19a132030226e25a28919cf552bbbd738037c2a614f17c03179fed83885c705c517c	f	2017-08-05 13:52:51
aa46d669506e8f43d555fc6ca020ed6c263da9534a90f061858e8f98e07ac8fc7facd388f4bc6def	d64c32a6bca49473a4b733c89a2eeb1d7ef8c8eee649a10a2e2292c37d553e6202ee548c462030c9	f	2017-08-05 13:55:27
7f412484843c8bffd2425a36ee144cbf714ac2a0da9928cec0cc7ef66631a8f7e315f08dc20fddff	df5e887605bae825f3e2348aacf7635a6eb4df3f108ed7bbcddb1f377d80099b86bbeff984caff29	f	2017-08-05 13:56:14
8f0cc721291f5dc4ea85b86cc70c50a9f67641fb3db9319bb41a9534fe7cddfcfde6080952dc7965	55fc2ca517439deeb559d68d8f46df0144fded361c3810a998034c25db9734abdc6c483a1ddd5567	f	2017-08-05 13:56:19
47b0882b8114dd42bdbe82f1ba04ff305bafb6db3c3696a48f8cd7ed9adf6416f2fe0fdfe561521b	3a34b2c668929f56cf72c9a25f69342c66f823a9c9e1e43d68d42486b98d11e93c90e46a1b1bb129	f	2017-08-05 13:56:22
818b4cb181b117011f2cd2feb69c821d0f295639170976c18b2b776530ef2408ba183c91cd348ff5	32247d1b7be2e01a4c24e9d55b8c7a4210aace5aed4648f8ff2ad15b3fece3d0047e9b16769ad1b1	f	2017-08-05 13:56:31
9bfecc28eeec8d17bc0e33e9e755abdd60aca7e46fc0050de2c8f1754e7f698ab60d12deecc7e144	2f226f85bec199828612ba36fd2e226a5f3ceeafd16e4839daac8213e3461776135557dfca66bef4	f	2017-08-05 14:17:00
bac4419686354295c39a33e6a8c310654ee2a15eab9b4e7d92c1464f012ad8f385cd860cb8d2bbe4	304b7827778d000d2339034d72644911723865925626f79ac27b5d994eaff13305bb6a33c2fba0a6	f	2017-08-05 14:31:28
8752ef1a1ad4f5fab5e585b603aac0e67c112ee082a40d4ec74d58ad76db366c825bd9dc9508ac55	99d1aeacdc979eb6a1733910c823eedf54f8b9199707f13ba7e5a331a1a217311b746f6e36a851fd	f	2017-08-05 14:50:52
f051f40596aa8de0e1bb2f7b43ea79abcb89ab8b24d5247cbbbe8b468fe85f6948a5892608eda323	bc05bdf3b3ec44fc2a781075f80f23673e5026a8ce160f3101ba0bc483202049937a0659cd1d1b8c	f	2017-08-05 15:44:07
736d6e8f57117f7b5c5c26b3dc3a24e4f25932889c87b18b7415c483be7364c3cad61a26e9773336	a06de49efbab77c9c68f5bb55dc87b401b77281a8f08daac34089321ab77eb4548e827fa68047474	f	2017-08-05 15:49:50
7afe0f719b250d622c8604c0f81bc08f1d442889cbfc3a3f6d9816de048e113c7a60456065da3d68	1d2f97977263ec8f445ae7924654e2a2de9de2f8aac6b729cba2ee8a23a511952028c479b290e5a6	f	2017-08-05 15:57:07
8fc49f289024283f91acb0baf72fcaab5e71bf981284929402188ac4757e99574c0029c3e9d4c219	6d5585d474a1fcfae7e9ba844d93bc16721f504276a2382dfe0d2c5ff12dcfa1d9946f05b6822c83	f	2017-08-05 15:59:27
d3c7ebccc36569d7521a5f7c1f8618db8b4e4a616ad1d836edcb8f0591c3b9ee1ab20d7f8bb6349d	b58ba962d2b99bed914fc89233d872ed6c311063f2b40f15708110a8a5011acab3fb62b651f36432	f	2017-08-05 16:22:18
581a8af6667f3d3dee30940f03de35128ce94d5967fc9568c25412fd968a629403c473b0ad8a4eb0	8377fda0d2c88e16e14052d8f49d1d3d0cbf8f228cab441c33ff9c723449d96a4d6e5bc21f9d29b5	f	2017-08-05 16:44:39
b2ff019b0106ffe998fac1cadcb5074d0c59711e88678bbd0d6e363d6e50bec08982c7ba6a7c3da9	d3a1b0b786de98fc773ce85193da066a3f1ab8535105bdaff9189356fe4553e233c2a903ec2a4c09	f	2017-08-05 17:50:21
43630efa208a15c5854607fc433ce4806f2a4d008d836a5e0947d037c7bc06d6cab74bc23354a135	fa84462749b021a8965feed5d22537eb1a4dad226aee0a464d29999091429340e819c2cf63efdd24	f	2017-08-05 17:50:40
59884f9874fd50f37213f27b94304570b5efc8e635b12e22decf09651fa2ef91a1941e9e6a4b603d	1f9dc74f0d39d54ffb62286b555cdd74c5532834b65f51e3c5f526a3ab29cfdc0871936ab04e8f51	f	2017-08-05 17:51:49
0087387d96ba939790acc37d3e7b69969175ef02d5ae6e82faf4633386e312aa6adc5aeef27ee62d	b62266a13e6f5854095f84410107521ca63e169638bda40c0787db18c9445d92cd3f9595b1f5a0e0	f	2017-08-05 17:57:31
620d9dc318cf11a3c8fa104ca303774ea5e00b2582929cdbb00309fb8bb195c6e00cdb1f61e6d902	c3722936fb92e90dcf2faadf7af83a5f9c7e54f07e134ffc1c85e4d95129f2aee61c933ac4481f7d	f	2017-08-05 18:18:04
9b4084f1413b0e9cd080cb4b9856ef7779103eb72c40a1752a76f004ea10a94e50e064bcf467b813	cca796c31915d06dcc00acd7d3d44f929752b37fb366b22187e965d02bc76b8809a064cf5e0b6b4c	f	2017-08-05 18:58:35
e034457c3ccc88e4f33a86499ad0564c486ae9f50d8ba9777804df07035e51b3bc25f95727b61ac6	b0cdc2d8276ec408b843bcc298a270f5106ae649d551309b39c80719086365c91ea812a343831c76	f	2017-08-05 19:03:52
2b4ae70911ad800fb23d5147306b5cef3371e142ce96833e4c14b2c364ca7a02fa69297f8bc566c7	367f3898cf556244e0f1f1933010e13dc71eb2c6a98cc4875d39c55752918eac36b40c1ee72aba19	f	2017-08-05 19:30:43
b693072920159cb230b9d0a826d546e0ee027d89d20b4d5f9e1b89010c77e982bd4fb16acd9bd00e	2e4e342024b33f28d47a5ae930f9a378ff5214bef169f552b45036374ca1071ed2786cd4304b5869	f	2017-08-05 20:15:15
c3a14100e68068565dde3f2d4aa9c8f327730edc8f24ecd7fcb2f52ff6564fb3717ebe88712d5e36	2921131e03878f70ab94d1aee89557f7521999d55b2ce3e1303c55bfe8c54bb7a42c93c91eb0a35d	f	2017-08-06 06:14:41
2563a4115357dbebc93f18c9627fb64c2e9b4385d53b3e4ddac2fb01a5d9e007207ffa0f9a5cdbaf	877b9520f3792151daef7eaca144e83d1dde0091679e0f2449e7b9006bf2654ca5d98f98d8536351	f	2017-08-06 06:23:23
fb5f54bd70a740df665df9a91121fd9792920a56351cf4d4bd42fc81cbb6ef7dbfe191a7220e484f	f9efb57b789397fa47c3decf8784ae05d004ee3b0900448bd7dddcbc8b5b0aa1062069f61809ffce	f	2017-08-06 06:23:42
4e313ab63aa5d205b567c53d5a736af0ab177857ee73727af090daafe291bad05aef3967057193b7	1896a55a7722bfce9a3abb66f6578d25c05be6536dd3a0be8f825f7e70b9ad69862477c1ee34ed28	f	2017-08-06 06:54:04
d81a8c5b4157991901f4fba7e0e899e815148cb2a6b5f9b6b62ae639423b17e3041b89a185d780cf	abb419a7457cf507532f2a4067309ded23c71cba8376229195c44b1a2bc3ec735e0339faa6f89a74	f	2017-08-06 07:00:50
db05a58fa720daf1023ca11dfd6104003f4093faf88fd73a600811bd08bad59c76b1eb0a50aa620f	6e2f54a934e45cab05e8a90c5081a4c28cbc2280802292b2282bd728a95e9557ac4ae18b1821a3a7	f	2017-08-06 07:18:00
b69f5e8b695c6657a4777b710fa4318886a2f2fb2e0ecc7479a040a5e51ba79ef49ddd4a6cf05114	a6cb050be0a884311535631756a973efc70707ff943747520c13661d73859af79e102ebf246423ad	f	2017-08-06 07:25:46
0de65ab3efa110c9e17e8c8d7068966908ebf987a9206079b685ea06709ea1ac4e4d39fea97ffe10	fc7b750d626bc787cd508aad5cff0ac46df268e7e82d5f347be4d0b3c205be8a6ff64a8fa69f650f	f	2017-08-06 10:07:44
41d7573387f2afc9891d00f0c482321553a53fc18f3179bc09a42ed5530e8f1c52e9d559a159bd36	a2b1ae5bd0543b3db7963a225488c1f9251aec3f6084ab44f101723798062dd65b505fdfb690d131	f	2017-08-06 10:10:38
f2f1dcc3b5b4aa5d057ee70b1919806f0f8ec7b1897074ab18881a064589c65bb3afb2c1c7446e98	a478dd5d0a5a1a6e04872d2ec4b9f23f77427ab854e39f95f38f69e965a8aaedaf9704b38d3209ec	f	2017-08-06 11:12:34
bfe59c4ce9cbc9423c1de43c948d5706439f9d8016de172342421ed2b13dc364389efd20c019b4ed	ca0fcf12e993f66d2e6856f5e40f2f42a9c21b5a6d5b6686861b4989290bb9774f88f64de17ee43a	f	2017-08-07 05:56:42
a2f24bd98c5fad894dff94bd4f090ef0cca194594cbc46bfe9968cc9c52fef0af05ae91cbf1634f6	0841072144d41a004718587972f43b2d502e453452587b36490f9a4fc9bd897c74e408eec24d8ac8	f	2017-08-07 06:00:47
60a18a9855d2239c24c2bb8a9db11b5789629a0b618b9d99f69afd9205f19f0dc0e913ff74a7a65e	97bdf66b042c47154892f752f339f6fb9a7d3f85c04afcc028ecfc878a659a9da8a3b6cf8d06212a	f	2017-08-07 06:03:39
db5987a340969615721ccb56c009ad167b35cdee9a3791ea384260886d1165ee74266bcabfff5f0e	6702a42979ae72788ccfc94d524f4776cc2250f474e185e1263f21dabfc7700fb0330192cc41b177	f	2017-08-09 12:50:35
05e536a060f0c65227a169e678b34df2bf35380b7234b480ced7a33e64558063191f3bc30e9aa7bf	9d0da7a2c1a7e1dd3c5b84f7780efb6ed3d6a837a33bf37160e403d21d99d7a33fba212fdbb48845	f	2017-08-09 13:06:58
04d3fcab3b64ad27f2633f65fbe11d68cee98d9cc7652bc93b2ce434ab87c4117b276213a99706f7	1128605b4bde1da7c831d8e652c91c4f4476050568ac19d61e8fad62bad27a6cfbc3b79ff2720e9b	f	2017-08-09 13:08:10
de66f2ad8d116a6f1bb33b88919ec559a1ae3856143ecbdf823eb4c2ad80779a0c136df39c1397bf	5cc93de2e16b51bd617a12c420d9834af8e60063dae3ca42fd80f81b1f8e6953e0c28ee33490dee4	f	2017-08-09 13:12:45
e0f05d73032b30eac2d23d4b8c55b8e2ad22fa15845da813db7955cfafc458ef87dfb59ac80cce3f	9aae0426c9aea07857811248d32c2b44611909364d4c440924dca81e3a5e2869cac68110b87e71ec	f	2017-08-10 06:36:34
6ddf9b182d6e66ce731d30cd4164071964402bc71661af56d29f71a3b3d95ec571baf5514b6351b9	a564e5ddbe367b132dc10b560950c7fad092f06e858051f1cccd57eda37ba840603ee9de06004f7a	f	2017-08-10 06:49:18
3c67161f87d7230647778015601ba18040fe2cba28c23d4781af4c5a775ab39c50633b9730f5e7d5	88edf9a0aea617a9bc516105977d4b1b3c2382204242030d41bfa6648d726ec28bb0792062c08d9b	f	2017-08-10 06:53:11
4bd189e79e8a703f37fa5887ae88cb63c1f2c1155e0b5e4e378417354d99707c2381811cd03a9559	34ace4e4fb19d4fe55e6cd855b403be9cc13995ed98c693e9b36e220e62c3b4fb8f6cd6fb98ceef9	f	2017-08-10 06:55:47
c42dcb71e3190f26380923be0cf69774de6b584d63fbd536fbcc61a7c293ffd2fb930a7ff194e5f4	1d3c19ccffd8e8349564b6f846014b9db17201d3b72288343f73bf52e844c05c88732d20bba2dff4	f	2017-08-10 07:14:58
6fd929bb7cdf3c10b81fdb434b25ba840d18d0dae952e8c43cf2b8f5f01e106cfd90ef765e63c09c	29705162422a608e5ad5f7abc4e0fa54a35ad7aacd67bf20d72f670ec6f659376913399bf4b97614	f	2017-08-10 07:16:28
139e00b654712d95be70b513bf1f47ff82f9f0154e815aaaf588c489192d7657ebb132a7d3e44db1	b9040f65aceb36272ce1e5eabdf71ce24c5c613b7a8208692593fef7fa9d9c2a50e97353bbabae15	f	2017-08-10 07:19:21
8b39d1c61a39c75896332d83eef98568c8d6f10281070d65b443e67e17b687cc6a8cc7296d944524	50ad2776ef83b167367a1af6a0b9f898be0f40df931de63c1f3f13ad11933e5f9ed2223597337312	f	2017-08-10 07:23:29
86a1459643c2e511f842d6a76f2a09101ea1a3d4c1695e7132f08d2d01346c51513c523524835765	15ebc56abeb7e3639b45feaedb8c397d05684f0c6fd9da58c6228d4c68d1938c953923093c4b891a	f	2017-08-10 10:19:08
d74f729b92e8cc9a04fc23966dfd9a79d823e2e0ff02e2585374b2ab9772538d267251a1caf3e57e	d6d317b27353a108c460ee7b839cce7a00b47b2bb788ce9dc692eef170c920827ab0695faed17d08	f	2017-08-10 10:20:30
925d0901771a08ac84a7b222c60d6b1293a7191d88bd3715d4aadd6d5bf3918a19b13c044f96668c	a3ba4f42aee6b0b3087bca62218a3afec717e21ac1c4cd67891dca9fb53cd8239d6e357bf7da46cb	f	2017-08-10 10:22:00
908f49784b280e5e36cc09cba8690a751dcac8871df4ec39d06449991fa08cf83a6b4fd41a60d499	c621e8f7fe841a6778632f4a2269618f147c55c2548a6ab9fd9ce1a1d4b93eda6a6da36e13e14539	f	2017-08-10 10:34:30
7a138bf4ec4ff6ed364fcef39cdfb038ebe6a94cdf4b86ad435ed498291ea772afb264a2f7ee853b	f8ae400693f408efd2eb632251297f78f3b9e397d14bede1923b0b455501bb215566b5f6913c89d0	f	2017-08-10 10:34:37
ab8fc5457cdb443c902af9a4cb0119f0b8ab9971e27e59269138bce924b7e2675de21a6065903ef0	c00b4f7f7ce06603b9d6ea5b97e99b4f68300e940c6e3eb947576bcef501cff86a9cb30bf7492b9c	f	2017-08-10 10:34:44
ffb57377af8133b3b35ff65b5bea0017be77f23c3ed8a864fa12ed2563af370eeadf634fc5730d52	5b2c9f071f206a15da29d3e3a0cef4f5a6bf29504bdef1061fd4fde1f1a6d731f2e4c6334c70d520	f	2017-08-10 10:34:54
c197a7165c99695de480d6d709b9c5d4f1e770b742c5bf669f7495f095631542da77ac3a9c2e170a	c4e76d56f80ffafe0d85cffdcddbad97e84c7d80f280446133dffbf1cabbbb6609a0a220fbdde891	f	2017-08-10 10:35:37
9d2699c799fd0c73cd23b8a4f98674dd39ee7bed58532a04263ff8ceae7bbaafc49bb47baaffce11	401a082a2ee657aad8d09d30b8c3dc17714356828c061c6571f3c9e7bc2ac7f891e25ddc4eb158ed	f	2017-08-10 10:35:50
67562ee214d501514ad8c8fc68270523c4d5d193956b687f5837adb8604f1b7b24981f58cf754cdd	5e89d6b62e4d6cc6cb8e796198c9c749a2397931cf090e509b49f3f6fcafaf25b01eaa8558051804	f	2017-08-10 10:40:06
01c586f355e56bf049cca8e03b30f74c0ee3b34a885ff880c6feb1ac94212922229285333f0d03c4	601f7c550bcf1703eceebf04d5674fa6ecea8c0ffb2fbb51ef70f2757ea5cdb05eeda72957c0448f	f	2017-08-10 10:41:14
3b785687a065d7c38dd8023de718a3a93434ec4f75dea6fb0e6d949785bda3be3209616f41340c24	ab074626c2f3f3392e9d89c33ead8a49ac135fe8ca99078a69a63fa464684dac47930c7b93880632	f	2017-08-10 10:51:03
4848ba63f403a00158fa9da67dde23e585442d908fc370fedabd134724055e2d39a1593d06ed9881	42b69022b4dd65c27f163b63b286c45981dc9e456a3ac83dd8fc638ce1c6f4f5fd65e517ba98cd00	f	2017-08-10 10:51:12
cbe40adfde18f7083277d02b03afa47188667269a75cd8632745bd68511a35ab0d336939dadb6370	c59ebad8f573cb9f6bcf761bbeed99b10120653c4f4bd54b703ed9a48a6f71af0d76ce0b285aa8e0	f	2017-08-10 11:06:02
40ac5749f57cf9b8ac7558b79a7f9e45a31a8e46b6b1711d92e190b3913da2521e531c4d5439e161	0c11df22422af8adef127571d19d7a77aca245e2856eeef072e96cfbbc4f93d94b62ec9c84ecd90f	f	2017-08-10 11:07:45
9273f48c12bc55e0eecf2b81d4719b034ae19800cdfe43264ebb48b23024d532bfd945aecaa63a55	2d772af59a169080e148c7cbfa76b865199ee44c26c17f58465641d489ae2d50df6fb067ef6a737f	f	2017-08-10 11:27:15
b1ca3fcfb4a1de1a2f86ba921f38a9d5094811d7d1f32b494d92944534f57291191964c2cfd9f6c5	95fa4bd17080c1ba7ec828303c7ef96213f7e73fb621161c455c04304addcd6d805d59ac7a823324	f	2017-08-10 11:37:20
efe7ad19aa6f440782c7ab43d36d7108b1adcb527ec6227231e7c903e6b4b4ed5139605897e5b6c7	985712fec89c1c984ce768ba41507ab32f13a9e584af63ea85cb0e2cc1eba8f8bf26d14d17b78953	f	2017-08-10 11:42:40
2a83d28847012dc58dd37f9c41484df5a1eb28502b4c635854495b7d29f26f246565faad3a516566	556a11d68114b6d82a62e63d76a2ffb6364060843a295a09828bf38d0781c418904423e54bc97e46	f	2017-08-10 11:51:18
0e26e7e52743633aee85ecb4a1460aa6f8244ea39213be895289307ff3bff79b915f6642a51885a2	22c4c2d8d316f16e0d5fa40cb00ad5893cf8c0d1b6805730848fde88773443eea5302be316e2339c	f	2017-08-10 11:51:31
896717e1010fd59e59f0b9344fb635ce0b3e329abe4c5a639bec0bd5d4b3231d7cf1c040a4f51838	f3d558088ec2df84f07e8eeeb86a2617d069c08c08aa479b8adea2b4623b8b0d92f0a16dd0db1415	f	2017-08-10 11:51:43
f6f65490f2ca2f825c2fbce2edf5dabebf9019b87ecaa34f868c43a086c4b6e6861e3aa5f3fa9f21	1085ad71fe56fea46cc7e6928852db7e89a5fb1fb3ace18ccd3a23dec40f1030ad7a2de036d9aaab	f	2017-08-10 11:52:16
949b501cb602ed326ae8727bbfa028285abcff9840b74ac7f4036f6eb898fb7ae9b56b8d04f5f560	4d72fcef8cb8cce089ea0d239a35506805c4f5480ec1c2e035f6d48ebe686b9c32a6904972160263	f	2017-08-10 11:53:03
589bb3e42729243694ce572e50c5ad781b96a249e389a48db17fd72b85aa6e5bd9de69faa7346173	3afc2a96380b1c07dc373a7ecbe3a41646b17fa9d3b6a6847baf7ac1dde40ad30e4e79f587e8d7c5	f	2017-08-10 11:53:33
d9bbea0f9c6e52461c0f2f42d90d9cb896c85c64e9214b0a0f77da33afcfbf9b57427d92721d8246	e04f7c70c5866840a7c407d0da1468827bb95ab30d1fedec5407992e9d50ccc1220ee97b320df793	f	2017-08-10 11:53:57
9b7bdfe027fed7ba615066dfdcf5e537c7a131ff8ab1f55aa11110aa4412af383574abffc9960a71	10b96c3ae9e822d61472b8a5bbbbd7a6e2d2b7ed515c8ccc740df10273055d64aae3e0ee10a05269	f	2017-08-10 11:54:27
96f40e45255881566953a61fdff76fd0c9679b4ff7eff304864be4716ddaa2bc23ada32d3548c226	ea6826862d1a08eca0236d4f692b89ab06e5429a924eeb847857c2d3fa73df00f938c730df7426d3	f	2017-08-10 12:44:14
126390ca49d3bc7e2c9c227670af36f1772b06c9c05daf16423c3d923406000ac8309e08c439f4e9	8420be0cb30f9d49030eac438b50c31827f5d1029d1f56d7a5d71a2becc178ac3292de07a492103f	f	2017-08-10 12:55:32
8b9deacb9dbcfb85c157d99e8781c4043bb7bbf36296096f4be26cc06f8ad8211aa79ae0285ab3a8	3bdc98aab18cc9b4d319c536bb33364d72f66b811720565146aebcf7f7beb7fa566d3b6a1cccba84	f	2017-08-10 12:56:02
4b45a48f051f822c7ff03eb3ebfab57169ff7a2828dbd8e109371a2b1915808add65b469bb5c8509	185d9536b5ee6c9a9f9d562d3ea11d08ac29d958fec8031f164d13761bf2886a060d9d3fb42cb430	f	2017-08-10 12:59:30
d34b7d1947056d63fb11148664cdf6714e335b70e684b435e0da340a48b8070c58f60323aa9e5183	bef27d2f213530a4301901a7e955d3212de9c805de760f074e2c73a8787bcb04a30b28f4b95818f4	f	2017-08-10 13:01:52
eeb9dcc2c5bf275ce53751d1c883d7097d20425523cfaec31cff8e7d201cc78eaa9a9fb60b913b93	400d0efb57599a88fe359c0e5ae23769c1fe7db6feee9716a5bc0ff23b11deba59aae717aadf48de	f	2017-08-10 13:03:14
0a523b944938b1f2165c7c56a89f77a538928073dbde22575f51c09c9b13c4be1cfe2a43b1230eb8	2d8c14c4d1996dfde7855621991e364c6ff61bb411cf4cb59c6f580e2a7fb8177f9c956c58bb21ee	f	2017-08-10 13:05:10
8dfeff7202db06a8a8a8035e7257b728eca136cfa3acda3d26eefc7aec80e5c5e0b274640d27c476	bb0c15c8ba70fe30e2370364c9ee21210764dfd1241daa9e6d4824f773ea864fc1cacffb5258aa0f	f	2017-08-10 13:10:51
4841e68b244096ed44fac849f7136976672142f4f3c9f53236ee364c1c53f5d7cfdb1b8d96e2615f	66ebfb8279a2151e61a897ac528f811e70148afcccc2b4ec1c55e28e129de894196c0923c64aa63d	f	2017-08-10 13:12:23
218f1a081c59f66afaf17cdcfebb01fb55efa1713dff7d4163874947223a42c793e6eba9e4d90768	6e06a85c1c7ccec56ab67a06287a62d8688a3bdf3ff17381ce47bbde5bb44dca3f41cdb2df7a85d3	f	2017-08-10 13:16:01
cb75b62136be448570478f96b0db746ae77888231ea4aeff0a7a09a8c2eabc05d3aaeefc8436b1b1	12fd5fc57166141984f5e6f10a24aa20cf8b0a44607f5b3f925ea9cd53ace158ffeabec648b3a617	f	2017-08-10 13:19:18
72447a6e9c8395bdb7652939a04356331c0523e9b001a93afd94df315cedb55f6826314720be4647	5857430c0f37e71dae566fd0cb1bfae016814235445e80e663f7561190dae234b91ae45ec6e2717e	f	2017-08-10 13:21:02
189e376847a46759854cdca347ee76a7980da84bd923b1c717525cd81f42a46e8d3849ffcca5dbf2	b33ee9596cd4cc47129cb753a04a9eedb15c9340592b1aa4373d1c59793a6c9389dd42be3379b211	f	2017-08-10 13:24:27
a5020b8deca5bfc8e914f9cec599efc93bc48d6fe0b8f281fd136d2f5e238a3818ad3bf69c994b53	e0139c2cfe9c287e97e3987f389fba25bd927735f57ea6270a0df0f2529adcc2aeb7cf69aab848f5	f	2017-08-10 13:25:03
438e975b9136cda015c9208ab61d39b5e1bcb3bdebeeb7a729d1d64cfa951ab22e672217a15f78ec	4f2a704c68d97c16a2ddb92e81b55295015900c5a7380ee6a5af602f9309318e8a9381d2e15000a6	f	2017-08-10 13:26:37
b6ee26ddd82548d0fd5f8c1758c4e15884e44da19b913fc2f0534273963d08f735b8dcf80bc79cf5	45b61c9300f2f98b4f16cc2969ce2779ca08592e367c900a0d258e86457a96f16f69dfd64ea6bb01	f	2017-08-10 13:26:58
85235c3c3b6af85cf31b2fb7da5dafd04b095a9cda506bb724487538738f75d71678464a93ff34ef	f079b6371a25c84a93da54accaa9ff831184fef8f1e1fccde6ac0fa093c125b829b38a3773a30f47	f	2017-08-10 13:27:29
c57eff2d8f382f5065e50bcbeebdd965dbf569182eba77b28bf94ee13f74d0f09bc203d7773eb334	3963a7d669176117e411b8211602e304840f0f70eb115d93dbfc6f24db63db13795cc8ef4fef9a3a	f	2017-08-10 13:33:42
807bdb7c7569d0055f5c2ddde093c0db43984d1c109194974f187993699a207b36285d7664f1e888	904eaf68ad7bc4737abcb093fe29e600f8d15c04ac28aaf8afacd4bf4dbfac81ebda5c0f5781841d	f	2017-08-10 13:35:12
b1e59173a59abc035a14eca76095955a78240cc8a4ee16667fb6e92a73a39d2b9a92ddb8f2333661	6af1b3654ab9d06cf2797663b708c58224659dbdd43321f49f7ef5338cf2b744be67fac0455d2c73	f	2017-08-10 13:42:14
5dd94f3e16621bf1883099a3db7aa8f4ad5f75f399749dcadead500a68b85b79140094a187fd97b4	cec4285089eb722eec3b0519f03a269e65763a8208909486c4ba337565e3c237b70128b66eabf9ef	f	2017-08-10 13:51:35
64223173278b51b97e6c565a59027d50a762753fb4c7fb6a640d37f0459da4a5ac2ceee1c426f68d	c65d061a898234acada1dfa6544d70a569c99b904ade7717e89b6b9ac2d95338c8635893d28eee1d	f	2017-08-10 14:03:05
a5630f0413a3991ab09019ffe8f411ffe05f8a6997a3dc4072a33b9bfde025a8dc376c1aa4fc6a60	e7db5d295bb852e31085cf10fe2e3e8cd9e9b4512f4b2f9d700986efb092b8294dc9e0d38f4ff308	f	2017-08-10 14:04:21
664ab0733a0107f3cd36eb42dd5c304082a4caa6429e01d71cf76090c426757a487e3a1bb5ad90bc	082595ff5cc6bfd761d1620d560a94cd68897440b98a4c54720e1715d59f5f76a54b8d96f262888b	f	2017-08-10 14:09:12
bd536336871c878cf43d520296ec3f0b7bb266de3604ef15b01c7ee3d1ad432f80f2577b1131c6a0	1bd682011a9e25fe473309a482c9b2b02c053a57d9be58e20adb713854933af6b0c9b60488c4eaf4	f	2017-08-10 14:09:54
c12e68c3fd2482b17f7dc08f30ddb7c41f56c404fc8ddf173d49afefceb890d919e88e01dd00920b	44d4a24a7bfe7c57a21a9e0d232afda813bd5ec259a84e67a1d27778b1b0b2411a6db5bc4b7c9ac9	f	2017-08-11 06:18:37
8a7b3332e4b6f9c51b90bc2adf2147a9f4996c9a2e4f949bb23ca9c7ced434a89ec4a82c63d5cdb3	315ca7ce51aa11ef1cdeb2ef561bca18d09ecae6bdeaf0a7029e067095dacafccba69cdfc68d64e5	f	2017-08-11 07:38:53
57cf47ba1520ce7343789882dd3e40254e88762d50fc82fc8a849dd1a3d1a22e47e566fe76332caf	125702e499ac3773a55f6ca32904caeba4d9a2995e8b32219354ec6706cb58b3c6c815f6e9f6dea5	f	2017-08-11 07:38:56
1dc2962645482f2f274b9eca373d7464b3c23d8fe2783dfe8d03b112d225724d458a3d3c9e82527b	63197386cdc9001cffdba2d66eed97f38f8374bf143c9650148271d387a1a32f54bc99f1cc067c6a	f	2017-08-11 07:38:57
04cd4d8a288e387d3ddabb140b5c2378e7547bd146dab393f576f552f8a310d4d2ad4eb3df81cb51	a96448bfa7f3770e18040dff1acb25d6cdf88e5672292682989d415095def1ce7bc815e30d716ae0	f	2017-08-12 07:32:37
3356635ff0af0e3c44c99422b75d56b2c73a59f1cacad0758711ff4e3d9fa9dadc1b63bbc5d80420	43a7bc59a6beaa0a18716bebbeaa943c226debb6d89c7f09cc9bf8ac553f147997e4ebb404e8b708	f	2017-08-12 07:45:32
5c076d48d29bbdceb55af42a93f9db089fe10f3dad60572d91965f171c6b18c09957f9c316951b9a	868c9c810d8abe12c2c2473d278fc82b1b2914dd1cc90a60e00015397fd6a4b3def257db25f86ca2	f	2017-08-12 07:58:48
dc0ef89a615cabe6367ec443636ee20c5dad0613e7cdff58e282ef7cfc128e48ca55c6e401f051be	6e0269e6204efdd3811dde6ebf8b8c56eab1eeddd4680d12047b2a83e980663fc17fb012ec6cecb9	f	2017-08-12 12:41:38
09214b7c5c3105485bf6f42242c4aba081022ca79b6de636571f20fe5da04f731660d7d7fc310068	eb51f13e13f50cb46c38bbee8bcb9493b11d37ec7e7e773ec045cec631924ad846164f78eba8e407	f	2017-08-12 12:56:57
6b9e694a6ee5b9da3db183b4b5e9c5b56c78151d1acc3c61bf26b4457f7e8aded513b6d16413369a	a1b63ed1768161e645bd8cd9728ee1c7faea7fb3a6b1540994d782348a21579cdcadaa26e740e623	f	2017-08-12 12:57:32
1ad190ed3a49aa7748fbc3c2678a5fcc197a6258c8c3207c38443b1a1e5f9c69ca67708fead134e1	fc13082c0fb96b80b267bd1678886422ebfc7037ba6171e71c17f5abd117e55b9df4795963d4837f	f	2017-08-12 12:57:51
da28b8310387a3c039c7640508816c8c87311a061578f07984cf3306f95ace445223ee9f08a3b9c9	329d0e2823ab6691faf54523a43fb8e6bae8e7667aca55288ad7fc1794cb7739a5c17a5073395a1f	f	2017-08-12 18:34:52
3785865be1adc66e4a1b15792e45dc8675e941c18b25c174df338811e244287fb9128dd1a9df7c3f	75f9fc0ca37d057cbf8ac6c00022c1745c61581d793f42fb596ac0f2b5229b745167cffa9948c45a	f	2017-08-12 18:35:29
e9b0a918461b3083e4b9159d8014174cc8dbc2c1bcbe506c099276a8fa57b80e425ff1f3acbfa68e	0d3aaeeb4acfbda59fae3b76cf05ad03c68081ab60b4104dca666dde2ddb5d5dcd3f73b34b70c018	f	2017-08-12 18:41:10
60c28b81fa734c0253bb8379c51b11ee2f172466258fbef604634d81027f60aff0f90bce0b2da802	57b28e7bbfb6fd063226e1f5e03420d476d2b707cda73edbea97fe011cdc7de6c3a93a7dc213e0a9	f	2017-08-13 07:06:35
7d14d0ea24e6b8c17d9189647700501488511d74568e4129ecc14e52ebf7305e6ace9bdec15dbdce	ceff59c1983ee918dd414dd15b7f41cb679d27537e61556688aa87bf32730f370f24444bbfa11d64	f	2017-08-13 10:23:40
8a903d70781c83ddceb0f22d7c87440525685243ea24fa3d163ddbb4ff49769cc48a50eff7062ee3	cbc960e5f3c908389bc1059145d21b237f4727049df2c25137cd3e6dab371eed25b85bc12ec15a2a	f	2017-08-13 13:08:24
efcef22658b5f68668259b67e7b490cb0ae4aba5e4ec93f9d3f79cd640e8b2bbc8e58db246045e89	5e396123585a2432f8dabc6b88dae2558e8523aa7976578686eb29cc3a323df957efd64a3d152f62	f	2017-08-13 13:11:33
302bab8ea556613d67e99854b2a5b8695a67c2c918fbc0aa6baecb4c921f1bd7a8c3956ab7a3ebb7	288625e61de072f8fdd0527c28e1faa57a7879443f9aaf7fc5dbd0b08b4d0186c69169228eab260e	f	2017-08-13 14:40:18
78d69014a8d0ccd2b959150b9efe8d9236df372b03c5baef4da743d770dc3dfae5be82eb6ddfa120	30228ef03ae7eebdc4432a4c12b7946f617286b76c87fb8b1b900a39460c72232d119c34ad3d5f3c	f	2017-08-13 14:49:11
a3f1c7933ce601f1362ff7aeb109351068ef0f0ab61d36328260fa9406363b6b049c2d88b9f31005	0aecbdab0db42099b7ccf08f73ea115924ea6cce90261a89f355a0008cb53082bf0b89556ce38d7a	f	2017-08-13 14:49:24
469d69e2ce0b9fa1c891217838419cdc70e908a95813aa7ed2c9b6ded9157520734909a7afecb383	097a5a6bc95ef737870b5dfc89bc38748a1cf1e6784aa8e929af54d6cc35b88fd69354a7fc809a99	f	2017-08-13 14:52:08
0bab53e7b22cef530ca0ede1cab97abf3ddabcc371abe12c142822e48b92737b8e8c3b35e36aa2ae	16134f3ed87ee0dbb6afbfb846043273a56a4c0116b22fa6492f1de949f0c134c72f7b69cfd75955	f	2017-08-13 16:03:20
e20a7dbd75533ac1ba58699fa7c0804d7eed51994d77631e20a805e863607e0a6b0256d64f329132	bc164beceadf43c9c52023f331d6dc95b61f0dc77f9e3601fe10e0d9c1921fea217cb9475ca5b58a	f	2017-08-13 20:16:03
870a1e0c973c8c9cbd4ebc07eae9586185db0678c69c2c3d379cf6a71ba992b93a49fd17b0403aa1	33350c42aad6566a44e9e79b2005da8c890e297993655bda0cd99c2280df28736dd8c476d5f4e547	f	2017-08-14 06:49:32
5971fad7a3fb4789bce842106d91a76b17c6d25ba54fbb105451491a9befacc20c46599848922db3	d4d3b66582876019c6fc9cff39f65e4662b5ebef3b32a534ca5f59f8ce1b5aeb532c7e8cc733ed46	f	2017-08-15 22:00:51
e6b58fb309452eec9e8fbe8630670dd5e67a3e3c47600e651dfa6004f1b4a8b4d37d1ab54c4d0411	8c6a62cde751d6f37549f80103e0d7f13b47c30fa8b1bb0b18ea1165352268a930708d648dab5446	f	2017-08-16 07:21:26
0933831080a7a49e756bbecc16f7d4f9ec4a0838693b5e687fc3418285d60382b1459b9f87e527c5	15045136be96b5db478c34ea58f58a6a9e8f8ceea81ed956035b156987294b24fdd06d78ca9f39a3	f	2017-08-16 12:17:22
4cc5bba925ea99cc483d82e232128c6a12c986b49ce776d0c3400e3da37f6cc4f44746c1c6c1d46f	68f4f6f9164f11d83a46303053501e8cb0304bcf2f97ba7d5ee87ced0208fa2ec186c5569aa445a4	f	2017-08-16 12:58:43
be34f192390fd54fd34eecac3565e5ac069ce83057a18abfbdd2f0acd3cb607d64804c2ae44b708d	7a1163719cbada3e7d518d534bb39a12bfa7f9d5186fa66fb594cf65e9dd9e12c246ecd091f06f9c	f	2017-08-16 12:59:28
4929b13880d515f510ca36bb7741aae43a87628a5f5795553eae17672bbd73928c60bad9db344e48	0e5de3cae01306847bc076e1150b62f0b293d9316274c617ed31e1cebadd1cef925e5e9eaced7fe3	f	2017-08-16 13:09:16
ac48497d0570d7079ad8708e38b5ef62f88fe6dfc3156e5b1ffcf5227ac0d893495c6f561f6efda7	10c9ee563deeb86fc3d6e008b236001da01f47d9cc8faed017f546aaa4f534a1d288337588532a2d	f	2017-08-16 13:09:35
14889c65ff97ea23f7e41df59ce246488969b825f9c32a780c9a08f4b2bca1a6cdff08a72de4ab91	604da1d86986e3a3a7545d4d59bf8f0dd167901e1679736d044a6176281981a688af65d64cd8036e	f	2017-08-16 13:56:51
3ab70a4f985e95699a362be63fbcd22f3e073bf4615cc67c92289513f70d17f1333aa5117fc3c3fe	2fe1f27b5c66802ef3f07ab4a6426b73cbed1e5d6aef4d41ce5c1f2d2138d8bee75f3a0e260e5420	f	2017-08-16 14:00:10
b37310ffe11abb4b832f55b007eaa502c6394572f1b9654d2a02dc9694b066a9f107bae934ec3d0f	73c96613aa0e63e6efa28e255f423d454a06bf3dad941a86021f6b1d4895fedc5ea818b69a735637	f	2017-08-16 14:02:32
3b4e7e2cbc3de2f95417fd374145b8396bcf587a8187300775fbfb2403789b7ec1a844f6ba35016a	93f009bb00c61134371294511729af8f7a3df1e1fc2e277b6df09ceefe1825fc189b4ab066e299b4	f	2017-08-16 14:02:40
44a62b7a98b5998c42a977699ffb22fcb0134a2b767b7e46ad37e951cb7e96a22321646b4b342925	69cd8ba5cc0e4018e1c11b64ddf1b0648711b815d074f3ced73d569be08c22b1ba88160bc04dcdc9	f	2017-08-16 14:03:11
c1ba7931e4c3bfdc07d98dc0f584225131647d9717de1bd6292380138b3b6075aff42971a6117750	c4de16ebf70b3e71f03be88b73160a4066a9527dd43953793f225d81bb81787366175b55b9a1d6a2	f	2017-08-16 14:24:56
f5bc4614d9edf29dbadfd3e26323d8e8960c7327820cd2fe8e223e81e518e29b6932f20809f5943a	bd05e1a7b1ded56b92b31a85c9e89a072bf465efff76bba3a81215aba43336f28b0a19521f00c039	f	2017-08-16 14:43:30
abdfb811c793032057f79a032a673c4e974dd6bd54334032945aba1700b7712b50137f4741c8e194	a85602851c2acee45bcd792756ab07f2b841f9b3902ec7576861a604dfe3ab6e4dea98b410ebf458	f	2017-08-16 14:49:44
4dfdd6d50b83f94355cf6db45df142373bd5027b292747480d2ee5f63125bbfc8755cfce144f202f	820e8638777b44978e723b5f39fb99511b1696fdd538c5b4a9062c88355e2e0bb77d1b6125120c7f	f	2017-08-16 14:51:54
a860f536c67e68712bb46eda71aa5de339a2d34ef914b6596d6133e1aae4a31370bb142469ef8003	9b23cbafa31d76defb61cd8ad6c4b949a4ad8960296804f61f984da93fc464e9573a20f534dfb36c	f	2017-08-16 14:52:24
9330a5acaccecb679350c41465a2ad995f60e852e5d870bad21543fce65c155d19fdf6fb4637dd9b	c50643c38aa25dd857823159ecf2056c7d870b594489d4ad0fa14489e3520f42daec0b26da8e58cb	f	2017-08-16 14:53:19
1150760fe72b5820fd2c3b2eff44695d2d8bb49c69c09d92ba71826991e6d6c207a5ad9539c6267e	59203553030d622a52e092848ce20b0ad80cef9cea03d32889a906019e0ea459abe3aca09a97e57a	f	2017-08-16 15:03:14
7b7c143c495018a9a931ee3f9bb6dde887dbfcbaef376c197437295589162686be2f2d9f00a7e4fb	3dc26330d7eabd8f1af57054614de7cdf09bde01d02e7cc477cebd00b7501f5c5b2e1243ec0b2a83	f	2017-08-16 15:56:10
976dbe551cffd0f908c75b117a18cf8ed6a6efccddb4994dccfcd1c4158b3f32e634393beee51fe3	01238fbb79a0596193bbecea362736a2e000cacc141b4dec13959474d01f4b30dce60e3a8319e60d	f	2017-08-16 16:00:16
1eeaf45b0b49a1f9ce2603ed221af532a40e97499974c87bb13a27748c91c6b83de350fc101865b7	f03fb78d6668aec55810d1146668f0568d7c93bfd9b45b29fd058565b5c18a452582be2f3c7939c9	f	2017-08-16 16:01:02
0fdfd8937f83ac9ed1d24571d29c813e6b54167bef2e35980ffa7b5559d187c696af75c37fc60288	f78ad0cc9acd99422612ba03273aab941ef224bce88e9e66cec157603a2bf9433412022800a8d6d4	f	2017-08-16 16:01:08
737576d70fe7322c3b0ce094faa96ce68a54bb2d674d022f71a055d79620bd9c69dd06bd9c034b72	9ce27a054b2ba95d031877b627b799e51e0a57b796ee260d9740b2cda81fe42a79c1c5c512be90aa	f	2017-08-16 16:02:15
7882a779d2024ad2d0ad9a1371003b7d02c1086881d1d84d13efafd1c340a6be5d686f8d269b2251	d50d69c065814292a9d5a89862574e17cd0beede1d15c3a40cc3f035b680676476297facbd3b7175	f	2017-08-16 16:02:42
b4c08780fe7392ded5e32d4d548e9bc58d61b395d0f28982c4c9a2bca57c56c7fcba37fdb7861401	a7f37f786d003f500366d4a254cc7448f97cf40f5bc4511ff0a687b59388ca6efa74c4031a7019a7	f	2017-08-16 16:02:44
d926bc2c8e5e6decdebf77430ca69c589b9749a7ee9b03f5f312a18a9d2b7e307e133ac913918e2f	b31631f414eccfa98f1eb2bd1f31fe426f644edc940db20c2561719a51a1ae63cdf5443802807b05	f	2017-08-16 16:31:19
5cfd75e20d3400b0af2d37d82a0f647fca6c9a27269fccb2891b94168973b1e0f8a5055da0be91e4	f6c133255e74eeb4ba76b2653688c70c6a69c84e3f42d587f2d9c4e8ff85218c16fc3d447c3b4a6a	f	2017-08-16 16:35:37
4098138a23696f85b356198a18103b971fbebccc00819acae2e6890b4091a4e9bd9be05de1242702	64707cc77594b39e2ccabbb775ad783ab7ab806ada3544a215bbe2caf6357557a95fd67966b839e5	f	2017-08-16 16:36:29
7b0b32bc41e2b3d69468833ce2926046a80c2b3e8245f194cd23bb2df0b9f81b2718b1a703f1ecbc	e6a25be78c20de6841408539c9df2fbb69f472e8b761d4070720673b95985e54130d51ad08978769	f	2017-08-16 16:37:22
65dfe74714eebf238974f7b5447633b7c6061a2f2abfd45eef3543dd07300d663e577a4af929a6c4	c4d94e287430b412dbb40e8d4fe3a7dc72fd911738e7c7cb2cfd580bb379722b47574272a16447ba	f	2017-08-16 16:38:10
2440e585c9c2ac68c31f68d7df03ec972c7ed286e7c35fd57bc526561388a74d301f445efc24110c	60b25abdd3f409236e920762fdca40ef03001d5af8be8229cffa0dc48ebc103551e4e6af49b7495a	f	2017-08-16 16:40:05
0966f808a4a97dac8cedb0661dbec6b0ac89a1ae184de3e939442479ff193edaa0720e996f6696a7	a881e2ae5ad4bd3f626e02efd1b29ee242054cd4119be630e77598dbd6f6a52c36448bb8b9ef9a3c	f	2017-08-16 16:42:01
09a97070fb5feda29231c0a7025f01156e58eeb66ce207c8e4871a2ed842f22711b0c5967c908978	dac74989f215263a9961589c2092bfdd465d1be75f9d0f803fdf18003bba3bd7d3d883e5e793bfc4	f	2017-08-16 16:42:31
219aa97cadfd7aa2d3a934aca09d8ae542ac736aec2b46e9aa714b9667f0fe06c8fe44dbe91e0e15	537a4f2e4e951aac67e3f9cabeca005a824874a2ee5e3de3c2796cbca545bd1962074addd4cc7dd6	f	2017-08-16 16:49:21
7972b9c70cd54bf835d97a16ff63e769c5a4f3cad0566446f95f3903e237357d383707df3fa7c253	0d4ebb680954a87d9162fe473dbc225bc3929a0d06e076906143b7f8978718ad0711ed9ca3b6157f	f	2017-08-16 16:50:53
76f37241460bd7e83e42b43e1e9b2e8a2aaa2250536de2868c765af010246ca73fa0df4e32ed835b	624475e44cab0fd91c2b5f15a061c6ce70130c20bf232c677a0426fc71325a14030e203a562a1abe	f	2017-08-16 16:56:00
cbcf531d808bd000f16130840a6f31f5f75f567683505b57d4c607adc38a21c6f48873344ed573ef	461eddcb3cb2f606648b3189ad9253cb1fdf7f0f2841024831d9c0a2eaa4648894a8c78df17abf90	f	2017-08-16 16:56:14
caec0840a9591d287d9d1498c5167ca6630a3835e5917e36c7518c64d403480cc3b8c51f47a80840	976f4628caa860e4ee058eda2eb58d4ab44ddaf44b1e35f582ce87a346f8d893140b29324f0dd548	f	2017-08-16 19:29:31
bac60ad4a2f7e72f6d32f6526f4be9a95dded4a8bf2553fcde4ea8a6da38e59d8dfdfce9f56dda7d	7c34d9e5f961bd953d026cbb73fa69e2d05ab05f6a6f8e84d26ea3b6ae32e1213b3fb870645403a5	f	2017-08-16 19:31:14
8ebee403ee985dfe0e32786df42436fb24d08ce3d8a94310e8e81c1c18b5ad7f9ddc436492a306cb	559c391828ce6169cfe22c85bfd9116dcd477eb3421a5a2b7a13cf7fd829578264d116c696362fc0	f	2017-08-16 19:32:30
699573b1c8f0a0f09b91d2cc073ec386ef7770f1fad32c4fa9865030ec5f424ac6f761ea5c282cc6	e526d63483b6a2a736a1274e026d44f6306bfe99097633cbd6d171ae5c23eb0063158d8806a22ea9	f	2017-08-16 19:33:01
0d36494f3f4971ee520c6469098f18ee0408556f60e6df43f3f5bf064c65e50fd14bff74e51d1248	303c6e9a3e52e87468e4f42f5e7e375e7907a037eb4c0f529464b9f8c91175faff773990f630d5c8	f	2017-08-16 19:35:05
738668a6f77fdbea09c9889dc0628241e5007e26c92bd74bffb8fd642849fff298b12aab96c73cd7	1ce93c5c4e7f73d0fa8b1c3a4b700a11710a9bb9174ab3729509675c1702a661a3b5fe0d724eee73	f	2017-08-16 19:35:32
0e60a283fa0672b00fa971565544272bc2e4f0edadeb37f9b092419f0f02663a1b80e6de47815f9e	f02a8a16cc46a77a4931c47882d7aa0efaef7d2aea601a157de676c9cab9bb52c623a59d795d8ac6	f	2017-08-16 19:37:16
6d4b531e88425ee2b01772a5c9ce40a8d8da4cab7f904c587ba8b7d13b858715ca9b8eedf92fac74	b71c2a4bc5d8c98f6799b5f265a9e4d4635bbd6ec154e80be7bdac172adce961ae90db41c862413d	f	2017-08-16 19:40:51
5f5e771c5d97e2e67efc8598bde0995a67b086f8bd78aad641a6837e6e4d1ed4f8558ddb84a8f588	1f8271f2ab2ce5b05ac64e7582d6f9f93dca9f96926939f57c62b7ea4305fdda420623b68632c6ef	f	2017-08-16 19:41:58
24935bf624fdf8116357d6208fad84127ad6b49e91d0f565655b4be75dd21464ab64f2b0932a85a3	52b33f4b19dcd18f849ed5f4a2de57f80580cc581ef001fb187f80aad40ab422cf931c1b93b0e2c7	f	2017-08-16 19:50:12
22bf63da958b3c5280aa3640a648ba25dba3182886380aa19ebacb797ce53722d2a6523ee5d576ad	e48a77c6527997984497fa02fd271f5e6449799d150faa7530861e761818dd172ecea7594381d12b	f	2017-08-16 20:01:08
b4ced893cd7ade94fc8b2f3f85bcc2dc949589f94a41c9a8fb5e19fd55b1b74e0c9cab4452ee5835	80caa0a51e72c86b7c85286ec088da8cfc28b6795c53a21ddbe4627f19eae973eeb543ef023fdcee	f	2017-08-16 20:03:49
e329d8b52602b6acf8c3724f18be27408f11153a73cf0290ace0d722c58d4055f5a041f670864914	c1aeff990e963975cc831a33ca82689c65ee59123b168595e1555262bc007bb0d443188b7362ebb3	f	2017-08-17 06:20:53
3c9fe95a894ffa2f08b3546b832783604c146fe7c32d001537173124bbd0449b5bf8ba9fe1759c5d	1cf9b82aa2cefec80090e5fac186746cc36755b822a07752785c2941a8bfb80d80c7c2388bf6d622	f	2017-08-17 07:04:59
0e5bd666cfcf3147137245e992bdde4a1f85ee2fa838f673c11eb5bc7e9568d612aef75279429d3e	a43af0dba41f942790bd3b7927c498a9290bb85b24ec36c36d4a3062f8bc22c2de1e74a8f4995535	f	2017-08-17 07:20:53
e11f5bc438263230cd117cf255d4785884f0b9d2fe783c6930fe6cfc52fc5da3c31d8c6f7480c6f6	c58b662536c87b2006b3ee6d4b58bae5112909b9736902bc130aa0dece6fcced655162252ac9bfe4	f	2017-08-17 07:21:48
73f5c048a259418d6a84f7d07b90232c80f8793a0f5df70fd1f2b467a6707c80aaca9fee010e7e9e	99906b02e47692a848aaf7029c6568f38cd9e9218a4e6bd3af2e7563d063f2be3d8e896ae3a3a43b	f	2017-08-17 07:48:31
308b53e8daf799ef175f91f72a0a5f294793b21d6480c2d268e3163bb03597d69decaf09f7b1ab12	fa6771bae982614449c1844e443857ee4415728dc6470eec0d876e906e0dc3871cebeb2a61455cf1	f	2017-08-17 08:25:26
a320ad791f7153636df0ec22b03155f1261a1387d5c2f7c1dfe73fd98029c00d2090175e97b6a866	82e10f0420163cc243a95b5e669cb2e4f0fb262827f6862462e69878a8f06b77f22bbd66f59ca01d	f	2017-08-17 08:25:34
8d10e8ac9aa05c3c52d94658e200bf2c01631d15ed3ff813973f63b0646ee55779aae01acedf32d6	d64f44bd63234b54a9d14697a31113014362a0d092f2457216f51910b5526ab5f1a63db3a9176345	f	2017-08-17 10:25:39
904946546d09e6c2154a1e4d59e8471db81dc3f0976e1e289efc1c937aad872768a25d1633ffb7b0	59f51a6fa9f7ac07e0404af103e4dfc797c2182ffcb1dd254906dba050ed051a55cad50ba32e3099	f	2017-08-17 10:25:44
f108a0204365f500b5fd7ce3674a010310e71b3ac49d2551cd7508513042060d031c3a164b717884	2f80d3c50a81ebc0372b69d473a46113180d3926a5d91647735a604785ef9a504d6743bdd1f72b61	f	2017-08-17 10:32:04
4da821a7806659d5b55f7cf838649d6258b363792069cde1fe6ef9a2dbca5b038d954ada87374764	4f50e89f4ef8c85ae1ebbff8f7a4352ac9e722b70ef193f4d07b3aa1d511fcb0cfd625eb842e250f	f	2017-08-17 11:17:05
bb6d92a88a7ee05463ef2656d7ba33c15ae45fd8c6fdfa909a459ff389c0c539a4832a51cededf7d	533734d50c5e79537e89167667d8e4f194a7791e25656da8a76b5cb5d9029c77b2ebe86f4696e86c	f	2017-08-17 11:34:58
6198ab05e0c46d7d520204a8d1dd9d61a4b3e39b676942c9c843bcb17931111be460e2380e32f2cc	3a13bfd147f039049c3bb89d5ab5988fe6091fbe4df8b6cd1de708a546a9fdfd747c4b4910fddcbe	f	2017-08-17 12:03:21
2aefa468d8e8b221703290cf8dcb08ffc74cb6daed9b57d4e70dfd5580de471c026850a823a213df	54686bc7f5b9a179933247f4a6933f009b6f3589c5ec545dffd0dc6c8e9d296e9ff39b4c0bd9bd90	f	2017-08-17 12:21:23
e09b152e50f1c6c3a7ef6eb119c6a26051654c9a49bfbcf1b389ac00bf9d347f4b171b9aa2d3bf15	1f684d4db4e47600a68cf7ccbaf20b95c7dcebc50cd51d9b80b247e6085cbea75dce120d815b2e17	f	2017-08-17 12:48:08
f2e2c021873e268176addf3a511f4bf4c2788433584d3c306a918287e1980c77b22f519c48a95ffd	62e4adbd239830473b889a141520245fc46f6f0b3ef76c41c022ddce916150afd914c7d3d9b72659	f	2017-08-18 07:35:38
131cc02b04534d179176fbb7a553089d2e19c6e9a1143fb83607530837318f8fa3df445fba882565	516b36021034b6135d4698a0b6f21121a3baa4c63554e4063e3a2083f756c1f154b79aa600696910	f	2017-08-18 09:33:59
b3331e8b4783198efd3f3f7534cb7a93b704dc62e86a3aba21663b8a68fc9d2f5eaaa2f394ddb879	a8859910397a030fda735d06040936d478beef571d99b260252caa5f543750d4ed46c91d359262ad	f	2017-08-18 09:52:51
bdb8242b6fdb17701e061391d730a0c154a2007a26b710bb598428fdd5fa30d9510533bb8d872726	513893f6e995fe3093bad29590cc673e7f71e5ebfe1149372e17e3e212270fd42cdad4a454f0a5ea	f	2017-08-18 10:27:54
d4c929b7310540bd66d368095398996d658a1a3c3b30db1f35c58f759b4cb5540bfa8a4e6bc235ca	df481897de415c9899c68da1056b735f7f2a2c547294c2ed222894a38584d89f0e0ea61fac2a8622	f	2017-08-18 10:29:10
1f6ca150b6973fab351023777102b5b9874f2842b8fc554994721d766e936a3b5d0b63151e4b1c84	4eef584f4bcf1bca04080f4584a7547eefa1d0557a57a3e40dac14a1713fef9214923beefc1c1bf3	f	2017-08-18 10:41:55
919c30159eb8b421cb2f417b2df9aa44b4db67cb5860f9f427e5d6b73201d3d7701039c37625c693	f986ff080549394c123a6368d5475362338a48e710993fa8db862ba03a1144c1d551a04599117546	f	2017-08-18 15:22:15
ab97f6eca08885a7b5672f50c4ad73f0b95e546998966e27af7aa002bded48422a6f6097f611a5f8	875bea88d1fdc80bffd18a9f51aebde1d6fd78cea7c97252e91b4a4ff221fc2754c740096d5d5622	f	2017-08-19 06:43:35
fa6e9a29e9d0e1f8d53843bfb3688c80e561dd9c2cef821ff0b91012a4f7fefaabb64f3bc8650578	9e65b24cb9ba74d67811f4a0d63fd2e8e45d955f69949cc3b3b932829052eb1616268667695564a5	f	2017-08-19 07:54:28
37a0148eea76b977bb72c771123de6a244eb009a334b7baaf71b9e4e2372049deb876efa1dbe3fc2	f6a3736402c1057c1a123c661887f768c774b926a8c2e083ce5c6d70d006a340becca755215cc726	f	2017-08-19 11:25:42
601bd8285c4a44bcb5e802e3cc3cda314b3050bbd040641add3ea25fce8e51d6f5ab39d024119658	8f14f8457885e24bc67db89eddbe3d9915b4e92eb33ac7b0835f2687f44763b092289995935da3e1	f	2017-08-19 13:07:42
fd621e52971dba0cfc2b580f0b99b1fb89f7fc497107aa80a25a74856fbbe5bfb35b81ebd030d468	32d9081b6182eb37f2dcffd88f8b8903b82e1264bb0110ca884b222afdfa2413f29019e5f176bd09	f	2017-08-19 14:28:28
80ecfc2eaba1bebb599f1dd5a25775a707705b834cc9599bdf0b06add2f6a0f6b620a27a8043eaec	90a3159b93929635964cebc3b7f4d62272c0227152a69434f75b8331fc08cdb26586befa5470661c	f	2017-08-19 15:16:35
247e2651c9f79623a528615d95443e598d3d9c00e138d794aa40a2180cc59ab401db1bb0de3a897e	6dfe942ce5828a20f11dc1969fdb40b6035fbc8b2455af29142931c5cc9628355e5a3ec2baa71f20	f	2017-08-19 15:19:06
ad05edb355395e9f8a9a98e7dcda67b0d9d25afdbeea1752614f213a1e5def86933df6d5469cba7e	049db096eccfeeb42c391460ff9bd2d89b98370b5cbe9bdb3fed6457879c7b1697782821a14c5a17	f	2017-08-19 18:23:13
5dbd99c2442207453a7ca815b1ea2fa74269ab911bbb8d0fc1dfd6ff0620b8c8cbdb349465dc34ff	76294de5aad40bb7a8136a49f4db70d9f7b3fff2ede12400e2151ee320f71c4a80af7eb28672fa07	f	2017-08-19 18:51:08
c0f89efdefc29fd60530e0107c2c47e4b2f670274d44d1e8d0ec7047faa42dd0a639958cbfa7d14b	4b4efb982acba789400ae78aec46bc8ce308c817ad617d8de4e0e9f9d4eec5bf853c2a559c358564	f	2017-08-19 18:52:45
fd0444ff32e1c2f34fb370f10ee19f434737a8edb32e578fc77883ac1e0818854c8780bb738eb94c	4517745aa93c94c6169f5caeed829113168d48ab3dcf68457f57df675f67842aba3286e2ed955a9b	f	2017-08-19 19:03:34
64f6d3544e8860ebbf5c023580c693f2996b060f90fa073aec3917c737b64395f620e80a92175855	879712545db2949c6559ba616688c158660617015686b82576db46d9c1d9bbbcf5ba266af5abb03a	f	2017-08-19 20:35:34
a89051b53c29e0c9993c88061fe9e2797de70fb5ae8f23da20f6ee1f8caaed8d6a6342efee1a5249	95069abf4601c8f24218a6915cf7023c478d855a8a84733e994b69f5e5ba56ab5cc4bb530308a85c	f	2017-08-19 20:40:14
0b0aae56895e3901bb5dd9e19f3fef0f54c7b0146692b2886894c855de1c7b5116b5af76baa495d9	740d973816539d30f7a4c2ffa99668dc9c41fe70f82d8b28276e78b911fda0708e5878c23b190ffa	f	2017-08-19 21:22:43
1cfc0dba0866ab995a788d60519d833f4ebe9975cb71c3952637f18170f195c6d9d2f882ec9691ba	ae7d7634cbb0de99646f5bd3d1db4b969dc751e81cda690ab5dc5a688c3089a5de62d17671f3c97d	f	2017-08-19 21:38:33
a86e14b3c046e758d621b8a6f83530a26987069222f2089f2a6f09bdd8582f94af71a27568858a86	99fd53aae251a1966e0c36f5e37f2b1aef1781afce352058562efe4eba3a63b02458eb374dbbb7fd	f	2017-08-19 21:38:58
809c889126303fc54efafacfe8e6f7d35ced86305cb9c071510ddaa423a1f67a77b6b54f54eb1c87	295d2913aa73ee60b8807851d0cb5eb98e336946b6ba097c6bab09cf30a75239a816e6d9da20c908	f	2017-08-19 21:39:30
3f349db1fb5bd4db235e0257c84e107c0f3ae9cd0c5e69d08b1f68bc2157cbc48a5e03eb433ad683	b360b65886e1c62fbfde28669a618af83ba354f01e6e27d651ff957f37fd5b1c792b3fe60eb4446a	f	2017-08-20 15:18:05
ba8fda83de1d3a6a94fd120ceaa8ee8a6d8f2910f85e7327b02a5589712229dc72c136b3c0e3e1e5	021859fe8ef136476e3d50f5f6dbf52f9aa9d6014428a22cedb6767d2e042bbeb27d69d63e318e25	f	2017-08-20 15:19:31
8a5b5d83dfa9b5fba1bd43dfa75845e771ac75acbcd84e0901b47d3dedb3765a4907b076c52b2efd	cf70c0c03bf40fc3cefc4be03692eb1665c8ad562659d6e8156c38e74679421d7af0bcf106cc3a49	f	2017-08-20 15:20:04
a912e5dc1093eaf573d66a0f4a5d3e5a5194a08431bd8e9a9396eb4e53a331d92feb50f0cd697a55	a37e53a449297ad2bf2ee996abd2570f40c74bc971f4a3e1c96424e69462157155e91e5bce52942d	f	2017-08-20 15:20:34
916879b1bb3afa11bd6fc9bf42ff8ff1d4014c5f590ff94c773d74a4995a863598624ef9c6a740fa	597ae8bbd7ef7417e089241df7c2331a64bc8f9e556da8b51aa8162fe3316936d1cb994e2be44cc8	f	2017-08-20 15:21:23
0fd0f6b2802f2921ad757ed9bc02859457c6078ee17f9eb48fdb63e4317e3d6ebcd77d54c93b0d3d	7fa99ec13d151decfa180fcbed6f5add0e0ae8a383014adefeff0075a8eb0e17f1801fad758c0ef2	f	2017-08-20 15:21:55
16c6785fdec48ab2d68ba3b3f32bc03527b50fff22f5288c7321d9e5b8e67d92a777df236d0306a7	5aee6441f692ff85c59b700df8f9b5b61065fc909ce003d9cbf2c902633ec2fa193d425fe2e3c211	f	2017-08-20 15:22:59
db4a793198b57334708f02a193242182ca1ad7ba6c87a3f9bde4b148b0ffde76f0bb0a6a51e97bcd	d105a7cff4fa69abdf1462806a5998871accb0b8446d1f3c9e30a200c1d4f3283424ebd15b60d827	f	2017-08-20 20:35:02
7d2f8517a507afc7c930188ad3d9dc61f081d8a772211f8e8039cb8f2db03523960718f20e85e8dc	b77800117f0b03a1fff12e5fb87b131cca7c26da7ccc8a73754faada848ff7aae3a3732dcc13e40d	f	2017-08-20 20:50:02
2a1fec94cf2558b0d39252bcf02b64a1be2915fbb852cd10d9c093742da96a1e791a0a4bd7064576	5ae27e1aa3d967bd10ca87d6c94f0ae37b7c576befeb2ae659c86bbb809ea90fe1975f8bb0658062	f	2017-08-21 07:00:50
dc004a28989b51b965fe24d29b61ba7cd531a8e9e4361788de0e3ad6ce3ad1c4434004fe7613ff4e	ea59344edb3ae999b7c6e1cd1cea03e27b26fc0e63373d979ce75e748f2caf2f76f0e318d625dc14	f	2017-08-21 15:17:46
b85226bc1cd6f68ee9f0e183a65b8e6049a61922ba93e0329e889be0c5b5c3b441543b142efef9d2	c4e1be355caf80e8e6835045019c2674b1970f38e0a6be3dacfe49b6b7ba886d1f8b40ef10d55130	f	2017-08-22 20:57:28
4bf8e56793f7e7c354093d9641d31ac70cc08ab1028072ef7ee7921ca4f3eb77299ef146d8fc43c1	7987825114b653496e1c791fc606f989a97882695559e6ca35f93932291cd2e78601b12700de8744	f	2017-08-23 06:37:47
4c9e86b15ca035fd931addff51979037505ed7ec490c96743a8fa05e363fed2b20589a233dd256f9	6e1bff08a4a5411c9528964a79fe5243febca660d93f3edc6d6a9ccc38e4c8991517d4bde32fdfc3	f	2017-08-23 10:14:28
80b2e6c69f1ec7a489b10786321ffd0ca44a927b878ff335abe8b2a40f884d68897c5d9d18d1ed10	eaa0037cad179f0d68bc386db0ace0e6b0e494375c787be285c896fabcdfb085ff3788481454ba40	f	2017-08-23 12:10:16
ced76009a7ac87c341aee613822ea7a9ac1eb65aaa70a3dd1a4abe998518a3d7f5d33673ea4e5f6a	e00b440f2cc7a307b7970ebab0cc202fa46ab1a2cb23e4e083cef7967fcd44bc6a3d98e7110eab79	f	2017-08-23 14:18:40
1c5f54aa4f897c11a1e00bbc22808e74377a11dc55d3919d571affe9aeabb6d4a6f3327aeb25226d	b0aab4fa61b2b8fb35d39221ba71c66d54d02c5ddc54e76318b5d2a6781344e1d8d87257a1fd95ba	f	2017-08-23 14:19:03
6fa844943d60c9d4e012b34d2f268538816fd2565fd1bc00cfeee3247d5026b6eaac5b9ac568cd36	a7dc555db0472f468f36d68cd51e379b9126a53edfa18b97908def4f47db54d2f02992f5aa774e03	f	2017-08-23 17:40:19
b3882f3906189bd3bdefab8c0ba4a79a211ee8a32db614cde7ea39bb47026b858c183968acdd87e6	560a6371a70dc184dd7f0bf0c1c3d157e9c925c9238b108d494753f8b3630d87bb6533035c8573cd	f	2017-08-23 20:46:55
a73c80f7b782901a091830848ad5a99cf658cd3c2cf185e3a940054043233c118c9d9ade081d8964	47da7fcbdd2312c4cf65b0b52054814b4cf1ee2c0c755c0e1dbe6b1d097a47cac6314df8e4141800	f	2017-08-24 06:56:42
c23ceec0a133e9658cdb4dedb0b535576fb7514f2ea039fb98492683d489a308fcbb8fc69df2514d	421143a89f091daef031927e6101c12dbb6c74ea3ddbb3781c0f807c68dd2b5c3acb079250435702	f	2017-08-24 13:56:15
4b3ba06640bb909a8511cf4a74c9280703da73520dd1e0fadf4c0a7bde65fbc3df862796dd6dc9ec	9fe3b0c696752079160d138fac2bf000f2a1948be3a7c3b62c04b48bbb462a333d8334710d61bb56	f	2017-08-24 15:35:16
829ea743b78de7f8789276fc420151ebeb4ae75b08fdee218ee187dbf49763a4d3988e72c93aee25	eb4718abf758ab9395cd8f3b63f0178fe2e518786424d1c7a92b770c25bb5306c36fb36dbafd380b	f	2017-08-24 21:25:48
67ab408f732da6e8bfd87b6c55e459140c468fccc413d0bf3d2fd9063e8a1a3adabac27bd62419f2	6b2620900cb2c1d771e785f0c86983a50d848f5ccd1300309039a0bed1c6045ad3c157a8e9461cd7	f	2017-08-24 21:42:08
7b835d33ebbae9f2cbe0ac66fd6eff0187c5a1816acfb26bf7d9b8734456d2f95e34f11286a0c4d5	6dd36ad31df8ba3abd3484bf90b40492d512352d053df9400da150f777a3a425c43175ea559a074d	f	2017-08-25 01:35:44
5c3a3f711060658c5cfddbbedbd94cb191c8720375aa4018574aae0a8b89fc3a8287304f0716110b	9658fae0725cb67e43b5ccce86af81d5bc38704d5514f9b312d0213451f1bc5a451e6989ee07cf1e	f	2017-08-25 01:45:55
c87995bfef238dbbcad4c103ca87e266365ca6101687aeb8cbc880c55b764f4c8564ef7f84e1e426	db76c67d5630aa3d4e8d1224a4c8552fda6f0cb9f5883a1c9fc1303e4cff19904a2537e2f95446e3	f	2017-08-25 01:55:29
496b90d5497b30b469a56a237770fe024a62aa2523dc488e7b0509fe900624e66aa21f4184c68efb	eb9cb951139603cd75280f2706d5cfa8f0b04aeaedf8fdbb1e14871beb9a78c6e0650a7268fecbb9	f	2017-08-25 08:04:50
727bfd875f3e93c40c9c1e3028e6a58ffbe2b8c0289c2d7f1d6844360ce5b1bd2e8f106134c1d7f1	91db60006353621b93202afed0c38b6025c374906b34e3ea7a79c294050ead79b992c4f1a35ad88c	f	2017-08-25 08:20:41
2eadce35256e20241d386807050ea23298733229c501ab0888cde2a0e1eae1fd0307b19e0c05737d	0d462ffa30e0f198d24a0553b17eacb419bdd5f327319b20d5d0c945a7c0a6b948b5c5408f3bd0e7	f	2017-08-25 09:51:49
0e7943f09d67b5c64e4c5c5b0bc0dc8060eab020a810b73436e9487d6c802c1d040c8db22acfaef7	22039af1ab768ca582e900ad19b78e0ecc9f446c126720b15f9ffa082fde5e2b5e2c6cf27b9da392	f	2017-08-25 12:24:40
46649e8ff84eb24ee78c2a1a3fef1a477dfba7b08521d82c8aec2fb7c7bef4fd2b8dfa4f173b0420	4a3f50df12e9eb886780e9c22027efaf0006a257763195fb1a307026d99e0414a637b9fe9eb28d0c	f	2017-08-25 13:11:32
f0d8015131764109d54a6c293e7c22f9ba87f533d55eabf3bc6bd3b78bf0ca0f3245493d36fc84d1	f5f061c2236afd5067558e2d68f6dbb3a89f2e0e90b69ed67cfbc05c856aeb7e4c65aeebc774554f	f	2017-08-25 13:11:52
80c433565e72fb782f5d92128a5158301c0a7452c9d37ea58f1994b61f5d91f9bed0359860e9ee3e	c5fbd279f7a24084ec5b36a9ff6210e1841b9513d547e1429d8142a3687dc982bb4b68442fdcfd8a	f	2017-08-25 13:12:26
3699e1a8520c93f48a3f1d1e266335a46183626a5f3f4870df52efd6daacd43d3e404eb2076fd355	01f1fc2c3319b6bd6168638eb4729ba561997a5256d4f1c48e3365ded36c12db0c163ada23f019f6	f	2017-08-25 13:12:59
501ebfbb5d7e7a97fbbaa62bf09c7c82a04ddd6f65b8397a60e544d10eaac5645fc4ffea15c5e0f6	8e93c726bb6412794cb25d87e698f1988f33bd303333d374dc19e4bc927add4e3a15285d32e9ed49	f	2017-08-25 13:13:12
3792a304e126cf59b9f203a08b2c98c469b26afee59bb13050f4197d5d29ce09b03fc7e375d7a151	242d4bf0d1db8b91dbcce21333fe0b045100675d223203d3697143a00e80768c113210605c4ded1d	f	2017-08-25 14:28:25
40f70322825fd21180f32e7ca1b3327829eedfd681726db3510a19e2f23ef014a4f8fae2f6dd080e	ed3f0f3d385882c68d5ee11288964c76792d868dae9b269b8b0ac9b306e3abcd5d8c5c4080e8a10f	f	2017-08-25 14:30:17
e7f1381c6ec022fa9555ff936acd88a2da1d7e94f634468c772d76c028241613df50c9881e01f534	836f6eead946a7dd0f8497205bff5a7e7a91b65c2a5d8687ba6db671c0d4bfb0b93664a8d3ef476e	f	2017-08-25 15:40:53
1675beae67852b83620b38893d34ce36d4be4d979050c73863e721f7e3c783f8111e424318ecbedb	dc624b492d6a8201a23dc80b06976c4237cf17556b779c10cd7642aa003bfc009dbbb0c960354f46	f	2017-08-25 15:59:07
a409f90264da5a1a1c18dfecee07e9468ee336e669364d140661a1e6b3212579676392f4f22c3e14	a7463955febfbde3c88a8ff421e1f9dbc225ca368ca98b1d21a99cea8f43277ead1921a1feb9a31c	f	2017-08-25 19:50:33
db666f01e39b26c886b16aec752373389730c24c17fdc269504202c92e9430c8486d360aad0d4cb3	85557ba589f9fe0fa2fcff25a6424beba9c9b93924e9a21a237adca30e5750e8c46453a88f38d8c6	f	2017-08-25 19:54:27
8a75c29c06295999839ea94b54b2fcfb812eeee5ffd76f3368ef192e4f33ce1dda43539125978441	659a6b62326cffae19051e1a358c385f3e7e9602b5c79791e1d7ecd5d6b2bb8cd8284af9e2cf8ee9	f	2017-08-25 21:32:16
e12b2587391ed14a84af3a6ed188987587a429b9a377493231603735df9b8ac9d8117d1e920e05a4	fbfb41bde67f886e9797a2b70e1160b06101454aab313f0fd1757521396a7cd963bcc351004c115a	f	2017-08-25 21:32:33
1dda1254338af49a88239a8c3aeb78680f8bd6af6958ab2cff62313609babc0e32c62f91b854e121	36ccf684be7c7001994dcc766a9007f3ebbf07fc7f59712f192ba393b8a747d8f6ef385058c0336d	f	2017-08-25 21:32:51
6950b6bef9ac3307fc340c67129a66e60e9b1a32aba65dc152069386a9eadda58c37c9b29db70fde	e314abd12d1bf04e1c9f9390c456b874a448c3c6ce60541098d424c62f601de6e443812ed255b592	f	2017-08-25 21:33:09
d2571875e44431b0bd533e922b4da1310c2c4fb8f55cb339e01a22f76c5663fd6421ddb238f29742	0435b62fa24212919cbf712a226f7aaeb3f5d577964c5956f7732862c47d2d7aceeda940fcc4ed5e	f	2017-08-25 21:36:52
2427346e5b7628f848dbec1bcc59f3d86e290cc9774ef443ff8ca87228a671d0bfc20269a2e26dcd	c869559a9876b8e3e1895bec3c419cffa17deb0a06926e1681db4f45eece626ebab651d5b9d2488b	f	2017-08-25 23:41:54
210c65ba6e396f6c93e1aa36fec2f01d64215bec42a18d0d45c07b0cb56bb048d28772949d1726f9	9bee695e4bc802d081169824dc313d5d025b49ab1ef94d57da5076a0a4158050efa8b34fe61902e2	f	2017-08-26 06:32:45
0736f7948b2b6241fb158befa9549f4cf6edd101b7710e808c60ac801fcf326c5098e6907857a920	b3b2fc4005c69f70a210269ec417be856c68a6216520fb8e384f9df5a7d4815f6728724aa30e180b	f	2017-08-26 06:42:27
8ac898c3c66b5c362863cca97d988ebd68554b1039cf3e0e8bd46f8804e1ccd610a897537a1c6de8	a842929165c23062de2b48dbdd33d0b986fe4511c36a810962020c393562cd9612e797f7d5692632	f	2017-08-26 06:53:23
61b1b7ead97d7a08ce87bf73428f6a3846087c51fa418940ed84e347b4a96ba900f675bf9ce4ec55	7f4089b9c326f5a575748dd47fd5b5166a81ebd9aa33d84fa8c0872016f6aad4c1fa7a946088d1d0	f	2017-08-26 07:09:49
42e15adbe898921d538402ff55007d32980c7c343041dfaa4dee0b07e5e0989ed82fe76ca996772f	510e111e6c131cf26ebe3243c8cc99e3bc62a9eca6c448ab2d973f822cc167f4769e9ca49e041586	f	2017-08-26 07:20:27
2ef59988b4c58f90ddc18709e7038f6e51beafdaaa22ac97b7d0e087326d0d4e069833f3c91f83e6	1eabe621dfdd6f3a54649b862e8b09b81b91db5231966506f75bb1a5a4be5519d8a6cc063c7bc190	f	2017-08-26 07:41:31
44124ad0be229dc9203779c66ada2d5a77686be75dd5af01e069e6823776e88795a5bc01423e81b6	312a50ea88db9027d91cb30f4d373ae7107b26f37b9f4c67407e0614c1e23358326084c4dc7c2a0e	f	2017-08-26 07:47:18
9ca979c36fd52377c94c337c9bab82e4bd8ab403d77cbd651cb5e8f94dcaf0af533b2357e927aac3	8e3a8c8e7b25b97c8839c88a6aacd67d23587862c7b45bdee915730ca7468e0af87d65ade6e6a1ca	f	2017-08-26 07:52:31
4ebbf1ad921adf6423393c092493bfb9666fc8c483e0eae8ea193e26b91dcc9175d52ec1e50aee3b	9a3127d81d9e742fc94d81e7b78c751946ced68d3073bc52eee9fe71c022a91ed701e275bb2f25f8	f	2017-08-26 07:54:58
077f83226ae3631325fce221af807d215bbf8aaf8f72e1f59de18a6992fd1506b3662bd562f031ec	12e1acb2000beb4cbcad00cc4cf80cbbece9efec0de68a19ecc58e4dd02336c9adbf20e70f984a87	f	2017-08-26 08:17:18
40d7f9021fdfe54ebc3c350ab2b878e71b17e2b5121534c9455e2aaefcbe0625a55f372fdb1aff96	81515d3539082ee4de1172cbf97d12c5948267bbba557d4a6149a174765eb8af57b5b960051293ba	f	2017-08-26 08:20:58
8d97d4d03e26ab3f405845a6a8604fe8271835c160301a44dad10ccac497ebf2b1a067ec96cbf47f	c40abbd4bc9b7f6fdd088bb8cc9ae2c47ac1a721ac2f2836c94d8ee664431fe52781711efc0d9816	f	2017-08-26 09:44:16
fb6505012bff721f6bd6bf282e446c9caaeb89092b7332b6772f0bca9541ece684642560013bc72e	45a723a2f479e056782e9c11d1569782ad1339463cb69532361108e5ed088ad86576b90a4021766a	f	2017-08-26 13:08:57
6ce70fb2390d3fc3718d748f7a4af1d2859017d8f78a9815d40139e64f7ee0cb4ebf5bb0bbb952e8	7a2ba52bb3e6d97c3049cbe9b5073f7c3558216ac743d68b77c7ea46ff96a08c4787a945c5253557	f	2017-08-26 14:03:11
0e883b1063f05e66d120ca7c167b9e39c4483ba9237d1e162586f212a61d2d37ab7799d3bd7ba15d	1266d1969c34b3450ef8c1e440539220db157cc31b027413e33b295f133564d012a5b9dc3db58b6b	f	2017-08-26 15:32:46
0676eacc566d9641e15bebe288d95163ca05195ac9f151e68fa1207a75e50249d6ef1533d2c2a37a	e60e363f1c39ec90e532f32e8543c9da111492ed8e9a24e541852b6082a4c8dbbde4d332d4a813dc	f	2017-08-26 16:11:40
2ac038c8e9041c4415957983d80c3ba58b693eecc49290d55888f2e227902adf8a5f878bd0e30ff9	044d01df02ba0b329b6321d3ae35a59d66c03500111dfb77531f07ba2bbe083df04fc05410268ce5	f	2017-08-26 16:21:53
9909411105e9f67fae669ae9f4b0ce68aebdfe30486bc5fae1818491a7cda4883f0160796ba83fd7	6053e29d9716d6be03b065d3d4f266b2e43b52b883562f0aaa7b1e37b2f1477ee6ad6b68674f4a52	f	2017-08-26 16:32:35
4f8050e5beaaba31582c4bb9613837d96f4d996cbf0419f63be527bf7f67a1303b5f56d1a5e52217	ab37fbc92f13cfeeb6f55ce69fb031b09808a459188614941d5e3b105a89d7ecb7b10f62b05bc71f	f	2017-08-26 16:44:00
14a9c43289a7a244be772bac0e846e0314e8d06eec36ae46a35be77e5333cda30c645379be7aa52b	fee9b379022bbb1c3b0df791852500f4d52fb18dab9c20d4f0d85000e1c68417e59e05474f1c0a72	f	2017-08-26 16:45:36
04a15cd4a135fb1c3604dc8bf0f688c0190a55a3f78741a20b05fe8671510986a41dc8f1d1045fe6	2dd7df53eb65d56cfbfbbbb69b3a53094dc0746d47388fdfdfed808b883243f076742521efe1317e	f	2017-08-26 16:48:19
fbcd3925270b342c370ba0a9e99051ff887eaebddf27e1aee6d5411825aeeac14ac40168a3f8095e	5d16b68922424a963b34ccc5c50b390e6b9c20d5fa0c3787f928d85f37b9d0ffbca56ffcc35c3e0e	f	2017-08-27 07:00:55
4b2cd0f7a5ba6446e5eb3b745150bf2b336ee9caabca6afce78f9e51805035548a9bd856dd64e166	a39bd234d18aab5bb4d866077bcb02b0010ddc571dbb792cf5564f147b6c651186363e5761593c03	f	2017-08-27 07:41:19
30dd5feeb5747c06220dce4506075ee9b63b55287c411ec3a4f3add89849ea264cae73ffcf70f4f2	97310ce1ae9198c0845f294be9328db8c5b9bcd8172ce5ee62399d19ec0bdcbeef8cd2ff30264695	f	2017-08-27 09:49:06
73afcff1258268d534f61318df385f005a28fcff27c045bcd73717bcdcb2503cdb6188068ad285a6	1982f409f447876c2152537a27c8e5abd08e96422d1cba89e2bb80f385c5e1572f67005ee100e8fb	f	2017-08-27 10:24:30
a80de6e0739454553cefe76c62dc1f6b066aab00fb418815b6e8021b0ec37ccd01ef30ef2fd04cfd	b14c076346d18718c2fe59bca51090a1fd2a2e6068a7f1aa749586481987a094327873d7bb41db63	f	2017-08-27 11:03:11
c5fe8e02a0811e6b2141ea7f7c7635905fc27e69f3f3b2a5180b37446c030fa532788ad3c335c5c5	a13413da4e2eabd9b9d865689def31a80b26f3d5192276b2334fead9f0c3c816c856bbf342c34572	f	2017-08-27 12:25:18
33acfb9e5bd9af1de6db979672e3c7981f5c4155931f95d6861103a41b9f617ee3ebd4c5bbdf2d38	02164bc096a97e3478dd401c300212da72518e64dabe0714041e513ac3caf81f3f167c00b9701365	f	2017-08-27 12:31:42
abe6672f72c8539a2ef78a766c6a8e6d07e3dc5f4b0a361e3fe970df8e4b186721241fbd10504d26	749d8a48c59e010615305d443b50d8f305aad1350460df84775c3d156286debd3519c6f018f03e56	f	2017-08-27 12:33:24
49931af1b50e7c57234ed501a2587b6ec058e878fb43eab9244473ef55827c29c4e208cf85ad110c	0cd6a0fe991d99de1d040cc403e419bb1401059a65e6fdb8f5bef34261a23a9576d979f65018fe20	f	2017-08-27 16:43:30
1fb5b73ffa1eb14e05e7eb14627e0710ed445a38fafb8eb4b7c6b70ab9028e8db19f74f50d18cb0d	549ad9109411d2cf4222cf3ee8fb99f5e486a0212a506eca7adcc41c28ea7513725c6567010d69c8	f	2017-08-27 18:09:43
015aacc5d90b71536ef91da4f75f38ab37a973272a17d3d4a058041bc6cc7afc20a19892fbc02822	37b5e6ced2520d346dffc26b993ac1237269f8ac3d8442480b3d808ed7c4ea23f718dcea1075780d	f	2017-08-28 06:08:07
bbf072fc486de3583d146d4c752be29d372eb738b10e3f0f7e9d581b0969a64bb2485924939a8c52	38466759775d5c1e5f43baae33e07391ee52735889aff93587749adde6ee7fb22f11650400f36536	f	2017-08-28 06:22:59
1367a8e756450e4b116d70fc9ff8565d0a4c250e985cadb93612663623b0444a0daf1d0141dffb9e	3fc3e091b16243187f89eb6db7c8f77a0dc73778b9e78b4fd2667cc0107aaa05e879c57b990a8528	f	2017-08-28 06:37:56
f1d90ccc4378754dc0bf538fc8bfaded687770bf44d2b5de073fb1743b07b1f838b1c64a658e5bb5	89df59037c94d257b2e19de72bdde42381d343ae7b6acbb5126bc7c4d7e08eb3191f67c3a09dd467	f	2017-08-28 06:46:08
5148d89813726de4231ce1f9c4469a9a742b7495ebce397c7d7055b86fd275cab7466e8081b81702	00aaa027e5033a914ef86726a777e545c34e5f3a6ac3c01c1c93731dd3838e151eb99e6829ba20c9	f	2017-08-30 00:20:24
efdf7224d595f545ea91eba29d3862472b719b02d890eb35f21cbf27c24403fa6932df3ccdd923cb	53b0aeb7042114f849d94a704136319b03aec20a5a35b670061f4906404eba858ac0967361265caf	f	2017-08-30 06:33:19
7da0e83f9d1a1b39d6ab5b55ce7f77bd5d49cb56ee92b1c4e0e45ae212e3e3f9348f0d206bf5e17b	f248f734a93cecdfc8d76573bd9dc57db0700b5db5a58a1dcb1e4bfd190458f4757c9e3b0d3e5265	f	2017-08-30 16:57:38
d8f5899a9b64cc412dcced35f0e57c3baf1c08ba7e4a5500c48df6bdb38823cf4949820be5881a14	e80f00b24bd414f6ec6c854ed657c79f714a30eeb74967ae7ca6b4ab7b82c9efdcd4795fb2abe274	f	2017-08-30 17:12:01
47583fabb98fa7f8f695a21ba5fff95b2214c56b99165952abe9425fda5bd706be5952276b51b56e	6cb3978509962186c54cf6ac4f36cb78bbc1289fb07c07b401e58ccbbd2b94b7405b0ff06cf09e83	f	2017-08-30 18:11:37
d15e1c5a455aa9a0e19fb2c32f702766acce5b833988a5ecd78b6049ab65c6c49a64e65908527c84	1ea4bfc5cd1f844f99981a79d25b000f40dd81308f6741929cb62d4eee0295d878339e396a00051e	f	2017-08-30 18:12:28
e0a78655d32c0dad6bb2927a2dc11c12c328970b464115344900b82bc72b9c344aebe0c8640fb89f	003ea5d7c1f0c97d2200103caa93360b482ade363c9f517c177a177258133f8ea4c2f161dbf349a1	f	2017-08-30 19:24:40
6a9dbf7a94a6047eb2059b694ef34bdc654b255bf448fb57fd51d5fe9848620e463678267f4e900c	887cf1607199a80bfdd7c85c074cae60cf048d2b8bae55b50e03631b53a5b8147f01fb42b673e90a	f	2017-08-30 19:25:14
2a938fd21e54d84511d982b4d9a82def22e9d0e387d3418d52d9ae9fdbed3f723caab1ab1c141ce3	17946d71540945116c9bf15c7c61f53631c1376aaabb9dda8177549c03b7e41c16ce4088ab8a205c	f	2017-08-30 19:30:14
13292f2971ca87462768ab78ca3b278f81bc4cfcca2daa7061822cfcbeb666c00ca3ebc3c10a1be9	0a25905ac43da5bab89e78331433876c9846360d5ddac09ba94129be69d4fea00cc1f6d7a46aefd6	f	2017-08-31 06:54:31
e23b6738b888ce348165fbcf975f5b2e718f215cd1f5bd45d22058ccd18dc024ccedcca59e45cddd	d854cc37eb930194d50ef8ee025023bcdf6085014f99e5fb989839d68227fc0d7923f856bb264b1a	f	2017-08-31 09:28:33
073476c4376d6b2182e294abf022f587471b56c5c240d8980ac5301764c2f0e8fa1e1e7a4d0a5434	1851c8db28c97e0d21a3739d6dd9050f1658cd0e60911dfb0305f2ba52e824f50cc4beedc7cd9395	f	2017-08-31 16:30:03
4f8af99bb96da141f22d7035f70d3ccf833694ed77744db805ff27f2016749c54b82a51326536f4e	e7b76e6350801f14097422316d9bf87c19995a62f13c1ac1b9a70fbb7f9617a5e62b4c93a45464ef	f	2017-08-31 17:09:38
0c12f853a1c70ede75dff166537152838ca3af5ef69b689076f49b887918d4861571d864c92934a6	31675fb85f1a4d8735fa8f3ac8399d8a9c36165ab4b082058065b483d100c270a8aeff6754b9aae6	f	2017-08-31 18:09:50
0cbc45e0f636ed02cd26a3a30ec670cc5bd4ea1d777a47675af2e6f86f77e36a261d1883f44d6da7	6f549c3f638ad73f8dc5f75da934a44d5b0d1de212d850204abdf32d5f1004b794fa95df608c4578	f	2017-08-31 22:00:39
c4de4112c31e3f90192df52a74accb347a240a59ffca07774c35d3a84767a46ce3fba8053e245481	a6b50e8ef39bee4165b8abac877f6be5f0dbfa6811405b6f39a6756dba0dda9eba537515103116ac	f	2017-08-31 22:20:24
73193860dee1febb9f96065b6388901076ac031dc0c0721f7eb959cef307bf812e44936257480b13	5758cb30245d0ac2857f7edcce75f83af9d4206c149ac87cde9420aa36dc60d85222eb98d5265de6	f	2017-08-31 22:21:29
eda7071c4c1b6addd8ac0023cd2c36d63d273abebc6cbcef5df2a09fcf73cb1d93d7b440bae6fce9	cf0f799ca6e824b257dd3fe9ddc01a1a5540aeec763d7710f0a9d5d308c03b1f9050dcd5f1fcf530	f	2017-09-02 08:36:34
ad6f4d9cca831b2f999ea3dd483a7348448f7d377a057fb2897299149d78a19103f8fabd52574b8b	0176cbc846f60a93e7d1126c009258114c9cbc2be2afb586b460cd796b685930c215515449af49f7	f	2017-09-02 09:54:16
111987fd933d6097a6ec02a94808735a99808302a4d325cf81c688e5a1cbe99478b69d16b3b27725	3f36121ea632fd973536f1f5191bd1f40261af8d3e31ae7f2932c990e9e1a2e97e3c4cc3ad565765	f	2017-09-02 11:05:59
a293b807d4062d3c0b08a7967f1e66973798ee64b9fae56e9cb0c42a967aca65239216a4884cad5e	61e5ca716b9e75e30647a8db87f2a006582f5cb021f1daef8cc27dbe37cc83f05984251e71dbc977	f	2017-09-02 11:08:12
e5a060980b585f472f6ffadad0342199ea219d41604c5f58e4f72caacbb3873c06a38365ff0de9f1	76115d1ae82006138eff8dc6af15f265cc5ff9fca3784a8cdd12be68b942f630dda4ce7d0064e359	f	2017-09-02 14:02:56
9c4839d68920c860fb3353b6f3a8b7e520d1644f1e9c45969722f1e42b79f678ee463c6be12c6015	395828d8733b30b27af5b5c71d7186df8eaca242f33424c1fc4abf3344af9f6a100bda870f605acd	f	2017-09-02 14:21:05
8f475986088c8b7eae2ba8523561ca4577d83d31b89a3cb118aab8ab909e991830a881659d1f06c4	cf9a136f6d54dd7b15dc90ae253753c062b09c695a9e1d531665f967df9655c1571c41b9d878da87	f	2017-09-03 10:29:50
fe19670cf94fa522cbbd3b5fd028fb00311c93644af8c1c218eecf48de39a45ab618d1c6c9087fb9	024f038a6c42b6ff826993f0157824b9a560198ce5e6a909a8d3756a84fd1b23b7b85841746c5d84	f	2017-09-03 13:55:04
ad9a446864e11f0f4f57af0818dc16a597904001d504b953e8512ca3785afdcdaaa2486ab1c01962	f1fb33d0b945362bc656f08e9f4d7a69b65e04db9f3ddfc4f4c90348e1b673b8b0222c8fb7b982ff	f	2017-09-03 13:57:47
e7fb1b76a2730a9ed5a2fe118de20b41da73f2bab723b30d269f6716c839b0d199db0b57f0a06406	0a4e4bf7efd1c11bdb4d59dd4296c9417f9fb131a004860093efebdcb1fd5ee0c4ef8dd71ff2b68c	f	2017-09-03 14:00:12
f811bec7f18e05b162437096438f2255a367a2fadff8b33eeecf50a4007411281990dc1eacf59e18	92ddbc21a4d26b79195dd76b06fa9000fd190b4f179c45bc61f83a4861e11de8dc21316060a9bc7c	f	2017-09-04 07:19:24
ad202b66ec58f4f20dc88fb4ac44bae6bb2b88e1e14de7aca7a4f6ca714456800d52bc9c376b4ad6	07c122173cbe4c512cbac482152d762f959ed09108a46de517a124ac8e1ccf8cd87fb5ede6aef8c0	f	2017-09-06 13:14:39
0501f42932de885b5510d0bbdb241eb35abcd3534a4246997eabe0d63126586b436e49f4e30f1c70	971f51692a89c55d03a77d2a0dde1d6ad0f5127a5c0adf697eb93adafac617025cbbf6ebf45cad69	f	2017-09-06 13:15:06
92e3374bcd02d5cdedd70ac9b4600f80d4f23c3a57dfe9c9b05056fb948a49e75a6a06a4773b4518	a5c377307f5255e540235339a9168a9a8f806adb3977d8cf5e48c8fdfaf5c80f923101bba839ee50	f	2017-09-06 13:23:09
07ac5460a5e68fd285ed5f63810e2e928d3c040cf329c0b71535a2b8fcdf8dd9e305210d1863e130	f88fc68381d3a8e4b5bb1ab446179e7a295c69696fb607204b05c653c6e9535ce272c3b374c7b325	f	2017-09-07 18:53:10
93543b72268984cb8629f8da70238e340d77dc91ef0287de9debe84b8415b4f0785ffec12830f65c	86c59b04852f2bc418e257e1874beae5ddce893764f4cbfe3f62c1f85832244d64f68c5685b6bf85	f	2017-09-07 19:01:00
a97e3898ad6b8567039eda1e60bc8990f052ceea29ad2a198902ed9a7134dbc13eadf2d4c7972a4e	adb65b0ea48d0cae7abbd68bf24249b483407bf94f133a60fc86b363ffa6777831996ec75ff7087b	f	2017-09-07 19:01:57
c52008ecf6fe04976fcea53205fc401520764bab2dc9e48ea4c2654131cbbc095b3a2723689d8ff4	0c8f7a898f0b4f9e2797f2f84a91f1489246073f0cf728686f441db8390b37f883158d3e11546715	f	2017-09-08 12:14:17
29d7392e1519bc220d2eeb9350192d0179a3f9901ad93469c51b4a72887b912b1161c332be776d9b	3ee5e815d1f78b3d8859a18f0293dd6ada56d7b84611f1dffe9c81f1fe8ce2693d05cf42d9c2ce73	f	2017-09-08 14:10:19
04c18fafe0229f50431e0f063382a350f171eefc7bd3e2de054935e5d1f8acc73bc5261d2d754366	433d6de1dd054625a3783fb0ecf1e92a8f998fa0361787089e5ad23908137732f03837b8855cf7a9	f	2017-09-08 14:28:20
09deec666ee84efa5cf7027308471f4bc46f27647f91a28a4ade94a7720b46fec129b74f273f7f9c	4ea00bc6977f4a89e960fb3e72ca2d8fa31c195a8a78963578489d4b205d9488cf3875d1d0be1d37	f	2017-09-08 15:18:27
b76791923fbc287b2d3d667485f76941e49e678aa9f6a876d2cb9defbf046166f66ccc1b77965b98	377254ba3f6b70d660b04b398096555e037ca2e777c4707ead4cac3f36ccba5a8ed828d151439876	f	2017-09-08 15:20:02
a5607ef0f193ae896da1944433988ce706654447abd3f734cbd39a50842b617588d24f44746216d8	913064bf159ce2e3cd3eca730c4643c949e3fd155587b9fa09b21c09c11ad11ad936b8fc7b57f299	f	2017-09-08 15:20:19
fd543f14e89a69d760db320c3745f7d2d59bc59993b3468f4a1c9946d2990d4860db7f8da92eda7b	d9558206b8bb190f99dfde05dbe223fcc1c59fc7d7f3d669a662b48f9b994c7d9850df3839a47aa1	f	2017-09-08 15:25:27
35bcf13e1691115eec1f3d83512649623118ba47b8e837f22deb7eb03ceb69b0983f0f326765e433	3ac2cf914f25b148b8d62f080bdf75f58841e2f207f6491ffd2cd98eac931d9b3b7c3b145bc404f9	f	2017-09-08 15:26:03
9a65b5ce061d6518e97fa5fd96e74d19c7316708a0410677beecad25c8188b2383e21b4cd7b0469d	5bca9d4472dcdfbb01ce8a0e116e5cb5af22195a0edf4da270b0c63dcc90e87c1a50712250398b18	f	2017-09-08 15:26:39
ac070e47ce105630a30d08bb3d6e17a96f28b1337dde03ce6b7be321814e6f8afd82fa732b4356af	d1f61c17edfc234334415fd048c0da60e9d91d23bd4d2c5d5c1e72816ea96632b87868c88815f807	f	2017-09-08 15:27:08
c8da1a1150cd92eab7812f1925d0411c8c3cf7da7461d077603c1e6b22c9539a9b2a9100c0f438db	0c1fcd355576561905c1f4cd5f0330b9bd147ee3325b351c7c735eb9802eb3d61b0a91f81af48c56	f	2017-09-08 15:27:52
d7b76350bafc7e7fa4a0a5c235e0ddb30946ed3ea1fbc73773f93567a8e2b0290bc3955dbcbe7149	d2965da26543cfb09be65d5a0e01ed81922125ef63c9daa31cafd67c58fff5ae187e77a8c10be699	f	2017-09-08 15:28:51
de7c3a7f8a1c5e8f972ac49acd64d97e1c8d94a6a4c73c2c2df1f1e4a2ffa4846a2988f6adbf7c07	bb6f71f618e18210f49eb6e451635e524a0a0d0a962c89140016999bdb490059ca08e9d19bd45c28	f	2017-09-08 15:29:52
c6f4eab6393e4e7a6937ff9527514ecabe1aa50a2e06f505ac75b6fa2a6c3efbfc0fdf8eba42dde7	374c0f37b449229a39ac60dfd81be4594725efc98d6712e6fff61f4414e78c0dc303834c48951a92	f	2017-09-08 15:31:49
a7f87826ab0f323ece5a039192c119cb8cc9f2478905fcd2c29acf6780d8bf1d8f38edbfb33c0dc2	94eb573917be2521c86b2de4d8f5468b7df800ae5554354f1c7dd293c51c4afe767d7dc3d19eb167	f	2017-09-08 15:32:33
bff80811f49313753b56d92db821a5a7bd9030e998b5a8b79c5894b36a04286b9e69d32c76c53ab2	34d5a2c00880770703b4b5ca598d5e9d892ccc9e9287d193c075659f64d81600db775488c3eeab75	f	2017-09-08 16:50:38
cd3450e5496efe20e4981cf731bfbed8da4f237ac593f7cdddd5a5fc6994c96a2f672ff1daee0211	08a54a4fe134416c32c2846e042dc54e7db57573efbc9ab5c3a598753bd59ba2182c0c17c243227c	f	2017-09-09 06:47:28
ead6f954d2beaed383014f56cdf29cc0702d3b8ba9f427821c11b7dfa5af3bd4aa29e1edbe0161f8	a5b6b16a16f6f5cabf0014891099938da6c7af15bba494aced3d1d25217ecec1b036b49e759c7760	f	2017-09-09 07:06:37
7d880fd84b5ca048c0b8e7afb0f7c64988bea45478794fca6bc131adeadc5841730e46b13e1e9794	8fdb2586e4ec45ce1ccf14aa1f2476e9e2fede34ebce3a3284f82dcaa7d043151e5413a7a0fc2b97	f	2017-09-09 13:33:56
eb1675a4713997ccae373b8375365ecdbea5d6fde1d5341fd734382a7ac0fdfbe0232620a2c0948d	10ae82d3610dd0006f4d768a0d83fb658a820622ab3f0e7ebecf9166b19b806522013d982b8bbf68	f	2017-09-10 06:45:59
4875e6e125477f360291a7e61653dbc1bbfbbcb9ca08b0aa1089ad0465c3627dc37a2800c92ccf0a	380ed91dcb45594b8a6af2f66b66927e377b9595735279bb0492d2050374719634d214b136d15bf0	f	2017-09-10 14:23:42
a0f8449c3ef29bd1752d5aaab74ce6e54adf19e3096edf8353a704a867506251073e9d5100504064	e01631dd79916f5cb11cd396b3f1c3a44acf0ae97a7ab60601cfff8972c9c7492dcd97208bcf5753	f	2017-09-10 14:24:09
72120eaeef74f0b65bb5df21353197f0336db3324fcf8cca7c6feb40c3700d3f179147a2b94b0124	7b8301abba3eeb42947aea30cdec02746cc104a04b6094b7dbea76bc82f4fcf3c8d5fe3b36cb2969	f	2017-09-10 14:24:14
75468a8f0e3dc5c8117312e4300ccebb673b4f410d57bd8824e18f5caf2e15650154476ca62fa193	a9fbeb77ccc0392b5b13b00cb24da10c3ae24ddf64b8ed45b5fc5359d12c8ac610789c5f3e334222	f	2017-09-10 14:24:54
94ce6f735bf28aa763cc47e7202d5ee04ed4d75756a43c23f43d6a84bbdeaff3bb9aaea0b087c1f4	7d8706af961c8a7e928d8aae0e1e4fded91b2f787537b847261eadc3c3943bc0294379b0dafb698e	f	2017-09-10 14:25:10
e9404c81bdb2cd3e8e52fe2761673f1cab3d5894e96bcb8d2a7b40202b75d5b2a494e808d2331087	0e3f5ac812ba5a6660a362c6e6a4ed6a298d83a3fb1a6d27cf75c5452906807a9764561e37ce4e31	f	2017-09-10 15:13:35
207da9101590ae4df5dbaaa70330134cdced64927355b9c6c01e87c1ede25d4a78b3141f14ac9fdf	c7795325310b4d4ac9db127b6712b27313fa32b3879f654fed31663ac3e40d68272a52c80c448614	f	2017-09-10 15:14:52
a7f4dc4378cef2fe9a17aab3594064a50b6e366f70d439cbdb61360b178032939bda70000f1921a5	2a818e041b0a0a925b69f408cdbd12f3a5806f015e75cf15e7ac5a762cf75eaa1333e7b9040adf20	f	2017-09-10 15:17:03
6dd797d34f08053b8bfc2df715bf2ea6a8e5cb5dc5189b83311f1c6109c9cbc26ebe88de1c4a550d	1236101f4f0e37b28654bc3a17576ca20cebff3fd683d3b59f8eb6485a3462ea8b24b0d6cc7edaa3	f	2017-09-10 15:19:19
df18959769a2ffb977d189146e1ab7d1b98078ce617cfaeac37ac2cfb70911da4b0a2423f81c0187	c52eb69a6b78a1afd328e2bdea96fcd304ba89d9bae7caa037bce38cce8576cdc018bffa92cffb22	f	2017-09-10 15:20:19
3236aa3ce6e3a5aafb19789f2c5b98bd998eefba86b9663044f1dfb559121fc8ea92bf4d4874d7f7	3a756b977dd4510a696d574b7b2f32bc0098d01d42700786b5b07c7336a40f70ad7274e88a832a6e	f	2017-09-10 15:21:11
a327a76da3c37039360576eac340bbcee15bfdf2405f8cf9da6af530d0e4584a267ea5873c8cfb0f	0ad5b84c745d908a69d004ecd684e33b33a89e8540b9dba9ada620564a5941a90f877c0e6426d24c	f	2017-09-10 15:22:58
5eb6ef9dd3d17dcd46f7600ea2e9b912074e833eb8628f9771915cce8bfbaa44d33cb50b42904635	bfecaef8f52d212ef254242b2174b473f25dcc6226dcf79d5a0584b4363f89a37d827aa066121ffc	f	2017-09-10 15:36:08
ccbf7aeba68140a410c50e12b6b0feb0a0a2396b5510376371018f83bedc33fcf5724598da141858	d7568d4366a52f871c2488d0632906209a59b798d29ffbe21bf728f621c8ef537b1e4080f5a6503a	f	2017-09-10 15:36:46
a6b4809714939236d0ea25f3dfe2a4b2b4c75c9404ceff12dffafadaed5045eed844df21ada433ac	6a248bbb8a3ffb32515d9de16166bac9fdc744d81322668c748b967b2c28288b3d7dc7b07b9bba7b	f	2017-09-10 15:38:35
162593074f920b90151182051da0c4d6abde792e3f6beb0588248ac59a37981f51e5e2adad80086a	3d86c61d2b7aba491b59be4977c29edcfb5bd5af98046ffc86aff666688d79a40687342d76db2136	f	2017-09-10 15:40:42
f62ec8ad05bcb1e8e222321f08f8938a5f988e4f14d39edd1288277233a85c05c7eb0a1dd120e8a0	ec88178229121305b27792ef9dc4f719e55df0629d2c191bb6c84a421d5681fc31388de4d220bfb0	f	2017-09-10 15:46:47
032ec7547db541533d84a8e06741f52a966a3dbde55befd09cbee360d2a807c982852116987d5229	2c9245516a3927d1e1c46ba24d2124e6c68c778022bb29be0b5ae8d2c12d5bada407f75da6f27155	f	2017-09-10 15:50:20
4d75e463ea428964362df83a0dd7279056af2685df52e7d1699de9e744837f5db768d805aa5fb8d3	0f7d0cbddec84ba1b677dfdb6f0d900e099472d828c174fe07afcbd1720351bb2e08f35bf085ce6b	f	2017-09-10 15:52:21
fbfc0c8c139d19fe1799c6a7026a7641c8c2dbbfa3284094e25c67fd4df82cd9c22cf8fcd673ff79	f2d50d3a7c204cb3796deaee74cf844ecc8038ca9f237b2292570aac82cea9c5063802abefa183d7	f	2017-09-10 15:57:02
f5c91c9f1be8cf73ee46c032561bc1d10d14705e240da2f885dd5368475c1f58f683283d413b1eb6	b1ccdadf0a57197e71e2c2dcb96eb689b22014344e006424297e342fd810126188230f6ea984c16e	f	2017-09-10 21:22:07
f81f17f9f95a0f47cb623cf88a1411ac71d3d09d268969f86e77452ff24263174e61d08ef4be7fc6	8efcfcfa59d2358330434203d62a7456e962dfdf96f6a84568cef15bb4f4f3b7e1e9d69e8eea0e2a	f	2017-09-10 21:24:00
02631811987d46ba3af9d635c7b3208a76880c1458a6553682d4894092da8a936da9c42fd953bb19	dcb1335f12d9bc149ea650f27180cc8553166309aa5dcaed83add9d5c246ac63d3ff3ef104b47eb6	f	2017-09-10 21:27:15
d485a4010c8dc033b191590628173453a1f35ba1e88b732a8134aa3ce50d3d3fd48a0e48118ecccb	8dbb1aa9576160302e2116000084be44c4b809a52d50814d62fea4f75a64e9f401db2c6e8fc6d4f7	f	2017-09-15 11:54:55
1ce90b889fd40113a7be4132e3de21c8eb2abf24384c97cae1eff9e0b417acae5ce396975318495f	db0a5c88894652caecec769664ceea49a0d2154775e1677dc4454cc88275ea02587ce85940bcf32f	f	2017-09-15 15:39:02
9f7909b245ae9432dfb529c3534b26aebbc86a2b8f43e849f4e78b12aa1b9ec8f825355d24ca4bb2	bdbfdea3c223e911b852eec4124b7afd73cf8e1d366ca40b29e1a524787009c909d769045927cf6e	f	2017-09-15 15:39:19
be70c166a1d40e4bc5e6c9d0a2d2be346246474562c1535a8d654ba64cc11c3a3eb231aa5914b05f	18bc6373811f23123f5f13fa5761fc29ece3279c284791f3a495d2e5d1073aefb871b7fc8231773b	f	2017-09-15 15:42:12
09edda8e46245683934285fb10afde2d06d9f2981662c4de5e18be31a82086b75fe77cde3d5f72b3	297ebfd6f7cfaaef7ea81a7ee355110e924199908b3e6dcc7fe7e902676dd94cd32a940090104bdb	f	2017-09-15 16:32:00
b94d00568ff4738cd86ecf0539dd7a0a6b44cc1bf9107e16121a4186e4a506392f272f993dfe0ff6	983f8c78652b9f2226a36a361d8c88edfb98fdd82f04ad7940a799ae90eb90508c5b3dcbe03ac883	f	2017-09-16 06:42:39
5c7d3b84dd7ac2b4fbac85be11384e3f4691b3976460c0d189e6c5e2bbb2e327d93d3031a00395d2	c9433a79dc0fab0f657699b5c459fe06938fe661ff7deaa9313b72689525e402cc078848093f06a6	f	2017-09-16 06:59:58
48bb85086ba73757375982dd8514f3c920288c69f747b0e5d7adf7834c4b7b56a3911b5b35ae6f20	f4091a9e00e2f45a84cada0cbbdf24b9f9d6686515ba868238a5a6aad4aec08175c4329d7276770e	f	2017-09-16 07:01:35
76f5076361498b8f5c1cac5d1392ef55738e9678a4fd8a7f98e472ad543ce2179a01f9ad25db2491	d3fe0c6e021bc3ae301263895e158195d83b871f200af9cf11c028d147f306e5a56e0d7596abfd6d	f	2017-09-16 07:04:07
3d0281ee8788728a25e7cb2e7fa6705a1fc7c97cc21de3edda42d19583b28c581f665b677d7bd61d	53d9a652e3353ecc8b8d922b42c9746755f4816fb8e8c38e078b6684f16902138a4b611c534edb31	f	2017-09-16 07:13:20
be8715002b28e810433c56500ab0799be7c676f07a72e1dfd03199a235b7b04d26ba076f2ff7e006	ca146af47969553753195dc92161111bc0529adb51e1771f4eb0b54f7882f4edabc968708c0c569c	f	2017-09-16 07:29:32
99eda098b968f1c1dc128b90b75b3cee66730b577428e59df8ed7dfceef58f85c5d8194e6f759962	c0352b8f7360cae02635c647913cebef47c38b73527a8e5d4c68e00406ad021bf1a71eed0ace5b8a	f	2017-09-16 11:04:23
96801663c57587227387364af15ae03ead731f491224ab6a9411446f3e41ecd9235295e30aa8e189	b248dfed4e5132d7f8827fde78fad34539d80047a874e02844e59b63f980fb8a9b955825c811dab6	f	2017-09-16 13:31:02
2eec69e6a1b28c024dbb8c6db39e0ffba180ceeb8abb5371b05ec6fe721cff56f157ebd0261d8cac	543fef5a53de34f20a12d57b6ab2ceb881494bdb6a4b6f45da2157d3212e9b2a5e6312133e913c0a	f	2017-09-16 13:44:35
0af3e7e84eeb6b24a2e1f6e1b785ea005a1ddf7bc8ff7d58897645f50c1a90d4518de29792449b4a	9bdfad983f0f00090f6809c219bf604e1dbac5c333fdb9e1e98649c4b379999d36a8e07cddcef71b	f	2017-09-16 13:45:15
5154dc17324be58f0a6085d798a71625a3b1259288ea216d54703179cb8fdc3cdfa1ccca9d2c2da0	f7f74e9c6fbbfc9d2d105d966d0e277a8fd0ab4919bdebe909801706d50927b22394ec246c3bbc52	f	2017-09-16 13:49:08
1eec45ad4604be9537bbf1247eb27748932669a810172a57fbc2c070b614b0afe003294395a6893b	9eb17449925133d66ebba02d34e70d5bb573bf309f9fcdf15d4270b1c4025841fa0cf93c700395bb	f	2017-09-16 14:14:39
0c0bb6fe3c5773a5a811c129cc23fc4e3cc6a608381a4166da62576cf71416bc63ad7e37859c4f2f	28527938c6ca566db0bea37158c4c956d65de101178ae5b89977e6982d43075c9f45ed965bc479f5	f	2017-09-16 14:32:09
ec69cfb50f96d4db9ab3d001f96c3966ef54ee764943d5cbc185bb1ad2051519c04b0663836d6408	e391d9d9a6ac4519ff14ef64968e017b6855940fff59f91a7b12ed1af29580065e879e86a67be035	f	2017-09-16 14:33:20
22de4edaf29f68f66dabc96c38a9bc0f816a1c7280bdc41e9ec047c5acf040b495f22c26206cc107	15608152006cb44532841e557dcf196530da797240cfb8491c1225756f172ee449e8c421304a9fc7	f	2017-09-16 14:33:41
e1cb19ae4aaa51d24bc59596674fee55648da6abae25d9382aa63458aa4705a5d6162fc9fba5633c	a4c040b335aa9f1442422aeb4d290944b8da5a97f47ae2c19a61f073a97d1cf1f43ca75950560f9f	f	2017-09-16 14:42:47
917eeea0dde3467da9dda5660551e643c5563ed98eb30d0657d32b4012f49d27139152678c9604bb	af161fa3f084a7ea76d970d76d20a876b00560ebba7cda8f300d98f2c734d2a07112cc4592535934	f	2017-09-16 14:44:54
16d316863d311594f787b56e0a15254e44b0ed43a919763a21a887f3a302aeece57a79d0758fe00e	81ba47a5d9fcc67d3667ae0c50752155d83f79e1030f5564b309ae8345fac534b38b6642571b1f27	f	2017-09-16 14:45:20
70585d5b53e1c8312c08e45c250dafca5f2a530f3a5f470d1fed600565df31d0c536df79d6beeda4	aa81c13dc749c4967168fbf3ef0bccc44ab00f43f27d389f0f5c6379493abc3b3ba72cc5476044eb	f	2017-09-16 14:45:53
e44a761e44972e9c30a02cf1c0d36717093b6f03c15fedc5a8523b0bdade26379b605a6f8689e461	f84f3bd9636d9321f33cc1cd196a76e1a3e55020239360b3e42043f7ccd2053ee9ece683a621ee8d	f	2017-09-16 14:46:22
3669de3b037fd4573c8c1bc7c0b1df9cc121a7168f4c472c2d95d9f9f44fb2bcb4fe262085acf644	1bef5be2e3cda7237c24cd9f5ebddc06f2d2575ee1f09686491a4775df5e3b2296f760cdb6f96461	f	2017-09-16 14:47:36
ffe51e881906fb9f5eb6d1761dff83381401888c9fcaae81e207b00189cfdcf5a80d9eb7b680c061	89df721971951bb1d16cc78e35cd4e6f545cb98d7237db66a464575e69c561768eb6bef4a724894c	f	2017-09-16 14:48:16
e2c1370ba70301ffe7b9ed886e2696d9cf536440f9ee61bfde4cad2887219068b629ed6d8ceb763d	8c49207552db352da6516c66d38e72e971373eb39f8c28ccadc5a1c14030fb0902a68c8220c03093	f	2017-09-16 15:08:40
9b7e8f4b812fc2408bade1c76ddc2a83013ae3637789f764bc6d86efcd67db174123d2e53af49cc3	07d4e1208b1ac8c0fa8a9dfea9989985eeee5861f7690134f4e8e578b9f578757e022ba761a23166	f	2017-09-16 15:12:21
ca310d2bc212654cbbf7ea6ad69b7a5f9c9568c65db09d167ab0375d9ab1a737c3d57f2b293c55e6	6452e28f9ff74a2759fd93191fb055911ffd1c78ec7d006b587ffbd75c7f094eee8311b56aa78ae2	f	2017-09-16 15:18:22
4a3635d1411e35719aa3c39c79b1b913a9581815c0d26bd8d9c69edfad69125945ac23b0206dd246	b054553760e8fae087fc0f4a61cd2f7fb952a686fc877d2e0a0b4269b0608d4b08355671b75dea11	f	2017-09-16 15:19:12
a81c44137792dd98f0dc9c95c17b17229d62fbdc29534a0eb039984d34dfc3124d36d0aa25b5543f	7348b23f7806ec634502e031c72c2655645fbf821a88ea5a9bb0568b715ed4a37d4be3675432a483	f	2017-09-16 15:26:55
cdb500706d3372f79cbd9d1ae83c0d071c7befc6d671130c2236e946a477665f8f60a05f37b15217	49f6cda702d1a1a74b0ecff852b51fba4d8f776bd0414cf6d00f612ccf000db729b828f19b1d6c5d	f	2017-09-16 15:28:44
628b9294d6eb72a05a78cf1d3fca2e1b8e4cee51fcebb437445c7ba17e9c7d50b31aa36b89796273	0da80ae2ef417fa0330744d5e0ff611f28f0891f96f3b71b331e4fa4b2e8c487c39d297a9a96a738	f	2017-09-16 15:29:30
e007b82edeca0b04e6faceaecc4a4d81b6122db56a555fc83649faf95fb1e9420bb251ad606cfc75	b4b9f595c033ea9143ba7a61864f9f7377433681d5f67a5ac48d18d6a34da8c2ae04756e2f190307	f	2017-09-16 15:30:26
f2798d85870b6739275a5fc0c856b7508bba935816ffd92aa5eadcf9882cabf52dd0b607f90a31b6	35172ffc879d1427e2d90e1e5d0f7c43cba30ce33152e3eed1aba8fe6b349f6b67f432ee32c9bf14	f	2017-09-16 15:30:55
d1115a7f9a390d614568768d50d68aac44d6d66c951f33012151ff8d676feb5fbab01d1572279012	877a4ac17ece80a73c6db8382f34573aedd3f882cc77f1056ba54b93d20a16ae947f02f4a65ddc1f	f	2017-09-16 15:31:23
51189e749f98a85fb28c91a67bf2265a2b89e4e32d5fe6a4ee04f489e1092f410478e091502db690	c15d9fc0142980500c116e85b116e6b8b054b16e3e23dce414f5b36b1dd5d6771b618ff24f2644a3	f	2017-09-16 15:31:51
3cf98f85bd76f3b88a43aa9721c2b7452199d50ef3dd7eef08015c57621bd08ae030c96dd897c4b4	8e9680bc83f4ceaef39e4a466ae18f2b1625a201b85a167318a1f5eeabfb800ac9018c3663385162	f	2017-09-16 15:39:28
7f73e91096c8c0bb4a6596b9f34539fc3bcf429589c7f50ae70705c737d641baa08d7cf1c25b90d9	88d04c030adbc6bed38c28c44adf520b074fb7a3f33f2183c4d5aa95902bf3be4fba10710659e668	f	2017-09-16 15:42:02
e1dbefadbb3575bf3eeb842a664cb68596da3ecdd03853c4d866cde332a4504ae2ca566f8ecbb6ed	f591074c44fdd915fcb4bc482eb74f894664e00b44ca7d0c5115978193dd34f836709367d7c46c37	f	2017-09-16 15:45:07
a8e09ff241d8cf4dd2001a572315f412aacce9d90dffcee50b14003fb7d6f4d42e65934f055a5bca	54d3c2616c1c5d8d950f220b3d6325a284501afd2ad5cbe704ba4f9cc51e790b0cff87b67850a02f	f	2017-09-16 15:47:23
1f2b7bf899d46709ff1f96c424d62c26c110e6eda4ca61ae3738d11e2dfea412964e191469d7c27c	072c4d67b7785022da32287c509a1bb1d7226d64ceef05dd2be67c0859ed9a9aa46b06f6a6c619b7	f	2017-09-16 15:50:02
dcbe3de867cbd255ee3474c396b0ea72cae9bbc693dd6a4ff80a7e50cbda957e54b049532d684b09	86309f121ef3123c2249a095cd3e3ab7f6559a02a4a74519aaad42e15febb2058fe27cb857ecfc1c	f	2017-09-16 16:34:48
9a21d0ee1a55b0dc7631da140a03b1ce3e0bfba4ac9908b754df5a2eca185efdf5511cfe53d0e99b	c6a16711f37a34c79fc3cba0276d70dee9b3e1f8e81130ee06a26cd2a7fd18f9ab868504d831f4f7	f	2017-09-16 16:41:52
54a1ea84f4eeaf679f9687b0bd297a054cedd9358e84821e0f7c6ba2b0f2ca94b46d1a1a9613f931	1b833690b2cfbd743c88bd1922891502cb592189f896b88d22bbf899d10c9ccfbdb62e908988e555	f	2017-09-16 17:08:15
0f10a6812954f83494919d08875dd3cef57ca149d85b393e371ba2323a7ff779a0b3db8a221d44ff	54ac886c918a5f86acef9cb1ca89b961e5a8153898b84e80074b23cc58726b211d10d9f04aad83e5	f	2017-09-16 17:09:55
128740e365655ebac57cdcaf223a6212870992a8d7564110dfad53d859bfe3682a828af3d1150c25	14ce9e9d1650766119e68e7e9087e4ab89383ed3f288acd00f3249c34101ebdd82133f133891fa3e	f	2017-09-17 06:57:41
86a6d96af98f944f42efb5e52b1c61cfb710b4b7d5dcc2d5205f2542ade311718683642f8d1f5d8e	cecc868e7f597f47cf24a8dcfbee41b07531921fd6f27a9b9220add62ca8e3a9aeea46ccfe52f013	f	2017-09-17 18:38:16
da014cfe0721c835ef0e14aa60af7f363c577033d56984bc5ae6bf20b5b560219ec8f3f19d8fee94	3a1de670044ca5d7f25cc9f67b90dc5a0d49b8c4e89a20779b97e5954cc6b4a328f59efd5fd005af	f	2017-09-18 07:22:13
3f3aa05c09ab5859082a90a9a54973919b79ddd78b7b46515f37bcb37824bb34f4493bab9942abac	a16482f198ff5f47e5542736f4f30e38dd87ec0b7b9894a66bbee58cde2fd35580259829af4e882b	f	2017-09-18 07:24:56
6d42b1f926ab2f445708cb6e1b7bba2d6491e85ad07e20c23a11568fe87c9bc48bb67d24327432b8	064870647bdb52293998205a6ee3d1792b89bcb38fdf6742b8a51a49ecf5cadefb00b18c72a77871	f	2017-09-18 07:31:26
ee62628e8ac268882bdae99f3c87edf6630c229a124c8d94f59a44813579fe6ecc9001ffb99d9861	3ca54cbff5e5acad3994dfe149e0a83189ab561cf1a2d7b0168bfd496353d851c2fd7975bd19776d	f	2017-09-18 11:17:47
c1d6c12394a742d5f7c6514eb8b7b321e2c4601c02a3f9dc8c245dce6a9b22fec4f13edd76f370bd	8a6756d5b075d75f7e407ab7e72dc72ddb806d49e2ca33ecc41c0fc2edd5f046c031f7e46ba0f1c1	f	2017-09-18 11:18:54
715d8eb040cadf26e0699901648350680b6b16f9cf4e6c88f2fdc9e6f32d7c9b35cbd924a5e81bd9	3eb52a176f23ffc43dc90c9804209ffb32bfa2ef0384adec81ed5a3fd0c612b66936dab8f9bd9bb5	f	2017-09-18 11:21:04
10d4c08d11aae8052f620f6db1e21d6bc6b5112654f83d84f64a7bdeedcc0010db4d4791c025107c	c4cbbe7fa38c51e10772c439f42ec750b88f209211b784b5c4f4b40f01edccba6c5a36a26a29e0d4	f	2017-09-18 11:34:44
b05b24bca888e8a8b5f57a80603c5ff1a14a8be47a0d4067367876e80d0181b67de5e8ba7aba3d4f	a7368493ba880e89bdab518e8793c17cfb0da056ff592c5f55e624c1ae479ba3b56f021549ef81d4	f	2017-09-20 10:17:53
9bb5e733483182c8c6a20a43f8e36855eac9295f75fb9c4a7b0d4a635a380088e34730b85f63914b	81754238ab77381d5efd9710cbe1e269c4624fd8b886f049461ed54c3a9db7a1ec805aaff6a9d8c9	f	2017-09-20 13:02:01
8c4b0742e77edf63ba02c78878790b26ed11834e29b8933cd76d7e9b98c24e874ea41ce9eaf9c041	108f99a04521dc5cd00bda09cb6df25a7aff92955c00875bad5d5c1ed26f7669e12d4e611a8bc94c	f	2017-09-20 13:02:37
5b762a67fd052a4d3fab6701b7e9cfcf159641ef529615b06558e67ea31edd88e6af5845c1fdd175	23337fcf626d21acd0eafa19136578c2cc92f1e1d95ab76b6cb859ae458b7829b8a0e3906864053b	f	2017-09-20 13:04:24
6e8b287a7835f1a3e810e01c6569793774dd8ccfeae6e237f0f387d2f8c03fc26bcb05773953d136	6c2f80c88eac44e195ef32c3bb8185486398c1a295aa2af9956a520b09ecbdc39d6cfc9a20f97ada	f	2017-09-20 13:05:40
6f30df3cf74804a45c590b9840c9fe9ece6b347563c96354389e6fa976de960d92db8cf7f0b73804	04e894efaa357c81f27d8996ada0b2f61550f10e0f8a37316f881d463fd6278a22048f0ede61874b	f	2017-09-20 13:05:43
de7c765236f6921f6018d242eb4b403344ed5b14051989ee79f47c59b7a9fb1ab6c6473b18ce60a3	ee85a3be8f69661202bc62a85586e8b462715f0ea9473e4c166aa3a4edf28089e8946bb6850494dc	f	2017-09-20 17:48:45
59b08e12be16a726db99028a0d1eedd9d36477ec209c295ec4f5f35382f6c4e124b7af0063ca8c8a	cf6a7fc46e379b66426ec51ad5dee280cc1d7d309e85781fd3bbfc8f8e898199a5b5cd58094faf4e	f	2017-09-20 17:48:46
cd761f7f809f5b225acc387f3c95d1753213015b179724cb70536fac1d05772f2f170e9769c11a69	7a91d1df0756b5ad0b437c0d167daa01490d71303ef5b81dea19bd8c69eee56ccb3ae6902d3976b3	f	2017-09-21 06:52:04
6e52f4378aced9febcfcb62c185c76d03dc12dbcc3f4ae8f18c4ab469018fa1f202601ba6d81134d	0d833615da32819153dcada7e2cecd0df1b564a2b0106fa088e00f131edc0536d31a6d8941828632	f	2017-09-21 06:52:05
ecb6f759bb3598192bd768e7c32d93307ec6951e036a7febfb27272cbe5c6d757d71ccdfc15e703e	04e5fd1d2df61c1f94b7782d23f6c14ca3aee33c130f668ee9594de1eded04d242645a11040affdb	f	2017-09-21 08:22:39
36747e3ab8d320ae1fb9c46089ca097c9386aa72d0314182d08f46619c566091433cd180ea1e701c	a403a526735f259985b741311f22161fa35b54a89a6f8a0002de5df5f48f2504cabe31ddb20ca93a	f	2017-09-22 11:31:23
14be90d8f1bc494c98c05d72b375a5592beb017e5552fbc12bee7bfc2543174aed8ab4ea9e6e5cd8	18945a6e0d6b90d8743490ff530f5c71a7ad5432b00d358d097cc9082f972143cddd08ee0ad2aace	f	2017-09-22 13:02:34
95f5cf9bef9cc40abedbdf2995ed68ef5935c9ea45e3a1f6d87528b8c7ec35ad2f7f13943a31556d	cbef03fb5d2f28c67511ef5257d08f160451d549315b5a0e1a1060221f0c1856c37f3b8fe1c7c43c	f	2017-09-22 13:40:05
f641687be4edf682c76c303d9a9b90f772ea4fc68390e025d4daa8321a396c4ff34bc4c664a96a54	0c6a99f0c591351769327b5683a6a648286349e5bfcb34419474e577d2f1c0f630b711a78477484c	f	2017-09-22 13:46:28
5a00ec86c43367fa262368cc9e0fbe5793d73a4e3f756a0e6c3cea7bca3cf59b51e62f8b3a9af056	4acc08de1a2f37f435db1ffd1de70f06a4d311783da65df0e108d0be2617f30beed6b86d1478a34f	f	2017-09-22 14:00:00
047296d6d874e2d735186c2b17fa19861ceeacfaf05955ffa2e3fc8a69eb6ce5ef5dd19844a6ef92	15a2fd7ee162f90e05eeccb0471c65abd6e84e8373efc21938abd66d409ad0a17593471ccb56114c	f	2017-09-22 17:06:52
c1c101325d1b803e94e9350e3876d4d6665c761fe1791c0e01b74f04628b0964dda205f4977e2cd1	a00955f09c828388d29be3d7d2dfb572fa1c2a7b4200bd0ba763746778c68781066035d9e63d64a4	f	2017-09-22 17:31:12
804ed6ee69d700514d66e8cc3de2f7a3742704222299dc412dadb2bbde2b89e36d9e6e7e72348991	49985e71281dcf6d2fab632fcb15fdaf84b2fc90f6e5d3c220eed292d3cf4ed773031d3e9127c5b8	f	2017-09-23 08:58:09
920083d403af0731eca8893789f281735bb80fe64379cf4be3b627f6a83969e8d7cfb609b6adc8da	baf1cc66456c729c2ad08125fd84ef2560e112adc7bb080f387eae0682337439dfd798126d75997a	f	2017-09-23 12:34:25
0430d78fd9f85ac2dda72d6a5ae37524672c21cb7dedaa2c7ee6dbfaf69e186c820a89549ca651e0	393596c161306aaaeadd48c78c104b3d31f302b42825cd7fbcc9c93c8a49a81012435d5ba2e1ccdc	f	2017-09-23 12:44:56
f1066a0f885b76fec4cdff00e3ce5055682167b46054cfb772ed8512492f46922f4de719285a86ef	bf6717e5aebb0481443784aca3a8eecefbda3655b4eb1098501c56721b96b225796203ba74cb582e	f	2017-09-23 18:25:46
29f9541f45c85839370166658f3a148f19b4bd913b4f7b8d55ad7bcc8814421ac8709a8f6761b7c0	70277330b9a0e80d5513f76aba0eeeab17e8c6120d9861eec564acd374d32bb68d239857b56f90f7	f	2017-09-24 09:48:14
a1400a1c81e100000f08d69e2c9741479f90c4675f5e35d2d60173fef9a9d52f80e8783e65183154	0a7aa23699e65718b1de7b3b8b2b6c506279bed9cedac92b73f37c7c0960c98ef4964570b9591755	f	2017-09-24 12:57:41
57c1e78a4a5fdb3ec2108ffd0f0584d97debfd738b45194dd5a2067e68477b93875e5e623356b078	9ff0b381ca76cb6569f15dc8d47053c5846c019e926298debb0802f350622489f9f57214b816ca81	f	2017-09-24 17:38:29
9b887183aef66577ab7a80d7214e0b4b6633ffc871984242fdfb5e032a3fa4147a082293ac96b1d3	fadb4e31ff1b2a5e820678d8ed271dcefd5814eed6ac56c1fda00bd4e6872861d6b0b959a99415c3	f	2017-09-25 06:21:48
dfe44f591c5f4700d37f8670cd8ebd365ca9e9e7479f7904361b098810c60da5e3c35847178f8b39	f45ba709271ab52a816fea46253f569ce30e3a1ac05166dadb27ba65ed5c954d84ed330f02f9eff5	f	2017-09-25 06:26:53
0b694536777cc48140d99a7d06a67e17d01f9d434d43fdc3da19ebd98533ad41e54152021c5d431d	98dd65c63df5e9c815d8857d08aa98e9de0fcc00e02c450ab90faad597eda28bddb044f0832a674b	f	2017-09-25 06:30:18
a82d34f9788aa5933e47117d5fc63dbc6ec20a88caa22545d494b1c48572fcc1cf5b7871dfbb0f79	1ce846eb4e6f7c870f8d334ea9cfe6fce5bcb0a86329c8a98d9251b31adf81572350db6a2bd0b808	f	2017-09-25 06:30:30
1146ae2fa0fd343aac531db37518ef68b646e1394f26a71a28f506246fe4635855afbb8027a26755	9e290d6587c7e72448e0aa1075866a88cd677b0318574538ab134e7ca6916c34896c07474cf39d74	f	2017-09-25 06:31:45
2cbbf3e898c8f759fba180ae5beb290f20392bb2f5017e72f284254966fd6523599a2d673c83944a	a825b0423640336f022bb468d63effe1b524e60447b86952d6fb5d7943806eb5ef58736d4b77b8e0	f	2017-09-25 06:56:24
294348ed22db392e25d93f69b8c9a7544e6a984fa7c0395b8dec27a5b882c65b6447e60f65d59aa9	06e32e87464b1673824b5b905950b7350691df9d2dcd6dd53d7ecb832cb7975549e117e9049fd79b	f	2017-09-25 07:04:49
c4bbe5f4bb33d9339a01eb1a3611f66eacfa1317dd4a2db6ea645bcedcd0e63506b01fe4976c467a	f2c0f6c65079522f5cb86d5ff476828a84ecc939fe2f60af4b8ea01fd8f2354b37be72d7ef3ef6b5	f	2017-09-25 07:15:33
eea5fd0e8b45eed3961c15818175ff941328fb1a46161208efff6623f92f52336dee5a422b734871	c4534346ee9ec83bc54060314943932de4f435c96cb389841f7e8e6eb46eccdc2b2c67959869e83f	f	2017-09-25 07:23:16
7e7cba0595a588db45427dfe3a3b18346370cc61100d129e13eea7d46ef860e3545cba91d3c87fb8	d7c2a0396d114ff7e2835834364a8afa89bea5a638f97e1491d9561337679897510aed417878becd	f	2017-09-25 09:48:17
8ab3de4933c38e69b0306f553a38acaa0c52af3bab3aae30e567bdaeee5f8cf36bce50bf853489d9	c1e77144cc2fdbdcaaf58fa0388f223fd75648cd5c5234a3d71a69caa36fc87cce3dd0606781de8b	f	2017-09-26 12:51:45
52b0566528e28474897973d452b4fa6ec575d7cea9cae41fa425bfc4f72f8c55c9eaf24a3ac58ae5	2a9d16a33fee78045b6ce1f86ba78e0da24c0262dbb215307ac3901169d30297ac671f18469a293c	f	2017-09-27 06:54:27
e35b14d615198a70fb56dc6aa6be7ec602f4908f056b44631f56313139b6212e8b75a507d43fedb2	6fa7ca5a9112f20f294a134f90e7392f4949ff836be456f610bd62a1aa318bc1911b5e22ed017934	f	2017-09-27 07:39:49
f6beeed1aa2f88252ced4d8e6a0b0d6403eb61d3323d3d44bed8e98081e886d8d803f1445679a2cd	2eb6141547362a2348566ff987c90e11609aec9b82d859e6545870db5530997aac6839f34a05d947	f	2017-09-27 08:33:56
1b7954598274fb9a023d01e62f78e47276457ec4650593b5b263168faead78427f7e01d92eeabb12	1ccfd439a192d4fa17222922e0162d9538bef6530cc333cd880e98aa1b4d8a99b81c196ecd60e4a8	f	2017-09-27 11:36:56
a3a90e0c5d07f8bab310a4560376af361bbdab6039442310aaa6b4f9a09e69ffceff153f44d309fa	31f4ae53243a398265c2ca80222d7f1991755130954687df6ef83ad88164644fa6979da42abe2f65	f	2017-09-27 15:14:42
64c6521307906026ad565488ae4fb0bea76341c50471f30ddf04ef6e4b649e5268ecefc3b61df65a	d71ab5f97a3352492c658e3d451dc50c7f026f9cda3255199a5fbd9a93de4e18e968696c0232780d	f	2017-09-28 06:53:44
523e211a853b61114a9cc5a45f915bfb5460b21c59286c50f0f959553a2c91a593d41f7f1a7096f8	551e56e1ac39bacb961a72f26491535cf9c56addbb2eabfd05118eac1c5fff7ced98e7e5148b3d4e	f	2017-09-28 06:58:24
0fbe52e0e4d9ecbbd288f15be02c1c37b1ab43e609315a961675d3b11dbd14cc16914581b26ff37d	4c1a45bd6795cbc291549d277e6d6bb3b7acc700b253210901258d994f084a78f71c90a644c7474a	f	2017-09-28 12:04:03
183813ffca9085af246c60076186ebc05866cb90d59af5889954c409ef01fc70b35d728e80a16cc8	8e10c1bc5109cea3161260c327f7ef5685edcf5b9280470948d64d4092724eb32f5998cec793829e	f	2017-09-28 12:31:53
12718b636691762b1385f25c7893d55f0ba1002b9fa5ac638347e56b593d748e8363f40771a8a3a8	288a2b1f60a9d9b2ade3dbce59a7c59d65f568a21b0d8611668dcd11ad9466bcf0d8543d278d4f27	f	2017-09-28 12:59:14
8b193e11e7f48c2288fd664aebb9ca40c236de407b459e884947e588f6b46b8dad299199c3289124	1f2f8a1fe09b77335cd0cb057c6dc3838c22862f54998ece510f252ff3de8f82315db1186665ee36	f	2017-09-28 14:11:46
65cd5fe683c1083a8cac014d1f7fc6c84082f16c9f1024936e4c4e3db095b27ca4f71922468d9e3d	4dd18581bd1e4f59f26fe5dbae1fd011af08e49c14f503590e92e56691773213ff63fa0394092a8c	f	2017-09-28 14:52:36
3d4a5a1166334e01b008164d1d89ca829d9ec30040736407ce2bee8fe4bcb5ffa35fa943e1be1e97	1778e3fe54d7b997ffc2d5c0ff38b8ae705e823b2576265afa6faa5a9efca8a77255cc98fae5e5ce	f	2017-09-28 14:55:43
7d63479b81bd1d125fd77806f72118290e9bdd80b72fd024bcc3ca94c42b5cda0c8fbb5e8b0011a7	db3fbc9de8e2086e6f9610b28e68bb6275ca0c180608d50d20cb4e7ddd78a24be634373f5d154007	f	2017-09-28 15:31:40
1a599179715f56969641789aa6bea5ef17dc855812dc6eb526e7af5352f1faf1daf3ee7a37e427da	9e00e6b3a6b9765f9ca1c479a7681429937f2f6d2c705425bbc4bae57280344d36c41770bdb2068e	f	2017-09-28 15:49:45
66d59aae0fbe6ef5c3565e81c90e06570567b753ff274753722580177a8175ec6ab17a24e448dcaa	fec4723fa6498e72669f111031e977eaaae180884c5ca2a3f5efdb06a200107b86964139081e0fbe	f	2017-09-28 15:50:02
644da5545107e4938474b686c7bd6b68ab266c9eed850f159a9e707e22c77db825afa732be499afd	7641c40e14bb22e14d83e021224fed3bd726a3374f3d42d2b1bedad6d70c35c668f6f60c484cd7dd	f	2017-09-29 07:09:50
f13cbf4111af1639075aa719e641969b491a3ea1803c2b940d0c187748fc4090227407897d48ea42	74dca87cccfb593117cf811391d476d3ce0f19503ed3fe3e119fb71a97897eb29017239f9854d8f1	f	2017-09-29 08:08:02
158a3898e9e550a9af2306b53082605d82a3374dcf5707fcc709221d0932a3d0c7fe34bbdaf16218	93eb85474a3be21977dc6d4791135dd5da214783b0541726eadd9a6fdccc42724272fc4fcaf4cf6e	f	2017-09-29 08:08:25
62beb310ab3a760d5e6f25112559ae5805cfdf7258ac389ac01d439440db93cfbdc8123cedfda6b0	e76f3518b11228869eefc094bb9b6652d96ae32ec67cb90797d9cb3c7509f04b7c3cea5ac610fd0b	f	2017-09-29 08:09:22
0bf86728a57868b7bf1657608f10df55241a39c1f63219b6a84055d31c924998e5cc76bf888f4a35	c6f1264e8607c7698d1da907c5b1757864cd1079f9698d5bc7ab242f5ee3c75e73ecdec5fc499964	f	2017-09-29 08:39:57
b4bb787d649a72dd4e678139bfdece27e59a7fe07544e061913d320cfff368381d93d9f76339b431	68ed7a62ecfcc20f0cb6075e547c04f07c192da6793089bb4ed05c03211a1b9486cbc2ac3292ddf6	f	2017-09-29 09:20:33
17460d0a7cfaf7e6b882706fc4dc3235a3f5d45a51aa4b74d7073791e35803f38a94c6276987a120	b17415fca5d75e4debb6f45d92d5704d7359b0409e19509029e037bb2612d029c666381bd871e04c	f	2017-09-29 09:20:49
e3c0d5b585066882fe06937f3114b00aec55eff4483b6afc24823fe9d34d181edf7a3aaf8d27ef5f	f31dda8d947f158e00ad588c74078e3223096526a8b173a2cf2d30b38c5473086d7ae5f2d3979341	f	2017-09-29 10:26:08
11c98cedf6302755db1766fa3154563152ceaf1abdd9eb1d937e8f030d3aa5e3ae6792a13cfefd9b	d34d099dac1f69f5b94519ce956a861d7760b8f5128f81f363da33b6f29bcede96d5f839d5cabc5b	f	2017-09-29 10:33:12
92ab308323ad522b68d4ea31eff8e2241eecafb86ce0b827d5567b197a0dd1b16ebdc4bffa835092	ac0ee6d7dada6910e9dac6edae0e417d1d86f92f07f6766519e0becf483269f100bdbf036d1e5736	f	2017-09-29 10:34:02
71ae227548c88c66f4d3bd3a8edd4af25cdfbc7a3d18ba554e295de52a3edd65014190afa7163568	3ef1bdbbff246ca65b18442c4e87734563ad2d00241a1ce517c119d1423d17eb53b2b8f9ab97022d	f	2017-09-29 10:35:41
4288c5385411bdab673aa6a99318b97214fcede6f1296c2d3a64c50a4d5cb0b4a7a5ecd240505508	b25a43528385ffed2455cf1d18dfa75c3a230d3ecb58ee11c55e8c4e93a6a996ea491c7f3a02a489	f	2017-09-29 11:33:57
a8eca55f605b5d34ad2c1a01424a7758e447d3d3ae997042e249beb7a6526891e3f434a9e358f7ed	31ae168b516f7dcf9616889eaf0274c26036f2cadffc347270da33663aa86221ea431546a1a44130	f	2017-09-29 12:56:18
007bc56c719aa1bfdcd0669401d2af717410595b656c39f4012502e5944331cc9fa8b23fefbb6488	b7fdf7bc7d96add63507cdfeb6e6808b31925acb7b946186c7c8683740a77053a98d93ec25b279e6	f	2017-09-29 12:58:20
979981ce91ad7f9af194a02a151cb439f8e64f8868565f3b77e2b3998f6774e179b2182cc9f17d27	ba482d22973c86e9afa001de3ee6a85c907c63b54c9bb06595095cfdadef6147eaee83432f11918c	f	2017-09-29 13:03:04
fc31b8ffef58be67528d900bcfa6f24042ccdb3298e3b4292a80bbb4037f749417223265ae5883e9	06df0c30bc3f246f9e6f4e2d5693c75aa11cef8cdd834e83250e66b560f92cf9aaa3630780eaf601	f	2017-09-29 13:43:39
eadd70bd7024eba56d9bd548d2aed2b0647254aedad124e942aefff46a7344a1d00595b677518d6d	9b211e35e6e4f72fb4c40d55b172abd7a41bbab9eb9dc14e662a9ff2e32f22cd3750c210a59dc351	f	2017-09-29 13:47:31
b5a951bb17e3e0c2580e8a80a51d7adcde6dadfb806902f82415aa9b879c60f7c66000f20cbdd49a	c6eb3743959f58078f48a8347dcbbf8173f41a8899c7e941bfa3304203b370f26e558f33f8c9fdac	f	2017-09-29 13:54:21
7f553e623e1b3f52944d4596a1799de107a02e6874b9a745395880ebb3456562dd9cea23000eada2	64e0d02e4052dd6649384168f627dc0ff8eff8b55370ab5cd0bbaa6af13805aa41b27d4ecffb1bff	f	2017-09-29 14:09:26
88f2b4d5afc01c7d174328312941def5efa52d37df92557b00a0875eaf44b20da34eb3939c43c837	6ba7e17be6434b3edffdeb22f11ad95e397eeca64c09ee84d13e25347627b015e74bd3c77a3ed789	f	2017-09-29 16:03:39
c62205563bd1f29062a7c387b43152c4a73538ca7c8985defed7dd4d25c267efa659b99a3f63096a	a7ca06cccd2e7460b2e26a466c488052a76c5f02e9e2881a382dfe55d01a72b67b11aca21f309ee8	f	2017-09-30 06:36:48
4a554dc3d4ca26ab7f4885b329bfc2ed6ec515ee9d9272200df29b228d2c2d39856b6b7802270186	e8eac16ad59d7b38137e146910b98011e232d0744413d55d36f6e77f120f32e9aaf5e56281bc8be3	f	2017-09-30 06:40:53
d83cb7d2e765726650ac856eec817c31d3d26223c307cd8af77b94e7a934aaf5d1c773391a9b0ec5	902852b7be68e2cdd42741c81ff103bfd44d9ff19c1e4dcbb87633657c3859344d315f3ca89a567b	f	2017-09-30 14:16:01
8132cb6edefa57d5bcafeb49070488b0130ad312e0fd6980b76c4883ceb9c1340b5e2b75cd8a367d	b049eeaf2e081be914e024f91ed763ebb0799ace508a831aece8cd106409367b0acaaac0aaf60f23	f	2017-09-30 14:50:44
d22de847608e53799569d4e0d5cbebd2524f693769563c7241e4cbe182cdd347d97d1eb313d71f31	bfdc2bb5fde735fb526c87d438d622bcfc089c7159a1ab46f44cac9c61c83d9758d153bc07409422	f	2017-09-30 15:05:48
20b57b2c7ad1f3914fd85009cc915befd6e61b87b07c7a974ac260066b766ebaeb0f9d6ea23d4ad5	885574a609385afafb923891ccbd33e1bef591d83b361ced1c530f7753371e70de07f8ebc57c5b06	f	2017-09-30 15:09:55
3c894916d2f6cd63b3c4ac158a9d9c6e29750fecc128ecaab013b94cb360c8c1e6c7fb5eeca0ebd6	6353aa5b997aaf1052f130dc08a5597196abbefb8686f98f45f88f31e425340dc2952a0828d479d0	f	2017-09-30 15:32:48
2bd73be3a762a4625d981883ada4448505fe102ac14e78386ac12ee3be203d2579efca52a0b222f4	a9466fbedde26f8f6c50b510206d640591b3c3c5125093325c815845a5dd697f84ab235311fbe4b1	f	2017-09-30 15:34:09
1af2b40240f208fd4bbb807ce9b46480cb35023ac8ff874cd426a39134180adb2f8f3172414740f9	417e7eb23c5cdae8384f1df0e560921c69352cd082b7827c6756af14f7fdb6dbf305a4acec3d86b0	f	2017-09-30 15:35:06
ddb96af65cda9f8c495dd9644102d63284c177d1d8c742a48d27d4bf897cc4e158eba9596ed7a2e6	5fdd2e62c20bfbf25cbe836a2ecd8daea8e2e644f643fb32e22e9911667754d33245709fed43ef60	f	2017-09-30 15:35:47
c36302e7b1a14240767b814346a2b2e7674ed27b2ce73b972135821fe7abcf2b0f1a6c628febef7e	86186491a86558d32ae0171339e302e348dddbef79c2d55603333ef21917dc062f58cd13830a5ad7	f	2017-09-30 15:36:50
5735f0172fa4de1283469ae3bf63a03bbaec263ea7bcb27a7173dbbf6e6594e48bb48fe2fec841b3	1f259938b6552bef0f245da15021647f64ac8e6fc50bebe247f50bbe807085a83e800bccf393d248	f	2017-09-30 16:13:19
ddc42233100f29f6cf80062eb62dd1e12f5b6e50d3287be7211f958321d0a4229b693004b3234e51	dcf035b9d5cf63678356e39134440422d16023884ac02f084d7710c2ea0179cd74b9ee929863b608	f	2017-09-30 18:18:37
1d84d15852ffd4a0628a27700afb200a1b40b04fafcfe07955790929f4c2efc2bb70dc43bfe41467	ab491019ce661d68e4ae0e2f46dcc73172a41c7eeb2e9e55c78c16aef5f0a5b01530cd0da3dfcf51	f	2017-09-30 18:50:58
bd258b6a94b1acc66d5a07712f8c6ea4ad61aa62defc36cf4a067df38c79723c429c28c6ca8f06ce	2f80a512268d915ae45fdac4938a089afe2540e4a551794e5dfb01b5fef153feb6591c5fe3de27b1	f	2017-09-30 19:26:23
060cab04f125fc30914fc34a6f7efe13458d6d6bc2d319b76239d19d2212ac1011a89613dd962c27	37816a106a7baafa2f6aa8478eef2e2ee8d3b7cdc8d8cd898ba87035b64e9ae868d0d060263a8a70	f	2017-09-30 19:31:26
b1e575befabf8c3d821e971956592b01c640d49108c31200b3df860399fb1658fe935a2b05dd97a9	cd5c8c5317dc8189ccb90b8d9f975ae744efc283eb23eae36326349927702b7e2cc43c13c69f3f39	f	2017-09-30 19:52:41
6b16ae24e7eaa71abd132789455d90f330319745a264ee5d25ac850887bcc77c674607b88bbb2bbe	eb8387d853ab2f6da5e51f5937a4e8bec70b06b3261c1d2985463cb2146ce205dbc1dec0496ebb48	f	2017-10-01 12:45:41
23447b0da12fc1dde913c9fb5d94b1f6df09f46b0d4292db92287645c4b127b371a3a4b89a1e319d	230ccf85e86d8e920a3b1009ca188add371a429d71e0597ca85762fdd1b6ed7309557d2fcbcccfce	f	2017-10-01 12:50:23
d7ccaab6df8e42bc4db4d08c3fa6de16bd062ec4e9cbbc48366381d39b367c5857c9999a35b1cfab	6c6081a2c650b47b308176e8e4cf7291c595f6f3ccdd43dc942fa0b69eac23d6136f019ce8e3414f	f	2017-10-01 12:55:38
c63e897e569fb2467d2771dbc7d70fb2afe99e65170990d038fb2881979216c63edd2ee7b4c4f83c	84ad18258a4dfff588af88b561e7858059f90aa42abbaad5fe14e933de0aece3a1573b7473ace920	f	2017-10-01 13:48:20
452f443f09874cf02e833b568b42e3db873470d3a94eef7f64cac9a2ebdde7a08bb531b1320c6c12	fc23479aa275156b8c4c3554d576b7d0abb3dc925eb7608bba5e56cd3f37ee72fe37a3f35e9d871e	f	2017-10-01 13:49:32
f74807f9711962b7509fc94bdbea3b9ad776e1089dacc04370e3ad5d2b356a8bbbefb55a13b8f788	87d3330cc145eda97843ec0d0e23be6bd793b001e11e30f4a17f27975049f9b23b9e7d41bbd6181f	f	2017-10-01 14:02:21
95b3c27fab1d1aed2dba4f1c3345eb57837f18cf9ef67a18ad4eba73a7a67467fea37c155fbfa77c	7fcc82aa4ecc9deed17ce8d91026b3b67a0d62a5e1f7529066865c71209b5a9de6097018c733356c	f	2017-10-01 14:11:26
ccbc2e7950e8b801466f6ba2d4d3f91265a9140407cd6cb6eadd7aa79ee1bae9208fc8d7d0f9c22f	68f8d1e95496b7bbc89bcfef9d3b63f7f664df7e15e32c91874b5f38bf75857df11332af4b4eaf53	f	2017-10-01 15:44:12
95f504519294d90a0b8038f96f82df2499d4f5180282551ce61b1297719c918198319c980e98f015	5e6d83ad08d1c6eaff7465f9ae1cfe37410676c2e1f204c0a61fa40598ab8beec7cb4a677c39b07c	f	2017-10-01 17:11:31
e8e817012efbb20b8b0759ce954f803bda731765dd970e9f52cde8fd2a637404f34366f4f8d732ff	a226963c9d468953e67bd50d5e4faeac7a9767adeeece7d767b2e8c18bbdbe7e1ac0c05355d173f6	f	2017-10-02 06:01:12
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY password_resets (email, token, created_at) FROM stdin;
ocean3@dispostable.com	0474e323656826c067ef39a5ad31f59d1d183cd89f5472cab84db01442ff1460	2017-06-17 10:31:04
ggggggggjjjjjj@dispostable.com	1fa735d8bb0445a6172def210b6f491de483c80f878157dd0d89ea60f031f7d6	2017-06-22 08:33:05
sgsddsgdsgdsg@dispostable.com	d0a2a9e5b053cd6cb38c35376773c6a67d9de38e6c0a3068a6069db9c067c8e2	2017-06-22 08:33:57
harshadtestingemployee@dispostable.com	a7d1f23cdf67d4b6abcca1e3b7f5d648883133afc5bce3d0944b04d9e9149d47	2017-06-22 12:37:22
co3a2@dispostable.com	5733879294a1ddc489dcf2518c62ea14ce4d8a25dc2bbd6d0150e4bf496404a2	2017-07-26 15:36:48
co3u1@dispostable.com	4e530bf0364bd9a6200023437a3d9c3e049f055d0fb30bc8c881c9ec5664f7d2	2017-07-26 15:37:45
co3u2@dispostable.com	8c4cba1c26ab44d6a9d684795c7e2ce2ca56e3b8ea64a573099f388f19849cb8	2017-07-26 15:38:19
userasmasc@distpostable.com	91e8f0dd2f61cdd67a8aea4850f480db7caef93b47c48aafc50ea88a51f4efa6	2017-07-05 20:07:08
palash111@dispostable.com	41054ae7334daf9fb6bfb27ca26903fda290a27abfd925b022b19c3433259728	2017-07-11 10:54:01
adminasmasc@dispostable.com	dca679ef6f5846d1f2a9a2aa21eda3d70019daef78203e6a08d675317d416c68	2017-07-13 07:54:12
ASDERT@dispostable.com	64426eaa7fb63155b9647b3716d19e678567e92538f412d0c2377c7af3b7f141	2017-07-13 12:44:15
ggggg@dispostable.com	c027b8fd02c2b4611a9cf7ee6d679fb339935d0e349d5b5ca5b13b6ab1086c38	2017-07-13 13:26:45
wetwet@dispostable.com	1a3193d5b8ea488d876c5113400a39134c7de0dc39842b22dfe2cebb002c93e3	2017-07-13 13:30:19
ffggsgd@dispostable.com	aac7f284ee05c2acfe2c015e32e456b4d5c843f3daf9163dc80114fccce7c46c	2017-07-13 13:33:11
afgasfs@dispostable.com	a96c891779285f31931356cc1601483f5dc082cc1a34f859da8a985d74a70714	2017-07-13 13:36:27
gdsgg@dispostable.com	805605f676bfdc1488a1e619caa0bbd54c26b0e3e2eafd72a5f0cd3e616f46a9	2017-07-13 13:51:30
fdgdfgdfg@dispostable.com	e445b2c5c16c0aeb9ab71aea927a18dd374f791ee6cf25b36787b3ee4f5e1c8c	2017-07-13 14:08:24
fdgdfgdfgyyyy@dispostable.com	eb979b00657007d34dd3501db162228a556d5eff3cf4aedf6aa7c9892e6a81c7	2017-07-13 14:13:00
\.


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

COPY project_user (id, user_id, project_id, created_at, updated_at) FROM stdin;
99	173	22	2017-07-25 21:58:03	2017-07-25 21:58:03
100	175	22	2017-07-25 21:58:14	2017-07-25 21:58:14
101	203	22	2017-07-25 21:58:17	2017-07-25 21:58:17
102	178	22	2017-07-25 21:58:28	2017-07-25 21:58:28
103	180	22	2017-07-25 21:58:40	2017-07-25 21:58:40
104	181	22	2017-07-25 21:58:47	2017-07-25 21:58:47
105	183	22	2017-07-25 21:58:54	2017-07-25 21:58:54
106	157	18	2017-07-25 22:03:01	2017-07-25 22:03:01
107	170	18	2017-07-25 22:03:07	2017-07-25 22:03:07
108	174	18	2017-07-25 22:03:12	2017-07-25 22:03:12
109	203	18	2017-07-25 22:03:15	2017-07-25 22:03:15
110	177	18	2017-07-25 22:03:30	2017-07-25 22:03:30
111	179	18	2017-07-25 22:03:37	2017-07-25 22:03:37
112	182	18	2017-07-25 22:03:45	2017-07-25 22:03:45
113	184	18	2017-07-25 22:03:48	2017-07-25 22:03:48
114	218	22	2017-07-26 12:34:42	2017-07-26 12:34:42
115	219	22	2017-07-26 15:38:47	2017-07-26 15:38:47
116	220	22	2017-07-26 15:38:47	2017-07-26 15:38:47
117	221	22	2017-07-26 15:38:48	2017-07-26 15:38:48
118	208	38	2017-07-26 19:49:42	2017-07-26 19:49:42
119	208	39	2017-07-26 19:49:57	2017-07-26 19:49:57
120	222	44	2017-07-27 16:40:31	2017-07-27 16:40:31
121	208	45	2017-07-31 17:04:11	2017-07-31 17:04:11
122	210	45	2017-07-31 17:04:12	2017-07-31 17:04:12
123	211	45	2017-07-31 17:04:12	2017-07-31 17:04:12
124	212	45	2017-07-31 17:04:13	2017-07-31 17:04:13
125	209	45	2017-07-31 17:04:13	2017-07-31 17:04:13
126	214	45	2017-07-31 17:04:41	2017-07-31 17:04:41
127	215	45	2017-07-31 17:04:42	2017-07-31 17:04:42
128	216	45	2017-07-31 17:04:42	2017-07-31 17:04:42
129	213	45	2017-07-31 17:04:43	2017-07-31 17:04:43
34	133	16	2017-06-16 11:14:17	2017-06-16 11:14:17
35	135	16	2017-06-16 12:50:34	2017-06-16 12:50:34
36	134	16	2017-06-16 13:41:05	2017-06-16 13:41:05
37	2	17	2017-06-16 14:15:54	2017-06-16 14:15:54
130	223	45	2017-07-31 19:24:26	2017-07-31 19:24:26
39	158	19	2017-07-03 07:40:13	2017-07-03 07:40:13
40	159	19	2017-07-03 07:40:46	2017-07-03 07:40:46
41	165	20	2017-07-05 19:16:49	2017-07-05 19:16:49
131	223	25	2017-07-31 19:31:52	2017-07-31 19:31:52
132	146	17	2017-08-04 13:56:21	2017-08-04 13:56:21
133	135	40	2017-08-04 13:58:46	2017-08-04 13:58:46
134	134	40	2017-08-04 13:58:51	2017-08-04 13:58:51
135	208	47	2017-08-08 18:37:18	2017-08-08 18:37:18
136	223	47	2017-08-08 18:37:30	2017-08-08 18:37:30
137	208	60	2017-08-11 14:23:41	2017-08-11 14:23:41
138	210	60	2017-08-11 14:23:43	2017-08-11 14:23:43
139	211	60	2017-08-11 14:23:43	2017-08-11 14:23:43
140	212	60	2017-08-11 14:23:44	2017-08-11 14:23:44
52	160	21	2017-07-06 13:38:47	2017-07-06 13:38:47
141	209	60	2017-08-11 14:23:44	2017-08-11 14:23:44
142	223	60	2017-08-11 14:23:45	2017-08-11 14:23:45
144	208	65	2017-08-11 15:20:43	2017-08-11 15:20:43
145	223	65	2017-08-11 15:22:32	2017-08-11 15:22:32
146	157	63	2017-08-11 15:24:47	2017-08-11 15:24:47
147	157	66	2017-08-11 15:25:05	2017-08-11 15:25:05
148	157	61	2017-08-11 15:25:19	2017-08-11 15:25:19
149	157	22	2017-08-11 15:36:24	2017-08-11 15:36:24
150	133	42	2017-08-16 12:07:54	2017-08-16 12:07:54
151	224	67	2017-08-19 07:34:47	2017-08-19 07:34:47
71	176	20	2017-07-06 16:45:38	2017-07-06 16:45:38
72	166	20	2017-07-06 18:58:48	2017-07-06 18:58:48
73	169	20	2017-07-06 19:39:06	2017-07-06 19:39:06
74	171	20	2017-07-06 19:39:07	2017-07-06 19:39:07
75	186	23	2017-07-08 06:04:36	2017-07-08 06:04:36
78	191	21	2017-07-11 13:24:55	2017-07-11 13:24:55
79	194	24	2017-07-13 12:59:46	2017-07-13 12:59:46
80	193	24	2017-07-13 12:59:50	2017-07-13 12:59:50
83	190	21	2017-07-14 14:41:38	2017-07-14 14:41:38
84	206	21	2017-07-14 14:41:40	2017-07-14 14:41:40
85	207	21	2017-07-14 14:41:41	2017-07-14 14:41:41
86	164	21	2017-07-14 14:41:43	2017-07-14 14:41:43
87	202	20	2017-07-14 14:52:14	2017-07-14 14:52:14
88	208	25	2017-07-17 16:21:58	2017-07-17 16:21:58
89	209	25	2017-07-17 16:31:08	2017-07-17 16:31:08
90	210	25	2017-07-17 16:34:37	2017-07-17 16:34:37
91	211	25	2017-07-17 16:34:38	2017-07-17 16:34:38
92	212	25	2017-07-17 16:34:38	2017-07-17 16:34:38
93	213	25	2017-07-17 17:53:29	2017-07-17 17:53:29
94	214	25	2017-07-17 17:53:30	2017-07-17 17:53:30
95	215	25	2017-07-17 17:53:30	2017-07-17 17:53:30
96	216	25	2017-07-17 17:55:30	2017-07-17 17:55:30
165	164	68	2017-08-25 11:25:00	2017-08-25 11:25:00
166	160	68	2017-08-25 11:25:00	2017-08-25 11:25:00
167	190	68	2017-08-25 11:25:01	2017-08-25 11:25:01
168	207	68	2017-08-25 11:25:01	2017-08-25 11:25:01
170	206	68	2017-08-25 11:25:04	2017-08-25 11:25:04
171	225	68	2017-08-25 11:25:04	2017-08-25 11:25:04
172	226	70	2017-08-30 16:01:33	2017-08-30 16:01:33
173	208	70	2017-09-01 17:12:06	2017-09-01 17:12:06
174	209	70	2017-09-01 17:12:06	2017-09-01 17:12:06
175	211	70	2017-09-01 17:12:06	2017-09-01 17:12:06
176	212	70	2017-09-01 17:12:07	2017-09-01 17:12:07
177	210	70	2017-09-01 17:12:08	2017-09-01 17:12:08
178	223	70	2017-09-01 17:12:08	2017-09-01 17:12:08
\.


--
-- Name: project_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('project_user_id_seq', 178, true);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY projects (id, uniq_id, name, description, client_id, sector_id, industry_id, "startDate", "endDate", longitude, latitude, radius, status, jdoc, created_at, updated_at, polyfence, pointfence, address, city, state, zip, county, country, deleted_at) FROM stdin;
21	d2f7be69-5b08-45ee-887d-d65440b0aab4	lumsum	dsad	121	1	1	2017-07-06	2017-07-06	-80	40	0	active	{}	2017-07-06 13:19:02	2017-07-06 13:19:02	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	dd	dsadasd	aa	78965	q	usa	\N
18	28f1b874-ca64-4b58-9a06-6f2279ee0f68	Home	Living	119	1	1	2017-06-30	2018-01-01	-82.0279929886080055	27.0152251790839983	0	active	{}	2017-06-30 18:43:35	2017-07-06 14:53:39	((27.0154336091901932,-82.0281244888628862),(27.0151142698829325,-82.0282457791140587),(27.0149902678935518,-82.0276848670853838),(27.0153125539745247,-82.0275789499282268))	(27.0152251790842328,-82.0279929886078207)	1077 Fergus Lane	Punta Gorda	FL	33983	Charlotte	US	\N
29	47630f68-1ad0-4c23-ab1c-83440bfe61bb	Demo Project II	Demonstration Use Only 2	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
19	b7edbf96-5780-4dfc-aa0b-e0fefaa2fcc9	palash project	hhhhhhhhhhhhhhh	120	1	1	2017-07-03	2017-07-03	-80	40	0	active	{}	2017-07-03 07:39:43	2017-07-03 07:39:43	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	2272 Airport Rd. S	indore	pp	452009	india	india	\N
30	7b125786-0aa0-4372-bb2f-b83e3e59e122	Demo Project III	Demonstration Use Only 3	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
31	7384cb50-c3be-46e7-b350-fe8aa73ef7be	Demo Project IV	Demonstration Use Only 4	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
32	5509ca7b-3cfd-495a-a5ab-394117b96eaf	Demo Project V	Demonstration Use Only 5	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
22	57368652-dba0-4c74-a8b8-e61ba5186596	Work	Bold Office	119	1	1	2017-07-06	2019-01-01	-82.5362829735719998	27.338634329013999	50	active	{}	2017-07-06 14:55:40	2017-08-17 15:31:39	((27.3364170864221698,-82.5407409170143751),(27.3365009663472982,-82.531163030853179),(27.341189422859145,-82.5311423599536056),(27.3411983831574616,-82.5406167404233884))	(27.3386343290139777,-82.5362829735717582)	1680 Fruitville Rd, #304	Punta Gorda	FL	33951	Sarasota	US	\N
20	277c34db-791b-494c-b4ae-d95bfd6b31ff	Punchcard	Punchcard	125	1	1	2017-01-01	2018-01-01	-82.5353527069089949	27.3384478323789999	0	active	{}	2017-07-05 19:07:45	2017-07-06 19:01:13	((27.3378558193436554,-82.5343658806346525),(27.3397820977655002,-82.5342798233032227),(27.3396548136461988,-82.5374390990406255),(27.3380056632010451,-82.5373435020447914))	(27.3384478323787121,-82.5353527069091797)	PO Box 3423	Sarasota	FL	34230	Sarasota	US	\N
33	222db8e0-1052-4b3b-bc00-7e6df1333f3a	Demo Project VI	Demonstration Use Only 6	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
34	de235a51-f21d-43a6-804e-2df1613258f8	Demo Project VII	Demonstration Use Only 7	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
35	26a1787f-d49e-483d-a24d-d8269a437438	Demo Project VIII	Demonstration Use Only 8	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
23	a83e2b0c-a3aa-4172-9493-4d6ca02e4a43	test project	working	129	1	1	2017-07-08	2017-07-08	-80	40	0	active	{}	2017-07-08 06:04:22	2017-07-08 06:04:22	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	dddd	india	mp	452009	india	iindia	\N
24	a211d41f-4684-486c-8489-216aef0daf61	wert	tttt	130	1	1	2017-07-04	2017-07-30	-80	40	0	active	{}	2017-07-13 12:59:27	2017-07-13 12:59:27	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	sapna sangeeta 	Indore	mp	452002	india	India	\N
36	1caac8d7-5a12-4b68-8c93-a82c296cb272	Demo Project IX	Demonstration Use Only 9	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
37	8b8d2c07-2321-4255-9936-2165ccf6d91b	Demo Project X	Demonstration Use Only 10	132	1	1	2017-01-01	2018-01-01	-82.5363933999999944	27.3384097100000005	0	Active	{}	2017-07-19 21:05:44	2017-07-19 21:05:44	\N	\N	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
38	e5bea624-3eb3-42c7-88e7-2979eb033e69	Home	Home	132	1	1	2017-07-26	2018-01-01	-82.5026139999999941	27.363824000000001	100	inactive	{}	2017-07-26 15:14:49	2017-09-01 14:02:10	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	3321 Gocio Road	Sarasota	FL	34235	Sarasota	US	\N
25	2e8add7f-d1eb-4ac8-ac15-3937064ff7b1	Demo Project	Demonstration Use Only	132	1	1	2017-07-17	2018-07-01	-82.5363934040070006	27.338409710274	0	active	{}	2017-07-17 16:14:59	2017-07-19 14:50:21	((27.3393242607710611,-82.5371405759075287),(27.338063206490979,-82.5371401829438014),(27.3380535148643915,-82.5359592737659113),(27.3393560396614177,-82.5359758995221))	(27.338409710274,-82.5363934040070006)	1680 Fruitville Rd, Suite 304	 Sarasota	FL	34236	 Sarasota	US	\N
17	d18a7b8e-0488-40ce-b79a-80180a0d0456	MonicaProject	MonicaProject Description	2	1	1	2017-06-16	2017-06-16	75.8669550999999984	22.7001251999999987	1000	active	{}	2017-06-16 14:15:43	2017-06-16 14:15:43	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	Mishika tower	Indore	MP	452001	India	India	\N
27	082f513c-aef7-4dbb-8031-b62e23ca059e	Demo Project I	Demonstration Use Only 1	132	1	1	2017-07-19	2017-07-30	-82.5363933999999944	27.3384097100000005	0	active	{}	2017-07-19 15:04:16	2017-07-20 13:28:40	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(27.3384097100000005,-82.5363933999999944)	3321 Gocio Road	Sarasota	FL	34235	Sarasota	US	\N
39	83a37619-0d2f-4009-a646-e36329736e8e	Work	Work	132	1	1	2017-07-26	2018-01-01	-82.5363771005250015	27.3385937633749982	100	active	{}	2017-07-26 17:58:00	2017-07-26 18:02:23	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(27.338593763374508,-82.5363771005248736)	1608 Fruitville	Sarasota	FL	34236	Sarasota	US	\N
16	e2355850-3868-4f11-94d8-b89a64a216f6	TestProject	Test Project Description	88	1	1	2017-06-16	2017-06-16	75.867057299999999	22.6999977999999984	1000	active	{}	2017-06-16 10:42:26	2017-08-26 07:31:24	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(22.7534700000000001,75.9145039999999938)	Mishika Tower	sarasota	FL	34236	sarasota	US	\N
43	bde87952-12b2-4053-a7f0-da5b068de6b6	newsss	assss	88	1	1	2017-07-27	2017-08-06	75.6463329999999985	27.700012000000001	100	active	{}	2017-07-27 13:44:03	2017-07-27 13:44:47	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(27.700012000000001,75.6463329999999985)	indore	indore	mp	452002	india	india	\N
41	76a78221-7723-49b7-8955-88223494e704	projectnew12	something,.	88	1	1	2017-07-27	2017-08-06	75.8675999999999959	21.6999999999999993	100	active	{}	2017-07-27 11:05:10	2017-07-27 13:52:40	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(21.6999999999999993,75.8675999999999959)	mishika tower	Indore	mp	452002	india	india	\N
40	abd96836-9c74-4365-90bc-0db94d577028	something	aaaa	88	1	1	2017-07-27	2017-07-30	75.8787650999999954	22.7000455999999993	100000	active	{}	2017-07-27 10:52:28	2017-08-09 12:06:42	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(22.7000455999999993,75.8787650999999954)	Mishika Tower	Indore	Mp	452010	India	India	\N
56	105db495-ab36-49c5-ac30-91b1c5365416	gdsfgbdfshdfhdfhdfhdf	hbfdh	88	1	1	2017-08-11	2017-08-11	75.0139999999999958	22.3249999999999993	0	active	{}	2017-08-11 12:56:48	2017-08-11 12:56:48	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	dgdfgdgd	fgdfgdfgdfgdg	ff	455677	gdgdsfg	sdghsd	\N
44	0a280d31-4b14-4b1f-8e63-3e350b898615	Bold	Downtown Office	138	1	1	2017-07-27	2018-10-31	-82.5387781000000018	27.3385348000000015	0	active	{}	2017-07-27 16:24:56	2017-07-27 16:50:24	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(27.3385348000000015,-82.5387781000000018)	1680 Fruitville Rd #304	Sarasota	FL	34236	Sarasota	US	\N
57	2f2a566a-2b10-4ff0-91e6-a97dc9ed59b0	gregsdgsdgsdg	sdgsdgs	88	1	1	2017-08-11	2017-08-11	75.3652000000000015	22.3210000000000015	0	active	{}	2017-08-11 13:49:54	2017-08-11 13:49:54	((22.3210000000000015,75.3652000000000015))	(40,-80)	sdfsdfsfgsgf	sdgsdg	dd	452123	fsadfasfas	fafasdff	\N
58	50eca164-3c64-426a-ac86-99b4a33d58dd	GHDFGDFGDFGFD	HGFD	88	1	1	2017-08-11	2017-08-11	75.4414075561520008	22.3416423283559986	0	active	{}	2017-08-11 14:02:30	2017-08-11 14:04:58	((22.3210000000000015,75.3621000000000549),(22.438924955234814,75.3498655029296742),(22.2903382128699192,75.1445556464066158),(22.0210000000000008,75.2621000000000322),(22.3248111212993976,75.4390042968750549))	(22.3416423283555687,75.4414075561523987)	gdfgdfg	dgdgd	gg	452364	safsdafgsdg	sdgsdhgsjgk	\N
59	98de46a9-7a13-487f-a3c6-8e84ca5a5c70	gdfgedhg	dfhdfh	88	1	1	2017-08-11	2017-08-11	75.3199999999999932	22.3200000000000003	0	active	{}	2017-08-11 14:08:28	2017-08-11 14:08:28	((22.3200000000000003,75.3199999999999932),(22.370000000000001,75.269999999999996),(22.0199999999999996,75.2199999999999989),(22.3200000000000003,75.3199999999999932))	(40,-80)	dghfdhgfdhdfhdh	dfhdfhd	mj	452633	asdfasfas	asfasfggfj	\N
45	8a51a9aa-a902-48d4-8cf7-b31ce10e9fd1	Tampa Airport Marriott	DEMO Tampa Airport Marriott	132	1	1	2017-07-31	2018-01-01	-82.5347502222289933	27.9821654406830014	0	active	{}	2017-07-31 16:47:06	2017-07-31 16:56:26	((27.9823334754114548,-82.5339969987198856),(27.9822638465694666,-82.5351202455213979),(27.9815876537746995,-82.5351385647048232),(27.981530967296024,-82.5339656086162563))	(27.9821654406832039,-82.5347502222290359)	4200 George J. Bean Parkway  Tampa  Florida  33607  USA 	Tampa	FL	33607	Hillsborough	USA	\N
49	d2400e66-d7dd-4f70-a4a1-90d2ccd6c191	hfghfh	hrthrth	88	1	1	2017-08-10	2017-08-10	75.2546300000000059	23.3655000000000008	100	active	{}	2017-08-10 13:03:47	2017-08-10 13:03:47	((40,-25),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	hyrr	yryrfh	tt	452002	yhryr	uuy	\N
46	8a6cc536-3648-4c89-abdc-1f23b43c5ee5	Test Geo Fence	Test	119	1	1	2017-07-31	2018-01-01	-82.0503786000000019	27.0240669999999987	100	inactive	{}	2017-07-31 17:11:44	2017-07-31 17:29:30	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(27.0240669999999987,-82.0503786000000019)	375 Kings Hwy	Port Charlotte	FL	33983	Charlotte	US	2017-07-31 17:29:30
50	284c9f95-42ef-44ba-93f6-c4811af181be	qq	qq	88	1	1	2017-07-31	2017-08-11	74.3652000000000015	22.3219999999999992	0	active	{}	2017-08-11 12:01:36	2017-08-11 12:03:41	((12,-15),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(22.3219999999999992,74.3652000000000015)	qq	qq	qq	256321	qq	qq	\N
47	71448d3f-aeed-4737-a0c4-f67b55440146	Villas of Grand Cypress	Demo Only	132	1	1	2017-08-08	2017-08-08	-81.5272960000000069	28.4037690000000005	0	active	{}	2017-08-08 18:35:21	2017-08-08 18:51:09	((28.4020406151691844,-81.5262198450797086),(28.4070984238186348,-81.525776488845338),(28.4072593000590068,-81.5287518106923699),(28.4015923173450879,-81.5284942914865951))	(40,-80)	1 N Jacaranda St.	Orlando 	FL	32836	Orange	US	\N
51	42c02d94-aa30-486c-a0b5-110111ce546b	asss	aa	88	1	1	2017-08-11	2017-08-11	75.320999999999998	22.2322999999999986	0	active	{}	2017-08-11 12:10:01	2017-08-11 12:10:01	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	aaa	aaa	sa	123654	sss	sss	\N
52	28b8bc73-d80a-46da-a2f1-c97187c7520f	dfsgdsfgg	dsfghhdsfgh	88	1	1	2017-08-11	2017-08-11	75.3211000000000013	22.1230000000000011	0	active	{}	2017-08-11 12:12:37	2017-08-11 12:12:37	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	gdsgsg	sdgsdgsd	dd	123632	sdfasdaf	sfsadfgas	\N
53	2545b23e-a685-4f18-9f82-be0c9316b39b	gfdgfd	dfhbfdhdddfd	88	1	1	2017-08-11	2017-08-11	75.3216000000000037	22.2113000000000014	0	active	{}	2017-08-11 12:14:24	2017-08-11 12:14:24	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	dfhdfhfd	dhdfhdf	ff	452361	cvsdfgvsdg	gsdgsd	\N
54	06c12f3c-8268-4b4b-97a2-4a2454bc525e	dsfgdsg	dsgsdghsd	88	1	1	2017-08-11	2017-08-11	75.2109999999999985	22.3211000000000013	0	active	{}	2017-08-11 12:15:53	2017-08-11 12:15:53	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	ghdsfhgs	sghsdgsd	dd	452136	sdgerg	gsdgsdg	\N
55	fb190f9c-e0d3-41f2-8bf5-16439a407464	dfgfdgbfd	dghdfdf	88	1	1	2017-08-11	2017-08-11	75.320999999999998	22.3210000000000015	0	active	{}	2017-08-11 12:18:15	2017-08-11 12:18:15	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	dfgdfgd	gdfgdfg	ss	452136	fgbdsfghsdfhgsd	hsdhd	\N
48	f2772e1c-3f5c-411e-86b1-b5d1549b1e3b	aaa	aaa	88	1	1	2017-08-10	2017-08-10	-80	40	0	active	{}	2017-08-10 12:59:05	2017-08-11 12:23:20	((40,-80),(40.0499999999999972,-80.0500000000000114),(39.6619515763166675,-80.9404541015625227),(38.9758308930627777,-79.5929606883649967),(39.8483437292217531,-78.516845703125))	(40,-80)	indore	indore	mp	452002	india	india	\N
42	57013f72-d87c-4140-93ec-bf42f2ca0317	somenew123	qqqq	88	1	1	2017-07-27	2017-08-06	75.8969689999999986	22.700012000000001	0	active	{}	2017-07-27 11:34:37	2017-08-11 12:29:51	((22.6844835232180095,75.9415952833473966),(22.6844935173588631,75.8715962166766076),(22.7511737919188981,75.7810498841855633),(22.7679868263233764,75.9026379470145685),(22.7518735001782488,76.0489458950494281),(22.6844835232180095,75.9415952833473966),(22.6844935173588631,75.8715962166766076),(22.6844935173588631,75.8715962166766076),(22.6844935173588631,75.8715962166766076),(22.6844935173588631,75.8715962166766076),(22.6734075883644834,75.8252528932894165),(22.6601020768016355,75.9083121731576966),(22.6643911186751517,75.9395596102461923))	(22.700012000000001,75.8969689999999986)	indore	indore	mp	452002	india	india	\N
62	21a1c9f6-3722-4c4f-a2b9-4c091a5d1642	gdsgds	gdsgdsgdsgg	121	1	1	2017-08-11	2017-08-11	75	25	0	active	{}	2017-08-11 14:38:49	2017-08-18 12:33:21	((22,75),(22.0500000000000007,74.9500000000000028),(21.6999999999999993,74.9000000000000057),(22,75))	(25,75)	gdsgds	gdsgs	uu	452366	dsgdsgdsgs	gsgdsgs	\N
63	188dc936-2cc4-42d2-92a9-97681aa54311	Gecko's	Gecko's Restaurant	119	1	1	2017-08-11	2021-08-01	-82.5268844000000001	27.3040213999999999	100	active	{}	2017-08-11 14:39:17	2017-08-11 14:41:58	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(27.3040213999999999,-82.5268844000000001)	351 N Cattlemen Rd	Sarasota	FL	34232	Sarasota	US	\N
64	476dbb38-2ad2-4a6e-b4b5-9fe6436ed68f	testingpro	testingpro	88	1	1	2017-08-11	2017-08-11	75.8787650000000014	22.7000123000000009	0	active	{}	2017-08-11 14:44:13	2017-08-11 14:44:13	((22.7000123000000009,75.8787650000000014),(22.7500123000000016,75.8287650000000042),(22.4000123000000002,75.778765000000007),(22.7000123000000009,75.8787650000000014))	(40,-80)	testingpro	indore	mp	452002	india	india	\N
66	45db6029-3f13-4d10-9047-68be4b5946d7	Wilde Maserati	Wilde Maserati Auto Dealership	119	1	1	2017-08-11	2020-08-29	-82.4745429999999971	27.2699579000000014	0	active	{}	2017-08-11 14:53:31	2017-08-11 15:02:43	((27.2706468542926537,-82.475834084289545),(27.2690027905220127,-82.4759235389404353),(27.2692133295445238,-82.4731304280880408),(27.2706445192138816,-82.4730838782958244),(27.270689942139466,-82.4748802185058025))	(27.2699579000000014,-82.4745429999999971)	4821 Clark Rd	Sarasota	FL	34233	Sarasota	US	\N
61	33972aa0-c4b3-48a9-a615-85bb8cfd454b	Blue Rooster	Blue Rooster Restaurant	119	1	1	2017-08-11	2020-03-01	-82.5411967999999945	27.3367842000000003	1000	active	{}	2017-08-11 14:27:08	2017-08-16 15:42:07	((27.3327717799082066,-82.5322101046238572),(27.3319967972015867,-82.5475360911042344),(27.3450821289110095,-82.5490864714058716),(27.3443734615803073,-82.5325981451829875))	(27.3367842000000003,-82.5411967999999945)	1525 4th St	Sarasota	FL	34236	Sarsota	US	\N
70	983c1c4c-69af-4a0d-8286-24fa9648b6d6	Lido Beach Resort	Testing Only	132	1	1	2017-08-30	2018-02-01	-82.5729864020999997	27.3072775211320007	0	active	{}	2017-08-30 15:50:54	2017-08-30 15:54:40	((27.3094129159325725,-82.5749604307951017),(27.3066515195407007,-82.5762930944999312),(27.3043465217453551,-82.5731653218607562),(27.3075066382538338,-82.5710137600545977))	(27.3072775211323595,-82.572986402099616)	700 Benjamin Franklin Dr	Sarasota	FL	34236	Sarasota	US	\N
65	03de7b6d-f9ef-4eda-8ad2-6cf81ed5a7ae	Blue Rooster	Demo Only	132	1	1	2017-08-11	2017-08-11	-82.5399177202379946	27.339978853769999	0	active	{}	2017-08-11 14:48:13	2017-08-16 16:21:49	((27.3401606115419149,-82.5400876411590616),(27.3397841419061116,-82.540078724012119),(27.3397793577237493,-82.5397479423675691),(27.3401694614615494,-82.5397031435165331))	(27.3399788537703792,-82.5399177202377246)	1525 4th St	Sarasota	FL	34236	Sarasota	USA	\N
60	2f36630b-50e8-4d2c-9239-9537cf23cd44	Bold Work Offices	Demo Only	132	1	1	2017-08-11	2017-08-31	-82.536320965607004	27.3384200845650014	40	active	{}	2017-08-11 14:19:57	2017-08-31 17:08:00	((27.3392293326256457,-82.5362002849578857),(27.3392477654771007,-82.5368350990799513),(27.3389567715761004,-82.5368252759936922),(27.3387683874212719,-82.536814999926662),(27.3387515521134539,-82.5369549274444694),(27.3384759691408199,-82.5369692802429427),(27.3384668934259487,-82.536468505859375),(27.3381602787851676,-82.5364422824350754),(27.3381515665807733,-82.5362086312468364))	(27.3384200845646532,-82.5363209656067056)	1680 Fruitville Rd	Sarasota	FL	34236	Sarasota	USA	\N
67	5042728c-582e-4269-999e-908c08bc425c	hhh	jgfgjghhj	140	1	1	2017-08-19	2017-08-26	75.8787870000000026	22.7001230000000014	35	active	{}	2017-08-19 07:34:05	2017-08-19 07:34:05	((22.7001230000000014,75.8787870000000026),(22.7501229999999985,75.8287870000000055),(22.4001230000000007,75.7787869999999941),(22.7001230000000014,75.8787870000000026))	(40,-80)	indore	indore	mp	452010	india	india	\N
68	6030856a-1b2c-41d3-ac1e-2e1c07b618ff	ujurtu	trutrurt	121	1	1	2017-08-21	2017-08-21	75.3199999999999932	51.3400000000000034	0	active	{}	2017-08-21 11:20:51	2017-08-21 11:20:51	((51.3400000000000034,75.3199999999999932),(51.3900000000000006,75.269999999999996),(51.0399999999999991,75.2199999999999989),(51.3400000000000034,75.3199999999999932))	(40,-80)	rturtu	utrur	tt	41256	rturr	trktrir	\N
69	48f7f40b-ee17-4778-8a07-5c831bd73c4d	fghfhdh	dfhdfhdfh	121	1	1	2017-08-21	2017-08-21	-80	40	100	active	{}	2017-08-21 11:26:19	2017-08-21 11:26:19	((40,-80),(40.0499999999999972,-80.0499999999999972),(39.7000000000000028,-80.0999999999999943),(40,-80))	(40,-80)	hdfhddh	hdh	ff	78997	dhd	hdfhdhdd	\N
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('projects_id_seq', 70, true);


--
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY reports (id, uniq_id, report_number, name, permissions, jdoc, created_at, updated_at, deleted_at) FROM stdin;
1	d2cb6670-dc30-48f5-b3c3-662b2fe4ce72	RPT-500	Estimated Payroll	{"user": false, "admin": false, "superuser": false, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
2	029bb68b-6b1e-434f-aee0-309e982ba338	RPT-100	Client Summary	{"user": false, "admin": false, "superuser": false, "superadmin": true, "clientadmin": false}	{}	\N	\N	\N
3	ce995ad8-a9cc-4b0c-984d-2328efef0ffe	RPT-101	Client Detail	{"user": false, "admin": false, "superuser": false, "superadmin": true, "clientadmin": false}	{}	\N	\N	\N
4	cda523e7-dcdf-446f-903e-6359b32d0837	RPT-200	Company Summary	{"user": false, "admin": true, "superuser": false, "superadmin": true, "clientadmin": true}	{}	\N	\N	\N
5	0c397f5b-0c6c-4886-b90e-7b9811579133	RPT-201	Company Detail	{"user": false, "admin": true, "superuser": false, "superadmin": true, "clientadmin": true}	{}	\N	\N	\N
6	0d7bd1c0-d7be-4795-bc1a-26ca793ee681	RPT-300	Project Hours Summary	{"user": false, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
7	b5a446ab-e5c1-467b-8d0b-208c96e15d9c	RPT-301	Project Hours Detail	{"user": false, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
8	212da9b3-27cb-4772-afe0-cd62aed45b32	RPT-302	Project Employees Onsite	{"user": false, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
9	7ac2ca43-080c-4b7d-98c5-5131d029039b	RPT-400	Employee Timesheet	{"user": true, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
10	a9645c43-9f7c-4e3a-8a1d-c12dee405d17	RPT-401	Employee Punches	{"user": true, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
11	f4bfcb9c-58e2-4425-b405-1f81d96bf292	RPT-402	Employee Detail	{"user": true, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
12	da82c56e-946c-47b1-a140-32e17a1a443e	RPT-403	Employee Late	{"user": true, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
13	b5fdba37-5472-4d55-a539-f4927f048677	RPT-404	Employee Overtime	{"user": true, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
14	bca9c450-7a41-44e8-b38a-1e34cf25dafc	RPT-405	Employee geo-fence	{"user": true, "admin": true, "superuser": true, "superadmin": false, "clientadmin": true}	{}	\N	\N	\N
\.


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

COPY user_logs (id, uniq_id, user_id, project_id, note, type, "dateTime", created_at, updated_at, check_id) FROM stdin;
8	32b7507e-5581-4f29-b13c-c317b9e6c8f4	135	16	virtual-gate	punch-in exception	2017-06-16 13:46:29	2017-06-16 13:46:28	2017-06-16 13:46:28	279
9	646a4d99-3a3f-455d-9659-df86879639a9	135	16	gbvvbbb	punch out exception	2017-06-16 13:51:31	2017-06-16 13:51:31	2017-06-16 13:51:31	279
10	85b14e21-269a-484c-9d64-262541321f00	2	17	hello	punch out exception	2017-06-16 14:17:48	2017-06-16 14:17:47	2017-06-16 14:17:47	280
13	ce40669a-0009-4f56-b78e-8a7b8901de49	135	16	ghvcf	punch-in exception	2017-06-20 11:01:29	2017-06-20 11:01:29	2017-06-20 11:01:29	282
14	07493f06-3dac-4d07-a0fe-b414224f8137	135	16	hhj	punch out exception	2017-06-21 06:34:58	2017-06-21 06:34:57	2017-06-21 06:34:57	282
15	04905589-3062-47f6-89d5-a621cc1fec3d	170	18	virtual-gate	punch-in exception	2017-07-05 20:26:13	2017-07-05 20:26:12	2017-07-05 20:26:12	331
16	7ecf3437-5d72-4969-8f8f-0b05f7eb7554	173	18	virtual-gate	punch-in exception	2017-07-05 20:26:18	2017-07-05 20:26:18	2017-07-05 20:26:18	332
17	08799b0b-9a9c-471a-b0ea-60b853d81a71	174	18	virtual-gate	punch-in exception	2017-07-05 20:26:23	2017-07-05 20:26:22	2017-07-05 20:26:22	333
18	b9bd2232-b2ca-42d8-9164-1e4c888cdcbd	175	18	virtual-gate	punch-in exception	2017-07-05 20:26:26	2017-07-05 20:26:26	2017-07-05 20:26:26	334
19	d7cf2559-0e70-497c-aba6-8dba6b2866a3	177	18	virtual-gate	punch-in exception	2017-07-05 20:58:48	2017-07-05 20:58:47	2017-07-05 20:58:47	335
20	8b16302e-5fd3-443a-9ac1-259434b4413a	178	18	virtual-gate	punch-in exception	2017-07-05 20:58:52	2017-07-05 20:58:52	2017-07-05 20:58:52	336
21	f67c43fd-13e1-4790-9973-81548c6a930b	179	18	virtual-gate	punch-in exception	2017-07-05 21:00:26	2017-07-05 21:00:25	2017-07-05 21:00:25	337
22	22d35c5e-a263-4a18-b50a-2e8f3c923560	180	18	virtual-gate	punch-in exception	2017-07-05 21:00:30	2017-07-05 21:00:29	2017-07-05 21:00:29	338
23	0321df5c-f2aa-4678-8273-887887e212e5	173	18	virtual-gate	punch out exception	2017-07-05 21:05:37	2017-07-05 21:05:36	2017-07-05 21:05:36	\N
24	2044499d-97a5-4a77-b1b1-17867c5f7c01	174	18	virtual-gate	punch out exception	2017-07-05 21:05:42	2017-07-05 21:05:41	2017-07-05 21:05:41	\N
25	54d3b2ff-f06e-4ed4-898f-db32e812f9e7	175	18	virtual-gate	punch out exception	2017-07-05 21:05:45	2017-07-05 21:05:44	2017-07-05 21:05:44	\N
26	0540aa49-07d8-4a2c-b45a-e3753df7dc22	177	18	virtual-gate	punch out exception	2017-07-05 21:05:48	2017-07-05 21:05:48	2017-07-05 21:05:48	\N
27	ba4bae6b-1711-410c-8242-d5b954cfde7a	178	18	virtual-gate	punch out exception	2017-07-05 21:05:52	2017-07-05 21:05:51	2017-07-05 21:05:51	\N
28	aa5feaad-5a08-43e5-8e06-5ded19655bdf	179	18	virtual-gate	punch out exception	2017-07-05 21:05:55	2017-07-05 21:05:54	2017-07-05 21:05:54	\N
29	efb64fa0-ae33-4727-b55a-56cfc71d4ec9	180	18	virtual-gate	punch out exception	2017-07-05 21:05:58	2017-07-05 21:05:57	2017-07-05 21:05:57	\N
30	072416a8-7ae6-4ef4-be8a-2b5db3c3e625	170	18	virtual-gate	punch out exception	2017-07-05 21:07:06	2017-07-05 21:07:06	2017-07-05 21:07:06	\N
31	d26c75c2-60ac-449d-b056-8a7b1b5fc8e0	157	18	virtual-gate	punch-in exception	2017-07-05 21:20:23	2017-07-05 21:20:23	2017-07-05 21:20:23	339
32	8e136e09-5475-4826-96b1-64fa9ac7d1c5	157	18	virtual-gate	punch out exception	2017-07-05 21:35:52	2017-07-05 21:35:51	2017-07-05 21:35:51	\N
33	981c43a2-c585-42a7-b66b-ac2512e36b6a	170	18	virtual-gate	punch-in exception	2017-07-06 15:40:22	2017-07-06 15:40:21	2017-07-06 15:40:21	340
34	a96c6698-54b5-42b3-90d7-e5370bcca39e	180	18	virtual-gate	punch-in exception	2017-07-06 15:40:26	2017-07-06 15:40:25	2017-07-06 15:40:25	341
35	3514212d-6d11-4bdb-a63b-0b06e3715144	178	18	virtual-gate	punch-in exception	2017-07-06 15:40:30	2017-07-06 15:40:30	2017-07-06 15:40:30	342
36	f7c4cca7-f391-4570-9fea-2d071dde18e2	179	18	virtual-gate	punch-in exception	2017-07-06 15:40:35	2017-07-06 15:40:34	2017-07-06 15:40:34	343
37	5003a2c1-17fa-4f6e-abdd-ddcd9ae0b6de	182	18	virtual-gate	punch-in exception	2017-07-06 15:40:39	2017-07-06 15:40:38	2017-07-06 15:40:38	344
38	474109f4-08bb-41e0-89c4-ecf58c506842	183	18	virtual-gate	punch-in exception	2017-07-06 15:40:43	2017-07-06 15:40:42	2017-07-06 15:40:42	345
39	26dc4036-a08e-4789-a8a7-970cf7a7037f	173	22	virtual-gate	punch-in exception	2017-07-06 15:41:00	2017-07-06 15:40:59	2017-07-06 15:40:59	346
40	a321b984-7453-4aa6-b356-47e005e0cb6e	170	18	virtual-gate	punch out exception	2017-07-06 15:45:14	2017-07-06 15:45:13	2017-07-06 15:45:13	\N
41	9425f2a0-b99c-4127-b879-11108ecd32b0	180	18	virtual-gate	punch out exception	2017-07-06 15:45:18	2017-07-06 15:45:18	2017-07-06 15:45:18	\N
42	141ce9f1-32f5-4d39-8e45-082c07643e2b	178	18	virtual-gate	punch out exception	2017-07-06 15:46:00	2017-07-06 15:46:00	2017-07-06 15:46:00	\N
43	a7216432-7c06-4e43-818e-ca20827c0ed2	179	18	virtual-gate	punch out exception	2017-07-06 15:46:03	2017-07-06 15:46:03	2017-07-06 15:46:03	\N
44	127918d0-ac5d-48db-bec7-aed3976b8429	182	18	virtual-gate	punch out exception	2017-07-06 15:46:08	2017-07-06 15:46:07	2017-07-06 15:46:07	\N
45	3bdd9e80-dc43-47eb-8ffe-1a04cdf63e44	183	18	virtual-gate	punch out exception	2017-07-06 15:46:11	2017-07-06 15:46:11	2017-07-06 15:46:11	\N
46	de62c964-e985-4b55-b767-c940c97b626d	173	22	virtual-gate	punch out exception	2017-07-06 15:46:22	2017-07-06 15:46:22	2017-07-06 15:46:22	\N
47	3a67b92d-0164-49de-8fc5-dc460b1b007e	173	22	virtual-gate	punch-in exception	2017-07-06 15:48:27	2017-07-06 15:48:26	2017-07-06 15:48:26	347
48	70d72f00-7b46-4fc5-860c-c0fe3d09ab1b	174	22	virtual-gate	punch-in exception	2017-07-06 15:48:30	2017-07-06 15:48:30	2017-07-06 15:48:30	348
49	90edb0e5-b9a4-4b59-8282-123d31214968	177	22	virtual-gate	punch-in exception	2017-07-06 15:48:35	2017-07-06 15:48:34	2017-07-06 15:48:34	349
50	cb8b0212-fd43-4562-b936-6565736d9afa	180	22	virtual-gate	punch-in exception	2017-07-06 15:48:38	2017-07-06 15:48:37	2017-07-06 15:48:37	350
51	670f1ae8-767e-4e9c-9a86-f60d96cb9212	181	22	virtual-gate	punch-in exception	2017-07-06 15:48:41	2017-07-06 15:48:40	2017-07-06 15:48:40	351
52	0b8149fe-fece-4826-900f-5b51eb69d101	184	22	virtual-gate	punch-in exception	2017-07-06 15:48:44	2017-07-06 15:48:43	2017-07-06 15:48:43	352
53	6617ce17-ca42-4f84-8587-d33a76756279	170	18	virtual-gate	punch-in exception	2017-07-06 15:48:55	2017-07-06 15:48:55	2017-07-06 15:48:55	353
54	d2ef10a8-b333-421b-947a-5e2dafe15dd6	175	18	virtual-gate	punch-in exception	2017-07-06 15:48:59	2017-07-06 15:48:59	2017-07-06 15:48:59	354
55	663ef787-1e89-4966-a3ed-7e4b1339df80	178	18	virtual-gate	punch-in exception	2017-07-06 15:49:02	2017-07-06 15:49:02	2017-07-06 15:49:02	355
56	358f2085-5d04-426c-aed0-b6706200332d	179	18	virtual-gate	punch-in exception	2017-07-06 15:49:06	2017-07-06 15:49:05	2017-07-06 15:49:05	356
57	6755ebca-19d5-4f80-bb35-d53761fa368a	182	18	virtual-gate	punch-in exception	2017-07-06 15:49:10	2017-07-06 15:49:10	2017-07-06 15:49:10	357
58	1c441f01-dc25-4a99-961e-64fe822790a9	183	18	virtual-gate	punch-in exception	2017-07-06 15:49:13	2017-07-06 15:49:12	2017-07-06 15:49:12	358
59	d456e843-8392-4a15-a284-1561d69a9fbc	157	22	virtual-gate	punch-in exception	2017-07-06 15:50:12	2017-07-06 15:50:11	2017-07-06 15:50:11	359
60	57b10cd0-f1bf-4b15-8bf2-651feddeaef1	176	20	virtual-gate	punch-in exception	2017-07-06 17:19:51	2017-07-06 17:19:50	2017-07-06 17:19:50	360
61	324246dd-ad50-4aa6-9647-931bb2e55a2d	176	20	virtual-gate	punch-in exception	2017-07-06 17:35:38	2017-07-06 17:35:37	2017-07-06 17:35:37	361
62	fa9fef94-5883-4e55-a44c-53dfcb4db20a	157	22	virtual-gate	punch-in exception	2017-07-06 17:58:44	2017-07-06 17:58:44	2017-07-06 17:58:44	362
63	ee27066d-c3f0-4018-a4f2-be8017936655	157	22	virtual-gate	punch-in exception	2017-07-06 17:59:20	2017-07-06 17:59:20	2017-07-06 17:59:20	363
64	7f139540-832e-4df4-a1c2-88671d28f067	157	22	virtual-gate	punch-in exception	2017-07-06 18:00:28	2017-07-06 18:00:27	2017-07-06 18:00:27	364
65	c492c28e-b286-43c9-9b71-b76803f438f5	157	22	virtual-gate	punch-in exception	2017-07-06 18:01:57	2017-07-06 18:01:56	2017-07-06 18:01:56	365
66	e2958e23-6602-40a4-a22c-c909e02cc5cf	176	20	virtual-gate	punch-in exception	2017-07-06 18:02:40	2017-07-06 18:02:39	2017-07-06 18:02:39	366
67	d0ce89d2-940e-4a92-96a6-64037f64a907	173	22	virtual-gate	punch out exception	2017-07-06 18:14:25	2017-07-06 18:14:25	2017-07-06 18:14:25	\N
68	340a1dcf-5bbe-4bf8-bcb2-b5ee1b6e9673	174	22	virtual-gate	punch out exception	2017-07-06 18:14:29	2017-07-06 18:14:29	2017-07-06 18:14:29	\N
69	7569c0d5-9836-4e0b-840c-2b55ffa63171	177	22	virtual-gate	punch out exception	2017-07-06 18:14:35	2017-07-06 18:14:35	2017-07-06 18:14:35	\N
70	888ffa54-70f8-4d91-807d-547f6b6d75ad	180	22	virtual-gate	punch out exception	2017-07-06 18:14:42	2017-07-06 18:14:42	2017-07-06 18:14:42	\N
71	cc06297d-f5fa-47c7-9e46-898455445006	181	22	virtual-gate	punch out exception	2017-07-06 18:14:47	2017-07-06 18:14:46	2017-07-06 18:14:46	\N
72	115ed6d4-fcd0-4171-8bdf-4781e33f1e46	184	22	virtual-gate	punch out exception	2017-07-06 18:14:52	2017-07-06 18:14:52	2017-07-06 18:14:52	\N
73	79bc64b6-2dab-40ae-9881-00100dc718d6	157	22	virtual-gate	punch out exception	2017-07-06 18:15:02	2017-07-06 18:15:01	2017-07-06 18:15:01	\N
74	29a5e247-e52a-4505-9317-cbf134b800ba	170	18	virtual-gate	punch out exception	2017-07-06 18:16:09	2017-07-06 18:16:08	2017-07-06 18:16:08	\N
75	2e6db905-a1eb-42a2-98b0-3f38b8766a1c	175	18	virtual-gate	punch out exception	2017-07-06 18:16:13	2017-07-06 18:16:12	2017-07-06 18:16:12	\N
76	4c1678cd-8c92-465d-a23a-d8d70f2ca1a1	178	18	virtual-gate	punch out exception	2017-07-06 18:16:17	2017-07-06 18:16:16	2017-07-06 18:16:16	\N
77	1816d9f5-2ba1-4c1f-a3fe-6b268f9efb57	179	18	virtual-gate	punch out exception	2017-07-06 18:16:22	2017-07-06 18:16:21	2017-07-06 18:16:21	\N
78	5bd937af-b58c-4fb4-9a4f-9438d748b57f	182	18	virtual-gate	punch out exception	2017-07-06 18:16:26	2017-07-06 18:16:26	2017-07-06 18:16:26	\N
79	f9b9990e-7c34-4643-8d49-1804a658e93f	183	18	virtual-gate	punch out exception	2017-07-06 18:16:31	2017-07-06 18:16:30	2017-07-06 18:16:30	\N
80	51744416-0fc3-4aea-9e09-f5ff2dbbc97a	170	18	virtual-gate	punch-in exception	2017-07-06 18:17:57	2017-07-06 18:17:56	2017-07-06 18:17:56	367
81	536bc25f-9b40-4cc0-bdd1-bf19f380c87a	175	18	virtual-gate	punch-in exception	2017-07-06 18:18:00	2017-07-06 18:18:00	2017-07-06 18:18:00	368
82	def6f0ff-ef07-46b8-ac70-e22dcbadb008	178	18	virtual-gate	punch-in exception	2017-07-06 18:18:05	2017-07-06 18:18:05	2017-07-06 18:18:05	369
83	c04399b5-54aa-429a-a633-b71c030b89c3	179	18	virtual-gate	punch-in exception	2017-07-06 18:18:08	2017-07-06 18:18:08	2017-07-06 18:18:08	370
84	062a0762-ceab-46c4-bd8c-f5d6cec980db	182	18	virtual-gate	punch-in exception	2017-07-06 18:18:14	2017-07-06 18:18:13	2017-07-06 18:18:13	371
85	5a6497ba-65d0-4b8c-a4ae-e126458bea7b	183	18	virtual-gate	punch-in exception	2017-07-06 18:18:16	2017-07-06 18:18:16	2017-07-06 18:18:16	372
86	cb0654db-f44d-424c-9386-8ceb71149b65	157	18	virtual-gate	punch-in exception	2017-07-06 18:18:30	2017-07-06 18:18:30	2017-07-06 18:18:30	373
87	a1c3c58f-ba4b-44a5-9bd1-cc743c8e4795	173	22	virtual-gate	punch-in exception	2017-07-06 18:18:40	2017-07-06 18:18:39	2017-07-06 18:18:39	374
88	fda898f4-287e-4740-b30c-b8dffd4e7920	174	22	virtual-gate	punch-in exception	2017-07-06 18:18:42	2017-07-06 18:18:42	2017-07-06 18:18:42	375
89	4d919b83-cef3-4607-aa9a-e364dc17fcd3	177	22	virtual-gate	punch-in exception	2017-07-06 18:18:48	2017-07-06 18:18:47	2017-07-06 18:18:47	376
90	0983aa02-e46a-4931-8c0d-eed48c270d8c	180	22	virtual-gate	punch-in exception	2017-07-06 18:18:50	2017-07-06 18:18:50	2017-07-06 18:18:50	377
91	0ec14a10-91b7-41a8-909e-77e64ede9262	181	22	virtual-gate	punch-in exception	2017-07-06 18:18:54	2017-07-06 18:18:53	2017-07-06 18:18:53	378
92	2ea75b82-6639-4f81-b21c-acfa5c638956	184	22	virtual-gate	punch-in exception	2017-07-06 18:18:57	2017-07-06 18:18:56	2017-07-06 18:18:56	379
93	50db03fb-67e4-43cb-af0b-e7b5db0554a6	176	20	virtual-gate	punch-in exception	2017-07-06 18:24:09	2017-07-06 18:24:09	2017-07-06 18:24:09	380
94	5ad9b288-5e90-4c42-90b8-25b644f8b7b3	166	20	virtual-gate	punch-in exception	2017-07-06 19:28:23	2017-07-06 19:28:22	2017-07-06 19:28:22	381
95	69290a83-deaf-4992-9f10-19f4f414c823	166	20	virtual-gate	punch-in exception	2017-07-06 19:32:15	2017-07-06 19:32:15	2017-07-06 19:32:15	382
96	88d24826-8861-4d89-a065-44a04a18d722	169	20	virtual-gate	punch-in exception	2017-07-06 19:39:42	2017-07-06 19:39:41	2017-07-06 19:39:41	383
97	bc35e1b6-f147-4bf8-8242-fe7885301e78	171	20	virtual-gate	punch-in exception	2017-07-06 19:39:49	2017-07-06 19:39:48	2017-07-06 19:39:48	384
98	63e6850c-5b07-4080-9a12-773fdaf9a8e7	173	22	virtual-gate	punch out exception	2017-07-06 20:22:44	2017-07-06 20:22:43	2017-07-06 20:22:43	\N
99	f409c4cc-5d86-4607-b17c-d10578393793	174	22	virtual-gate	punch out exception	2017-07-06 20:22:48	2017-07-06 20:22:48	2017-07-06 20:22:48	\N
100	c3ed2b10-0ff9-4e05-a560-cbcc9621422d	177	22	virtual-gate	punch out exception	2017-07-06 20:22:55	2017-07-06 20:22:54	2017-07-06 20:22:54	\N
101	8e846e7a-de90-4065-aece-68507a4e3ea0	180	22	virtual-gate	punch out exception	2017-07-06 20:23:00	2017-07-06 20:22:59	2017-07-06 20:22:59	\N
102	b316c01f-175f-4929-8e15-461419a8fd21	181	22	virtual-gate	punch out exception	2017-07-06 20:23:04	2017-07-06 20:23:03	2017-07-06 20:23:03	\N
103	19401996-ab6b-4d96-a0b3-0709d4cb4856	184	22	virtual-gate	punch out exception	2017-07-06 20:23:08	2017-07-06 20:23:07	2017-07-06 20:23:07	\N
104	7b09375a-e071-4965-a9eb-f51019860c88	170	18	virtual-gate	punch out exception	2017-07-06 20:23:21	2017-07-06 20:23:20	2017-07-06 20:23:20	\N
105	b15d2587-e0e5-4581-8c8a-5e221250c8f0	175	18	virtual-gate	punch out exception	2017-07-06 20:23:24	2017-07-06 20:23:23	2017-07-06 20:23:23	\N
106	e07b3966-96c9-4ec1-aaba-c5fb98836deb	178	18	virtual-gate	punch out exception	2017-07-06 20:23:27	2017-07-06 20:23:26	2017-07-06 20:23:26	\N
107	fec0ac92-99ee-4ebd-b92d-b8023fdee388	179	18	virtual-gate	punch out exception	2017-07-06 20:23:30	2017-07-06 20:23:29	2017-07-06 20:23:29	\N
108	cae7f95b-14d5-424b-b6d4-38ca5675d91f	182	18	virtual-gate	punch out exception	2017-07-06 20:23:33	2017-07-06 20:23:33	2017-07-06 20:23:33	\N
109	ad01d5c1-6905-4c34-a72e-d3e7aa41e89f	183	18	virtual-gate	punch out exception	2017-07-06 20:23:36	2017-07-06 20:23:36	2017-07-06 20:23:36	\N
110	c949d718-95a8-4ff3-a188-78d2af8c83f2	157	18	fuufu	punch out exception	2017-07-06 20:23:57	2017-07-06 20:23:56	2017-07-06 20:23:56	373
111	5bff661f-b6e5-4dff-a421-0fb3945fbb62	133	16	uhjj	punch-in exception	2017-07-07 07:26:45	2017-07-07 07:26:44	2017-07-07 07:26:44	385
112	66b0bf9d-bfde-4cc2-9607-6a015a621a83	133	16	hjnn	punch out exception	2017-07-07 07:30:13	2017-07-07 07:30:13	2017-07-07 07:30:13	385
113	d7c085a8-7441-47d1-acb6-402576a37aed	2	17	vnbhh	punch out exception	2017-07-10 13:03:26	2017-07-10 13:03:26	2017-07-10 13:03:26	391
114	63054a51-5434-4e4e-9754-89c7010b2168	2	17	hhnbb	punch out exception	2017-07-10 13:06:04	2017-07-10 13:06:03	2017-07-10 13:06:03	392
117	e494b46e-cacd-4eb8-b3dc-204d059b8863	169	20	virtual-gate	punch out exception	2017-07-10 19:37:58	2017-07-10 19:37:58	2017-07-10 19:37:58	\N
118	e0fd2b9d-4268-4d66-b6ab-28195fe3b237	176	20	virtual-gate	punch out exception	2017-07-10 19:38:04	2017-07-10 19:38:03	2017-07-10 19:38:03	\N
119	961e01b7-9dcf-4634-bd26-9753bf2306c3	171	20	virtual-gate	punch out exception	2017-07-10 19:38:09	2017-07-10 19:38:08	2017-07-10 19:38:08	\N
120	8013eea0-b105-4d8d-80b5-8b7f4c5bb266	166	20	virtual-gate	punch out exception	2017-07-10 19:38:38	2017-07-10 19:38:37	2017-07-10 19:38:37	\N
121	4449c5d0-adbb-453d-a751-9abfcf5ecae4	176	20	virtual-gate	punch-in exception	2017-07-10 20:01:34	2017-07-10 20:01:34	2017-07-10 20:01:34	407
129	121fb984-7f89-4fd7-8796-66002d99a60b	176	20	virtual-gate	punch-in exception	2017-07-11 15:22:20	2017-07-11 15:22:20	2017-07-11 15:22:20	419
131	96061612-0273-4b3a-96cc-6f8f80b8a6cd	202	20	virtual-gate	punch-in exception	2017-07-14 14:54:13	2017-07-14 14:54:12	2017-07-14 14:54:12	421
132	7d60a6fe-9f4c-4587-9b01-d6463c08fa24	202	20	virtual-gate	punch out exception	2017-07-14 15:38:56	2017-07-14 15:38:55	2017-07-14 15:38:55	\N
133	a3a9dffa-92fd-471c-a48c-1547baaf6c5c	202	20	virtual-gate	punch-in exception	2017-07-14 15:39:00	2017-07-14 15:38:59	2017-07-14 15:38:59	422
134	55dffe07-609d-49e6-9865-6c3d2a5dd85b	202	20	virtual-gate	punch out exception	2017-07-14 15:39:01	2017-07-14 15:39:01	2017-07-14 15:39:01	\N
135	6f4eed03-f9fd-4b0f-938f-a54d9ecf5579	202	20	virtual-gate	punch-in exception	2017-07-14 15:39:04	2017-07-14 15:39:04	2017-07-14 15:39:04	423
136	b9491297-b92d-42a3-a9ef-14fe23da6372	209	25	virtual-gate	punch-in exception	2017-07-17 18:05:29	2017-07-17 18:05:28	2017-07-17 18:05:28	426
137	ed51dee6-c1a8-49e2-99da-732b41fe100c	210	25	virtual-gate	punch-in exception	2017-07-17 18:06:01	2017-07-17 18:06:01	2017-07-17 18:06:01	427
138	c0aa6ebd-56ec-4b24-97fe-c4d497e87228	211	25	virtual-gate	punch-in exception	2017-07-17 18:06:07	2017-07-17 18:06:06	2017-07-17 18:06:06	428
139	62b7fe8c-2b48-4155-a79a-0bc9f192106f	212	25	virtual-gate	punch-in exception	2017-07-17 18:06:12	2017-07-17 18:06:12	2017-07-17 18:06:12	429
140	77823c6d-aff9-4c87-bb17-7019a17bfa26	213	25	virtual-gate	punch-in exception	2017-07-17 18:06:26	2017-07-17 18:06:26	2017-07-17 18:06:26	430
141	7e196bbd-6588-4ed6-af63-f1d480d98b7a	214	25	virtual-gate	punch-in exception	2017-07-17 18:06:32	2017-07-17 18:06:31	2017-07-17 18:06:31	431
142	aaf71b70-538e-4d17-b400-7af444448a1d	215	25	virtual-gate	punch-in exception	2017-07-17 18:06:36	2017-07-17 18:06:35	2017-07-17 18:06:35	432
143	6d28bdcf-b8ba-4cca-a137-77a724214f5d	216	25	virtual-gate	punch-in exception	2017-07-17 18:06:42	2017-07-17 18:06:42	2017-07-17 18:06:42	433
144	2407037f-ad28-4fb4-9c09-fde636c866ed	213	25	virtual-gate	punch out exception	2017-07-17 19:45:02	2017-07-17 19:45:02	2017-07-17 19:45:02	\N
145	27d70506-a196-4f28-8391-6d1bbbe3bfa2	214	25	virtual-gate	punch out exception	2017-07-17 19:45:07	2017-07-17 19:45:06	2017-07-17 19:45:06	\N
146	405be7c9-5ecc-4d3a-be29-f4c861300682	215	25	virtual-gate	punch out exception	2017-07-17 19:45:14	2017-07-17 19:45:13	2017-07-17 19:45:13	\N
147	a2d59f08-e746-4c84-a3c8-e5b577949ec3	216	25	virtual-gate	punch out exception	2017-07-17 19:45:20	2017-07-17 19:45:20	2017-07-17 19:45:20	\N
148	39a661bb-c08d-4c3d-9164-be26a722c5a0	209	25	virtual-gate	punch out exception	2017-07-17 19:46:13	2017-07-17 19:46:12	2017-07-17 19:46:12	\N
149	641b9707-ad57-4b1e-99ca-797922bdd27e	157	22	tdbtfgg	punch-in exception	2017-07-20 15:18:07	2017-07-20 15:18:07	2017-07-20 15:18:07	483
150	5fbb970e-4628-4744-981e-57aeb7fe74d2	173	22	Badge input	punch-in exception	2017-07-20 15:28:07	2017-07-20 15:28:07	2017-07-20 15:28:07	485
151	92ec2b75-c291-46ca-9f31-c7e6e3a4d7aa	174	22	Badge input	punch-in exception	2017-07-20 15:28:13	2017-07-20 15:28:12	2017-07-20 15:28:12	486
152	c376b70b-cce8-4c1b-8943-4191ac9161f1	177	22	Badge input	punch-in exception	2017-07-20 15:28:17	2017-07-20 15:28:16	2017-07-20 15:28:16	487
153	de5536ec-d8e1-4eae-93c5-cdcdd4de6542	184	22	QR input	punch-in exception	2017-07-20 15:30:35	2017-07-20 15:30:34	2017-07-20 15:30:34	488
154	32d587cb-0828-497c-809e-ad2dd6ba3a9b	181	22	QR input	punch-in exception	2017-07-20 15:31:21	2017-07-20 15:31:20	2017-07-20 15:31:20	489
155	9d92af91-b502-4067-959d-548edcb822b3	180	22	virtual-gate	punch-in exception	2017-07-20 15:33:06	2017-07-20 15:33:05	2017-07-20 15:33:05	490
156	1ad183b0-bbe6-43f1-af51-83f8a3672f49	157	18	ggggffsfj	punch-in exception	2017-07-20 15:33:34	2017-07-20 15:33:33	2017-07-20 15:33:33	491
157	29a12e6e-6fa4-401d-9cfd-cd08c3c844f0	170	18	QR input	punch-in exception	2017-07-20 15:34:09	2017-07-20 15:34:09	2017-07-20 15:34:09	492
158	81019248-153f-4672-bdec-022db19b1745	175	18	Badge input	punch-in exception	2017-07-20 15:34:20	2017-07-20 15:34:19	2017-07-20 15:34:19	493
159	017cd39a-faaf-4c6a-a0eb-29bc6cdfd777	178	18	Badge input	punch-in exception	2017-07-20 15:34:25	2017-07-20 15:34:25	2017-07-20 15:34:25	494
160	6b46d465-35ab-458d-b0da-6c5b0de17104	179	18	Badge input	punch-in exception	2017-07-20 15:34:31	2017-07-20 15:34:30	2017-07-20 15:34:30	495
161	c794c7c0-6810-406f-9109-901469f1316b	182	18	Badge input	punch-in exception	2017-07-20 15:34:37	2017-07-20 15:34:37	2017-07-20 15:34:37	496
162	f8a2bc5a-5a30-411a-b2c7-49d47fe1e508	183	18	Badge input	punch-in exception	2017-07-20 15:34:43	2017-07-20 15:34:43	2017-07-20 15:34:43	497
163	d698d624-8dfd-4dfa-bbe9-aad9a0642409	157	18	khddg	punch out exception	2017-07-20 15:35:43	2017-07-20 15:35:42	2017-07-20 15:35:42	491
164	eb964090-862d-45f2-9fb8-e156311ad04e	214	25	QR input	punch out exception	2017-07-20 19:02:20	2017-07-20 19:02:19	2017-07-20 19:02:19	\N
165	ab5a9627-fe7b-44cc-8f6e-7669c42bc927	214	25	QR input	punch out exception	2017-07-20 19:05:22	2017-07-20 19:05:22	2017-07-20 19:05:22	\N
166	1f230766-c1c8-4052-96a3-2514606cc06c	208	25	at home boss	punch out exception	2017-07-20 21:20:57	2017-07-20 21:20:56	2017-07-20 21:20:56	503
167	3aacd617-2a83-4e97-9ac8-422c807ebab1	214	25	test	punch-in exception	2017-07-20 21:22:55	2017-07-20 21:22:54	2017-07-20 21:22:54	505
168	178a5564-d870-444e-bbc1-a14b18c38a1e	215	25	hi	punch-in exception	2017-07-20 21:38:44	2017-07-20 21:38:44	2017-07-20 21:38:44	506
169	8d3202ba-f90c-468d-a095-6aca74757713	216	25	bar	punch-in exception	2017-07-20 21:39:08	2017-07-20 21:39:08	2017-07-20 21:39:08	507
170	10afa8cc-8c21-44aa-b93e-44de3d48edff	213	25	with him	punch-in exception	2017-07-20 21:39:42	2017-07-20 21:39:41	2017-07-20 21:39:41	508
171	40341e34-6b59-4014-a4ce-b841c45f1075	213	25	coffee	punch out exception	2017-07-21 15:18:37	2017-07-21 15:18:36	2017-07-21 15:18:36	508
172	136c2322-8762-4924-8431-e13890e7a419	214	25	nope	punch out exception	2017-07-21 15:19:44	2017-07-21 15:19:44	2017-07-21 15:19:44	505
173	28b49d42-5a09-41d1-9bba-9e034dde0bf9	215	25	hahaha	punch out exception	2017-07-21 15:20:21	2017-07-21 15:20:21	2017-07-21 15:20:21	506
174	c0ae2510-4be1-45ff-9b23-ec8a438243ff	216	25	at bar	punch out exception	2017-07-21 15:20:48	2017-07-21 15:20:47	2017-07-21 15:20:47	507
175	9dac6801-689b-4276-9d90-9fd19dac8766	210	25	hi boss getting parts!	punch out exception	2017-07-21 15:22:24	2017-07-21 15:22:23	2017-07-21 15:22:23	504
176	8a29a69b-9b0f-4ff1-901a-e55095114f04	208	25	home	punch-in exception	2017-07-21 17:26:36	2017-07-21 17:26:35	2017-07-21 17:26:35	509
177	26c40ae9-f51b-4804-b7dd-852aaf445910	208	25	yep	punch out exception	2017-07-21 20:15:39	2017-07-21 20:15:39	2017-07-21 20:15:39	509
178	e4ec2dca-4d41-432f-87cf-653601967e83	216	25	x	punch-in exception	2017-07-21 20:35:13	2017-07-21 20:35:12	2017-07-21 20:35:12	510
179	d1587f6a-9911-4d71-8853-ecc63ce2db77	216	25	beer 30	punch out exception	2017-07-21 21:45:13	2017-07-21 21:45:12	2017-07-21 21:45:12	510
180	cece202b-af2d-4f76-87b1-9b5f0d438ce2	208	25	home	punch-in exception	2017-07-22 15:18:03	2017-07-22 15:18:02	2017-07-22 15:18:02	511
181	67b812ad-9c71-456e-af55-f7364572fc08	208	25	yes	punch out exception	2017-07-22 20:24:48	2017-07-22 20:24:48	2017-07-22 20:24:48	511
182	6822a155-42ca-4182-af71-fa134096a10a	208	25	Sunday funday	punch-in exception	2017-07-23 20:57:47	2017-07-23 20:57:47	2017-07-23 20:57:47	512
183	fe3adb49-8a60-4b33-827a-4ba8ecde21c5	208	25	test	punch-in exception	2017-07-24 20:47:06	2017-07-24 20:47:06	2017-07-24 20:47:06	514
184	fa13b0e8-2fab-43a8-a672-e3bf84eb7f3b	208	25	tree	punch out exception	2017-07-24 21:49:33	2017-07-24 21:49:32	2017-07-24 21:49:32	514
185	b91a333d-c8c3-4b64-a321-5794d725ca0d	173	22	QR Input	punch out exception	2017-07-25 21:27:52	2017-07-25 21:27:51	2017-07-25 21:27:51	\N
186	c132bdb9-9aa6-492a-89ee-dae76457085a	177	22	QR Input	punch out exception	2017-07-25 21:29:04	2017-07-25 21:29:04	2017-07-25 21:29:04	\N
187	55a14b14-5b92-4054-91a4-424deea26fee	184	22	QR Input	punch out exception	2017-07-25 21:29:09	2017-07-25 21:29:09	2017-07-25 21:29:09	\N
188	6479050f-a25b-4a85-ab67-70b35ed2ee3e	180	22	QR Input	punch out exception	2017-07-25 21:29:19	2017-07-25 21:29:19	2017-07-25 21:29:19	\N
189	41797184-b62f-4772-8a2e-2a2dbe074dfa	174	22	QR Input	punch out exception	2017-07-25 21:29:23	2017-07-25 21:29:22	2017-07-25 21:29:22	\N
190	fb5ed9ff-dbc2-4a3a-8f2a-5ad8753b8b49	181	22	QR Input	punch out exception	2017-07-25 21:29:43	2017-07-25 21:29:43	2017-07-25 21:29:43	\N
191	5f3c77fb-0cb1-403e-a01e-8dd1a6514d23	157	22	jggffhh	punch out exception	2017-07-25 21:29:54	2017-07-25 21:29:54	2017-07-25 21:29:54	498
192	5f52e04b-dab7-47ac-8073-fab15200f119	183	18	QR Input	punch out exception	2017-07-25 21:31:03	2017-07-25 21:31:03	2017-07-25 21:31:03	\N
193	25e40a6e-dc49-44e7-b42d-d04b750a957e	179	18	QR Input	punch out exception	2017-07-25 21:31:09	2017-07-25 21:31:08	2017-07-25 21:31:08	\N
194	f901bd26-4746-4107-94fc-d276bf642934	178	18	QR Input	punch out exception	2017-07-25 21:31:13	2017-07-25 21:31:13	2017-07-25 21:31:13	\N
195	3a3fec0e-5a04-4833-874c-75ffd14d0d59	182	18	QR Input	punch out exception	2017-07-25 21:31:18	2017-07-25 21:31:17	2017-07-25 21:31:17	\N
196	04e27dc6-1710-402e-8c66-3e8876911873	175	18	QR Input	punch out exception	2017-07-25 21:31:22	2017-07-25 21:31:22	2017-07-25 21:31:22	\N
197	700f61d3-9f63-4183-bb6a-1b95c3570cf8	170	18	QR Input	punch out exception	2017-07-25 21:31:29	2017-07-25 21:31:29	2017-07-25 21:31:29	\N
198	4e5339df-b8d5-4666-9ea3-4ccca3a1bb12	157	22	jghfhfh	punch-in exception	2017-07-25 22:09:45	2017-07-25 22:09:44	2017-07-25 22:09:44	525
199	dccb0ff0-ad27-411b-852d-154e57630203	173	22	QR Input	punch-in exception	2017-07-25 22:09:55	2017-07-25 22:09:55	2017-07-25 22:09:55	526
200	75700443-1ab7-47a4-a318-3ecab60fdae6	203	22	QR Input	punch-in exception	2017-07-25 22:09:58	2017-07-25 22:09:58	2017-07-25 22:09:58	527
201	438570fd-7415-4c87-97bb-79407c19d0b1	175	22	QR Input	punch-in exception	2017-07-25 22:10:01	2017-07-25 22:10:00	2017-07-25 22:10:00	528
202	5eed165c-24ec-48d1-a5a9-f1ca1ec7fab8	178	22	QR Input	punch-in exception	2017-07-25 22:10:04	2017-07-25 22:10:03	2017-07-25 22:10:03	529
203	7a1dc6bc-2f22-4759-b966-1d68837d890d	180	22	QR Input	punch-in exception	2017-07-25 22:10:06	2017-07-25 22:10:05	2017-07-25 22:10:05	530
204	c13ea7a9-fcf0-409b-952c-8e24b558b373	181	22	QR Input	punch-in exception	2017-07-25 22:10:12	2017-07-25 22:10:11	2017-07-25 22:10:11	531
205	dcf0ce72-de11-49d3-87c6-56883113c571	183	22	QR Input	punch-in exception	2017-07-25 22:10:14	2017-07-25 22:10:13	2017-07-25 22:10:13	532
206	bba9692b-e723-4755-bd14-34e2f8da31fc	157	22	hgtvf	punch out exception	2017-07-25 22:10:29	2017-07-25 22:10:29	2017-07-25 22:10:29	525
207	a097d589-2596-4048-b25d-48b6c0877370	170	18	QR Input	punch-in exception	2017-07-25 22:10:45	2017-07-25 22:10:45	2017-07-25 22:10:45	534
208	08f53bb6-bf70-462e-ab6e-ef65ea0680b1	174	18	QR Input	punch-in exception	2017-07-25 22:10:47	2017-07-25 22:10:47	2017-07-25 22:10:47	535
209	51619d0e-600e-42ea-96f9-01c3a9774362	177	18	QR Input	punch-in exception	2017-07-25 22:10:55	2017-07-25 22:10:54	2017-07-25 22:10:54	536
210	a3e5c88d-56ae-4c67-92ce-8aa5420d01d7	179	18	QR Input	punch-in exception	2017-07-25 22:10:57	2017-07-25 22:10:56	2017-07-25 22:10:56	537
211	b008bfdc-fd77-4e14-8ce4-a629c585d548	182	18	QR Input	punch-in exception	2017-07-25 22:11:04	2017-07-25 22:11:03	2017-07-25 22:11:03	538
212	54f84f06-3173-4e84-b3f6-77ce01c4fda7	184	18	QR Input	punch-in exception	2017-07-25 22:11:06	2017-07-25 22:11:05	2017-07-25 22:11:05	539
213	ac594134-c1dc-4dcb-ae20-c0505359a28f	157	22	jdhehhd	punch-in exception	2017-07-25 22:11:21	2017-07-25 22:11:20	2017-07-25 22:11:20	540
214	f8deb346-b78f-4990-90d7-3521c41f168b	203	22	QR Input	punch out exception	2017-07-25 22:11:44	2017-07-25 22:11:43	2017-07-25 22:11:43	\N
215	e045d845-caf3-450a-9a57-2f94bcf9ceac	157	22	u cyfuvyvt	punch out exception	2017-07-25 22:11:54	2017-07-25 22:11:53	2017-07-25 22:11:53	540
216	262c1f94-8765-4066-8f67-c89f3a8d85bf	203	18	QR Input	punch-in exception	2017-07-25 22:12:21	2017-07-25 22:12:21	2017-07-25 22:12:21	542
217	b49df0d9-7a55-40a9-9b35-f24d09d72338	184	18	QR Input	punch out exception	2017-07-25 22:50:55	2017-07-25 22:50:55	2017-07-25 22:50:55	\N
218	cffaacff-9b47-4c43-97b4-53dee6b2bdb3	182	18	QR Input	punch out exception	2017-07-25 22:50:59	2017-07-25 22:50:58	2017-07-25 22:50:58	\N
219	cf741500-98f9-4a29-93e1-789aee29db72	179	18	QR Input	punch out exception	2017-07-25 22:51:02	2017-07-25 22:51:01	2017-07-25 22:51:01	\N
220	2d3bdc28-6f26-4144-9df9-fc580406ce58	177	18	QR Input	punch out exception	2017-07-25 22:51:04	2017-07-25 22:51:03	2017-07-25 22:51:03	\N
221	a2aa772d-15f3-47a5-9c21-c88b197adfbc	203	18	QR Input	punch out exception	2017-07-25 22:51:06	2017-07-25 22:51:05	2017-07-25 22:51:05	\N
222	9dd6fade-f0d4-4054-a204-53d3a98dcb2a	174	18	QR Input	punch out exception	2017-07-25 22:51:08	2017-07-25 22:51:08	2017-07-25 22:51:08	\N
223	38827e84-ad0e-4b63-bec1-13fd97ca77e8	170	18	QR Input	punch out exception	2017-07-25 22:51:10	2017-07-25 22:51:10	2017-07-25 22:51:10	\N
224	1541022a-e2f3-4823-8371-b7898073ed82	157	22	hdjhddj	punch-in exception	2017-07-25 22:51:34	2017-07-25 22:51:34	2017-07-25 22:51:34	543
225	8e795fe0-b551-4718-83aa-84f843e97968	183	22	QR Input	punch out exception	2017-07-25 22:51:43	2017-07-25 22:51:43	2017-07-25 22:51:43	\N
226	b08cc960-a818-4598-be46-9a80eb75a78d	181	22	QR Input	punch out exception	2017-07-25 22:51:45	2017-07-25 22:51:45	2017-07-25 22:51:45	\N
227	92c2726d-a5b5-47a2-a98f-62a8c2f402aa	180	22	QR Input	punch out exception	2017-07-25 22:51:50	2017-07-25 22:51:49	2017-07-25 22:51:49	\N
228	39b93987-0863-445a-9a10-ab4f9808254c	178	22	QR Input	punch out exception	2017-07-25 22:51:52	2017-07-25 22:51:52	2017-07-25 22:51:52	\N
229	0e722e5e-125c-46b6-b7a3-412c4b92d44f	175	22	QR Input	punch out exception	2017-07-25 22:51:54	2017-07-25 22:51:54	2017-07-25 22:51:54	\N
230	4ee829b0-cb1b-4fed-802c-bfcc397dc68b	173	22	QR Input	punch out exception	2017-07-25 22:51:59	2017-07-25 22:51:59	2017-07-25 22:51:59	\N
231	92b43723-2b2d-41b8-983e-14f22d3dafb7	157	22	jdjddjjf	punch out exception	2017-07-25 22:52:12	2017-07-25 22:52:12	2017-07-25 22:52:12	543
232	f915139f-2496-4419-bbf8-5a2cd3f261ea	208	25	test	punch-in exception	2017-07-26 01:36:17	2017-07-26 01:36:17	2017-07-26 01:36:17	544
233	8415924d-7ebc-4ac6-805d-f05cab7f273f	157	22	jdfnrjdhs	punch-in exception	2017-07-26 01:59:47	2017-07-26 01:59:47	2017-07-26 01:59:47	547
234	cb2be29b-d9fb-49e9-8408-6096904f43b4	157	22	hdbdvdhs	punch out exception	2017-07-26 01:59:58	2017-07-26 01:59:58	2017-07-26 01:59:58	547
235	05529152-671b-4e90-9c88-8131ca4cee9c	157	22	hdjdjd	punch-in exception	2017-07-26 12:36:34	2017-07-26 12:36:34	2017-07-26 12:36:34	552
236	4afd5509-edb1-4cdc-9531-a941a8479a98	173	22	QR Input	punch-in exception	2017-07-26 12:36:44	2017-07-26 12:36:44	2017-07-26 12:36:44	553
237	6985bd2c-52ca-4e7d-a9b8-ffa85619f93e	203	22	QR Input	punch-in exception	2017-07-26 12:36:48	2017-07-26 12:36:47	2017-07-26 12:36:47	554
238	69b00693-fa42-4082-bcaf-7c3f26d12a1f	203	22	QR Input	punch out exception	2017-07-26 12:37:11	2017-07-26 12:37:11	2017-07-26 12:37:11	\N
239	7e0f5f84-4363-48e6-a4f4-805584cd84bf	175	22	QR Input	punch-in exception	2017-07-26 12:37:40	2017-07-26 12:37:40	2017-07-26 12:37:40	555
240	bf759a8d-be90-40d0-89e2-c54e4b32fd28	178	22	QR Input	punch-in exception	2017-07-26 12:37:43	2017-07-26 12:37:43	2017-07-26 12:37:43	556
241	e7183ff8-a828-418d-a622-e7ccb31a2cb0	180	22	QR Input	punch-in exception	2017-07-26 12:37:45	2017-07-26 12:37:45	2017-07-26 12:37:45	557
242	1161ac1a-589f-4637-a8e9-8c1c9dfe1171	203	22	QR Input	punch-in exception	2017-07-26 12:37:47	2017-07-26 12:37:47	2017-07-26 12:37:47	558
243	aebc98d8-eb9c-4c37-a348-24c27edb9c28	181	22	QR Input	punch-in exception	2017-07-26 12:37:52	2017-07-26 12:37:52	2017-07-26 12:37:52	559
244	b85fc647-f3a4-42a6-b81c-04f92f0842fb	183	22	QR Input	punch-in exception	2017-07-26 12:37:55	2017-07-26 12:37:54	2017-07-26 12:37:54	560
245	307b9313-860c-419f-ab07-246cb2a18ef6	218	22	QR Input	punch-in exception	2017-07-26 12:37:57	2017-07-26 12:37:56	2017-07-26 12:37:56	561
246	0fb6d943-627c-4782-8288-229d79183550	157	22	hdjdjd	punch out exception	2017-07-26 12:39:45	2017-07-26 12:39:44	2017-07-26 12:39:44	552
247	8f3a8b6a-e4ee-4a6c-9eb9-61539b2ba762	170	18	QR Input	punch-in exception	2017-07-26 12:40:00	2017-07-26 12:39:59	2017-07-26 12:39:59	563
248	2c059b0b-c5cb-47ca-9f5d-df219f7cc500	174	18	QR Input	punch-in exception	2017-07-26 12:40:02	2017-07-26 12:40:01	2017-07-26 12:40:01	564
249	feb89806-df48-4a9a-b9b8-8163b7df9d60	177	18	QR Input	punch-in exception	2017-07-26 12:40:08	2017-07-26 12:40:08	2017-07-26 12:40:08	565
250	bd9916a8-cafe-40b9-bf8d-f06c245361b2	179	18	QR Input	punch-in exception	2017-07-26 12:40:11	2017-07-26 12:40:10	2017-07-26 12:40:10	566
251	8cf84a0f-d0c7-4ec6-b2c0-a68615ca77f9	182	18	QR Input	punch-in exception	2017-07-26 12:40:18	2017-07-26 12:40:18	2017-07-26 12:40:18	567
252	aa34a9bb-afa2-4b6f-bfd6-53b0dde88c90	184	18	QR Input	punch-in exception	2017-07-26 12:40:21	2017-07-26 12:40:20	2017-07-26 12:40:20	568
253	f3702aac-e656-4778-ada5-6de37263f15f	157	22	hdjedh	punch-in exception	2017-07-26 12:40:41	2017-07-26 12:40:40	2017-07-26 12:40:40	569
254	a23c7277-193a-40d1-826f-744255c64dd2	219	22	QR Input	punch-in exception	2017-07-26 15:41:18	2017-07-26 15:41:17	2017-07-26 15:41:17	576
255	ae94aab2-e8c3-4c63-925a-5e14d09828c1	220	22	QR Input	punch-in exception	2017-07-26 15:41:21	2017-07-26 15:41:20	2017-07-26 15:41:20	577
256	c393d0ff-3267-4b46-95ac-76245fa660d8	221	22	QR Input	punch-in exception	2017-07-26 15:41:23	2017-07-26 15:41:23	2017-07-26 15:41:23	578
257	3df5f308-224b-4f19-a876-a40872bff6c9	157	18	ugufuv	punch-in exception	2017-07-26 15:44:09	2017-07-26 15:44:09	2017-07-26 15:44:09	579
258	939dc8cd-2071-40e5-bdfe-836c347a6820	157	18	fufufgi	punch out exception	2017-07-26 15:44:15	2017-07-26 15:44:15	2017-07-26 15:44:15	579
259	56567859-0d42-43bc-ab31-ff39731703dc	173	22	QR Input	punch out exception	2017-07-26 15:44:27	2017-07-26 15:44:27	2017-07-26 15:44:27	\N
260	59bbcb0f-5926-4ca3-a836-dfce1d0b0fac	203	22	QR Input	punch out exception	2017-07-26 15:44:29	2017-07-26 15:44:28	2017-07-26 15:44:28	\N
261	004ce2c9-6763-48f1-a208-5213d433d064	175	22	QR Input	punch out exception	2017-07-26 15:44:31	2017-07-26 15:44:30	2017-07-26 15:44:30	\N
262	2e921b08-ac0b-4d68-b813-8358873ca401	178	22	QR Input	punch out exception	2017-07-26 15:44:32	2017-07-26 15:44:32	2017-07-26 15:44:32	\N
263	9f6155d6-d20d-4ea3-a6f3-ed85b36565af	180	22	QR Input	punch out exception	2017-07-26 15:44:34	2017-07-26 15:44:33	2017-07-26 15:44:33	\N
264	12f21d56-f627-4f2f-8019-a3e08e085c18	181	22	QR Input	punch out exception	2017-07-26 15:44:37	2017-07-26 15:44:37	2017-07-26 15:44:37	\N
265	a272999e-f4c5-4f00-adb8-4606427fd5f6	183	22	QR Input	punch out exception	2017-07-26 15:44:40	2017-07-26 15:44:39	2017-07-26 15:44:39	\N
266	391ab049-2197-4066-893c-f93ee4c0bb56	218	22	QR Input	punch out exception	2017-07-26 15:44:41	2017-07-26 15:44:41	2017-07-26 15:44:41	\N
267	15cf2d90-da15-4137-9776-a34c5dbba15d	219	22	QR Input	punch out exception	2017-07-26 15:44:43	2017-07-26 15:44:42	2017-07-26 15:44:42	\N
268	10349d80-a81a-48f6-be5c-e8f4f77a1b3e	220	22	QR Input	punch out exception	2017-07-26 15:44:45	2017-07-26 15:44:44	2017-07-26 15:44:44	\N
269	fd81162d-f2f1-427e-9121-1c3283e44afd	221	22	QR Input	punch out exception	2017-07-26 15:44:46	2017-07-26 15:44:46	2017-07-26 15:44:46	\N
270	d16d5d63-33d4-4ac0-84a6-e464ec636f38	173	22	QR Input	punch-in exception	2017-07-26 15:45:28	2017-07-26 15:45:28	2017-07-26 15:45:28	582
271	a84b2488-e9e4-4bb0-8ade-c9f3bf01756c	203	22	QR Input	punch-in exception	2017-07-26 15:45:30	2017-07-26 15:45:29	2017-07-26 15:45:29	583
272	37934c53-3dab-429d-ae21-0f0fb0e6a727	175	22	Badge Input	punch-in exception	2017-07-26 15:45:36	2017-07-26 15:45:35	2017-07-26 15:45:35	584
273	aca0e34a-cde6-434a-b15a-a9611be5ac89	178	22	Badge Input	punch-in exception	2017-07-26 15:45:41	2017-07-26 15:45:41	2017-07-26 15:45:41	585
274	cec1fb59-38e2-4d70-b531-dd78e61806d8	180	22	Badge Input	punch-in exception	2017-07-26 15:45:52	2017-07-26 15:45:52	2017-07-26 15:45:52	586
275	198c4e0f-e350-4805-be0a-72c0530c8e64	181	22	QR Input	punch-in exception	2017-07-26 15:46:13	2017-07-26 15:46:12	2017-07-26 15:46:12	587
276	c1a8128c-b620-4348-9dd0-7eccef3e3ed1	183	22	QR Input	punch-in exception	2017-07-26 15:46:14	2017-07-26 15:46:14	2017-07-26 15:46:14	588
277	1f47c564-df3e-44e9-8ad4-d20270e34b80	218	22	QR Input	punch-in exception	2017-07-26 15:46:16	2017-07-26 15:46:15	2017-07-26 15:46:15	589
278	761660ab-4f1d-4aff-a30d-9c7af230b447	219	22	QR Input	punch-in exception	2017-07-26 15:46:18	2017-07-26 15:46:17	2017-07-26 15:46:17	590
279	be1a5116-2cc7-43ad-8696-431c6e5fb361	220	22	QR Input	punch-in exception	2017-07-26 15:46:19	2017-07-26 15:46:19	2017-07-26 15:46:19	591
280	64bae72f-b37b-48c1-82dd-704ff68cf170	221	22	QR Input	punch-in exception	2017-07-26 15:46:21	2017-07-26 15:46:20	2017-07-26 15:46:20	592
281	11c7e2f4-c0b4-4d8b-8662-d22f9e9be28d	208	38	test	punch-in exception	2017-07-26 19:55:38	2017-07-26 19:55:38	2017-07-26 19:55:38	593
282	5750151c-bdac-4311-875b-b3964d52b3f8	208	38	good	punch out exception	2017-07-26 19:56:15	2017-07-26 19:56:15	2017-07-26 19:56:15	593
283	69f11853-0565-4b23-a43d-0ff44096c227	212	25	cool.. just outside gfence	punch-in exception	2017-07-26 21:37:22	2017-07-26 21:37:22	2017-07-26 21:37:22	596
284	3681082c-b2cd-41dc-af0c-a6e72085f21d	212	25	at 3:01 and Fruitville	punch out exception	2017-07-26 21:40:07	2017-07-26 21:40:06	2017-07-26 21:40:06	596
285	c9878842-de60-4433-ba8f-b64d44a3ef39	208	39	test	punch-in exception	2017-07-26 22:01:07	2017-07-26 22:01:07	2017-07-26 22:01:07	598
286	9e30c6c5-156c-4179-bb82-35af48bd3948	208	39	test	punch out exception	2017-07-26 22:01:16	2017-07-26 22:01:16	2017-07-26 22:01:16	598
287	c404de59-18c4-4e26-b444-e1d5d901b140	212	25	t	punch-in exception	2017-07-27 02:32:35	2017-07-27 02:32:34	2017-07-27 02:32:34	599
288	eeb2c2c1-0347-4bf1-8c9b-dc133f39c847	212	25	rays office	punch out exception	2017-07-27 14:02:46	2017-07-27 14:02:45	2017-07-27 14:02:45	599
289	a0493e21-70b6-4cf3-99de-471afc147968	208	25	rays office	punch-in exception	2017-07-27 14:03:29	2017-07-27 14:03:28	2017-07-27 14:03:28	600
290	0d6d1f30-92d7-42dc-a102-291c026aa4bd	173	22	QR Input	punch out exception	2017-07-27 16:41:54	2017-07-27 16:41:53	2017-07-27 16:41:53	\N
291	fa64dd80-41d6-41bc-8c30-fb503ab4fba4	203	22	QR Input	punch out exception	2017-07-27 16:41:56	2017-07-27 16:41:55	2017-07-27 16:41:55	\N
292	fdc08449-1427-4491-8501-a524bb4a3e34	175	22	QR Input	punch out exception	2017-07-27 16:41:59	2017-07-27 16:41:59	2017-07-27 16:41:59	\N
293	101f3006-458f-45de-8116-e77892cbe8f9	178	22	QR Input	punch out exception	2017-07-27 16:42:07	2017-07-27 16:42:06	2017-07-27 16:42:06	\N
294	2bd3d417-d684-4207-8185-9184458de856	180	22	QR Input	punch out exception	2017-07-27 16:42:09	2017-07-27 16:42:08	2017-07-27 16:42:08	\N
295	cddae107-e2de-4d62-a2b1-9fc1c4ab78b3	181	22	QR Input	punch out exception	2017-07-27 16:42:16	2017-07-27 16:42:15	2017-07-27 16:42:15	\N
296	63c6d443-57b2-4a19-94e7-209d938c8352	183	22	QR Input	punch out exception	2017-07-27 16:42:18	2017-07-27 16:42:17	2017-07-27 16:42:17	\N
297	5017adc6-6f2b-484e-bfea-f1c6fdcf5b6c	218	22	QR Input	punch out exception	2017-07-27 16:42:19	2017-07-27 16:42:19	2017-07-27 16:42:19	\N
298	133ec8bf-06f7-4d50-9fd3-d860b2e798c1	219	22	QR Input	punch out exception	2017-07-27 16:42:21	2017-07-27 16:42:21	2017-07-27 16:42:21	\N
299	1d571d89-c8c5-4e11-9dfb-6fc5780d31ef	220	22	QR Input	punch out exception	2017-07-27 16:42:23	2017-07-27 16:42:22	2017-07-27 16:42:22	\N
300	90564be9-50ef-4aa0-ba7b-1b4d8d6ee97b	221	22	QR Input	punch out exception	2017-07-27 16:42:25	2017-07-27 16:42:24	2017-07-27 16:42:24	\N
301	2a1eba19-e464-42fa-81ac-569a6ea088d1	157	18	uifugu	punch-in exception	2017-07-27 16:42:48	2017-07-27 16:42:47	2017-07-27 16:42:47	601
302	66cae9df-3e39-4207-aef5-d1a7a654e0b6	170	18	QR Input	punch out exception	2017-07-27 16:42:56	2017-07-27 16:42:55	2017-07-27 16:42:55	\N
303	00c9113a-5997-4a55-aa0f-628b3ec75421	174	18	QR Input	punch out exception	2017-07-27 16:42:57	2017-07-27 16:42:57	2017-07-27 16:42:57	\N
304	e2ba96db-1614-4c93-a301-e376d49cd379	177	18	QR Input	punch out exception	2017-07-27 16:43:05	2017-07-27 16:43:05	2017-07-27 16:43:05	\N
305	718addc3-f3b1-4e32-a5a8-5bc24aa50dca	179	18	QR Input	punch out exception	2017-07-27 16:43:07	2017-07-27 16:43:06	2017-07-27 16:43:06	\N
306	fdf4a8b5-766d-4a1c-b6b9-ad571b1954ff	182	18	QR Input	punch out exception	2017-07-27 16:43:10	2017-07-27 16:43:10	2017-07-27 16:43:10	\N
307	30b3b870-deca-4caa-91a9-e6a677e5c8d9	184	18	QR Input	punch out exception	2017-07-27 16:43:12	2017-07-27 16:43:11	2017-07-27 16:43:11	\N
308	d35dcd73-fceb-4a18-ab48-26d1489e48c7	157	18	hythgf	punch out exception	2017-07-27 16:43:26	2017-07-27 16:43:25	2017-07-27 16:43:25	601
309	b215d966-69ea-4e42-b53e-56179fc4db61	222	44	hdhdhe	punch-in exception	2017-07-27 16:44:09	2017-07-27 16:44:09	2017-07-27 16:44:09	602
310	6e3f20c0-f43f-4749-97c5-0a5348455274	222	44	hdbedhh	punch out exception	2017-07-27 16:44:15	2017-07-27 16:44:15	2017-07-27 16:44:15	602
311	ef400fea-3471-40ac-bd02-8cde721763d0	157	18	bfnffjjf	punch-in exception	2017-07-27 18:15:16	2017-07-27 18:15:15	2017-07-27 18:15:15	604
312	e92c288a-f0ed-4fe2-9eb9-e62ccb72f550	170	18	QR Input	punch-in exception	2017-07-27 18:15:28	2017-07-27 18:15:27	2017-07-27 18:15:27	605
313	53c28187-0d32-4afb-89ce-be214d3bdf9f	174	18	QR Input	punch-in exception	2017-07-27 18:15:30	2017-07-27 18:15:29	2017-07-27 18:15:29	606
314	133bd90e-52bb-44bc-aa78-87dda92f3cd2	177	18	QR Input	punch-in exception	2017-07-27 18:15:32	2017-07-27 18:15:32	2017-07-27 18:15:32	607
315	8841766d-d1a7-42ab-b0db-d8894133f98a	179	18	QR Input	punch-in exception	2017-07-27 18:15:34	2017-07-27 18:15:33	2017-07-27 18:15:33	608
316	cd1a80cc-2902-4844-80da-8d0d08025edd	182	18	QR Input	punch-in exception	2017-07-27 18:15:38	2017-07-27 18:15:38	2017-07-27 18:15:38	609
317	c0deb73b-9d5f-4b55-9277-7540824cd1b4	184	18	QR Input	punch-in exception	2017-07-27 18:15:40	2017-07-27 18:15:39	2017-07-27 18:15:39	610
318	c7cfe924-063f-437d-87cc-3d2aa7b5ea88	157	18	jdjdjf	punch out exception	2017-07-27 18:15:57	2017-07-27 18:15:57	2017-07-27 18:15:57	604
319	541e8f7d-298c-4f3b-aacf-68e908b123ca	173	22	QR Input	punch-in exception	2017-07-27 18:16:08	2017-07-27 18:16:08	2017-07-27 18:16:08	612
320	e78e022a-49b6-4c56-ae1f-8e08a23ee237	203	22	QR Input	punch-in exception	2017-07-27 18:16:10	2017-07-27 18:16:09	2017-07-27 18:16:09	613
321	ad34b510-3b90-41dc-b3eb-bcc94ad833d7	175	22	QR Input	punch-in exception	2017-07-27 18:16:12	2017-07-27 18:16:12	2017-07-27 18:16:12	614
322	e13d55bf-2ba1-489a-8c19-32851a2e464d	178	22	QR Input	punch-in exception	2017-07-27 18:16:14	2017-07-27 18:16:13	2017-07-27 18:16:13	615
323	0e2d7cdd-58a2-43a1-a12e-399f556e2e42	180	22	QR Input	punch-in exception	2017-07-27 18:16:15	2017-07-27 18:16:15	2017-07-27 18:16:15	616
324	8698daff-32b4-4a62-91c8-4348565f6441	181	22	QR Input	punch-in exception	2017-07-27 18:16:19	2017-07-27 18:16:18	2017-07-27 18:16:18	617
325	df262a76-67c9-401f-b34a-444d13a276a7	183	22	QR Input	punch-in exception	2017-07-27 18:16:20	2017-07-27 18:16:20	2017-07-27 18:16:20	618
326	bac240d3-c07a-4676-a3a4-e9f441d388f7	218	22	QR Input	punch-in exception	2017-07-27 18:16:23	2017-07-27 18:16:22	2017-07-27 18:16:22	619
327	3cc1dc3e-4e88-47b9-a0ae-0ef49f091af9	219	22	QR Input	punch-in exception	2017-07-27 18:16:25	2017-07-27 18:16:24	2017-07-27 18:16:24	620
328	2af8ae5b-338b-4456-bf35-6ffaaf971334	220	22	QR Input	punch-in exception	2017-07-27 18:16:27	2017-07-27 18:16:26	2017-07-27 18:16:26	621
329	25b1d0a0-246c-4f7b-bb81-3826a3495698	221	22	QR Input	punch-in exception	2017-07-27 18:16:28	2017-07-27 18:16:28	2017-07-27 18:16:28	622
330	e306f603-8f92-4c93-8941-7be49d448730	173	22	QR Input	punch out exception	2017-07-28 14:32:21	2017-07-28 14:32:21	2017-07-28 14:32:21	\N
331	75d6dd79-6c93-4131-9f03-e29bd0c42934	203	22	QR Input	punch out exception	2017-07-28 14:32:23	2017-07-28 14:32:23	2017-07-28 14:32:23	\N
332	55b0d804-2bff-4434-b1c3-114a5858a1c6	175	22	QR Input	punch out exception	2017-07-28 14:32:30	2017-07-28 14:32:29	2017-07-28 14:32:29	\N
333	824dabb6-4a9b-4d04-b1ea-f39ddde310fb	178	22	QR Input	punch out exception	2017-07-28 14:32:32	2017-07-28 14:32:32	2017-07-28 14:32:32	\N
334	d184cd60-0c3a-447f-949c-63978181ec0d	180	22	QR Input	punch out exception	2017-07-28 14:32:34	2017-07-28 14:32:33	2017-07-28 14:32:33	\N
335	fdbf9a7b-9b76-4a70-ac33-9e0673dc5d91	181	22	QR Input	punch out exception	2017-07-28 14:32:38	2017-07-28 14:32:38	2017-07-28 14:32:38	\N
336	c25d3140-c65c-43e3-8815-bbeec00be469	183	22	QR Input	punch out exception	2017-07-28 14:32:40	2017-07-28 14:32:40	2017-07-28 14:32:40	\N
337	10f8cb11-8407-42da-99a7-efc3c5e45db9	218	22	QR Input	punch out exception	2017-07-28 14:32:42	2017-07-28 14:32:41	2017-07-28 14:32:41	\N
338	e02e89d8-36fd-421a-89f4-278768c9b6bc	219	22	QR Input	punch out exception	2017-07-28 14:32:44	2017-07-28 14:32:44	2017-07-28 14:32:44	\N
339	867fd90c-a108-4317-a082-e0944bc859db	220	22	QR Input	punch out exception	2017-07-28 14:32:47	2017-07-28 14:32:46	2017-07-28 14:32:46	\N
340	b9813a5f-b235-4523-be2c-838b90089be3	221	22	QR Input	punch out exception	2017-07-28 14:32:48	2017-07-28 14:32:48	2017-07-28 14:32:48	\N
341	a6a57e74-ad7d-4950-b38c-e884e7aeb2bf	157	22	htggf	punch out exception	2017-07-28 14:33:12	2017-07-28 14:33:12	2017-07-28 14:33:12	611
342	e630266e-57de-49b7-ad2f-7877abbfb458	170	18	QR Input	punch out exception	2017-07-28 14:33:28	2017-07-28 14:33:28	2017-07-28 14:33:28	\N
343	1b9ba8fe-86a9-40b0-b084-506fd0327f57	174	18	QR Input	punch out exception	2017-07-28 14:33:31	2017-07-28 14:33:30	2017-07-28 14:33:30	\N
344	849d27f2-bc0b-4279-a71a-7a5a2952cca8	177	18	QR Input	punch out exception	2017-07-28 14:33:34	2017-07-28 14:33:33	2017-07-28 14:33:33	\N
345	2e20f182-680c-420f-8468-19ccde7e7378	179	18	QR Input	punch out exception	2017-07-28 14:33:36	2017-07-28 14:33:35	2017-07-28 14:33:35	\N
346	77db0b24-0e69-4367-8200-afce4491b08b	182	18	QR Input	punch out exception	2017-07-28 14:33:40	2017-07-28 14:33:39	2017-07-28 14:33:39	\N
347	5c714d84-fc3a-47ef-880d-4a982d3d6579	184	18	QR Input	punch out exception	2017-07-28 14:33:42	2017-07-28 14:33:42	2017-07-28 14:33:42	\N
348	a651a0fb-a3bc-4b33-94e2-f887fa367864	208	25	sb	punch out exception	2017-07-28 15:17:37	2017-07-28 15:17:36	2017-07-28 15:17:36	600
349	2c8a8209-09cb-40a0-8fb3-6b11c32ddfca	208	25	house	punch-in exception	2017-07-28 16:43:44	2017-07-28 16:43:43	2017-07-28 16:43:43	627
350	6e36528e-348c-4fb3-97ca-96b7f37cd19a	208	25	ok	punch out exception	2017-07-28 20:37:12	2017-07-28 20:37:11	2017-07-28 20:37:11	627
351	21473bb0-b0d1-4621-9a96-dbf21ad6c019	208	25	me	punch-in exception	2017-07-28 22:13:57	2017-07-28 22:13:56	2017-07-28 22:13:56	628
352	1b80a8e1-2760-41f8-a3a8-6d65348585ae	135	16	Badge input	punch-in exception	2017-07-31 06:38:18	2017-07-31 06:38:17	2017-07-31 06:38:17	637
353	59a213e0-4d14-4e16-bc5c-d1d67ec509de	135	16	Badge input	punch out exception	2017-07-31 06:42:11	2017-07-31 06:42:11	2017-07-31 06:42:11	\N
354	33338378-440d-4e18-9214-be3987ce6196	134	16	QR input	punch-in exception	2017-07-31 08:02:29	2017-07-31 08:02:28	2017-07-31 08:02:28	638
355	40a64272-191d-41b3-9fcf-cc71ffb90c3c	134	16	QR input	punch out exception	2017-07-31 08:02:33	2017-07-31 08:02:33	2017-07-31 08:02:33	\N
356	3439a3c7-2093-49dc-a2a0-cbd2e8381567	157	22	jdjdjdud	punch-in exception	2017-07-31 14:50:10	2017-07-31 14:50:10	2017-07-31 14:50:10	639
357	88d151ed-a350-4dd6-a526-59e347bd6fb5	173	22	QR Input	punch-in exception	2017-07-31 14:50:17	2017-07-31 14:50:16	2017-07-31 14:50:16	640
358	605f8154-a086-4ca6-a868-19c95c9fee49	203	22	QR Input	punch-in exception	2017-07-31 14:50:19	2017-07-31 14:50:19	2017-07-31 14:50:19	641
359	5d81e324-2e3c-46b0-bb49-6848133f2b65	203	22	QR Input	punch out exception	2017-07-31 14:50:22	2017-07-31 14:50:22	2017-07-31 14:50:22	\N
360	0eb68bc2-9a54-4c8d-9ef8-1f9ad9b89d33	175	22	QR Input	punch-in exception	2017-07-31 14:50:26	2017-07-31 14:50:26	2017-07-31 14:50:26	642
361	bca419aa-14b5-4540-ab80-c6b6909bd1e8	178	22	QR Input	punch-in exception	2017-07-31 14:50:28	2017-07-31 14:50:28	2017-07-31 14:50:28	643
362	37656195-dcd8-48f8-b51f-1bd63d3323b9	180	22	QR Input	punch-in exception	2017-07-31 14:50:30	2017-07-31 14:50:30	2017-07-31 14:50:30	644
363	7acb006b-0ed3-4ed5-90ca-104c458dfe4b	181	22	QR Input	punch-in exception	2017-07-31 14:50:34	2017-07-31 14:50:34	2017-07-31 14:50:34	645
364	7ce4921c-7432-4262-843b-fd439d10020b	183	22	QR Input	punch-in exception	2017-07-31 14:50:36	2017-07-31 14:50:35	2017-07-31 14:50:35	646
365	6768228a-04f3-44be-839a-fc7f065150fe	218	22	QR Input	punch-in exception	2017-07-31 14:50:37	2017-07-31 14:50:37	2017-07-31 14:50:37	647
366	6d238a74-2a92-4525-96b4-b162e831796c	219	22	QR Input	punch-in exception	2017-07-31 14:50:39	2017-07-31 14:50:39	2017-07-31 14:50:39	648
367	638c7c12-d596-4e38-920c-193512d4ebf9	220	22	QR Input	punch-in exception	2017-07-31 14:50:42	2017-07-31 14:50:41	2017-07-31 14:50:41	649
368	5f760804-669b-4431-b0c4-984df7b2219c	221	22	QR Input	punch-in exception	2017-07-31 14:50:43	2017-07-31 14:50:43	2017-07-31 14:50:43	650
369	7583a9b4-b976-46de-9420-c7d23bd447a0	157	22	hdjhdjdjd	punch out exception	2017-07-31 14:50:54	2017-07-31 14:50:54	2017-07-31 14:50:54	639
370	7d838e9e-1db0-4eeb-b8fe-f25ea2866197	170	18	QR Input	punch-in exception	2017-07-31 14:51:11	2017-07-31 14:51:10	2017-07-31 14:51:10	652
371	f3cc21e8-85e6-4721-8668-1d283c02aeb4	174	18	QR Input	punch-in exception	2017-07-31 14:51:14	2017-07-31 14:51:14	2017-07-31 14:51:14	653
372	948c4d05-4e46-4da0-9b55-068d129b08f4	203	18	QR Input	punch-in exception	2017-07-31 14:51:17	2017-07-31 14:51:16	2017-07-31 14:51:16	654
373	9470230d-0edd-49e9-8a89-b2bf90f1680c	177	18	QR Input	punch-in exception	2017-07-31 14:51:19	2017-07-31 14:51:18	2017-07-31 14:51:18	655
374	868a1fee-17af-4a36-bb57-3e3957b08fe9	179	18	QR Input	punch-in exception	2017-07-31 14:51:21	2017-07-31 14:51:20	2017-07-31 14:51:20	656
375	a48595bd-5ddb-4648-81dc-d60b4517d303	182	18	QR Input	punch-in exception	2017-07-31 14:51:25	2017-07-31 14:51:24	2017-07-31 14:51:24	657
376	d44c296b-5398-4fa1-a165-3e25462a4c22	184	18	QR Input	punch-in exception	2017-07-31 14:51:27	2017-07-31 14:51:26	2017-07-31 14:51:26	658
377	5e2be864-6a80-47f5-8dc9-72302ea04c7f	208	45	test	punch-in exception	2017-07-31 18:12:01	2017-07-31 18:12:01	2017-07-31 18:12:01	659
378	ad843359-930e-4152-9e45-3c8619d2c121	170	18	QR Input	punch out exception	2017-07-31 18:32:51	2017-07-31 18:32:51	2017-07-31 18:32:51	\N
379	8261de20-c4e3-4367-ab84-8ba3357714c7	174	18	QR Input	punch out exception	2017-07-31 18:32:53	2017-07-31 18:32:52	2017-07-31 18:32:52	\N
380	515e1321-2d83-40c1-9e42-9f81bcff57b3	203	18	QR Input	punch out exception	2017-07-31 18:32:55	2017-07-31 18:32:55	2017-07-31 18:32:55	\N
381	bceabd3b-2bc0-4fc1-a747-6104d767afa4	177	18	QR Input	punch out exception	2017-07-31 18:32:57	2017-07-31 18:32:56	2017-07-31 18:32:56	\N
382	bc3a494d-bb97-4a2d-b686-3eb876c02c6b	179	18	QR Input	punch out exception	2017-07-31 18:32:59	2017-07-31 18:32:58	2017-07-31 18:32:58	\N
383	902bbebc-e2ac-4e76-b685-faa9d8c65e23	182	18	QR Input	punch out exception	2017-07-31 18:33:02	2017-07-31 18:33:02	2017-07-31 18:33:02	\N
384	5219946b-411b-411b-a9ce-36fa79203802	184	18	QR Input	punch out exception	2017-07-31 18:33:04	2017-07-31 18:33:04	2017-07-31 18:33:04	\N
385	245d7f98-5fae-4cb8-b1fe-dc98087936ce	157	22	hdjjdx	punch-in exception	2017-07-31 18:33:18	2017-07-31 18:33:18	2017-07-31 18:33:18	660
386	3fbcb3e0-33de-4109-88d1-0829a5adfd4f	173	22	QR Input	punch out exception	2017-07-31 18:33:27	2017-07-31 18:33:27	2017-07-31 18:33:27	\N
387	4fdc6e68-3596-4bbd-b19f-f2f320436c16	175	22	QR Input	punch out exception	2017-07-31 18:33:33	2017-07-31 18:33:32	2017-07-31 18:33:32	\N
388	3bf57b64-76bc-4637-acfc-948b7e4887c1	178	22	QR Input	punch out exception	2017-07-31 18:33:36	2017-07-31 18:33:35	2017-07-31 18:33:35	\N
389	027a7257-2463-43b0-a62d-c5ce15237ea5	180	22	QR Input	punch out exception	2017-07-31 18:33:37	2017-07-31 18:33:37	2017-07-31 18:33:37	\N
390	1d5145e1-9a60-41fb-88fd-78de3d2dba65	181	22	QR Input	punch out exception	2017-07-31 18:33:40	2017-07-31 18:33:40	2017-07-31 18:33:40	\N
391	6d5f1073-c681-4c39-84b8-81c9f75f8acf	183	22	QR Input	punch out exception	2017-07-31 18:33:42	2017-07-31 18:33:41	2017-07-31 18:33:41	\N
392	4f1c805d-662b-40f3-a9ce-397ff693ae11	218	22	QR Input	punch out exception	2017-07-31 18:33:43	2017-07-31 18:33:43	2017-07-31 18:33:43	\N
393	ba55bab0-f3eb-40fa-8087-a71ff38b070a	219	22	QR Input	punch out exception	2017-07-31 18:33:45	2017-07-31 18:33:45	2017-07-31 18:33:45	\N
394	e18175ae-9da8-4276-9315-d9bc26765fec	220	22	QR Input	punch out exception	2017-07-31 18:33:47	2017-07-31 18:33:47	2017-07-31 18:33:47	\N
395	7e00ad2f-bd1c-475d-b459-2b15a2dedfd7	221	22	QR Input	punch out exception	2017-07-31 18:33:49	2017-07-31 18:33:48	2017-07-31 18:33:48	\N
396	4727bf3b-8956-4144-871e-da20412dc66d	157	22	jdhehf	punch out exception	2017-07-31 18:33:59	2017-07-31 18:33:59	2017-07-31 18:33:59	660
397	e52b2625-3654-475a-886f-127ea6743b58	208	45	test	punch out exception	2017-07-31 19:25:23	2017-07-31 19:25:23	2017-07-31 19:25:23	659
398	d8ca6439-1f91-4ec8-b597-7ed02f22ea31	223	45	here	punch-in exception	2017-07-31 19:30:25	2017-07-31 19:30:25	2017-07-31 19:30:25	661
399	cbdd0c3d-7358-41f2-9a8a-95d48844b5e1	223	45	test	punch out exception	2017-07-31 19:32:12	2017-07-31 19:32:12	2017-07-31 19:32:12	661
400	025a2068-ec21-4580-bb5d-b328fc3746fc	223	25	test	punch-in exception	2017-08-01 17:09:55	2017-08-01 17:09:55	2017-08-01 17:09:55	662
401	ae49abd7-3f36-4df0-85de-28eea3b6a1c5	223	25	test	punch out exception	2017-08-01 17:10:05	2017-08-01 17:10:04	2017-08-01 17:10:04	662
402	93ec15d6-2387-43d7-9c8c-c3366ade6c15	223	45	test	punch-in exception	2017-08-01 22:01:00	2017-08-01 22:00:59	2017-08-01 22:00:59	663
403	eed7bace-e38e-4402-b647-6c0ba449203e	157	18	hrhtgtf	punch-in exception	2017-08-03 15:00:14	2017-08-03 15:00:13	2017-08-03 15:00:13	677
404	e69101ac-6dcd-44f7-b8c3-83d0f7dcb4e2	170	18	QR Input	punch-in exception	2017-08-03 15:00:27	2017-08-03 15:00:27	2017-08-03 15:00:27	678
405	ddf72473-d92d-4967-9089-bbe10aee9883	174	18	QR Input	punch-in exception	2017-08-03 15:00:29	2017-08-03 15:00:29	2017-08-03 15:00:29	679
406	4d162e57-1c45-4722-9dd2-0c29f6700119	177	18	QR Input	punch-in exception	2017-08-03 15:00:32	2017-08-03 15:00:32	2017-08-03 15:00:32	680
407	2e61642c-d2f9-4253-b52e-44bb91a4f3f4	179	18	QR Input	punch-in exception	2017-08-03 15:00:34	2017-08-03 15:00:34	2017-08-03 15:00:34	681
408	19f95fad-2188-4329-a070-02051fa1611b	182	18	QR Input	punch-in exception	2017-08-03 15:00:37	2017-08-03 15:00:37	2017-08-03 15:00:37	682
409	34af2bdc-186d-43aa-8ea3-63b7add8362a	184	18	QR Input	punch-in exception	2017-08-03 15:00:40	2017-08-03 15:00:39	2017-08-03 15:00:39	683
410	f1ca2f19-d2a9-4d25-9089-db1dff8fa5bb	157	18	htghyf	punch out exception	2017-08-03 15:00:51	2017-08-03 15:00:51	2017-08-03 15:00:51	677
411	8aa0e2ae-42b2-41da-a158-4a4b715d15fa	173	22	QR Input	punch-in exception	2017-08-03 15:01:01	2017-08-03 15:01:01	2017-08-03 15:01:01	685
412	61b6e427-1522-4c02-b631-2238fd049fba	203	22	QR Input	punch-in exception	2017-08-03 15:01:03	2017-08-03 15:01:02	2017-08-03 15:01:02	686
413	c0c1f374-84c7-406b-b46b-b8ee090f1f07	175	22	QR Input	punch-in exception	2017-08-03 15:01:05	2017-08-03 15:01:04	2017-08-03 15:01:04	687
414	8b65e2b4-4bba-41ce-8d10-f32f31957395	178	22	QR Input	punch-in exception	2017-08-03 15:01:07	2017-08-03 15:01:06	2017-08-03 15:01:06	688
415	5e4acd5f-e428-43d6-9d7e-ebd1611a20c5	180	22	QR Input	punch-in exception	2017-08-03 15:01:08	2017-08-03 15:01:08	2017-08-03 15:01:08	689
416	46153140-67b3-4342-99a6-7c6230e70fb0	181	22	QR Input	punch-in exception	2017-08-03 15:01:13	2017-08-03 15:01:13	2017-08-03 15:01:13	690
417	55307650-2a97-4bed-a1cb-8fb96b20548a	183	22	QR Input	punch-in exception	2017-08-03 15:01:15	2017-08-03 15:01:14	2017-08-03 15:01:14	691
418	d5713bdf-b842-4f77-854b-dbda6a11b696	218	22	QR Input	punch-in exception	2017-08-03 15:01:16	2017-08-03 15:01:16	2017-08-03 15:01:16	692
419	15589626-d646-469c-8ea8-4119bc124da9	219	22	QR Input	punch-in exception	2017-08-03 15:01:18	2017-08-03 15:01:18	2017-08-03 15:01:18	693
420	c4af0e4c-9671-458b-a845-3745d71af983	220	22	QR Input	punch-in exception	2017-08-03 15:01:20	2017-08-03 15:01:19	2017-08-03 15:01:19	694
421	2306bddd-d318-4715-8452-bf78e824b00d	221	22	QR Input	punch-in exception	2017-08-03 15:01:21	2017-08-03 15:01:21	2017-08-03 15:01:21	695
422	035658ef-5b22-46cf-95da-ae139f76463b	208	25	test	punch out exception	2017-08-04 17:26:12	2017-08-04 17:26:12	2017-08-04 17:26:12	676
423	5c157793-7578-4030-8694-4df433b793ce	208	25	test	punch-in exception	2017-08-04 17:31:30	2017-08-04 17:31:29	2017-08-04 17:31:29	710
424	c1925090-1597-437c-8db4-f1d4a6fe2ad2	208	25	test	punch out exception	2017-08-07 13:15:51	2017-08-07 13:15:51	2017-08-07 13:15:51	710
425	ca4c4746-0aac-49a4-9f3b-762bc635f356	208	45	trst	punch-in exception	2017-08-07 13:22:39	2017-08-07 13:22:39	2017-08-07 13:22:39	711
426	bd5a8d0c-d994-4498-af21-aa48ff9c3af5	208	45	test	punch out exception	2017-08-07 13:22:51	2017-08-07 13:22:51	2017-08-07 13:22:51	711
427	5388e05f-aefe-4533-a6ef-eba46d9888a1	223	45	test	punch out exception	2017-08-07 13:23:19	2017-08-07 13:23:18	2017-08-07 13:23:18	663
428	2d9449a0-33e4-4ffa-9783-0ab0caa2ba5c	223	47	test	punch-in exception	2017-08-08 18:53:31	2017-08-08 18:53:31	2017-08-08 18:53:31	712
429	a19c6ce1-f42b-4eeb-acbe-0a38e54f1521	223	47	yep	punch out exception	2017-08-08 19:05:30	2017-08-08 19:05:30	2017-08-08 19:05:30	712
430	6ec5a01e-b18b-437d-90eb-f0ea7c604dc8	173	22	QR Input	punch out exception	2017-08-09 15:16:49	2017-08-09 15:16:49	2017-08-09 15:16:49	\N
431	5643085e-475e-48a0-927e-e9799d802a28	203	22	QR Input	punch out exception	2017-08-09 15:16:51	2017-08-09 15:16:51	2017-08-09 15:16:51	\N
432	420b0854-3742-4d17-9677-37eb49048c44	175	22	QR Input	punch out exception	2017-08-09 15:16:54	2017-08-09 15:16:54	2017-08-09 15:16:54	\N
433	d5e92424-9043-449a-b7fb-7381ffb00a5f	178	22	QR Input	punch out exception	2017-08-09 15:16:56	2017-08-09 15:16:55	2017-08-09 15:16:55	\N
434	245162f2-4436-4203-8d42-8ae9ad8763b0	180	22	QR Input	punch out exception	2017-08-09 15:16:58	2017-08-09 15:16:57	2017-08-09 15:16:57	\N
435	fe5be19d-aaad-43e3-b71b-765a59d33dd5	181	22	QR Input	punch out exception	2017-08-09 15:17:06	2017-08-09 15:17:06	2017-08-09 15:17:06	\N
436	24abda22-4a92-4244-8c46-bf740a8c199a	183	22	QR Input	punch out exception	2017-08-09 15:17:08	2017-08-09 15:17:08	2017-08-09 15:17:08	\N
437	c8d0b42e-b3e3-4c5e-90b2-e40dfd7a7bc3	218	22	QR Input	punch out exception	2017-08-09 15:17:10	2017-08-09 15:17:09	2017-08-09 15:17:09	\N
438	586de565-7d84-40f3-96e9-31bf67ea416f	219	22	QR Input	punch out exception	2017-08-09 15:17:12	2017-08-09 15:17:11	2017-08-09 15:17:11	\N
439	02aec2b1-4087-4925-8751-f912937731a1	220	22	QR Input	punch out exception	2017-08-09 15:17:14	2017-08-09 15:17:13	2017-08-09 15:17:13	\N
440	58696e9f-fb35-4ea9-8c1f-0cb0f9941b03	221	22	QR Input	punch out exception	2017-08-09 15:17:15	2017-08-09 15:17:15	2017-08-09 15:17:15	\N
441	acab04da-c683-4b98-9dec-8368bf3b9a53	174	18	QR Input	punch out exception	2017-08-09 15:27:59	2017-08-09 15:27:59	2017-08-09 15:27:59	\N
442	f3f2a980-4033-415a-b417-89281be103bc	177	18	QR Input	punch out exception	2017-08-09 15:28:06	2017-08-09 15:28:06	2017-08-09 15:28:06	\N
443	56d66e3a-f343-49ae-a137-10162c160f5b	179	18	QR Input	punch out exception	2017-08-09 15:28:08	2017-08-09 15:28:08	2017-08-09 15:28:08	\N
444	5c932452-6b2b-46c0-9a00-d4961e3af2d3	182	18	QR Input	punch out exception	2017-08-09 15:28:13	2017-08-09 15:28:12	2017-08-09 15:28:12	\N
445	c7ac6202-fe1f-4936-a808-8c6fc6b5501d	184	18	QR Input	punch out exception	2017-08-09 15:28:14	2017-08-09 15:28:14	2017-08-09 15:28:14	\N
446	570a5831-e329-4c61-bedc-3ef2f93e4b21	203	18	hdjdj	punch-in exception	2017-08-09 15:28:59	2017-08-09 15:28:58	2017-08-09 15:28:58	730
447	c84f1c9f-9019-4632-8d81-035f4b2c5fde	170	18	QR Input	punch out exception	2017-08-09 15:29:05	2017-08-09 15:29:05	2017-08-09 15:29:05	\N
448	cdeed403-4a39-4d7c-a6b9-b10234505906	203	18	ghgft	punch out exception	2017-08-09 15:29:13	2017-08-09 15:29:13	2017-08-09 15:29:13	730
449	d5335972-3ca2-4293-bde6-610b9c8b53a9	173	22	virtual-gate	punch out exception	2017-08-09 15:31:12	2017-08-09 15:31:11	2017-08-09 15:31:11	\N
450	61b78348-d25c-4553-a81f-7982b401ac09	203	22	virtual-gate	punch out exception	2017-08-09 15:31:25	2017-08-09 15:31:24	2017-08-09 15:31:24	\N
451	e22fedb6-4cdf-4731-9a5b-353633ef71ad	223	60	test	punch-in exception	2017-08-11 15:14:07	2017-08-11 15:14:06	2017-08-11 15:14:06	733
452	d44026cf-9e23-45d6-befb-cd370b5920f5	173	22	hggg	punch-in exception	2017-08-11 15:19:27	2017-08-11 15:19:27	2017-08-11 15:19:27	734
453	0d46e19f-4606-48ee-a911-ae6c7376892e	173	22	hgggg	punch out exception	2017-08-11 15:20:04	2017-08-11 15:20:03	2017-08-11 15:20:03	734
454	6ad7a477-bac8-4896-b633-a4effd18ea7f	157	22	virtual-gate	punch-in exception	2017-08-11 15:41:37	2017-08-11 15:41:36	2017-08-11 15:41:36	735
455	08e3f82e-167b-4df4-8900-72a624ccb2e7	157	22	virtual-gate	punch out exception	2017-08-11 15:41:40	2017-08-11 15:41:40	2017-08-11 15:41:40	\N
456	a9ccac6b-f64e-4a88-ba84-c62f8feca035	157	22	virtual-gate	punch-in exception	2017-08-11 15:43:32	2017-08-11 15:43:32	2017-08-11 15:43:32	736
457	22296c1c-a648-470b-992c-38a27a49a371	157	22	virtual-gate	punch out exception	2017-08-11 15:43:34	2017-08-11 15:43:34	2017-08-11 15:43:34	\N
458	b1a74715-c286-4f64-a721-a88019124203	157	22	virtual-gate	punch-in exception	2017-08-11 15:43:35	2017-08-11 15:43:34	2017-08-11 15:43:34	737
459	3db4ca88-52fe-4fac-a8fd-fbda9305670c	157	22	virtual-gate	punch out exception	2017-08-11 15:43:37	2017-08-11 15:43:37	2017-08-11 15:43:37	\N
460	52da317a-f273-4295-980a-38c73ece39f0	157	22	virtual-gate	punch-in exception	2017-08-11 15:43:38	2017-08-11 15:43:38	2017-08-11 15:43:38	738
461	4dc87af6-77c0-4fef-b84f-776ebb5eb1bf	157	22	virtual-gate	punch out exception	2017-08-11 15:43:39	2017-08-11 15:43:38	2017-08-11 15:43:38	\N
462	091be210-fb21-4515-9ee9-d195e92f02d5	157	22	virtual-gate	punch-in exception	2017-08-11 15:43:39	2017-08-11 15:43:39	2017-08-11 15:43:39	739
463	471213db-d053-42f1-82d1-997203e92f15	157	22	virtual-gate	punch out exception	2017-08-11 15:43:40	2017-08-11 15:43:39	2017-08-11 15:43:39	\N
464	8a2042c6-ff9a-4e47-8941-9d358cb856dc	157	22	virtual-gate	punch-in exception	2017-08-11 15:43:49	2017-08-11 15:43:49	2017-08-11 15:43:49	740
465	adcc6df1-9644-4838-86ad-ade44404c613	157	22	virtual-gate	punch out exception	2017-08-11 15:43:57	2017-08-11 15:43:57	2017-08-11 15:43:57	\N
466	908464f5-2baa-4606-92fc-910ac7142ddc	157	22	virtual-gate	punch-in exception	2017-08-11 15:44:43	2017-08-11 15:44:42	2017-08-11 15:44:42	741
467	6b18703c-60cf-48de-ad47-5ba70e09a607	157	22	virtual-gate	punch out exception	2017-08-11 15:45:01	2017-08-11 15:45:00	2017-08-11 15:45:00	\N
468	672da936-070c-4d4f-ad76-2cd801a60fb8	157	18	virtual-gate	punch-in exception	2017-08-11 15:46:21	2017-08-11 15:46:20	2017-08-11 15:46:20	742
469	48fb2fc5-1ee1-4ada-a12d-88f2b32240f9	157	18	virtual-gate	punch out exception	2017-08-11 15:47:52	2017-08-11 15:47:51	2017-08-11 15:47:51	\N
470	888c8ee3-1eb3-4f02-a30d-6928775b7154	203	22	hffffhhy their if to	punch-in exception	2017-08-11 15:52:36	2017-08-11 15:52:36	2017-08-11 15:52:36	743
471	9b32b415-c1d5-4c74-9f0f-1da81890e6b4	157	22	Badge input	punch-in exception	2017-08-11 15:52:52	2017-08-11 15:52:52	2017-08-11 15:52:52	744
472	a9dc7474-af98-4f8f-9fec-9446a1b659c8	157	22	Badge input	punch out exception	2017-08-11 15:53:58	2017-08-11 15:53:57	2017-08-11 15:53:57	\N
473	1e154016-8867-408f-ab9b-7304c9796fd9	203	22	hfg didn't hi get	punch out exception	2017-08-11 15:54:24	2017-08-11 15:54:23	2017-08-11 15:54:23	743
474	79a884cb-46c4-4f6d-9694-823299521515	157	22	virtual-gate	punch-in exception	2017-08-11 21:22:30	2017-08-11 21:22:29	2017-08-11 21:22:29	745
475	db73e030-f71d-45ce-b113-b657907df94a	157	22	virtual-gate	punch out exception	2017-08-11 21:22:31	2017-08-11 21:22:30	2017-08-11 21:22:30	\N
476	adc84b55-6cf2-4774-b68c-b5a4e5a621d4	223	60	test	punch out exception	2017-08-14 11:49:48	2017-08-14 11:49:47	2017-08-14 11:49:47	733
477	8ca2e27c-c93c-479e-8fde-128959930d56	223	65	test	punch-in exception	2017-08-14 11:49:57	2017-08-14 11:49:57	2017-08-14 11:49:57	748
478	62cba825-d84a-44db-b07d-d123aeb87c98	223	65	test	punch out exception	2017-08-15 13:42:23	2017-08-15 13:42:23	2017-08-15 13:42:23	748
479	7223745a-20bb-4593-af4f-b668dfd321b1	223	60	no	punch-in exception	2017-08-15 13:42:34	2017-08-15 13:42:33	2017-08-15 13:42:33	749
480	95184bd4-5237-43cf-982d-26f1c2accc77	135	16	virtual-gate	punch-in exception	2017-08-16 12:01:08	2017-08-16 12:01:07	2017-08-16 12:01:07	750
481	d0cbc87b-9a77-40fa-b854-ba3b225d8b42	135	16	virtual-gate	punch out exception	2017-08-16 12:01:11	2017-08-16 12:01:10	2017-08-16 12:01:10	\N
482	7cbeff7b-af39-445c-8ba5-6af1536a8905	135	16	virtual-gate	punch-in exception	2017-08-16 12:02:39	2017-08-16 12:02:38	2017-08-16 12:02:38	751
483	fae5a1cb-ebf7-4ed5-aa24-3f68e3c9df5e	135	16	virtual-gate	punch out exception	2017-08-16 12:02:50	2017-08-16 12:02:49	2017-08-16 12:02:49	\N
484	ca2d3bc7-6a74-4410-870a-6495051a3e39	157	22	bdndfh	punch out exception	2017-08-16 12:34:19	2017-08-16 12:34:19	2017-08-16 12:34:19	684
485	993a88e6-bade-4431-984c-dc9dfbcb13e7	157	22	hebddhd	punch-in exception	2017-08-16 12:35:38	2017-08-16 12:35:37	2017-08-16 12:35:37	754
486	27b3a43f-30d4-4a30-b330-4a8570716195	157	22	jdjdjd	punch out exception	2017-08-16 12:35:54	2017-08-16 12:35:54	2017-08-16 12:35:54	754
487	72c73e44-64c2-4393-8432-4f1345bdcba5	157	22	hdjdjf	punch-in exception	2017-08-16 12:36:09	2017-08-16 12:36:09	2017-08-16 12:36:09	755
488	b4cf8a3e-7af4-4ca7-be1d-d53653469774	157	22	hehefh	punch out exception	2017-08-16 12:36:18	2017-08-16 12:36:18	2017-08-16 12:36:18	755
489	d5bccd52-1400-4164-905f-eb4aacd3f8ec	157	18	ndndjfjf	punch-in exception	2017-08-16 12:36:27	2017-08-16 12:36:27	2017-08-16 12:36:27	756
490	b43e36d8-2b6a-4b42-b378-47c338959b90	157	18	hdbdfhdj	punch out exception	2017-08-16 12:36:35	2017-08-16 12:36:35	2017-08-16 12:36:35	756
491	d7f82f7d-7d68-4c5b-b708-978507c5a206	157	18	bfndfj	punch-in exception	2017-08-16 12:40:16	2017-08-16 12:40:15	2017-08-16 12:40:15	757
492	fc11d358-7928-496d-b3e2-f425eca0fa59	203	18	Badge Input	punch-in exception	2017-08-16 12:40:47	2017-08-16 12:40:47	2017-08-16 12:40:47	758
493	7eccaffa-a302-4995-8cab-a0883423e49d	157	18	ndjejf	punch out exception	2017-08-16 12:41:01	2017-08-16 12:41:00	2017-08-16 12:41:00	757
494	49dd5c26-8a23-4cd1-9f33-39b0c6fc5e80	157	22	hehrf	punch-in exception	2017-08-16 12:41:08	2017-08-16 12:41:07	2017-08-16 12:41:07	759
495	ad501437-ef0e-4229-9f0a-746abf549140	203	22	Badge Input	punch-in exception	2017-08-16 12:41:23	2017-08-16 12:41:22	2017-08-16 12:41:22	760
496	6c33770d-a89e-4c28-ab65-25449514e1a2	203	18	virtual-gate	punch out exception	2017-08-16 15:38:22	2017-08-16 15:38:22	2017-08-16 15:38:22	\N
497	e0774c8c-d131-4a16-8c32-2dd8ccb05485	157	22	virtual-gate	punch out exception	2017-08-16 15:39:09	2017-08-16 15:39:08	2017-08-16 15:39:08	\N
498	d57a8d3c-4ba1-4ca8-88d5-0915877dd3b0	203	22	virtual-gate	punch out exception	2017-08-16 15:39:30	2017-08-16 15:39:29	2017-08-16 15:39:29	\N
499	2a403b3f-0239-40e3-90f8-5c770a5e58d8	157	61	bdndhd	punch-in exception	2017-08-16 15:41:42	2017-08-16 15:41:42	2017-08-16 15:41:42	762
500	7b1acd79-f058-4aa8-bfc8-9bedab6c445b	157	61	bdndhd	punch out exception	2017-08-16 15:41:51	2017-08-16 15:41:51	2017-08-16 15:41:51	762
501	6c8ac194-0e2a-4895-9f87-23bf6cf3c009	223	60	test	punch out exception	2017-08-16 16:21:21	2017-08-16 16:21:21	2017-08-16 16:21:21	749
502	abd6511a-59ee-4039-8dcd-b49d379b2572	223	65	test	punch out exception	2017-08-16 16:25:50	2017-08-16 16:25:50	2017-08-16 16:25:50	764
503	8115ae68-7b30-442c-90e9-6a028f6a02af	223	60	test	punch out exception	2017-08-16 21:04:42	2017-08-16 21:04:41	2017-08-16 21:04:41	765
504	acb30a7f-b943-489d-8a61-93d00f524fc3	223	65	trst	punch-in exception	2017-08-17 14:34:22	2017-08-17 14:34:22	2017-08-17 14:34:22	775
505	97116879-cfe1-428e-a8d1-e879923f27d4	223	65	test	punch out exception	2017-08-17 14:46:44	2017-08-17 14:46:43	2017-08-17 14:46:43	775
506	da33053c-2cc9-4026-a327-21123bde03e3	183	22	hfgh	punch-in exception	2017-08-17 15:43:22	2017-08-17 15:43:21	2017-08-17 15:43:21	784
507	cc28d4c0-4732-44b9-b5c0-ec80174c8218	183	22	hgghy	punch out exception	2017-08-17 15:43:30	2017-08-17 15:43:29	2017-08-17 15:43:29	784
508	cb2bf323-f074-48a1-a0bf-dd6cfe7b928e	183	22	hftxd	punch-in exception	2017-08-17 15:43:56	2017-08-17 15:43:55	2017-08-17 15:43:55	785
509	2adbf773-2100-4b49-a7ab-17b1f0729527	183	22	I vgg	punch out exception	2017-08-17 15:44:17	2017-08-17 15:44:17	2017-08-17 15:44:17	785
510	d59ed782-f178-4752-b356-390b93e430cc	210	45	test	punch-in exception	2017-08-17 15:55:38	2017-08-17 15:55:37	2017-08-17 15:55:37	789
511	2f739a47-631f-4819-b2ba-ea44b1e85767	210	45	yep	punch out exception	2017-08-17 15:58:50	2017-08-17 15:58:49	2017-08-17 15:58:49	789
512	e4423cc7-1108-4713-a5ac-33ecd13626ab	210	60	test	punch-in exception	2017-08-18 15:20:19	2017-08-18 15:20:19	2017-08-18 15:20:19	797
513	52d1bd2b-9c4a-497c-b0e7-1cde6879f23a	210	60	inside	punch out exception	2017-08-18 18:38:11	2017-08-18 18:38:10	2017-08-18 18:38:10	797
514	3a509415-bc93-4229-a8dd-6babf5f00056	223	60	yep	punch-in exception	2017-08-18 20:17:26	2017-08-18 20:17:25	2017-08-18 20:17:25	798
515	87313648-b3de-441a-99e8-3575e792da79	223	60	trrrr	punch out exception	2017-08-18 23:29:06	2017-08-18 23:29:06	2017-08-18 23:29:06	798
516	2c5148cb-f9a6-4fda-a77d-ff161f56ad0c	223	60	lunch	punch out exception	2017-08-22 16:35:55	2017-08-22 16:35:54	2017-08-22 16:35:54	800
517	c7cc1ebe-44c2-45ec-aae9-d7b645a39c8d	223	60	inside	punch-in exception	2017-08-24 14:27:00	2017-08-24 14:27:00	2017-08-24 14:27:00	807
518	aa0496e6-c98a-4e85-8081-70d7ddbaf042	210	60	ok	punch-in exception	2017-08-24 18:15:02	2017-08-24 18:15:02	2017-08-24 18:15:02	808
519	e569db42-abc2-4781-9f5b-8941833f8687	210	60	hi	punch out exception	2017-08-24 18:15:18	2017-08-24 18:15:17	2017-08-24 18:15:17	808
520	d7511293-7f91-4698-8a8a-68478edf8c35	135	16	hyb bvjv	punch-in exception	2017-08-26 08:54:58	2017-08-26 08:54:57	2017-08-26 08:54:57	814
521	94351c5f-4458-4d7d-bfd2-d7212be349f7	135	16	test	punch-in exception	2017-08-26 08:57:00	2017-08-26 08:56:59	2017-08-26 08:56:59	815
522	3a09dd4a-41e4-4b61-8149-affac5adc5cb	135	16	st	punch out exception	2017-08-26 08:59:19	2017-08-26 08:59:18	2017-08-26 08:59:18	816
523	8269ae79-a4d2-4dce-a9b6-06528f866524	135	16	mjhh	punch-in exception	2017-08-26 09:00:25	2017-08-26 09:00:25	2017-08-26 09:00:25	818
524	53fa561b-7c8e-49c4-8d1e-709ae0a9a303	135	16	test	punch-in exception	2017-08-26 09:01:14	2017-08-26 09:01:13	2017-08-26 09:01:13	819
525	bfb1ced7-3ccd-4f9f-914e-80eca35196ba	135	16	test	punch-in exception	2017-08-27 09:26:25	2017-08-27 09:26:25	2017-08-27 09:26:25	833
526	fe20dacb-501b-407d-a5a2-264987028732	135	16	test	punch-in exception	2017-08-27 09:29:37	2017-08-27 09:29:37	2017-08-27 09:29:37	834
527	4ac7868a-a12d-46e6-9ef1-031f9aa8dd8a	208	60	test	punch-in exception	2017-08-28 22:03:57	2017-08-28 22:03:56	2017-08-28 22:03:56	847
528	370f4951-bb50-43ab-9ac6-b562c3ec849d	208	60	test	punch out exception	2017-08-28 22:04:05	2017-08-28 22:04:04	2017-08-28 22:04:04	847
529	959ecc50-db8b-42d2-9268-07486ba0c438	208	60	test	punch-in exception	2017-08-28 23:20:43	2017-08-28 23:20:43	2017-08-28 23:20:43	848
530	d062fa30-21ee-4ff3-9b3b-0a084d01be2c	208	65	test	punch-in exception	2017-08-28 23:21:50	2017-08-28 23:21:49	2017-08-28 23:21:49	849
531	a8043056-2386-402b-8f4f-066f880b7e86	208	60	test	punch-in exception	2017-08-28 23:22:03	2017-08-28 23:22:02	2017-08-28 23:22:02	850
532	ba2b1a9d-5e96-4e51-bed3-867d6be10e1b	208	60	test	punch-in exception	2017-08-28 23:22:41	2017-08-28 23:22:41	2017-08-28 23:22:41	851
533	8816f8e8-83e9-41bc-a06c-1ddd84ac0c11	226	70	test	punch-in exception	2017-08-31 14:32:47	2017-08-31 14:32:46	2017-08-31 14:32:46	860
534	70d610e2-f5fb-464a-90d3-e9833dab8698	226	70	virtual-gate	punch out exception	2017-08-31 15:31:37	2017-08-31 15:31:36	2017-08-31 15:31:36	\N
535	77b383c7-3a4b-433d-9d7d-c1d3c59e3a1f	210	60	test	punch out exception	2017-08-31 15:35:34	2017-08-31 15:35:34	2017-08-31 15:35:34	862
536	bf849b27-4246-4f69-a741-46cae5ea928d	209	60	test	punch-in exception	2017-08-31 15:35:58	2017-08-31 15:35:58	2017-08-31 15:35:58	863
537	1ee66894-b9fc-4ff9-8639-40b67ca72c81	226	70	test	punch-in exception	2017-08-31 15:37:23	2017-08-31 15:37:23	2017-08-31 15:37:23	864
538	12e118a7-506a-4478-a7d2-952bff4449c4	209	60	virtual-gate	punch out exception	2017-08-31 16:10:04	2017-08-31 16:10:03	2017-08-31 16:10:03	\N
539	2e5623f2-fc92-44ad-8dd7-dace096142ce	226	70	virtual-gate	punch out exception	2017-08-31 16:12:05	2017-08-31 16:12:05	2017-08-31 16:12:05	\N
540	72d243ff-d6f6-40de-af32-1ac5a7ecca6e	226	70	test	punch-in exception	2017-09-01 13:48:54	2017-09-01 13:48:53	2017-09-01 13:48:53	873
541	549be1ed-1ef7-4a0a-9b91-766d7cdf82fb	209	60	QR input	punch out exception	2017-09-01 14:09:16	2017-09-01 14:09:16	2017-09-01 14:09:16	\N
542	1ba993e4-5489-42c4-9824-5ce96c458106	210	60	QR input	punch out exception	2017-09-01 14:09:50	2017-09-01 14:09:49	2017-09-01 14:09:49	\N
543	deca8ff5-a6a1-4203-9b76-a2041a248fa8	226	70	virtual-gate	punch out exception	2017-09-01 14:11:49	2017-09-01 14:11:48	2017-09-01 14:11:48	\N
544	43f77a36-0cb1-433d-8baa-799519504e97	208	70	test	punch-in exception	2017-09-01 17:12:21	2017-09-01 17:12:20	2017-09-01 17:12:20	874
545	3cf2be50-ae55-47b6-a2ed-64a3185fda5c	208	70	test	punch out exception	2017-09-01 17:45:14	2017-09-01 17:45:13	2017-09-01 17:45:13	874
546	a90037e8-3f6f-4aa8-9a3e-b1aacdfec8d7	208	70	test	punch-in exception	2017-09-01 17:46:13	2017-09-01 17:46:13	2017-09-01 17:46:13	875
\.


--
-- Name: user_logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('user_logs_id_seq', 546, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: forge
--

COPY users (id, first_name, last_name, email, password, remember_token, created_at, updated_at, uniq_id, client_id, "mobileNumber", role, status, jdoc, username, permissions, deleted_at, tos_agree_date, "persistanceFaceId") FROM stdin;
1	IHOS	Superadmin	admin@punchcardllc.com	$2y$10$jc7Z4HHPbYow/25yRayfv.mJVZTzdbnUxjtAqfTxxdF/PhOgK877u	MvsvnKrC3cITHTRY9xkrM3cZRgxZYO41pmDqa09kc8z0BWIdhaoqCCuEFoYe	2017-01-20 18:27:05	2017-02-03 18:25:23	fe481698-2043-4177-9bc6-0e0fc1a0dea8	1	555-555-1212	superadmin	active	{"address": {"address1": ""}, "vehicle": {"carMake": ""}, "emerContact": {"name": ""}, "payroll_data": {"pay_rate": ""}}	ihosSuperadmin	{"reports": [], "scanner": []}	\N	\N	\N
2	monika patel	kumar	monica@geeksperhour.com	$2y$10$9vBMbV.0Ikm/U/aDEzplmecriq3HcRjmbBTMklH/q0YXGX5HZ/DP2	koSfAeoyJUuuDoFCdOPkq33IqWfRUiAAm8FS1fFMei9UzQuC8B3Q3ZEt73MR	2017-05-23 06:54:36	2017-08-04 13:56:55	5489e937-a90a-492d-a628-5afd73c3dcee	2	8525852582	user	active	{"trade": "HR", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "HR", "department": "HR", "homeNumber": "", "middleName": "monika ", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	monica@geeksperhour.com	{"reports": [], "scanner": [17]}	\N	\N	\N
133	TestEmployee	TestEmployee	harshadTestEmployee@dispostable.com	$2y$10$eFTb7iVCgX0F8lX6GoNB1e.faUzzZeZw8IxPmTP2VwgXOg79K85Lq	Yp2e75QqfTLUTJodSucXAIqz76LxrVxZyWTwGeNL3kXpioXFh723Capx80DZ	2017-06-16 10:28:55	2017-07-07 06:23:05	f5a88fad-341b-4629-acda-c1ab117085e8	88	7823232323	clientadmin	active	{"trade": "ABC", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "User", "department": "IT", "homeNumber": "7823232323", "middleName": "TestEmployee", "workNumber": "7823232323", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	55	{"reports": [], "scanner": [16]}	\N	\N	\N
134	TestSuperUser	TestSuperUser	harshadTestSuperUser@dispostable.com	$2y$10$AS1EsZy/0o1sGSi7lDtbse10GWLE/YodNBlkg6DMagkqkoOxeMaKe	rOcDcChSKkigpeU1av2YGY3zI3nhUNYLEFCHg9BJ2QNwa2SGzIXx6wmbwz59	2017-06-16 11:27:18	2017-06-16 11:42:39	1ea6ab99-eacc-44d8-9db7-e7bf72fae817	88	5656565656	superuser	active	{"trade": "ABC", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "ABC", "department": "ABC", "homeNumber": "5656565656", "middleName": "TestSuperUser", "workNumber": "5656565656", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	TestSuperUser	{"reports": [], "scanner": [16]}	\N	\N	\N
135	TestUser	TestUser	harshadTestUserEmployee@dispostable.com	$2y$10$tfMWn.cqrX.d1u4t8UnbrerApj1LXHcb9sqNmEV49/w9HAjfhaOJm	S1RQnscIoxoWpE97K3AJmVPB5N48GLn64pvRvk1n17n9XC2sdbWWUZ1JAuqB	2017-06-16 11:54:36	2017-08-26 06:52:19	7fb7eddb-6587-4f98-b669-12282c6b89a6	88	5678567856	user	active	{"trade": "ABC", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "123", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "ABC", "department": "ABC", "homeNumber": "5678567856", "middleName": "TestUser", "workNumber": "5678567856", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}}	TestUser	{"reports": [], "scanner": [16]}	\N	\N	\N
143	GeeksClientAdmin	GeeksClientAdminLast	GeeksClientAdmin@dispostable.com	$2y$10$2j7Qx5KXKWrn.tl2LFMnL.YFmO7df/IDe77A2FcltewDDMkId7zIO	Q72zFRL4EVtaBU8yhjyrGGQYbKiw9MK0ftwXHEvcMHgORUK211YKx0I3z3o3	2017-06-28 11:51:17	2017-06-28 12:03:03	88f8b53e-452d-4df1-88bb-41a5aa1b9b75	102	7654321234	clientadmin	active	{"trade": "HR", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "HR", "department": "HR", "homeNumber": "7654321234", "middleName": "GeeksClientAdminMiddile", "workNumber": "7654321234", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	GeeksClientAdmin	{"reports": [], "scanner": []}	\N	\N	\N
141	harshadtestingemployee	harshadtestingemployee	harshadtestingemployee@dispostable.com	$2y$10$RbsVlLc5lsPikFsx/CgzyuBJvpt2am.Vmiqj67GWxYB0XWOjAAzrW	\N	2017-06-22 12:37:22	2017-06-22 12:51:55	f2c788f0-c6af-4d3d-9a1a-399cc5c077c8	101	3456789876	clientadmin	active	{"trade": "harshadtestingemployee", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "harshadtestingemployee", "department": "harshadtestingemployee", "homeNumber": "3456789876", "middleName": "harshadtestingemployee", "workNumber": "3456789876", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	harshadtestingemployee@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
144	GeeksSuperUser	GeeksSuperUserLast	GeeksSuperUser@dispostable.com	$2y$10$ydJ2avzdvfjODw5UTpuCSuaJ5G0UwSWSWRQ17MjEbvjK.CzBii.7m	hgnVwxMqBrAADIqRI0tuvCSgsNGpxfb0Ozyc5yORVuKlUg0ycDKSQna5H0s6	2017-06-28 11:54:25	2017-06-28 11:58:57	ea4d8eae-14a3-4ce4-8248-75ca30a87cc4	102	8989787878	superuser	active	{"trade": "HR", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "HR", "department": "HR", "homeNumber": "8989787878", "middleName": "GeeksSuperUserMiddile", "workNumber": "8989787878", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	GeeksSuperUser	{"reports": [], "scanner": []}	\N	\N	\N
142	GeeksEmployee	GeeksEmployeeLast	GeeksEmployee@dispostable.com	$2y$10$NCVeyj3bGwAm3XlkVELJl.30/pDiooBWN4pzGt/tSX41er1yLo/d2	jQfe20UYGvxeAYRlNvLXm5NlulU3FKZ1hBb5RlnD4CkYQwwuoQ0ZQPjmUTte	2017-06-28 11:49:12	2017-06-28 13:16:17	42d7f138-0cb8-4413-a125-9a0ce41386d6	102	7878989865	user	active	{"trade": "HR", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "HR", "department": "HR", "homeNumber": "7878989865", "middleName": "GeeksEmployeeMiddile", "workNumber": "7878989865", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	GeeksEmployee	{"reports": [], "scanner": []}	\N	\N	\N
197	tutyuty	tyutyu	ffggsgd@dispostable.com	$2y$10$iUV4GNA4FY7LG5M.O9Mj/uUJgV/S8CW01lyPnP87z.xarCCb.1S9q	\N	2017-07-13 13:33:11	2017-07-13 13:33:11	b6df6e51-ee3f-4c01-8ef4-23cfa7714a89	130	3696969696	clientadmin	active	{"trade": "tyuty", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "utyu", "department": "tyuty", "homeNumber": "", "middleName": "tyuty", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	ffggsgd@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
198	fraqwr	qwr	afgasfs@dispostable.com	$2y$10$PY3sz/3QuRsWJlC/JiRZtuxap.8nsb/4cMp98rG94BK4FjRPBomCm	\N	2017-07-13 13:36:27	2017-07-13 13:36:27	ecaafae8-e818-4144-8bcb-1549a50467a6	130	2323343433	superuser	active	{"trade": "qwrqwr", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "qwrwqr", "department": "qwrqw", "homeNumber": "", "middleName": "qwqrwqwr", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	afgasfs@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
199	dgd	gdfgds	gdsgg@dispostable.com	$2y$10$K3YWsnk/6t3cnTFvJg2kJOM2oMIdXpQh0KBN.CWLUG8SENcnTCKuq	\N	2017-07-13 13:51:30	2017-07-13 13:59:11	6b1a268b-136f-497a-bb8a-43773ad145bb	130	1233212343	superuser	active	{"trade": "dsg", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "dsdsg", "department": "dsgds", "homeNumber": "", "middleName": "dsg", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	gdsgg@dispostable.com	{"reports": [], "scanner": []}	2017-07-13 13:59:11	\N	\N
200	dfgd	dfg	fdgdfgdfg@dispostable.com	$2y$10$6/DG9SUULnNndD70dyw9revmDSuKXptWdel1RHVFE1Vs/YCV48KRq	\N	2017-07-13 14:08:24	2017-07-13 14:08:24	b3e66a7c-7b68-4a81-bc3e-7d0c32a679d3	130	2585858585	superuser	active	{"trade": "dfgdf", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "dfgdfg", "department": "gdfg", "homeNumber": "", "middleName": "dfgfdgf", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	fdgdfgdfg@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
145	PC001	EE01CA	PC001EE01CA@dispostable.com	$2y$10$5W6kCjClQXUeyoIGFcYDKe2XknxzWT2bNaXfuecM13j6uAamOrjRC	IjLyy2Ov5Pux2suIwl8YqiFBncKWOnbxDotakXyEK8gM5vPVe1g8lirPhz86	2017-06-29 18:12:38	2017-06-29 18:20:08	22a4aecd-e9a9-4538-9e3f-3e7cd00b61bf	103	1111111111	clientadmin	active	{"trade": "Operations", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Client Admin", "department": "Administration", "homeNumber": "1111111111", "middleName": "Danger", "workNumber": "1111111111", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	PC001EE01CA	{"reports": [], "scanner": []}	\N	\N	\N
146	test	test	PunchcardTestA@dispostable.com	$2y$10$nhauhzCvqOMJh6F2nHzQMuZ.0R.Cu.WVErGK63WkOHoqWvqUGgWW2	ZFk4lT6KAYpPOq2qxrCUk6RQ89nMF6Y6XE9yZ81Iy34lvYQaF9SZS1WrvCwQ	2017-06-29 19:08:17	2017-06-29 19:12:22	9631336f-d862-43cb-89a3-5c744425df8a	2	0000000000	clientadmin	active	{"trade": "test", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "test", "department": "test", "homeNumber": "0000000000", "middleName": "test", "workNumber": "0000000000", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	PunchcardTestA	{"reports": [], "scanner": [17]}	\N	\N	\N
148	PC001	EE02SU	PC001EE02SU@dispostable.com	$2y$10$WuCDDCS3r5uqwMgnEiVm6OGVduzkPjJGQLzV4.2yfrSXVec4Mp5r6	lfdablddXxBe53lSWrHxiSpFXdviCOXlHutu3R6Mxpi4OaNsv8FelSffb52K	2017-06-29 19:33:16	2017-06-29 19:34:11	280e72da-fea9-4e16-a2c1-da3af9d858da	103	1111111121	superuser	active	{"trade": "Operations", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Super User", "department": "Administration", "homeNumber": "1111111121", "middleName": "Danger", "workNumber": "1111111121", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	PC001EE02SU	{"reports": [], "scanner": []}	\N	\N	\N
149	PC001	EE03UR	PC001EE03UR@dispostable.com	$2y$10$ngdaSZmbuzgw/8dgLTdtsuvf7v6VYuP9Ya/lfoSVZeY8fE9GiV61.	yJTkzkxadTXqWx0NkzK4kP49VAvBtMZCl3QvcTSSqgQucPDzDNMZ44iMcDKV	2017-06-29 19:40:57	2017-06-29 19:42:29	1ce47e0d-877f-4ad4-80ea-8aebe8f03876	103	1111111131	user	active	{"trade": "Operations", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "User", "department": "Administration", "homeNumber": "1111111131", "middleName": "Danger", "workNumber": "1111111131", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	PC001EE03UR	{"reports": [], "scanner": []}	\N	\N	\N
151	myparentclientharshadclientadmin	myparentclientharshadclientadmin	myparentclientharshadclientadmin@dispostable.com	$2y$10$Vmq./yWIDGmtWmpAAyNhoO.1ufzsv6usqOR.5yUaXnF9teLu37Lq.	H7W6aUEL9PZwCQJXQxcNiUAexsSQbsn2KWRWzKZ4TiZ4YwXublkVSTMc8loq	2017-06-30 13:48:06	2017-06-30 13:49:49	7051c220-5cb6-420e-8f6e-d16f42f61d26	110	2234564322	clientadmin	active	{"trade": "myparentclientharshadclientadmin", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "myparentclientharshadclientadmin", "department": "myparentclientharshadclientadmin", "homeNumber": "2234564322", "middleName": "myparentclientharshadclientadmin", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	myparentclientharshadclientadmin	{"reports": [], "scanner": []}	\N	\N	\N
152	myparentclientharshadsuperuser	myparentclientharshadsuperuser	myparentclientharshadsuperuser@dispostable.com	$2y$10$NlsINvtC8j.MsZHEa2RYX.G66Wg.B1UU24WqlJd9fkqmBdSAKoHHS	jvbcij5ydtaHUsyMgVbDk3A7Y52iaEKcjAVyvJ9pYLARlQzHvBaKDPJ26IHd	2017-06-30 13:52:58	2017-06-30 13:55:20	4f2cb1ef-eaf5-48be-ab29-1cebf8e56eca	110	2587414563	superuser	active	{"trade": "myparentclientharshadsuperuser", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "myparentclientharshadsuperuser", "department": "myparentclientharshadsuperuser", "homeNumber": "", "middleName": "myparentclientharshadsuperuser", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	myparentclientharshadsuperuser	{"reports": [], "scanner": []}	\N	\N	\N
147	Test	Test	PunchcardTest1@dispostable.com	$2y$10$v45EmFrt9chH7kXQfLpx9uFqWLmlfPxcst0FvEzHy7XrFYY8UZmx6	UKUa2EM6BqwkP2zGLZrzH80B7gvblL0nxqWko1SEjWk3CZ6agCVRv1TI3tXT	2017-06-29 19:27:25	2017-06-29 19:28:31	bbde77e9-d593-48c5-b483-4ee1961b70ef	2	0000000001	clientadmin	active	{"trade": "Test", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Test", "department": "Test", "homeNumber": "0000000001", "middleName": "Test", "workNumber": "0000000001", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	PunchcardTest1	{"reports": [], "scanner": [17]}	\N	\N	\N
164	aafrwhh	aqgdsgs	rohit1234@dispostable.com	$2y$10$jc7Z4HHPbYow/25yRayfv.mJVZTzdbnUxjtAqfTxxdF/PhOgK877u	8r01HIhNZ3gWYUGAac5Dd3py3lxBJVnq8D6weoOeJAWJQg2uzYUJeWgRpBJw	2017-07-03 13:12:34	2017-07-03 13:15:22	778ca421-2956-4f16-92ea-31c69ef3fec5	121	7857554895	user	active	{"trade": "aassg", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "aasg", "department": "sgsaafgjfj", "homeNumber": "6523147896", "middleName": "aesgsgs", "workNumber": "8526975466", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	rohit1234	{"reports": [], "scanner": [68]}	\N	\N	\N
158	palash admin	palash admin	palashnnnnnnn@dispostable.com	$2y$10$ca490jxY33/43oe3mg46V.A2E12xrtpR2F8h7qjn6p8qLbjDzEHZ6	eb7NG0wuh5y8waTgWRW54dI1RXqdnib9TIT5YRMrpr5ANbGopf1zrX6gju3B	2017-07-03 07:19:11	2017-07-03 07:21:21	03ad0a2a-3937-4527-9374-265cf462dfa6	120	5585858585	clientadmin	active	{"trade": "palash admin", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "palash admin", "department": "palash admin", "homeNumber": "", "middleName": "palash admin", "workNumber": "", "emerContact": {"name": "palash agrawal", "email": "", "relation": "", "homeNumber": "02397842475", "workNumber": "02397842475", "mobileNumber": "02397842475"}, "payroll_data": {"pay_rate": 0}}	palashnnnnnnn@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
159	palashuser	palashuser	palashuser@dispostable.com	$2y$10$c7BL.3KIhJqTBh074lemM.Bkk7GXSeshdl3fwtKphqpqnaHdMUHG.	YVVC66tcZ5AJWyUb4smmYTkgUE1AuB5nnlrfzvHLqYH1xH4OzeuVIYaK6ua2	2017-07-03 07:26:24	2017-07-03 07:31:39	9c059b80-e349-4e29-9a48-568fa639a7ba	120	5536363232	superuser	active	{"trade": "palashuser", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "palashuser", "department": "palashuser", "homeNumber": "", "middleName": "palashuser", "workNumber": "", "emerContact": {"name": "palash agrawal", "email": "", "relation": "", "homeNumber": "02397842475", "workNumber": "02397842475", "mobileNumber": "02397842475"}, "payroll_data": {"pay_rate": 0}}	palashuser@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
165	Ted	Asma	tedasma@gmail.com	$2y$10$mlXcXdNcUxUzG8MeimYLiezHSruHCz5i8lMGzoV..SxTA6aXwYk5G	T0unjLn5v1HxAyhIstNpO5atX9CSfEb0qjB27Jyo2Ty7Likbmqp16xtaPnqJ	2017-07-05 18:56:07	2017-07-05 18:59:54	f8238b2d-a57c-4dcc-872c-ae07d2287ac2	125	2625738979	clientadmin	active	{"trade": "Consultant", "address": {"zip": "34230", "city": "Sarasota", "state": "Florida", "address1": "PO Box 3423", "address2": ""}, "vehicle": {"carMake": "Audi", "carModel": "A4", "licPlateState": "Florida", "licPlateNumber": "DBA-N17", "driversLicenseState": "Florida", "driversLicenseNumber": "123-4567890-12"}, "job_title": "Consultant", "department": "Operations", "homeNumber": "", "middleName": "W", "workNumber": "", "emerContact": {"name": "Ted Asma", "email": "tedasma@gmail.com", "relation": "", "homeNumber": "2625738979", "workNumber": "2625738979", "mobileNumber": "2625738979"}, "payroll_data": {"pay_rate": "25"}}	asma	{"reports": [], "scanner": []}	\N	\N	\N
160	palash3593	palash3593	palash3593@dispostable.com	$2y$10$Rmb.im2zNgnHfK6QQjTMxO5Ab8En0Zc2uCPGFfuidHFsMPlXNzdMO	tbQctdXN8XMUArbHBitsgrc4O3RDFE10Atw26rrQ2bgFpb4zaUGRqW9nv67F	2017-07-03 13:07:25	2017-07-03 13:09:24	2c9af668-96b6-4769-b409-653017ed98bf	121	7896541236	clientadmin	active	{"trade": "palash3593", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "palash3593", "department": "palash3593", "homeNumber": "3698521478", "middleName": "", "workNumber": "7896325412", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	palash3593	{"reports": [], "scanner": [68]}	\N	\N	\N
157	Bryan	Perry	brperry2006@gmail.com	$2y$10$NGjwYzYQnCIZsUMYtjydSukm21CTaRLOcCE.2/WJP7PGdX9A00vH6	VXCd5wOEnPSpVC8dW7RXMEv1HgvK12E5h9eRkvdpyPCg06OOddhfGrIVXo1a	2017-06-30 18:37:46	2017-07-26 15:55:14	edfd19f1-7ee9-4e26-ad8b-9ab6009bf579	119	9412766925	clientadmin	active	{"trade": "Consulting", "address": {"zip": "33950", "city": "Punta Gorda", "state": "FL", "address1": "123 Main", "address2": ""}, "vehicle": {"carMake": "Chevy", "carModel": "Tahoe", "licPlateState": "FL", "licPlateNumber": "punch", "driversLicenseState": "FL", "driversLicenseNumber": "p100100100"}, "job_title": "Manager", "department": "Management", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "Ted Asma", "email": "emergencycontact@dispostable.com", "relation": "Related", "homeNumber": "1112223344", "workNumber": "2625738979", "mobileNumber": "2625738979"}, "payroll_data": {"pay_rate": "50"}}	bryan	{"reports": [], "scanner": [18, 63, 66, 61, 22]}	\N	\N	\N
170	Super	Admin 1	sa1@dispostable.com	$2y$10$ULEyaxh9lKuqZJ3Q3qkCvOHDwHDFQ6ucQcGwn6qgztUVdFHWl7.6K	zBrYNKQY1RMwoRmKuGK2ulur4GRXb9mbiRnsVMd1BKU2RXYaN9vOcIeLGiEW	2017-07-05 20:03:53	2017-07-26 15:56:21	2cefa2ec-0014-4670-b0bb-6f93d15558cd	119	9411112221	superuser	active	{"trade": "testing", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Truck", "carModel": "SA1", "licPlateState": "FL", "licPlateNumber": "SA1", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "super admin", "department": "admin", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "50"}}	sa1	{"reports": [], "scanner": [18, 22]}	\N	\N	\N
171	Admin	Asmasc	adminasmasc@dispostable.com	$2y$10$vX7zuiltBFaYgQtLWYS4AOIGrbBrjteT5zeJX423JdP7FNWpnDlSa	V3XF49nUF7LGVHJ67TYU27vdsz8iMzwAyJ4CGYKIaGY1ptz3uhIjr7g1FmHR	2017-07-05 20:04:35	2017-07-05 20:11:03	042a0d63-93db-4cd8-be33-31e9cc67a7ce	126	2625738991	admin	active	{"trade": "SC Admin", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "SC Admin", "department": "SC Admin", "homeNumber": "2625738991", "middleName": "", "workNumber": "2625738991", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	adminasmasc	{"reports": [], "scanner": []}	\N	\N	\N
172	User	Asmasc	userasmasc@distpostable.com	$2y$10$ASfZHW1DqzzMRq2XQa4n6OP3jXFeZUfKZAt79ETUnnp8SzmXvh.BG	\N	2017-07-05 20:07:08	2017-07-05 20:14:47	26c5c371-16c8-4157-86c2-8e1197fe5146	126	2625738992	user	active	{"trade": "User SC", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "User SC", "department": "User SC", "homeNumber": "2625738992", "middleName": "", "workNumber": "2625738992", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	userasmasc	{"reports": [], "scanner": []}	2017-07-05 20:14:47	\N	\N
166	User	Asma	userasma@dispostable.com	$2y$10$FoPdqftOBhoQwosTd2lWOuDRRqZGZOvMvesaqnq.jQXslOYQ.Kjr.	AvtvAciJmTcQlcqhJk6xAcklJSxtDylCuQhhDYnAh0SJ5eoEHScTHxXUK6VO	2017-07-05 19:32:36	2017-07-05 20:25:22	80b67067-c55c-4415-9bd6-6f134ace01e7	125	2625738980	user	active	{"trade": "Consulting", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Consultant", "department": "Operations", "homeNumber": "", "middleName": "W", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "10"}}	UserAsma	{"reports": [], "scanner": []}	\N	\N	\N
173	Super	Admin 2	sa2@dispostable.com	$2y$10$0lF5pmL0bSsxQEIfy4emOOMn59vO4Q/FyYJeMshkpUJGqtWHH874O	Zt2n5LYgUVShZXdIXKY6XrTxIlMgIhRERQPIdrammf9DlAHaFJXaV36W6kPH	2017-07-05 20:08:17	2017-07-26 15:56:04	abbf331b-ea81-42c1-8d29-21c77389c4ac	119	9411112222	superuser	active	{"trade": "Testing", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Car", "carModel": "SA2", "licPlateState": "FL", "licPlateNumber": "SA2", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Admin 2", "department": "Admin", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "50"}}	sa2	{"reports": [], "scanner": [18, 22]}	\N	\N	\N
174	User	Number 1	u1@dispostable.com	$2y$10$HnPO4h5UApwYU.rmfm9AE.lmen05mjF6pkmGxViVqcv9DIzymz4wu	JMesNXC1ymG1boUyrGFGdqOPPG4p30P3otlj22tXTS9pdUvMlnYmOsWicTQR	2017-07-05 20:10:04	2017-07-26 15:55:36	51327afb-2fc2-487b-ad75-68c3ee215da8	119	9411112223	user	active	{"trade": "Test", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Truck", "carModel": "U1", "licPlateState": "FL", "licPlateNumber": "U1", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "User", "department": "", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "25"}}	u1	{"reports": [], "scanner": [18, 22]}	\N	\N	\N
175	User	Number 2	u2@dispostable.com	$2y$10$w7MpLkHskBqiyNAX6xgPFey8ILAVRbw4/xgT0EXzqzAz5usYo/2cK	KzZW8frN8fmE81CpFoeIQ8QJLvPm9wsTljYZfdSdEiK4z3NEwEnlk0GMRPxQ	2017-07-05 20:11:01	2017-07-26 15:55:27	4b61738f-cb11-409b-aaf2-a0e35ff6b7ee	119	9411112224	user	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Car", "carModel": "U2", "licPlateState": "FL", "licPlateNumber": "U2", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "User", "department": "Users 2", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "25"}}	u2	{"reports": [], "scanner": [18, 22]}	\N	\N	\N
176	User01	Asmasc	user01asmasc@dispostable.com	$2y$10$UdM144vTC9y3gqCHSJ1XHeoUFbEV8m2ZSyPcZIWL0k8feCd4WzjGW	Z47nEEpTz9ypGre2vZhdHxr86Hc6xVPInQPWhcSiJoLCpxE3tOdpB5gATq9C	2017-07-05 20:21:57	2017-07-06 16:48:23	864a0c62-ce03-4196-9640-2f261b98d8f9	126	2625738993	user	active	{"trade": "user01asmasc", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "user01asmasc", "department": "user01asmasc", "homeNumber": "2625738993", "middleName": "", "workNumber": "2625738993", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	user01asmasc	{"reports": [], "scanner": []}	\N	\N	\N
169	Super	Asma	superasma@dispostable.com	$2y$10$8PhglD6TVhUtyYrHLFTtL.Er.Ix8urXqhkbjUK666lJBUt4sJBdDC	6RI3xnpQHv7tajOmZ5TXgGYLVgJhXH7cMKZf8H4h3JXXexdbmkVPPnUQOKoQ	2017-07-05 19:35:56	2017-07-05 20:26:33	b6cb5500-29d2-49cf-aa58-c127770f0999	125	2625738981	superuser	active	{"trade": "Consulting", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Consultant", "department": "Operations", "homeNumber": "", "middleName": "W", "workNumber": "", "emerContact": {"name": "Ted Asma", "email": "", "relation": "", "homeNumber": "2625738981", "workNumber": "2625738981", "mobileNumber": "2625738981"}, "payroll_data": {"pay_rate": "15"}}	superasma	{"reports": [], "scanner": []}	\N	\N	\N
182	Co 2	Admin 2	co1a2@dispostable.com	$2y$10$mk6AKwhJXal3SXFGXzrnVuDVTfx09miClyKMFBYRv4Z.jzdWfX2Eu	G1DZaJs72Bc5m8vZMwLuUugTXMxHNjKce1KjN1guFjxcsrnlvTVTRdkotY0r	2017-07-06 15:18:11	2017-07-26 15:53:22	f1719ea0-249e-4afb-a4c8-e09407f14a1e	128	9412223335	admin	active	{"trade": "Water Boy", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Segway", "carModel": "co2a2", "licPlateState": "FL", "licPlateNumber": "co2a2", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Admin", "department": "Super", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "45"}}	co2a2	{"reports": [], "scanner": [22, 18]}	\N	\N	\N
183	Co 2	U 1	co2u1@dispostable.com	$2y$10$A1iyCF6Oc2zypQABz0HmjOUHT.REhWQtrGEjYos2YsOI8.RXObrLS	zdVIqOWFuz0T9f4G0KggPFKBZNxlHq2KfLVu7A41GypPRwceIHmU0UWIBIdZ	2017-07-06 15:19:33	2017-07-26 15:53:33	e376af8e-5e87-4ba7-b953-7891b34be261	128	9412223336	user	active	{"trade": "consumer", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Skateboard", "carModel": "co2u1", "licPlateState": "WY", "licPlateNumber": "co2u1", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "user", "department": "using", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "35"}}	co2u1	{"reports": [], "scanner": [22, 18]}	\N	\N	\N
178	Co 1	Admin 2	co2a2@dispostable.com	$2y$10$wBZf.OgJFEIb7uRiM4affexsE5CQXVoc/C4cwOXFVIVO9YXDD3TYi	yuURUnLscudyhcbBA1j7K89DY6kUqmyu7JLx3mg8LN5SqIAmmZhmQErbiRP8	2017-07-05 20:43:22	2017-07-26 15:52:05	6411af56-406f-4e3e-a034-dd92d4664f03	127	9412222223	admin	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Truck", "carModel": "co1a2", "licPlateState": "AZ", "licPlateNumber": "co1a2", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Admin 2", "department": "Admin", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "45"}}	co1a2	{"reports": [], "scanner": [18, 22]}	\N	\N	\N
179	Co 1	U 1	co1u1@dispostable.com	$2y$10$Zl3C9sOLWkg5M/wYgq8xK.pq4b0iO/YBaZfD.9eSdP2TvvWqyuvOG	M8LTDkOKsb3O8xo1QcDmoDO7CVApxncKUcNuGJ4ORoQKQMDyB2GOrftgfynr	2017-07-05 20:44:32	2017-07-26 15:52:16	622f5bdb-71f9-472d-9650-6b80d91b041b	127	9412222224	user	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Car", "carModel": "co1u1", "licPlateState": "FL", "licPlateNumber": "co1u1", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "User 1", "department": "User", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "35"}}	co1u1	{"reports": [], "scanner": [22, 18]}	\N	\N	\N
180	Co 1	U 2	co1u2@dispostable.com	$2y$10$TRsXcpESVbeROfg1vEUhDuZEg5JbrFeWUoOoLrDvSi730rsv2i.4W	8m6AdFpY3OGrxPHbtiguEGWoziwQE01Z82itnU5AwMy7ZuJzHZxZOcumQbKh	2017-07-05 20:45:47	2017-07-26 15:52:28	8f9194a9-fc44-488e-a2c1-96a13ae5279c	127	9412222225	user	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Truck", "carModel": "co1u2", "licPlateState": "NY", "licPlateNumber": "co1u2", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "User 2", "department": "User", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "35"}}	co1u2	{"reports": [], "scanner": [22, 18]}	\N	\N	\N
184	Co 2	U 2	co2u2@dispostable.com	$2y$10$ZuMjnUKxCHSxk7eMLeGZbufoA1pg7fQ5zl3b9eq1xguRzDkolTF7a	c0KqkMJPDrfjxn0mwdWVR01jS0fiwSKAoaFob8jsh3HEE7LxiuTJdgGKHNww	2017-07-06 15:20:43	2017-07-26 15:53:42	27687053-bfb0-46b1-8dd5-3cadd011b45b	128	9412223337	user	active	{"trade": "purchaser", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Unicycle", "carModel": "co2u2", "licPlateState": "HI", "licPlateNumber": "co2u2", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "user", "department": "using", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "35"}}	co2u2	{"reports": [], "scanner": [22, 18]}	\N	\N	\N
177	Co 1	Admin 1	co1a1@dispostable.com	$2y$10$/UIxBjQTlXKTRxyB0DxL4.yl2oS4UkGbZYMpTbp/cthzxkT/7I42u	KMzzqGxQzpsq0H3UsZopfUzkzzsXyIlfKjqkxcuJ3f5NoxyuMXXf6x8fbCiv	2017-07-05 20:41:48	2017-07-26 15:51:55	06af2936-b8e1-4e06-99c0-6ddd97031c82	127	9412222222	admin	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Car", "carModel": "co1a1", "licPlateState": "FL", "licPlateNumber": "co1a1", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Admin 1", "department": "Admin", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "45"}}	co1a1	{"reports": [], "scanner": [18, 22]}	\N	\N	\N
185	2121212121	harshadclientadmin	harshadclientadmin@dispostable.com	$2y$10$hv5e4xS1YPAqVLvjt306KOFm.9/22uWjze4TQ2rDko.T9OHjrXB7C	3JxIODx19qeH6XqoD3M9psMkhHB7PnSft7yxrCwyY7A8cbFXxJ1EbIk71Ao1	2017-07-08 05:59:35	2017-07-08 06:00:24	55fb63d5-347b-4470-90be-0602cd19b0f0	129	2132323232	superuser	active	{"trade": "harshadclientadmin", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "harshadclientadmin", "department": "harshadclientadmin", "homeNumber": "", "middleName": "harshadclientadmin", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	harshadclientadmin	{"reports": [], "scanner": []}	\N	\N	\N
186	harshadclient admin	harshadclient admin	harshadsuperuser@dispostable.com	$2y$10$kgB6U/1DRA39DlAiWn5ztOZo24NsYAFZ4MslsfRg5jYaHdXeuB29u	ncxKxywxKeCwHk0Y2FtSwzC4h3XDfeNqeOUqycT98WwSBKjMZVfBlSzClCos	2017-07-08 06:02:21	2017-07-08 06:03:27	1d0f1e45-ff9c-4492-8746-70122b8ba040	129	2525142525	clientadmin	active	{"trade": "harshadclient admin", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "harshadclient admin", "department": "harshadclient admin", "homeNumber": "", "middleName": "harshadclient admin", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	harshadclientadmin1	{"reports": [], "scanner": []}	\N	\N	\N
190	palash111	palash111	palash111@dispostable.com	$2y$10$hXDl.w1lO0AGQNlOM8JYcuLbk6uNRPbUYCH2GYasoRN3C5qDMJzGC	\N	2017-07-11 10:54:01	2017-07-11 10:54:01	e2073684-2d28-47e6-8eb7-7d0e59de1cd8	121	7896541274	user	active	{"trade": "aa", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "mr", "department": "aa", "homeNumber": "7896541236", "middleName": "palash111", "workNumber": "7896541236", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	palash111	{"reports": [], "scanner": [68]}	\N	\N	\N
192	qqqqqq	qqqqqq	ASDERT@dispostable.com	$2y$10$t4qA0pRW8XFVFp556YGLzu5q6ceGnbYGcyG6IjhXPPguy/1z7fp7i	\N	2017-07-13 12:44:15	2017-07-13 12:45:24	d2f784db-a02b-47e7-99e9-834a0de700e1	120	1452365244	clientadmin	active	{"trade": "qq", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "qq", "department": "qq", "homeNumber": "", "middleName": "qqqqqq", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	dfgdfgdgdfSFFF	{"reports": [], "scanner": []}	\N	\N	\N
196	wtwtw	wt	wetwet@dispostable.com	$2y$10$.7RUdDNz2LUxUOuhEJO0XORq3efNOV/TBNhdFYe2oEhe2NheZ9CL.	\N	2017-07-13 13:30:19	2017-07-13 13:30:19	52c35e2d-79f9-40e6-9637-9366e4b406c4	130	2585858582	superuser	active	{"trade": "ewtew", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "ewtew", "department": "ewtew", "homeNumber": "", "middleName": "ewt", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	wetwet@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
194	wertyu	wsadfr	dsadfasfa@dispostable.com	$2y$10$iLB3wPzfABzBFVSNA8j8/OPu.qRId0s5t0/U7rFyzoR8hituboKga	B1vvd811sMXd8iRWBSHZHdYAzIulBl6IHF1YVzRgJHZ2uAzhiY6N1UA621Oq	2017-07-13 12:54:16	2017-07-13 12:55:59	1cb3c364-fab5-42ce-ac64-5b50a778ee53	130	74123698545	superuser	active	{"trade": "ree", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "mr", "department": "mt", "homeNumber": "", "middleName": "qwe", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	asdcxz	{"reports": [], "scanner": []}	\N	\N	\N
193	awewsa	asweds	palash147@dispostable.com	$2y$10$8aQTpvDJPPBlOGb.WeNT9.3qHNOBexfxWGwEl0Y8oLUeq6YilF.8m	RKoN8cDnko902XPdrsZKdjYQl62qwWzE8m4h1z3A1i7A1nXVlpJZuZICMEJh	2017-07-13 12:52:34	2017-07-13 12:56:41	66a66ac0-639e-4560-a15a-86f34077a086	130	8521471236	clientadmin	active	{"trade": "asdfgv", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "mr", "department": "aa", "homeNumber": "", "middleName": "aa", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	awqszx	{"reports": [], "scanner": []}	\N	\N	\N
195	gggggggggg	ggggggggggggggggggggggggg	ggggg@dispostable.com	$2y$10$n8cbwcUKoDwVJEpxNQ09/uGn760HzggQ8SwCLDRP2QL9o.FDLqQhK	\N	2017-07-13 13:26:45	2017-07-13 13:26:45	e1937d06-3a7c-4d76-90da-1116ad24e101	130	1212345555	superuser	active	{"trade": "gg", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "gggggggggggg", "department": "ggg", "homeNumber": "", "middleName": "gggggggggggggggg", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	ggggg@dispostable.com	{"reports": [], "scanner": []}	\N	\N	\N
201	dsgs	gds	fdgdfgdfgyyyy@dispostable.com	$2y$10$TgBplczHF2/CC2Sqzgl0OOcl8QzDPzMkNl7X/eyxn5mriw1qtwuw6	\N	2017-07-13 14:13:00	2017-07-13 14:17:50	cc80e952-86fc-4348-8136-e4d23f812246	130	02397842333	superuser	active	{"trade": "dsgdsg", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "dsgdsgds", "department": "gdsg", "homeNumber": "", "middleName": "gdsg", "workNumber": "", "emerContact": {"name": "palash agrawal", "email": "", "relation": "", "homeNumber": "2397842475", "workNumber": "2397842475", "mobileNumber": "2397842475"}, "payroll_data": {"pay_rate": 0}}	fdgdfgdfgyyyy@dispostable.com	{"reports": [], "scanner": []}	2017-07-13 14:17:50	\N	\N
202	User02	Asmasc	user02asmasc@dispostable.com	$2y$10$Fn857cjjjyLf7wwdLSM27.Xi0n7O1b90GdPHxf8GhdPJ1oM21/iDi	rb3aAja5HQ1oaQaq0UFzQTNyAAZAeaGxmMirOgU81mhaus4Agmh80nhXqgCo	2017-07-13 16:34:07	2017-07-13 16:38:42	c2954162-5e12-4155-a5a9-1e54d28027a9	126	2625738994	user	active	{"trade": "user02asmasc", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "user02asmasc", "department": "user02asmasc", "homeNumber": "2625738994", "middleName": "", "workNumber": "2625738994", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	user02asmasc	{"reports": [], "scanner": []}	\N	\N	\N
203	Super	Admin 3	sa3@dispostable.com	$2y$10$JlbqpX.H96pGmSErTUUrY.7//kc25/FTa6CXwkjAMOWSILecN2JuK	VZp6gPjYUWq5km5iUs3jyHuMz2K53tmp8esrBIvqvS5RKbm2CTQmgeXg34uR	2017-07-13 18:38:43	2017-07-26 15:55:46	0c462fb2-a833-474a-b972-938e3cbe2852	119	9411112225	superuser	active	{"trade": "Consulting", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Van", "carModel": "SA3", "licPlateState": "FL", "licPlateNumber": "SA3", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Admin", "department": "Management", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "50"}}	sa3	{"reports": [], "scanner": [22, 18]}	\N	\N	\N
204	testingagaaa	testingagaaa	testingagaaa@dispostable.com	$2y$10$WIcC1BduXWMudmEaMSFPyO4eqAQKRj.ZJFUxI8sDeC9etH7aOmVBu	QtRkQ7ji5QRZlVKwS22hO2FsZAvtaPBndpDpzGnoJc4nMGWUbS7YOHBcaGMY	2017-07-14 11:22:05	2017-07-14 11:33:00	1199467b-b382-4c66-af51-93123a6976c5	2	5858558888	clientadmin	active	{"trade": "testingagaaa", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "testingagaaa", "department": "testingagaaa", "homeNumber": "", "middleName": "testingagaaa", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	testingagaaa	{"reports": [], "scanner": []}	\N	\N	\N
205	ddddddddd	ddddddddd	ddddddddd@dispostable.com	$2y$10$TwQUE1.CW12l8GsUIISQaOPS1bwPla7SOxEd7lHmT7fAZ2hIQwDOC	7iFzd26dNNq6vDUpw8h3GYZ6qGml10mVMQXLPmQQE7pbidLklQ0dolNHgzvI	2017-07-14 11:36:50	2017-07-14 11:37:33	4f97621c-ce8b-447b-889a-c3e171c2f0ee	2	07828038855	clientadmin	active	{"trade": "ddddddddd", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "ddddddddd", "department": "ddddddddd", "homeNumber": "", "middleName": "ddddddddd", "workNumber": "", "emerContact": {"name": "palash agrawal", "email": "", "relation": "", "homeNumber": "7828038803", "workNumber": "7828038803", "mobileNumber": "7828038803"}, "payroll_data": {"pay_rate": 0}}	ddddddddd	{"reports": [], "scanner": []}	\N	\N	\N
207	fdsfdffa	faadfadfafaf	sfsafgsag@dispostable.com	$2y$10$aC9mtG3YvY.4f.i/a77EueODI2YEH8rKcWlwfqO0YCsCFZ.HIis0q	2fwgtLx5xZUBKvdiVgRdPo28tL2DEkHmZtwEdTbaPPkhfCCzSz9cocafrKkW	2017-07-14 13:35:47	2017-07-14 13:40:43	aafe03fd-06a7-4922-994b-090d9f0108a5	121	1236541232	user	active	{"trade": "afsafsaf", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "safasfaf", "department": "afasfsafsaf", "homeNumber": "", "middleName": "afsafsafsaf", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	fsafsafasfa	{"reports": [], "scanner": [68]}	\N	\N	\N
208	Demo	Client Admin	democa@dispostable.com	$2y$10$CBMUyQxdirPTXfmJCzxSy.DBzG6a/reW7G7/ybznaiUL54cSF1QS2	PmmvvsZb5oYwijZFK5LNN9JeNxWI8WbHc7lQQrFREEGJsgpg4vzURgjq0JL1	2017-07-17 15:52:08	2017-07-17 18:02:58	97d4537e-612d-457b-847c-a369687a0ddf	132	2625731111	clientadmin	active	{"trade": "democa", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Client Admin", "department": "democa", "homeNumber": "2625731111", "middleName": "", "workNumber": "2625731111", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	democa	{"reports": [], "scanner": [25, 60]}	\N	\N	\N
206	reeerwr	ew	qwerfda@dispostable.com	$2y$10$pMVaNZGtadm6UkQ5jIQuwOG1hRrkaUGflpkdNBOCYNZtBgmxqiNoG	WGXrHFqlBXiMTS7OvwgsT6kdtFPzWRGRV3s84P8O0qmreAJ3foIoPmjuKls5	2017-07-14 13:13:02	2017-07-14 13:18:01	5731d45c-d36a-4cf9-aa8c-c099e51891ec	121	8523697412	clientadmin	active	{"trade": "bggdsg", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "grewrew", "department": "sffssd", "homeNumber": "", "middleName": "wrwerrw", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	dsggagag	{"reports": [], "scanner": [68]}	\N	\N	\N
209	Demo	Super User	demosu@dispostable.com	$2y$10$8tASh93FBjmKx23TMKfceOn0U72XXrpqb5g9ObJuoDM2m1Uz8oy4C	MJ9rfNBKtCv91s9T601V7pl8meReQNQ2sh9AajCLdg8GX7oDfiCg1i9X1nZf	2017-07-17 16:24:35	2017-07-26 15:41:58	16daf127-0958-46cb-b9d5-dc4ae60ba176	132	2625731112	superuser	active	{"trade": "demosu", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demosu", "department": "demosu", "homeNumber": "2625731112", "middleName": "Danger", "workNumber": "2625731112", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}}	demosu	{"reports": [], "scanner": [25, 60]}	\N	\N	\N
211	Demo	User2	demou2@dispostable.com	$2y$10$c47sDmGBbpP42pHhTFzGIO/HtTfmrp.9rIR7MZJH6R36ODOGFIATO	SzKwaL3yeMLqnNHO2DAOSdY5ImowdeKUkR5F6e7PKbDTLEDYFBAZoYKl40zk	2017-07-17 16:33:20	2017-07-17 16:54:37	d8ef78b3-7f09-490c-a940-9713ad17b937	132	2625731114	user	active	{"trade": "demou2", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demou2", "department": "demou2", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	demou2	{"reports": [], "scanner": [60]}	\N	\N	\N
212	Demo	User3	demou3@dispostable.com	$2y$10$kCvPkO45hKvzSBXqjXr/DOc0B.c10jdo9JTG0bT/njwJLBrbvDOIe	fGbpCwGE1N4ohKq8ubM7nGgJHqDhv0ITrr3f8KD0kpwwJCEt9AGKV2QyIggR	2017-07-17 16:34:21	2017-07-17 16:55:51	eb302db1-96d9-4bdf-b6fc-b82d699ebef7	132	2625731115	user	active	{"trade": "demou3", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demou3", "department": "demou3", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	demou3	{"reports": [], "scanner": []}	\N	\N	\N
214	Demo	SCU1	demoscu1@dispostable.com	$2y$10$Z1iqVg29d0DwCoJJOJQRUurZRxPQ8FNMCbMM6LNAwbKnzayGDti.S	38AAOn262uZs3jTqgiiqLIifqk7CNlblecnpPztmpIaABGza0dzSXy58zFke	2017-07-17 17:36:14	2017-07-17 17:59:16	b45cac3d-1e76-4e6e-a356-76613b67b536	133	2625732223	user	active	{"trade": "demoscu1", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demoscu1", "department": "demoscu1", "homeNumber": "2625732223", "middleName": "", "workNumber": "2625732223", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	demoscu1	{"reports": [], "scanner": []}	\N	\N	\N
215	Demo	SCU2	demoscu2@dispostable.com	$2y$10$ls7resbW0yoTwf2PfolX.OG5Idajt7DP/Pe5gizaTTrffVRNqdqc.	Y2R7d64DbiNjJrPz7Nz0l6UpM1k2VqwbaySzvoSs7NyZmfmwG6CWtjfOO85L	2017-07-17 17:39:09	2017-07-17 17:59:45	c5132728-6331-4f44-93bc-5c83c9761895	133	2625732224	user	active	{"trade": "demoscu2", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demoscu2", "department": "demoscu2", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	demoscu2	{"reports": [], "scanner": []}	\N	\N	\N
216	Demo	SCU3	demoscu3@dispostable.com	$2y$10$4tHLulo568A6v2ZyYvofhu4XHTugsgkZ.Cwt.a1wLs19S5e7fGCha	R47p4hog7gW68CxQZ3IzDdtxUk89OghRnKtRHxJDqRnpCmgrZyiyNrIsApXK	2017-07-17 17:40:49	2017-07-17 18:00:10	96f0f32c-5907-4fd9-a537-9736c036cf5f	133	2625732225	user	active	{"trade": "demoscu3", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demoscu3", "department": "demoscu3", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	demoscu3	{"reports": [], "scanner": []}	\N	\N	\N
213	Demo	SCA	demosca@dispostable.com	$2y$10$pBb.8HjnngYLla10apyqHOSD5/jVoxPHRrNsIw.YuLJMeGZHtKiyK	M3izODT2IRNvyvIYCme71030XF4KliTRb9akvor9AOsxHh6qpjY1JpeYceJI	2017-07-17 17:34:22	2017-07-17 17:58:33	3a711832-1364-4554-a67c-fc0bb8435765	133	2625732222	admin	active	{"trade": "demosca", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demosca", "department": "demosca", "homeNumber": "2625732222", "middleName": "", "workNumber": "2625732222", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	demosca	{"reports": [], "scanner": [25]}	\N	\N	\N
210	Demo	User1	demou1@dispostable.com	$2y$10$ox1T9X8nErceEQdma5LY/ORaqhJHL/bGlQ6zhkkB51lGmeR1NVrB.	QuNlzQLSfmok0G2UGOOT5UtwQeBsIlX8dTzhchv5Kp8HMdr138AvHQoZKs36	2017-07-17 16:32:28	2017-07-17 16:48:36	05db2ab1-5c9c-4d58-a19e-93a8f21cd7bc	132	2625731113	user	active	{"trade": "demou1", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "demou1", "department": "demou1", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	demou1	{"reports": [], "scanner": [60]}	\N	\N	\N
217	harshad	harshad	harshad252525@dispostable.com	$2y$10$wL9gh/JSdWCRrqD/uysHnuRUPMJu3gOtr5MkOULcuGdi3nmuhEoZK	JYnKnJHLozQhDaYmQagfylP27r6rIJFdSJr0x2dhx5S3uMVRNdjGFliOiXAv	2017-07-18 07:16:36	2017-07-18 07:20:28	2ca285dc-df6d-4ba5-ac61-ce75baa50ec8	134	2323232333	clientadmin	active	{"trade": "harshad", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "harshad", "department": "harshad", "homeNumber": "", "middleName": "harshad", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	harshad	{"reports": [], "scanner": []}	\N	\N	\N
218	Co 3	Admin 1	co3a1@dispostable.com	$2y$10$t6WOVDzsp.26qKoAVVs8vOpt/PCmEgf6azjF.MZu2JnNZVbQeYlrG	pPJpsJWgvIj11Sic0smFZMvXAbILF2H377yDW3tFSLhlLytStjwYxHDDbDvd	2017-07-26 12:29:12	2017-07-26 15:50:32	cc5622d1-05b9-4007-8078-d662972a3578	137	9412223341	admin	active	{"trade": "Admin", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "Make", "carModel": "Model", "licPlateState": "AK", "licPlateNumber": "Co 3 Admin 1", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Admin", "department": "Admin", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "45"}}	co3a1	{"reports": [], "scanner": [22]}	\N	\N	\N
219	Co 3	Admin 2	co3a2@dispostable.com	$2y$10$aFPy3ka7/LWRn8j6W2841OhcqQlhISwUmvqKC/jlkXmyHT8iVSzh2	\N	2017-07-26 15:36:48	2017-07-26 15:50:47	716d754e-c228-4a0b-8210-20ab9e14f91a	137	9412223342	admin	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "", "department": "", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "45"}}	co3a2	{"reports": [], "scanner": [22]}	\N	\N	\N
220	Co 3	User 1	co3u1@dispostable.com	$2y$10$.MFsyj5OU6ICxL2IJXffZ.Xv5epymUuZ2oywOQDi2KBAdU0LhNm2m	\N	2017-07-26 15:37:45	2017-07-26 15:51:01	1165ff8b-11a0-4542-9e7f-2d88fb71910a	137	9412223343	user	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "", "department": "", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "20"}}	co3u1	{"reports": [], "scanner": [22]}	\N	\N	\N
221	Co 3	User 2	co3u2@dispostable.com	$2y$10$krPN1JqH3/Ak226Olz2GcuzMKOPhUtuOFinj3.suzdwjb4OttlB/e	\N	2017-07-26 15:38:19	2017-07-26 15:51:13	babe487a-bdad-471f-b506-d04a4489c820	137	9412223344	user	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "", "department": "", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "20"}}	co3u2	{"reports": [], "scanner": [22]}	\N	\N	\N
181	Co 2	Admin 1	co2a1@dispostable.com	$2y$10$RMCg8QbtBHACDI0nxhyYAOGlBMOYlqY5V7sUWCt.ILdTrZ2i6j.iC	kOOpw3tmmr89mDbhOjcQiMfmnajxGiDUvOCG6EnKF1M7RxQjPqByxGAStMTg	2017-07-06 15:15:53	2017-07-26 15:53:11	8a4b1f1d-eac6-4573-b14d-064ba4fc26fb	128	9412223334	admin	active	{"trade": "Masonry", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "SUV", "carModel": "co2a1", "licPlateState": "AK", "licPlateNumber": "co2a1", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Admin", "department": "Management", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "45"}}	co2a1	{"reports": [], "scanner": [22, 18]}	\N	\N	\N
222	Bryan	Perry	bryan.perry@aihcgroup.com	$2y$10$s6j6Jt2Db/bKLgZ.WCZlVOsRAoIzqUgBgY2eORwiNuTbjCDRLf72q	X2JyJSntWFH5ZxxqrbZioMAzJHhUbFLeywa8UT7tp2Gx4RP01uayuFAnb2ZD	2017-07-27 16:05:49	2017-07-27 16:08:52	a842acb4-b5ce-434a-b5f9-eedad4813912	138	9418675309	clientadmin	active	{"trade": "TBD", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "Manage", "department": "Development", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": "100"}}	bryan.perry	{"reports": [], "scanner": [44]}	\N	\N	\N
224	testEmployee	testEmployee	testEmployeedemo@dispostable.com	$2y$10$/QDoAb4jB6u9zIM1UQRe1etoiOvd9nl3P48Sk.kPKFqC1SdLJ0Zti	C1iNGW6v5ZMuVSf8tBH14a5Mk7zoIeYY8P7LnRCPpmysUQR3i3kBiMA60318	2017-08-19 07:29:33	2017-08-19 07:31:13	ee558993-9359-4ab2-9f51-ceadf122e5cb	140	9898989898	clientadmin	active	{"trade": "hr", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "hr", "department": "hr", "homeNumber": "", "middleName": "testEmployee", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	testEmployeedemo	{"reports": [], "scanner": []}	\N	\N	\N
223	Demo	Ray	DemoRay@dispostable.com	$2y$10$GxKHQFyJSqjBBF8W3XVH.O9kGdW7TNA7nzwIZQ2e0AWpojGLyOQcK	tALXLXK8MGfSJGVZOUpNUoCPyqtg1iECLuMKNmF8fTKHSXMNrS1XmkPuU9P4	2017-07-31 19:21:57	2017-07-31 19:29:40	730b2183-8b92-4014-bbb1-8bc20e98d5ec	132	1111111112	superuser	active	{"trade": "DemoRay", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "DemoRay", "department": "DemoRay", "homeNumber": "1111111112", "middleName": "", "workNumber": "1111111112", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	DemoRay	{"reports": [], "scanner": []}	\N	\N	\N
226	Test01CA	Test01CA	Test01CA@dispostable.com	$2y$10$TXoO.htruvYx0zi9pphs5eywirHwGwXW181BIq0rPHwVxG7ovKNVG	DkuhoqXFiXw3ZTrkcO7ZoVogB0gPae0sBgD4HZ9NAR7SvFisPY8dilqngHwx	2017-08-30 16:01:05	2017-08-30 19:05:34	376fd5e9-88ac-4dbd-8164-ddd12a67d69a	132	0101010101	clientadmin	active	{"trade": "", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "", "department": "", "homeNumber": "", "middleName": "", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	Test01CA	{"reports": [], "scanner": [70]}	\N	\N	\N
191	qq	qq	palash111@20email.eu	$2y$10$FIdKDZprpgC2wjh/KtrVzOInvBVlbkZvKuqLmgLSmqIuRkDJC28CG	sBtSsufZLmSvhqrn9UhVQ2axfLibgqeBm710JmF7UNLdGP2Lubq5GQNTA1hf	2017-07-11 11:06:39	2017-07-11 11:07:16	fea1d039-706a-4228-9b8c-bef40039a936	121	7415289635	user	active	{"trade": "qq", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "qq", "department": "qq", "homeNumber": "7415289635", "middleName": "qq", "workNumber": "7415289635", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	qq	{"reports": [], "scanner": [68]}	\N	\N	\N
225	sadsadf	fffaaf	new123654@dispostable.com	$2y$10$4I0qBQh8BZvG2wZvexPhVemAQnxRii3snai/EpxLXW5Kkjp3YuepK	LJv4xEn333GySvIUEz18ig43DaQXCTpprlSY4Uo4lEU4pA7i1jANURjJZsUq	2017-08-22 10:27:45	2017-08-22 10:57:42	2d45fd54-48c7-4d59-be92-487be1a50ec1	121	2536987412	user	active	{"trade": "ffasfa", "address": {"zip": "", "city": "", "state": "", "address1": "", "address2": ""}, "vehicle": {"carMake": "", "carModel": "", "licPlateState": "", "licPlateNumber": "", "driversLicenseState": "", "driversLicenseNumber": ""}, "job_title": "safsafsa", "department": "fsafsafas", "homeNumber": "", "middleName": "fasfasf", "workNumber": "", "emerContact": {"name": "", "email": "", "relation": "", "homeNumber": "", "workNumber": "", "mobileNumber": ""}, "payroll_data": {"pay_rate": 0}}	vzxvdzg	{"reports": [], "scanner": [68]}	\N	\N	\N
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: forge
--

SELECT pg_catalog.setval('users_id_seq', 226, true);


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

