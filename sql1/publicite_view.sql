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


-- -- ------------------------------
-- -- v_chiffre_affaire_seance_affichage
-- -- ------------------------------
-- CREATE OR REPLACE VIEW v_chiffre_affaire_seance_affichage AS
-- SELECT
--     film,
--     date_diffusion,
--     heure_diffusion,

--     -- Tickets
--     montant_ticket,

--     -- Publicité
--     SUM(ca_diffusion)                   AS ca_pub_total,
--     SUM(montant_paye_diffusion)         AS ca_pub_paye,
--     SUM(reste_a_payer_diffusion)        AS ca_pub_restant,

--     -- Total général
--     montant_ticket
--       + SUM(ca_diffusion)               AS ca_total,
--     montant_ticket
--       + SUM(montant_paye_diffusion)     AS ca_encaisse,
--     montant_ticket
--       + SUM(reste_a_payer_diffusion)    AS ca_restant

-- FROM (
--     SELECT
--         s.film,
--         s.date_diffusion,
--         s.heure_diffusion,

--         COALESCE(SUM(t.prix),0) AS montant_ticket,

--         p.ca_diffusion,
--         p.montant_paye_diffusion,
--         p.reste_a_payer_diffusion

--     FROM v_ca_pub_seance_societe_final p
--     JOIN v_pub_seance_societe s
--          ON s.film=p.film
--         AND s.date_diffusion=p.date_diffusion
--         AND s.heure_diffusion=p.heure_diffusion
--     LEFT JOIN seance se ON se.id=s.id_seance
--     LEFT JOIN ticket t ON t.id_seance=se.id

--     GROUP BY
--         s.film, s.date_diffusion, s.heure_diffusion,
--         p.ca_diffusion, p.montant_paye_diffusion, p.reste_a_payer_diffusion
-- ) x
-- GROUP BY
--     film, date_diffusion, heure_diffusion, montant_ticket
-- ORDER BY
--     date_diffusion, heure_diffusion;

-- ---------------------------------
-- --v_seance_ticket_publicite
-- ---------------------------------
-- CREATE OR REPLACE VIEW v_seance_ticket_publicite AS
-- SELECT
--     f.titre                                AS film,
--     DATE(s.debut)                          AS date_diffusion,
--     TO_CHAR(s.debut,'HH24:MI')             AS heure_diffusion,

--     -- Tickets
--     COUNT(st.id) AS nb_tickets,
--     COALESCE(SUM(
--         CASE WHEN st.id IS NOT NULL THEN t.prix ELSE 0 END
--     ),0) AS montant_ticket


--     -- Publicités
--     COUNT(dp.id)                           AS nb_publicites,
--     STRING_AGG(DISTINCT so.nom, ', ')      AS societes_publicitaires

-- FROM seance s
-- JOIN film f ON f.id = s.id_film

-- LEFT JOIN ticket t 
--        ON t.id_seance = s.id

-- LEFT JOIN diffusion_publicitaire dp 
--        ON dp.id_seance = s.id

-- LEFT JOIN societe so 
--        ON so.id = dp.id_societe

-- GROUP BY
--     f.titre,
--     DATE(s.debut),
--     TO_CHAR(s.debut,'HH24:MI')

-- ORDER BY
--     date_diffusion,
--     heure_diffusion;


