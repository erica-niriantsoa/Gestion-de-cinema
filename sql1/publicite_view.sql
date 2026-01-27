-----------------------
--ALEA HIER
-----------------------

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



    CREATE OR REPLACE VIEW v_chiffre_affaire_seance AS
SELECT
    f.titre AS film,
    DATE(s.debut) AS date_diffusion,
    TO_CHAR(s.debut, 'HH24:MI') AS heure_diffusion,

    -- Montant total des tickets vendus
    COALESCE(SUM(t.prix), 0) AS montant_ticket,

    -- Montant total des publicités diffusées pendant la séance
    COALESCE(SUM(td.prix), 0) AS montant_publicite,

    -- Chiffre d'affaire total
    COALESCE(SUM(t.prix), 0) + COALESCE(SUM(td.prix), 0) AS chiffre_affaire_total

FROM seance s
JOIN film f ON f.id = s.id
LEFT JOIN ticket t 
       ON t.id_seance = s.id

LEFT JOIN statut_ticket st 
       ON st.id = t.id_statut
      AND st.code = 'PAYE'

LEFT JOIN diffusion_publicitaire dp ON dp.id_seance = s.id
LEFT JOIN tarif_diffusion_publicitaire td ON td.id = dp.id_tarif

GROUP BY
    f.titre,
    DATE(s.debut),
    TO_CHAR(s.debut, 'HH24:MI')

ORDER BY
    date_diffusion,
    heure_diffusion;



------------------------------
---v_ca_pub_seance_societe 
-----------------------------
CREATE OR REPLACE VIEW v_ca_pub_seance_societe AS
SELECT
    f.titre                               AS film,
    DATE(s.debut)                         AS date_diffusion,
    TO_CHAR(s.debut, 'HH24:MI')           AS heure_diffusion,
    so.nom                                AS societe,

    COUNT(dp.id)                          AS nb_diffusions,

    COUNT(dp.id) * td.prix               AS ca_pub_seance

FROM seance s
JOIN film f ON f.id = s.id_film

JOIN diffusion_publicitaire dp 
     ON dp.id_seance = s.id

JOIN societe so 
     ON so.id = dp.id_societe

JOIN tarif_diffusion_publicitaire td
     ON td.id = dp.id_tarif

GROUP BY
    f.titre,
    DATE(s.debut),
    TO_CHAR(s.debut, 'HH24:MI'),
    so.nom,
    td.prix;


-------------------------------
-- : v_ca_pub_mensuel_societe
-------------------------------
CREATE OR REPLACE VIEW v_ca_pub_mensuel_societe AS
SELECT
    DATE_TRUNC('month', date_diffusion)::DATE AS mois,
    societe,
    SUM(ca_pub_seance) AS chiffre_affaire_pub
FROM v_ca_pub_seance_societe
GROUP BY
    DATE_TRUNC('month', date_diffusion),
    societe;


DROP VIEW IF EXISTS v_solde_publicite_mensuel CASCADE;

---------------------------
--v_solde_publicite_mensuel
--------------------------
CREATE OR REPLACE VIEW v_solde_publicite_mensuel AS
SELECT
    ca.mois,
    s.id AS id_societe,
    ca.societe,
    ca.chiffre_affaire_pub AS chiffre_affaire,

    COALESCE(SUM(p.montant),0) AS total_paye,

    COALESCE(SUM(p.montant),0)
      / NULLIF(ca.chiffre_affaire_pub,0) * 100 AS pourcentage_paye,

    ca.chiffre_affaire_pub
      - COALESCE(SUM(p.montant),0) AS reste_a_payer

FROM v_ca_pub_mensuel_societe ca
JOIN societe s ON s.nom = ca.societe
LEFT JOIN paiement_publicite p
   ON p.id_societe = s.id
  AND DATE_TRUNC('month', p.date_paiement) = ca.mois

GROUP BY
    ca.mois,
    s.id,
    ca.societe,
    ca.chiffre_affaire_pub;


-- ------------------------------
-- Vue fille proportionnelle par diffusion et par société
-- ------------------------------

CREATE OR REPLACE VIEW v_ca_pub_seance_societe_final AS
SELECT
    c.film,
    c.date_diffusion,
    c.heure_diffusion,
    c.societe,
    c.ca_pub_seance AS ca_diffusion,

    vm.pourcentage_paye,

    c.ca_pub_seance * vm.pourcentage_paye / 100
        AS montant_paye_diffusion,

    c.ca_pub_seance
      - (c.ca_pub_seance * vm.pourcentage_paye / 100)
        AS reste_a_payer_diffusion

FROM v_ca_pub_seance_societe c
JOIN v_solde_publicite_mensuel vm
  ON vm.societe = c.societe
 AND vm.mois = DATE_TRUNC('month', c.date_diffusion);


---------------------
--affichage
---------------------
DROP VIEW IF EXISTS v_chiffre_affaire_seance_affichage CASCADE;

