CREATE TABLE societe (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL UNIQUE,
    libelle TEXT
);


CREATE TABLE type_publicite (
    id SERIAL PRIMARY KEY,
    libelle TEXT NOT NULL UNIQUE
);


CREATE TABLE tarif_diffusion_publicitaire (
    id SERIAL PRIMARY KEY,
    prix NUMERIC(12,2) NOT NULL CHECK (prix > 0),
    libelle TEXT NOT NULL,
    actif BOOLEAN DEFAULT true
);

CREATE TABLE diffusion_publicitaire (
    id SERIAL PRIMARY KEY,

    id_seance INT NOT NULL 
        REFERENCES seance(id) ON DELETE CASCADE,

    id_societe INT NOT NULL 
        REFERENCES societe(id) ON DELETE RESTRICT,

    id_type_publicite INT NOT NULL 
        REFERENCES type_publicite(id) ON DELETE RESTRICT,

    id_tarif INT NOT NULL
        REFERENCES tarif_diffusion_publicitaire(id) ON DELETE RESTRICT,

    date_diffusion DATE NOT NULL
);


CREATE TABLE statut_ticket (
    id SERIAL PRIMARY KEY,
    code TEXT UNIQUE NOT NULL, -- RESERVE, PAYE, ANNULE, UTILISE, REMBOURSE
    libelle TEXT NOT NULL
);

-- ------------------------------
-- TICKETS
-- ------------------------------
CREATE TABLE ticket (
    id SERIAL PRIMARY KEY,
    id_reservation INT REFERENCES reservation(id) NULL, -- nullable pour ticket sans reservation
    id_seance INT REFERENCES seance(id),
    id_place INT REFERENCES place(id),
    id_statut INT REFERENCES statut_ticket(id),
    id_categorie_personne INT REFERENCES categorie_personne(id), -- adulte/enfant
    prix NUMERIC(10,2) NOT NULL
);   
CREATE TABLE seance (
    id SERIAL PRIMARY KEY,
    id_film INT REFERENCES film(id),
    id_salle INT REFERENCES salle(id),
    debut TIMESTAMPTZ NOT NULL,
    fin TIMESTAMPTZ,
    langue TEXT
);

CREATE TABLE film (
    id SERIAL PRIMARY KEY,
    titre TEXT NOT NULL,
    description TEXT,
    duree_minutes INT,
    date_sortie DATE,
    age_min INT DEFAULT 0, -- age minimum conseille
    langue_originale TEXT -- langue du film
);


CREATE OR REPLACE VIEW v_solde_publicite_mensuel AS
SELECT
    ca.mois,
    ca.id_societe,
    ca.societe,
    ca.chiffre_affaire,

    COALESCE(SUM(p.montant), 0) AS total_paye,
    COALESCE(SUM(p.montant), 0) / NULLIF(ca.chiffre_affaire, 0) * 100 AS pourcentage_paye,
    ca.chiffre_affaire - COALESCE(SUM(p.montant), 0) AS reste_a_payer

FROM v_chiffre_affaire_publicite_mensuel ca
LEFT JOIN paiement_publicite p
    ON p.id_societe = ca.id_societe
   AND DATE_TRUNC('month', p.date_paiement) = ca.mois

GROUP BY
    ca.mois,
    ca.id_societe,
    ca.societe,
    ca.chiffre_affaire;
