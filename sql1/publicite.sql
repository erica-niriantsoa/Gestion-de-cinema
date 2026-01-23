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


-- ------------------------------
-- SOCIETES
-- ------------------------------
INSERT INTO societe (nom, libelle) VALUES
('Vaniala', 'Entreprise locale'),
('Lewis', 'Entreprise commerciale');

-- ------------------------------
-- TYPES DE PUBLICITE
-- ------------------------------
INSERT INTO type_publicite (libelle) VALUES
('Bande-annonce'),
('Spot TV'),
('Sponsorisation');


-- ------------------------------
-- DIFFUSIONS PUBLICITAIRES
-- ------------------------------
INSERT INTO diffusion_publicitaire
(id_seance, id_societe, id_type_publicite, id_tarif, date_diffusion)
VALUES
(1, 1, 1, 1, '2025-12-01'),
(2, 2, 2, 1, '2025-12-02'),
(3, 1, 1, 1, '2025-12-03');   -- ✅ corrigé

-- ------------------------------
-- COUTS DE DIFFUSION PUBLICITAIRE
-- ------------------------------
INSERT INTO tarif_diffusion_publicitaire (prix, libelle)
VALUES (200000, 'Tarif standard par diffusion');


SELECT
    s.nom AS societe,
    COUNT(*) AS nb_diffusions,
    SUM(t.prix) AS chiffre_affaire
FROM diffusion_publicitaire d
JOIN societe s ON s.id = d.id_societe
JOIN tarif_diffusion_publicitaire t ON t.id = d.id_tarif
WHERE d.date_diffusion BETWEEN '2025-12-01' AND '2025-12-31'
GROUP BY s.nom
ORDER BY s.nom;


CREATE OR REPLACE VIEW v_chiffre_affaire_publicite_mensuel AS
SELECT
    DATE_TRUNC('month', d.date_diffusion)::DATE AS mois,
    s.id                                  AS id_societe,
    s.nom                                 AS societe,
    COUNT(d.id)                           AS nombre_diffusions,
    SUM(t.prix)                           AS chiffre_affaire
FROM diffusion_publicitaire d
JOIN societe s 
    ON s.id = d.id_societe
JOIN tarif_diffusion_publicitaire t 
    ON t.id = d.id_tarif
GROUP BY
    DATE_TRUNC('month', d.date_diffusion),
    s.id,
    s.nom
ORDER BY
    mois,
    societe;


CREATE OR REPLACE VIEW v_chiffre_affaire_publicite_mois_total AS
SELECT
    DATE_TRUNC('month', d.date_diffusion)::DATE AS mois,
    COUNT(d.id)                               AS nombre_diffusions,
    SUM(t.prix)                              AS chiffre_affaire_total
FROM diffusion_publicitaire d
JOIN tarif_diffusion_publicitaire t 
    ON t.id = d.id_tarif
GROUP BY
    DATE_TRUNC('month', d.date_diffusion)
ORDER BY
    mois;