CREATE OR REPLACE VIEW v_chiffre_affaire_seance_affichage AS
WITH 
-- 🎬 Publicités agrégées par séance
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

-- 🎟️ Tickets agrégés par séance
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

    -- 🎟️ Tickets encaissés
    ts.montant_ticket,

    -- 📺 Publicité
    COALESCE(p.montant_pub_total, 0) AS montant_pub_total,
    COALESCE(p.montant_pub_paye, 0) AS montant_pub_paye,
    COALESCE(p.montant_pub_restant, 0) AS montant_pub_restant,

    -- 🍿 Produits extra
    COALESCE(e.montant_extra, 0) AS montant_extra,

    -- 💰 Totaux
    ts.montant_ticket
        + COALESCE(p.montant_pub_total, 0)
        + COALESCE(e.montant_extra, 0) AS ca_total,

    ts.montant_ticket
        + COALESCE(p.montant_pub_paye, 0)
        + COALESCE(e.montant_extra, 0) AS ca_encaisse,

    ts.montant_ticket
        + COALESCE(p.montant_pub_restant, 0)
        + COALESCE(e.montant_extra, 0) AS ca_restant

FROM tickets_seance ts
LEFT JOIN pub_seance p 
    ON p.film = ts.film
   AND p.date_diffusion = ts.date_diffusion
   AND p.heure_diffusion = ts.heure_diffusion

LEFT JOIN v_chiffre_affaire_produit_extra_par_film e
    ON e.film = ts.film
   AND e.date_diffusion = ts.date_diffusion
   AND e.heure_diffusion = ts.heure_diffusion

ORDER BY
    ts.date_diffusion,
    ts.heure_diffusion;




INSERT INTO vente_produit_extra (id_seance, id_produit, quantite)
VALUES
(1, 1, 8),  -- Séance 1, 8 Pop corn
(2, 1, 5),  -- Séance 2, 5 Pop corn
(3, 1, 10); -- Séance 3, 10 Pop corn
