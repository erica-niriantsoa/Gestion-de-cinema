\c postgres;
DROP DATABASE IF EXISTS cinema;
CREATE DATABASE cinema;
\c cinema;


-- ------------------------------
-- FILMS & categorieS
-- ------------------------------
CREATE TABLE film (
    id SERIAL PRIMARY KEY,
    titre TEXT NOT NULL,
    description TEXT,
    duree_minutes INT,
    date_sortie DATE,
    age_min INT DEFAULT 0, -- age minimum conseille
    langue_originale TEXT -- langue du film);
);


-- ------------------------------
-- TYPE DE PLACE
-- ------------------------------
CREATE TABLE type_place (
    id SERIAL PRIMARY KEY,
    libelle TEXT NOT NULL -- STANDARD, VIP, PMR
);

-- ------------------------------
-- CATEGORIE PERSONNE
-- ------------------------------
CREATE TABLE categorie_personne (
    id SERIAL PRIMARY KEY,
    libelle TEXT NOT NULL -- ADULTE, ENFANT, SENIOR...
);


CREATE TABLE categorie (
    id SERIAL PRIMARY KEY,
    libelle TEXT UNIQUE NOT NULL
);

CREATE TABLE film_categorie (
    id_film INT REFERENCES film(id) ON DELETE CASCADE,
    id_categorie INT REFERENCES categorie(id) ON DELETE CASCADE,
    PRIMARY KEY (id_film, id_categorie)
);

-- ------------------------------
-- SALLES & PLACES
-- ------------------------------
CREATE TABLE salle (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    capacite INT NOT NULL CHECK (capacite > 0)
);

CREATE TABLE place (
    id SERIAL PRIMARY KEY,
    id_salle INT REFERENCES salle(id) ON DELETE CASCADE,
    rangee TEXT,
    numero INT,
    code_place TEXT,
    id_type_place INT REFERENCES type_place(id)
);

-- ------------------------------
-- SEANCES
-- ------------------------------
CREATE TABLE seance (
    id SERIAL PRIMARY KEY,
    id_film INT REFERENCES film(id),
    id_salle INT REFERENCES salle(id),
    debut TIMESTAMPTZ NOT NULL,
    fin TIMESTAMPTZ,
    langue TEXT
);

CREATE INDEX idx_seance_salle_debut
ON seance(id_salle, debut);

-- ------------------------------
-- PERSONNES (Clients)
-- ------------------------------
CREATE TABLE personne (
    id SERIAL PRIMARY KEY,
    nom_complet TEXT,
    email TEXT UNIQUE,
    telephone TEXT,
    mot_de_passe TEXT,
    role TEXT CHECK (role IN ('ADMIN', 'CLIENT'))
);

-- ------------------------------
-- STATUTS RESERVATION
-- ------------------------------
CREATE TABLE statut_reservation (
    id SERIAL PRIMARY KEY,
    code TEXT UNIQUE NOT NULL, -- CREEE, EN_ATTENTE, PAYEE, CONFIRMEE, ANNULEE, EXPIREE
    libelle TEXT NOT NULL
);

-- ------------------------------
-- RESERVATIONS
-- ------------------------------
CREATE TABLE reservation (
    id SERIAL PRIMARY KEY,
    id_personne INT REFERENCES personne(id) NULL, -- nullable pour vente sur place
    id_seance INT REFERENCES seance(id),
    id_statut INT REFERENCES statut_reservation(id),
    montant_total NUMERIC(12,2) DEFAULT 0,
    date_reservation TIMESTAMPTZ DEFAULT now()
);

-- ------------------------------
-- HISTORIQUE STATUT RESERVATION
-- ------------------------------
CREATE TABLE historique_statut_reservation (
    id SERIAL PRIMARY KEY,
    id_reservation INT REFERENCES reservation(id) ON DELETE CASCADE,
    id_statut INT REFERENCES statut_reservation(id),
    date_changement TIMESTAMPTZ DEFAULT now(),
    change_par INT REFERENCES personne(id)
);

-- ------------------------------
-- STATUTS TICKET
-- ------------------------------
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

