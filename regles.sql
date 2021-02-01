--------------------------
-- Fonction personnalisées
--------------------------

-- Fonction retournant une date au 1er juin de l'année de la date passée en paramètre
CREATE OR REPLACE FUNCTION anon.date_naissance_tronquee(date_initiale TIMESTAMP)
    RETURNS TEXT
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN date_trunc('year', date_initiale) + interval '5 month';
END;
$$;

-- Fonction retournant un nom aléatoire en minuscule en fonction de la valeur initiale.
-- En spécifiant les mêmes paramètres, le nom retourné sera toujours identique
CREATE OR REPLACE FUNCTION anon.nom_minuscule(seed TEXT, salt TEXT)
    RETURNS TEXT
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN lower(anon.pseudo_last_name(seed, salt));
END;
$$;

-- Fonction retournant aléatoirement une ville parmi un tableau de villes prédéfinies
-- Permet d'éviter des accès à la table des villes proposées par l'extension et améliorer le temps de traitement
CREATE OR REPLACE FUNCTION anon.ville_personnalisee()
    RETURNS TEXT
    LANGUAGE plpgsql
AS
$$
BEGIN
    RETURN anon.random_in(ARRAY['Paris', 'Londres', 'Washington', 'Tokyo']);
END;
$$;

-- Règles d'anonymisation
CREATE OR REPLACE FUNCTION anon.initRegles()
    RETURNS VOID AS
$BODY$

DECLARE
    random_string TEXT := MD5(random()::text);

BEGIN

------------------------
-- Règles basiques
------------------------
SECURITY LABEL FOR anon ON COLUMN public.personne.prenom IS 'MASKED WITH FUNCTION anon.fake_first_name()';
SECURITY LABEL FOR anon ON COLUMN public.personne.ville_naissance IS 'MASKED WITH FUNCTION anon.fake_city()';
SECURITY LABEL FOR anon ON COLUMN public.personne.telephone IS 'MASKED WITH FUNCTION anon.random_phone()';
SECURITY LABEL FOR anon ON COLUMN public.personne.mail IS 'MASKED WITH FUNCTION anon.partial_email(mail)';
SECURITY LABEL FOR anon ON COLUMN public.personne.commentaire IS 'MASKED WITH FUNCTION anon.lorem_ipsum(words := 5)';
SECURITY LABEL FOR anon ON COLUMN public.personne.prenom_formate IS 'MASKED WITH VALUE ''PRENOM''';
SECURITY LABEL FOR anon ON COLUMN public.compte_bancaire.date_ouverture IS 'MASKED WITH FUNCTION anon.random_date()';
SECURITY LABEL FOR anon ON COLUMN public.compte_bancaire.iban IS 'MASKED WITH FUNCTION anon.fake_iban()';
SECURITY LABEL FOR anon ON COLUMN public.compte_bancaire.montant IS 'MASKED WITH FUNCTION anon.random_int_between(5000, 200000)';

------------------------
-- Règles personnalisées
------------------------
SECURITY LABEL FOR anon ON COLUMN public.personne.date_naissance IS 'MASKED WITH FUNCTION anon.date_naissance_tronquee(date_naissance)';
EXECUTE format(
        'SECURITY LABEL FOR anon ON COLUMN
        public.personne.nom IS ''MASKED WITH FUNCTION anon.pseudo_last_name(nom || id, ''''%s'''')''', random_string
    );
EXECUTE format(
        'SECURITY LABEL FOR anon ON COLUMN
        public.personne.nom_formate IS ''MASKED WITH FUNCTION anon.nom_minuscule(nom || id, ''''%s'''')''', random_string
    );
END ;
$BODY$
LANGUAGE plpgsql VOLATILE
COST 100;

-- Initialisation des règles
SELECT anon.initRegles();