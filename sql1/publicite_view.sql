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
LEFT JOIN ticket t ON t.id_seance = s.id
LEFT JOIN diffusion_publicitaire dp ON dp.id_seance = s.id
LEFT JOIN tarif_diffusion_publicitaire td ON td.id = dp.id_tarif

GROUP BY
    f.titre,
    DATE(s.debut),
    TO_CHAR(s.debut, 'HH24:MI')

ORDER BY
    date_diffusion,
    heure_diffusion;
