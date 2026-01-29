CREATE TABLE produit_extra (
    id SERIAL PRIMARY KEY,
    libelle VARCHAR(100) NOT NULL,
    prix NUMERIC(12,2) NOT NULL
);

INSERT INTO produit_extra (libelle, prix) VALUES
('Pop corn', 10000),
('Soda', 5000),
('Chips', 7000);
CREATE TABLE vente_produit_extra (
    id SERIAL PRIMARY KEY,
    id_seance INT NOT NULL REFERENCES seance(id) ON DELETE CASCADE,
    id_produit INT NOT NULL REFERENCES produit_extra(id),
    quantite INT NOT NULL CHECK (quantite > 0),
    date_vente TIMESTAMP NOT NULL DEFAULT now()
);
);

CREATE OR REPLACE VIEW v_chiffre_affaire_produit_extra_par_film AS
SELECT
    f.titre AS film,
    DATE(s.debut) AS date_diffusion,
    TO_CHAR(s.debut, 'HH24:MI') AS heure_diffusion,
    COALESCE(SUM(vpe.quantite * pe.prix), 0) AS montant_extra
FROM vente_produit_extra vpe
JOIN seance s ON s.id = vpe.id_seance
JOIN film f ON f.id = s.id_film
JOIN produit_extra pe ON pe.id = vpe.id_produit
GROUP BY f.titre, DATE(s.debut), TO_CHAR(s.debut, 'HH24:MI')
ORDER BY DATE(s.debut), TO_CHAR(s.debut, 'HH24:MI');





-Vue chiffre d’affaire produit extra (mensuel):

CREATE OR REPLACE VIEW v_ca_produit_extra_mensuel AS
SELECT
    DATE_TRUNC('month', date_vente)::DATE AS mois,
    SUM(quantite * prix_unitaire)         AS chiffre_affaire_produit
FROM vente_produit_extra
GROUP BY DATE_TRUNC('month', date_vente)
ORDER BY mois;

-Vue chiffre d’affaire ticket (mensuel):

CREATE OR REPLACE VIEW v_ca_ticket_mensuel AS
SELECT
    DATE_TRUNC('month', s.debut)::DATE AS mois,
    SUM(t.prix) AS chiffre_affaire_ticket
FROM ticket t
JOIN statut_ticket st 
   ON st.id = t.id_statut AND st.code = 'PAYE'
JOIN seance s 
   ON s.id = t.id_seance
GROUP BY DATE_TRUNC('month', s.debut);


-global
CREATE OR REPLACE VIEW v_ca_global_mensuel AS
SELECT
    COALESCE(t.mois, p.mois, e.mois) AS mois,

    COALESCE(t.chiffre_affaire_ticket, 0)  AS ca_ticket,
    COALESCE(p.chiffre_affaire_pub, 0)     AS ca_publicite,
    COALESCE(e.chiffre_affaire_produit, 0) AS ca_produit,

    COALESCE(t.chiffre_affaire_ticket, 0)
  + COALESCE(p.chiffre_affaire_pub, 0)
  + COALESCE(e.chiffre_affaire_produit, 0) AS ca_total

FROM v_ca_ticket_mensuel t
FULL JOIN v_ca_pub_mensuel_total p 
       ON p.mois = t.mois
FULL JOIN v_ca_produit_extra_mensuel e 
       ON e.mois = COALESCE(t.mois, p.mois)
ORDER BY mois;

exemple insertion vente:

CREATE OR REPLACE VIEW v_ca_pub_mensuel_total AS
SELECT
    mois,
    SUM(chiffre_affaire_pub) AS chiffre_affaire_pub
FROM v_ca_pub_mensuel_societe
GROUP BY mois;


INSERT INTO vente_produit_extra (id_seance, id_produit, quantite, prix_unitaire, date_vente)
VALUES
-- 🎬 Séance 1 (2026-01-20 10:00)
(1, 1, 8, 10000, '2026-01-20 11:00:00+03'),

-- 🎬 Séance 2 (2026-01-21 10:00)
--(2, 1, 5, 10000, '2026-01-21 11:15:00+03'),

-- 🎬 Séance 3 (2026-01-21 15:00)
(3, 1, 10, 10000, '2026-01-21 16:30:00+03');
