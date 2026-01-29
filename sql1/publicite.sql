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



CREATE INDEX idx_diffusion_date
    ON diffusion_publicitaire(date_diffusion);

CREATE INDEX idx_diffusion_societe
    ON diffusion_publicitaire(id_societe);
