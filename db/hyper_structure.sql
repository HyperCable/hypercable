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
-- Name: timescaledb; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS timescaledb WITH SCHEMA public;


--
-- Name: EXTENSION timescaledb; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION timescaledb IS 'Enables scalable inserts and complex queries for time-series data';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: hits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.hits (
    event_name character varying DEFAULT 'page_view'::character varying,
    site_id integer NOT NULL,
    session_id character varying NOT NULL,
    client_id character varying NOT NULL,
    user_id character varying,
    tracking_id character varying NOT NULL,
    protocol_version character varying DEFAULT '2'::character varying,
    data_source character varying DEFAULT 'web'::character varying,
    location_url character varying,
    hostname character varying,
    path character varying,
    title character varying,
    user_agent character varying,
    ip character varying,
    referrer character varying,
    referrer_source character varying,
    screen_resolution character varying,
    user_language character varying,
    country character varying,
    region character varying,
    city character varying,
    latitude double precision,
    longitude double precision,
    utm_source character varying,
    utm_medium character varying,
    utm_term character varying,
    utm_content character varying,
    utm_campaign character varying,
    browser character varying,
    os character varying,
    device_type character varying,
    user_props jsonb DEFAULT '{}'::jsonb,
    event_props jsonb DEFAULT '{}'::jsonb,
    non_interaction_hit boolean DEFAULT false,
    started_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    site_id integer NOT NULL,
    session_id character varying NOT NULL,
    client_id character varying NOT NULL,
    user_id character varying,
    tracking_id character varying NOT NULL,
    protocol_version character varying DEFAULT '2'::character varying,
    data_source character varying DEFAULT 'web'::character varying,
    location_url character varying,
    hostname character varying,
    path character varying,
    title character varying,
    user_agent character varying,
    ip character varying,
    referrer character varying,
    referrer_source character varying,
    screen_resolution character varying,
    user_language character varying,
    country character varying,
    region character varying,
    city character varying,
    latitude double precision,
    longitude double precision,
    utm_source character varying,
    utm_medium character varying,
    utm_term character varying,
    utm_content character varying,
    utm_campaign character varying,
    browser character varying,
    os character varying,
    device_type character varying,
    landing_page character varying,
    is_bounce boolean DEFAULT true,
    entry_page character varying,
    exit_page character varying,
    pageviews integer DEFAULT 0,
    events integer DEFAULT 0,
    duration integer DEFAULT 0,
    end_at timestamp without time zone NOT NULL,
    started_at timestamp without time zone NOT NULL
);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: hits_started_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX hits_started_at_idx ON public.hits USING btree (started_at DESC);


--
-- Name: index_hits_on_site_id_and_session_id_and_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_hits_on_site_id_and_session_id_and_started_at ON public.hits USING btree (site_id, session_id, started_at DESC);


--
-- Name: index_sessions_on_site_id_and_session_id_and_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_sessions_on_site_id_and_session_id_and_started_at ON public.sessions USING btree (site_id, session_id, started_at DESC);


--
-- Name: sessions_started_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_started_at_idx ON public.sessions USING btree (started_at DESC);


--
-- Name: hits ts_insert_blocker; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON public.hits FOR EACH ROW EXECUTE FUNCTION _timescaledb_internal.insert_blocker();


--
-- Name: sessions ts_insert_blocker; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON public.sessions FOR EACH ROW EXECUTE FUNCTION _timescaledb_internal.insert_blocker();


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20201116103826'),
('20201208173343'),
('20201208205418'),
('20201216100948'),
('20201217004521'),
('20201222091938');


