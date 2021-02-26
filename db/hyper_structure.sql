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
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.events (
    event_name character varying DEFAULT 'page_view'::character varying,
    site_id character varying NOT NULL,
    session_id character varying NOT NULL,
    client_id character varying NOT NULL,
    user_id character varying,
    tracking_id character varying NOT NULL,
    protocol_version character varying DEFAULT '2'::character varying,
    data_source character varying DEFAULT 'web'::character varying,
    session_engagement boolean DEFAULT false,
    engagement_time integer,
    session_count integer,
    request_number integer,
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
    browser character varying,
    os character varying,
    device_type character varying,
    user_props jsonb DEFAULT '{}'::jsonb,
    event_props jsonb DEFAULT '{}'::jsonb,
    started_at timestamp without time zone NOT NULL,
    raw_event jsonb DEFAULT '{}'::jsonb,
    traffic_campaign character varying,
    traffic_medium character varying,
    traffic_source character varying
);


--
-- Name: _hyper_5_1_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_5_1_chunk (
    CONSTRAINT constraint_1 CHECK (((started_at >= '2021-02-18 00:00:00'::timestamp without time zone) AND (started_at < '2021-02-25 00:00:00'::timestamp without time zone)))
)
INHERITS (public.events);


--
-- Name: _hyper_5_2_chunk; Type: TABLE; Schema: _timescaledb_internal; Owner: -
--

CREATE TABLE _timescaledb_internal._hyper_5_2_chunk (
    CONSTRAINT constraint_2 CHECK (((started_at >= '2021-02-25 00:00:00'::timestamp without time zone) AND (started_at < '2021-03-04 00:00:00'::timestamp without time zone)))
)
INHERITS (public.events);


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
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: _hyper_5_1_chunk event_name; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_1_chunk ALTER COLUMN event_name SET DEFAULT 'page_view'::character varying;


--
-- Name: _hyper_5_1_chunk protocol_version; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_1_chunk ALTER COLUMN protocol_version SET DEFAULT '2'::character varying;


--
-- Name: _hyper_5_1_chunk data_source; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_1_chunk ALTER COLUMN data_source SET DEFAULT 'web'::character varying;


--
-- Name: _hyper_5_1_chunk session_engagement; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_1_chunk ALTER COLUMN session_engagement SET DEFAULT false;


--
-- Name: _hyper_5_1_chunk user_props; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_1_chunk ALTER COLUMN user_props SET DEFAULT '{}'::jsonb;


--
-- Name: _hyper_5_1_chunk event_props; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_1_chunk ALTER COLUMN event_props SET DEFAULT '{}'::jsonb;


--
-- Name: _hyper_5_1_chunk raw_event; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_1_chunk ALTER COLUMN raw_event SET DEFAULT '{}'::jsonb;


--
-- Name: _hyper_5_2_chunk event_name; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_2_chunk ALTER COLUMN event_name SET DEFAULT 'page_view'::character varying;


--
-- Name: _hyper_5_2_chunk protocol_version; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_2_chunk ALTER COLUMN protocol_version SET DEFAULT '2'::character varying;


--
-- Name: _hyper_5_2_chunk data_source; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_2_chunk ALTER COLUMN data_source SET DEFAULT 'web'::character varying;


--
-- Name: _hyper_5_2_chunk session_engagement; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_2_chunk ALTER COLUMN session_engagement SET DEFAULT false;


--
-- Name: _hyper_5_2_chunk user_props; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_2_chunk ALTER COLUMN user_props SET DEFAULT '{}'::jsonb;


--
-- Name: _hyper_5_2_chunk event_props; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_2_chunk ALTER COLUMN event_props SET DEFAULT '{}'::jsonb;


--
-- Name: _hyper_5_2_chunk raw_event; Type: DEFAULT; Schema: _timescaledb_internal; Owner: -
--

ALTER TABLE ONLY _timescaledb_internal._hyper_5_2_chunk ALTER COLUMN raw_event SET DEFAULT '{}'::jsonb;


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
-- Name: _hyper_5_1_chunk_events_started_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_1_chunk_events_started_at_idx ON _timescaledb_internal._hyper_5_1_chunk USING btree (started_at DESC);


--
-- Name: _hyper_5_1_chunk_index_events_on_site_id_and_session_id_and_sta; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_1_chunk_index_events_on_site_id_and_session_id_and_sta ON _timescaledb_internal._hyper_5_1_chunk USING btree (site_id, session_id, started_at DESC);


--
-- Name: _hyper_5_2_chunk_events_started_at_idx; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_2_chunk_events_started_at_idx ON _timescaledb_internal._hyper_5_2_chunk USING btree (started_at DESC);


--
-- Name: _hyper_5_2_chunk_index_events_on_site_id_and_session_id_and_sta; Type: INDEX; Schema: _timescaledb_internal; Owner: -
--

CREATE INDEX _hyper_5_2_chunk_index_events_on_site_id_and_session_id_and_sta ON _timescaledb_internal._hyper_5_2_chunk USING btree (site_id, session_id, started_at DESC);


--
-- Name: events_started_at_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX events_started_at_idx ON public.events USING btree (started_at DESC);


--
-- Name: index_events_on_site_id_and_session_id_and_started_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_site_id_and_session_id_and_started_at ON public.events USING btree (site_id, session_id, started_at DESC);


--
-- Name: events ts_insert_blocker; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER ts_insert_blocker BEFORE INSERT ON public.events FOR EACH ROW EXECUTE FUNCTION _timescaledb_internal.insert_blocker();


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
('20201222091938'),
('20210213182643'),
('20210226015643'),
('20210226091913'),
('20210226093841');


