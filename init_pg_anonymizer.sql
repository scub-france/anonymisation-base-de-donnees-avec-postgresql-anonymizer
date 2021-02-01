-- Initialisation de l'extension d'anonymisation
SELECT pg_catalog.set_config('search_path', 'public', false);
CREATE EXTENSION IF NOT EXISTS anon CASCADE;
SELECT anon.init();
SELECT anon.partial_email('test@test.net');
