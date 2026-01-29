CREATE OR REPLACE VIEW v_solde_publicite_mensuel AS
SELECT
    ca.mois,
    ca.id_societe,
    ca.societe,
    ca.chiffre_affaire,

    COALESCE(SUM(p.montant), 0) AS total_paye,
    COALESCE(SUM(p.montant), 0) / NULLIF(ca.chiffre_affaire, 0) * 100 AS pourcentage_paye,
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



    