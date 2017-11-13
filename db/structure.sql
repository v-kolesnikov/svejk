--
-- PostgreSQL database dump
--

-- Dumped from database version 10.0
-- Dumped by pg_dump version 10.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: deliveries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE deliveries (
    id uuid NOT NULL,
    webhook_id integer NOT NULL,
    request jsonb DEFAULT '{}'::jsonb NOT NULL,
    response jsonb,
    created_at timestamp without time zone NOT NULL,
    delivered_at timestamp without time zone
);


--
-- Name: que_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE que_jobs (
    priority smallint DEFAULT 100 NOT NULL,
    run_at timestamp with time zone DEFAULT now() NOT NULL,
    job_id bigint NOT NULL,
    job_class text NOT NULL,
    args json DEFAULT '[]'::json NOT NULL,
    error_count integer DEFAULT 0 NOT NULL,
    last_error text,
    queue text DEFAULT ''::text NOT NULL
);


--
-- Name: TABLE que_jobs; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON TABLE que_jobs IS '3';


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE que_jobs_job_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: que_jobs_job_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE que_jobs_job_id_seq OWNED BY que_jobs.job_id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    filename text NOT NULL
);


--
-- Name: webhooks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE webhooks (
    id integer NOT NULL,
    name text NOT NULL,
    url text NOT NULL,
    secret_key text,
    events text[] DEFAULT ARRAY[]::text[] NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE webhooks_id_seq OWNED BY webhooks.id;


--
-- Name: que_jobs job_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY que_jobs ALTER COLUMN job_id SET DEFAULT nextval('que_jobs_job_id_seq'::regclass);


--
-- Name: webhooks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY webhooks ALTER COLUMN id SET DEFAULT nextval('webhooks_id_seq'::regclass);


--
-- Name: deliveries deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);


--
-- Name: que_jobs que_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY que_jobs
    ADD CONSTRAINT que_jobs_pkey PRIMARY KEY (queue, priority, run_at, job_id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (filename);


--
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (id);


--
-- Name: deliveries deliveries_webhook_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveries
    ADD CONSTRAINT deliveries_webhook_id_fkey FOREIGN KEY (webhook_id) REFERENCES webhooks(id);


--
-- PostgreSQL database dump complete
--