CREATE OR REPLACE VIEW v_chiffre_affaire_seance_affichage AS
WITH 
-- Sous-requête pour les publicités agrégées par séance
pub_seance AS (
    SELECT
        film,
        date_diffusion,
        heure_diffusion,
        SUM(ca_diffusion) AS montant_pub_total,
        SUM(montant_paye_diffusion) AS montant_pub_paye,
        SUM(reste_a_payer_diffusion) AS montant_pub_restant
    FROM v_ca_pub_seance_societe_final
    GROUP BY film, date_diffusion, heure_diffusion
),
-- Sous-requête pour les tickets agrégés par séance (TOUTES les séances)
tickets_seance AS (
    SELECT
        s.id AS seance_id,
        f.titre AS film,
        DATE(s.debut) AS date_diffusion,
        TO_CHAR(s.debut, 'HH24:MI') AS heure_diffusion,
        COALESCE(SUM(
            CASE WHEN st.code = 'PAYE' THEN t.prix ELSE 0 END
        ), 0) AS montant_ticket
    FROM seance s
    JOIN film f ON f.id = s.id_film
    LEFT JOIN ticket t ON t.id_seance = s.id
    LEFT JOIN statut_ticket st ON st.id = t.id_statut
    GROUP BY s.id, f.titre, DATE(s.debut), TO_CHAR(s.debut, 'HH24:MI')
)
SELECT
    ts.film,
    ts.date_diffusion,
    ts.heure_diffusion,

    -- Tickets encaissés
    ts.montant_ticket,

    -- Publicité (déjà agrégée) - 0 si pas de pub
    COALESCE(p.montant_pub_total, 0) AS montant_pub_total,
    COALESCE(p.montant_pub_paye, 0) AS montant_pub_paye,
    COALESCE(p.montant_pub_restant, 0) AS montant_pub_restant,

    -- Totaux
    ts.montant_ticket + COALESCE(p.montant_pub_total, 0) AS ca_total,
    ts.montant_ticket + COALESCE(p.montant_pub_paye, 0) AS ca_encaisse,
    ts.montant_ticket + COALESCE(p.montant_pub_restant, 0) AS ca_restant

FROM tickets_seance ts
LEFT JOIN pub_seance p 
    ON p.date_diffusion = ts.date_diffusion
    AND p.heure_diffusion = ts.heure_diffusion
    AND p.film = ts.film

ORDER BY
    ts.date_diffusion,
    ts.heure_diffusion;


-- ---------------------------------
-- --v_seance_ticket_publicite
-- ---------------------------------
CREATE OR REPLACE VIEW v_seance_ticket_publicite AS
SELECT
    f.titre                                AS film,
    DATE(s.debut)                          AS date_diffusion,
    TO_CHAR(s.debut,'HH24:MI')             AS heure_diffusion,

    -- Tickets PAYÉS uniquement
    COUNT(st.id) AS nb_tickets,
    COALESCE(SUM(
        CASE WHEN st.id IS NOT NULL THEN t.prix ELSE 0 END
    ),0) AS montant_ticket,

    -- Publicités
    COUNT(dp.id)                           AS nb_publicites,
    STRING_AGG(DISTINCT so.nom, ', ')      AS societes_publicitaires

FROM seance s
JOIN film f ON f.id = s.id_film

LEFT JOIN ticket t 
       ON t.id_seance = s.id

LEFT JOIN statut_ticket st 
       ON st.id = t.id_statut
      AND st.code = 'PAYE'

LEFT JOIN diffusion_publicitaire dp 
       ON dp.id_seance = s.id

LEFT JOIN societe so 
       ON so.id = dp.id_societe

GROUP BY
    f.titre,
    DATE(s.debut),
    TO_CHAR(s.debut,'HH24:MI')

ORDER BY
    date_diffusion,
    heure_diffusion;





CREATE OR REPLACE VIEW v_chiffre_affaire_seance_affichage AS
SELECT
    c.film,
    c.date_diffusion,
    c.heure_diffusion,

    -- Tickets encaissés
    COALESCE(SUM(t.prix),0) AS montant_ticket,

    -- Publicité (répartie proportionnellement selon le chiffre d'affaire pub de la société)
    SUM(ca.chiffre_affaire) * (SUM(c.ca_diffusion) / NULLIF(SUM(ca.chiffre_affaire),0)) AS montant_pub_total,
    SUM(ca.total_paye) * (SUM(c.ca_diffusion) / NULLIF(SUM(ca.chiffre_affaire),0)) AS montant_pub_paye,
    SUM(ca.reste_a_payer) * (SUM(c.ca_diffusion) / NULLIF(SUM(ca.chiffre_affaire),0)) AS montant_pub_restant,

    -- Totaux
    COALESCE(SUM(t.prix),0) + SUM(ca.chiffre_affaire) AS ca_total,
    COALESCE(SUM(t.prix),0) + SUM(ca.total_paye) AS ca_encaisse,
    COALESCE(SUM(t.prix),0) + SUM(ca.reste_a_payer) AS ca_restant

FROM v_ca_pub_seance_societe_final c

LEFT JOIN v_solde_publicite_mensuel ca
    ON ca.id_societe = c.id_societe
   AND DATE_TRUNC('month', c.date_diffusion) = ca.mois

LEFT JOIN seance s 
       ON DATE(s.debut) = c.date_diffusion
      AND TO_CHAR(s.debut,'HH24:MI') = c.heure_diffusion

LEFT JOIN ticket t 
       ON t.id_seance = s.id

LEFT JOIN statut_ticket st
       ON st.id = t.id_statut
      AND st.code = 'PAYE'

GROUP BY
    c.film,
    c.date_diffusion,
    c.heure_diffusion

ORDER BY
    c.date_diffusion,
    c.heure_diffusion;
