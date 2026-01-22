CREATE TABLE Societe (
    id SERIAL PRIMARY KEY,
    nom TEXT NOT NULL,
    libelle TEXT
);

CREATE TABLE type_publicite (
    id SERIAL PRIMARY KEY,
    libelle TEXT NOT NULL
);

CREATE TABLE difusion_publicitaire (
    id SERIAL PRIMARY KEY,
    id_seance INT NOT NULL REFERENCES seance(id),
    id_societe INT NOT NULL REFERENCES Societe(id),
    id_type INT NOT NULL REFERENCES type_publicite(id)
);

CREATE TABLE cout_difusion_publicitaire (
    id SERIAL PRIMARY KEY,
    prix NUMERIC(10,2) NOT NULL, -- prix avec 2 décimales
    libelle TEXT
);


-- ------------------------------
-- SOCIETES
-- ------------------------------
INSERT INTO Societe (id, nom, libelle) VALUES
(1, 'Coca-Cola', 'Boissons gazeuses'),
(2, 'Nike', 'Articles de sport'),
(3, 'Apple', 'Technologie et électronique'),
(4, 'McDonalds', 'Restauration rapide');

-- ------------------------------
-- TYPES DE PUBLICITE
-- ------------------------------
INSERT INTO type_publicite (id, libelle) VALUES
(1, 'Bande-annonce'),
(2, 'Spot TV'),
(3, 'Affiche'),
(4, 'Sponsorisation');

-- ------------------------------
-- DIFFUSIONS PUBLICITAIRES
-- ------------------------------
INSERT INTO difusion_publicitaire (id, id_seance, id_societe, id_type) VALUES
(1, 1, 1, 1),  -- Coca-Cola, Bande-annonce, Séance 1
(2, 2, 2, 2),  -- Nike, Spot TV, Séance 2
(3, 3, 3, 1),  -- Apple, Bande-annonce, Séance 3
(4, 4, 4, 3),  -- McDonalds, Affiche, Séance 4
(5, 5, 1, 2),  -- Coca-Cola, Spot TV, Séance 5
(6, 6, 2, 1),  -- Nike, Bande-annonce, Séance 6
(7, 7, 3, 4);  -- Apple, Sponsorisation, Séance 7

-- ------------------------------
-- COUTS DE DIFFUSION PUBLICITAIRE
-- ------------------------------
INSERT INTO cout_difusion_publicitaire (id, prix, libelle) VALUES
(1, 200000, 'Prix standard par bande-annonce'),
(2, 200000, 'Prix premium pour spot TV'),
(3, 200000, 'Prix affichage'),
(4, 200000, 'Prix sponsorisation spéciale');
