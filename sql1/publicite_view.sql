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