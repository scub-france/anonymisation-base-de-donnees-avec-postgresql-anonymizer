--
-- PostgreSQL database dump
--

-- Dumped from database version 13.1 (Debian 13.1-1.pgdg100+1)
-- Dumped by pg_dump version 13.1 (Debian 13.1-1.pgdg100+1)

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: compte_bancaire; Type: TABLE; Schema: public; Owner: test_pga
--

CREATE TABLE public.compte_bancaire (
    id bigint NOT NULL,
    personne bigint,
    date_ouverture timestamp without time zone,
    iban character varying(255),
    montant numeric
);


ALTER TABLE public.compte_bancaire OWNER TO test_pga;

--
-- Name: personne; Type: TABLE; Schema: public; Owner: test_pga
--

CREATE TABLE public.personne (
    id bigint NOT NULL,
    nom character varying(255),
    prenom character varying(255),
    date_naissance timestamp without time zone,
    ville_naissance character varying(255),
    telephone character varying(255),
    mail character varying(255),
    commentaire character varying(255),
    nom_formate character varying(255),
    prenom_formate character varying(255)
);


ALTER TABLE public.personne OWNER TO test_pga;

--
-- Data for Name: compte_bancaire; Type: TABLE DATA; Schema: public; Owner: test_pga
--

COPY public.compte_bancaire (id, personne, date_ouverture, iban, montant) FROM stdin;
13	3	2017-04-15 00:00:00	FR3030303030303030303030303	200000
12	2	2017-12-15 00:00:00	FR2020202020202020202020202	10000
14	4	2016-10-15 00:00:00	FR4040404040404040404040404	500000
11	1	2018-07-15 00:00:00	FR1010101010101010101010101	5000
\.


--
-- Data for Name: personne; Type: TABLE DATA; Schema: public; Owner: test_pga
--

COPY public.personne (id, nom, prenom, date_naissance, ville_naissance, telephone, mail, commentaire, nom_formate, prenom_formate) FROM stdin;
3	GATES	Bill	1955-10-28 00:00:00	SEATTLE	0707070707	bill@test.net	Commentaire confidentiel	gates	bill
1	PELTIER	Nicolas	1981-10-01 00:00:00	ANGOULEME	0505050505	nicolas@scub.net	Commentaire personnel	peltier	nicolas
4	MUSK	Elon	1971-06-28 00:00:00	PRETORIA	0808080808	elon@test.net	Donnée personnelle	musk	elon
2	TRAUMAT	Stéphane	1978-08-01 00:00:00	BORDEAUX	0606060606	stephane@scub.net	Donnée confidentielle	traumat	stephane
\.


--
-- Name: compte_bancaire compte_bancaire_pk; Type: CONSTRAINT; Schema: public; Owner: test_pga
--

ALTER TABLE ONLY public.compte_bancaire
    ADD CONSTRAINT compte_bancaire_pk PRIMARY KEY (id);


--
-- Name: personne personne_pk; Type: CONSTRAINT; Schema: public; Owner: test_pga
--

ALTER TABLE ONLY public.personne
    ADD CONSTRAINT personne_pk PRIMARY KEY (id);


--
-- Name: compte_bancaire compte_bancaire_personne_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: test_pga
--

ALTER TABLE ONLY public.compte_bancaire
    ADD CONSTRAINT compte_bancaire_personne_id_fk FOREIGN KEY (personne) REFERENCES public.personne(id);


--
-- PostgreSQL database dump complete
--