-- ------------------------------
-- HISTORIQUE STATUT TICKET
-- ------------------------------
CREATE TABLE historique_statut_ticket (
    id SERIAL PRIMARY KEY,
    id_ticket INT REFERENCES ticket(id) ON DELETE CASCADE,
    id_statut INT REFERENCES statut_ticket(id),
    date_changement TIMESTAMPTZ DEFAULT now(),
    change_par INT REFERENCES personne(id),
    commentaire TEXT
);

-- ------------------------------
-- TARIF PAR DEFAUT
-- ------------------------------
CREATE TABLE tarif_defaut (
    id SERIAL PRIMARY KEY,
    id_type_place INT REFERENCES type_place(id),
    id_categorie_personne INT REFERENCES categorie_personne(id),
    prix NUMERIC(10,2) NOT NULL
);

-- ------------------------------
-- TARIF SPECIFIQUE PAR SEANCE (OPTIONNEL)
-- ------------------------------
CREATE TABLE tarif_seance (
    id SERIAL PRIMARY KEY,
    id_seance INT REFERENCES seance(id),
    id_type_place INT REFERENCES type_place(id),
    id_categorie_personne INT REFERENCES categorie_personne(id),
    prix NUMERIC(10,2) NOT NULL
);

-- ------------------------------
-- MOYENS DE PAIEMENT
-- ------------------------------
CREATE TABLE moyen_paiement (
    id SERIAL PRIMARY KEY,
    libelle TEXT NOT NULL UNIQUE, -- CARTE_BANCAIRE, ESPECES, CHEQUE, VIREMENT, CHEQUE_CADEAU
    description TEXT
);

-- ------------------------------
-- PAIEMENTS
-- ------------------------------
CREATE TABLE paiement (
    id SERIAL PRIMARY KEY,
    id_reservation INT REFERENCES reservation(id),
    id_moyen_paiement INT REFERENCES moyen_paiement(id),
    montant NUMERIC(10,2) NOT NULL CHECK (montant > 0),
    date_paiement TIMESTAMPTZ DEFAULT now(),
    reference TEXT, -- numero de transaction, reference de cheque, etc.
    statut TEXT CHECK (statut IN ('EN_ATTENTE', 'ACCEPTE', 'REFUSE', 'REMBOURSE'))
);

-- ------------------------------
-- PROMOTIONS
-- ------------------------------
CREATE TABLE promotion (
    id SERIAL PRIMARY KEY,
    code TEXT UNIQUE NOT NULL, -- ex: "ETE2024", "FIDELITE10"
    libelle TEXT NOT NULL, -- ex: "Réduction été 2024", "Code fidélité"
    description TEXT,
    type_promotion TEXT CHECK (type_promotion IN ('POURCENTAGE', 'MONTANT_FIXE', 'OFFRE_SPECIALE')),
    valeur NUMERIC(10,2) NOT NULL, -- 10 pour 10%, 5.00 pour 5€
    montant_minimum NUMERIC(10,2) DEFAULT 0, -- montant minimum d'achat requis
    date_debut DATE,
    date_fin DATE,
    utilisations_max INT, -- nombre maximum d'utilisations
    utilisations_courantes INT DEFAULT 0,
    actif BOOLEAN DEFAULT true,
    UNIQUE(code)
);

-- ------------------------------
-- RESERVATION PROMOTION (table de liaison)
-- ------------------------------
CREATE TABLE reservation_promotion (
    id SERIAL PRIMARY KEY,
    id_reservation INT REFERENCES reservation(id) ON DELETE CASCADE,
    id_promotion INT REFERENCES promotion(id),
    montant_reduction NUMERIC(10,2) NOT NULL,
    date_utilisation TIMESTAMPTZ DEFAULT now()
);


CREATE TABLE equivalence_tarif (
    id SERIAL PRIMARY KEY,
    id_categorie_personne INT NOT NULL,
    coefficient NUMERIC(5,2) NOT NULL,
    description TEXT,
    CONSTRAINT fk_categorie_personne FOREIGN KEY (id_categorie_personne) 
        REFERENCES categorie_personne(id)
);
