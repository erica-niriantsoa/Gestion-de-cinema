

-- ------------------------------
-- ALEA
-- ------------------------------

--table paiement_publicite
CREATE TABLE paiement_publicite (
    id SERIAL PRIMARY KEY,

    id_societe INT NOT NULL
        REFERENCES societe(id) ON DELETE RESTRICT,

    montant NUMERIC(12,2) NOT NULL CHECK (montant > 0),

    date_paiement DATE NOT NULL,

    reference TEXT,

    commentaire TEXT
);

--SUIVI DU SOLDE PAR SOCIÉTÉ ET PAR MOIS
CREATE OR REPLACE VIEW v_solde_publicite_mensuel AS
SELECT
    ca.mois,
    ca.id_societe,
    ca.societe,
    ca.chiffre_affaire,

    COALESCE(SUM(p.montant), 0) AS total_paye,

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



-- Suppression des anciens paiements pour éviter les doublons
DELETE FROM paiement_publicite
WHERE date_paiement BETWEEN '2025-12-01' AND '2025-12-31';

-- Paiements pour Vaniala (id_societe = 1)
INSERT INTO paiement_publicite (id_societe, montant, date_paiement, reference, commentaire) VALUES
(1, 1000000.00, '2025-12-05', 'VAN-DEC01', 'Premier paiement du mois');
INSERT INTO paiement_publicite (id_societe, montant, date_paiement, reference, commentaire) VALUES
(1, 500000.00, '2025-12-05', 'VAN-DEC01', 'Premier paiement du mois');

-- Paiements pour Lewis (id_societe = 2)
INSERT INTO paiement_publicite (id_societe, montant, date_paiement, reference, commentaire) VALUES
(1, 400000.00, '2025-12-10', 'LEW-DEC01', 'Paiement partiel');
(2, 200000.00, '2025-12-18', 'LEW-DEC02', 'Reste payé');


--REQUETE
SELECT
    mois,
    societe,
    chiffre_affaire,
    total_paye,
    reste_a_payer
FROM v_solde_publicite_mensuel
WHERE societe = 'Vaniala'
  AND mois = '2025-12-01';