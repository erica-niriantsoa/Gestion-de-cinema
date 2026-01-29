-- Vue complète
CREATE OR REPLACE VIEW vue_reservation_complete AS
SELECT 
    r.id as reservation_id,
    r.date_reservation,
    r.montant_total,
    p.nom_complet as client_nom,
    p.email as client_email,
    f.titre as film_titre,
    s.debut as seance_debut,
    s.fin as seance_fin,
    sal.nom as salle_nom,
    sr.libelle as statut_reservation,
    COUNT(t.id) as nb_tickets,
    -- FILTER pour exclure les lignes où t.id est NULL
    COALESCE(
        ARRAY_AGG(
            json_build_object(
                'ticket_id', t.id,
                'place', pl.code_place,
                'type_place', tp.libelle,
                'categorie', cp.libelle,
                'prix', t.prix,
                'statut', st.libelle
            )
        ) FILTER (WHERE t.id IS NOT NULL),
        '{}'::json[]
    ) as tickets
FROM reservation r
LEFT JOIN personne p ON r.id_personne = p.id
JOIN seance s ON r.id_seance = s.id
JOIN film f ON s.id_film = f.id
JOIN salle sal ON s.id_salle = sal.id
JOIN statut_reservation sr ON r.id_statut = sr.id
LEFT JOIN ticket t ON r.id = t.id_reservation
LEFT JOIN place pl ON t.id_place = pl.id
LEFT JOIN type_place tp ON pl.id_type_place = tp.id
LEFT JOIN categorie_personne cp ON t.id_categorie_personne = cp.id
LEFT JOIN statut_ticket st ON t.id_statut = st.id
GROUP BY r.id, p.id, f.id, s.id, sal.id, sr.id;


CREATE OR REPLACE VIEW statuts_ticket_actifs AS
SELECT id FROM statut_ticket 
WHERE code IN ('RESERVE', 'PAYE', 'UTILISE');

-- Vue pour les places disponibles (VERSION FINALE)
CREATE OR REPLACE VIEW places_disponibles AS
SELECT
    s.id as seance_id,
    p.id as place_id,
    p.code_place,
    p.rangee,
    p.numero,
    tp.libelle as type_place,
    tp.id as type_place_id,
    s.debut as seance_debut,
    f.titre as film_titre,
    sal.nom as salle_nom,
    sal.id as salle_id
FROM place p
JOIN type_place tp ON p.id_type_place = tp.id
JOIN salle sal ON p.id_salle = sal.id
CROSS JOIN seance s
JOIN film f ON s.id_film = f.id
WHERE s.id_salle = p.id_salle
AND NOT EXISTS (
    SELECT 1 FROM ticket t
    WHERE t.id_seance = s.id
    AND t.id_place = p.id
    AND t.id_statut IN (SELECT id FROM statuts_ticket_actifs)
);


-- Vue pour calculer le revenu maximal par séance (basé sur tarif_defaut)
DROP VIEW IF EXISTS revenu_maximal_seance;
CREATE VIEW revenu_maximal_seance AS
SELECT 
    s.id as seance_id,
    f.titre as film_titre,
    s.debut as seance_debut,
    s.fin as seance_fin,
    sal.nom as salle_nom,
    sal.id as salle_id,
    sal.capacite,
    -- Nombre de places par type
    COUNT(DISTINCT p.id) as nb_places_total,
    COUNT(DISTINCT CASE WHEN p.id_type_place = 1 THEN p.id END) as nb_places_standard,
    COUNT(DISTINCT CASE WHEN p.id_type_place = 2 THEN p.id END) as nb_places_premium,
    -- Revenu maximal : somme des prix maximums selon le type de place
    COALESCE(SUM(
        (SELECT MAX(td.prix) 
         FROM tarif_defaut td 
         WHERE td.id_type_place = p.id_type_place)
    ), 0) as revenu_maximal
FROM seance s
JOIN film f ON s.id_film = f.id
JOIN salle sal ON s.id_salle = sal.id
JOIN place p ON p.id_salle = sal.id
GROUP BY s.id, f.titre, s.debut, s.fin, sal.nom, sal.id, sal.capacite
ORDER BY s.debut DESC;


CREATE OR REPLACE VIEW view_tarif_defaut_all AS
SELECT 
    td.id_type_place,
    e.id_categorie_personne,
    cp.libelle AS categorie_personne,
    ROUND(td.prix *(1- e.coefficient)) AS prix_calcule
FROM tarif_defaut td
JOIN equivalence_tarif e 
    ON 1 = 1  -- on veut appliquer tous les coefficients à chaque type de place
JOIN categorie_personne cp 
    ON cp.id = e.id_categorie_personne
WHERE td.id_categorie_personne = 1;  -- prix de base = adulte
