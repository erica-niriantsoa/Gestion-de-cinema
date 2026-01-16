-- Mettre à jour le tarif enfant pour les places STANDARD uniquement
UPDATE tarif_defaut 
SET prix = 15000 
WHERE id_type_place = 1          -- STANDARD
  AND id_categorie_personne = 2; -- ENFANT

-- Vérification
SELECT 
    tp.libelle as type_place,
    cp.libelle as categorie_personne,
    td.prix
FROM tarif_defaut td
JOIN type_place tp ON td.id_type_place = tp.id
JOIN categorie_personne cp ON td.id_categorie_personne = cp.id
ORDER BY td.id_type_place, td.id_categorie_personne;


-- Supprimer la vue existante si elle existe
DROP VIEW IF EXISTS ca_par_diffusion;

CREATE OR REPLACE VIEW ca_par_diffusion AS
SELECT 
    s.id as diffusion_id,
    s.debut as date_heure_diffusion,
    TO_CHAR(s.debut, 'DD/MM/YYYY HH24:MI') as diffusion_formattee,
    f.titre as film_titre,
    sal.nom as salle_nom,
    sal.capacite,
    -- CA basé sur les paiements réellement acceptés
    COALESCE(SUM(p.montant), 0) as chiffre_affaire,
    COUNT(DISTINCT r.id) as nb_reservations,
    COUNT(t.id) as nb_tickets_vendus,
    
    -- Détail par type de place
    COUNT(CASE WHEN tp.id = 1 THEN t.id END) as nb_places_standard,
    COUNT(CASE WHEN tp.id = 2 THEN t.id END) as nb_places_premium,
    COUNT(CASE WHEN tp.id = 3 THEN t.id END) as nb_places_vip,
    
    -- Places enfant STANDARD uniquement (avec remise 15.000 Ar)
    COUNT(CASE WHEN cp.id = 2 AND tp.id = 1 THEN t.id END) as nb_enfants_standard,
    
    ROUND((COUNT(t.id) * 100.0 / NULLIF(sal.capacite, 0)), 2) as taux_occupation_percent,
    CASE 
        WHEN COUNT(t.id) > 0 
        THEN ROUND(COALESCE(SUM(p.montant), 0) / COUNT(t.id), 0)
        ELSE 0 
    END as ca_moyen_par_ticket
FROM seance s
JOIN film f ON s.id_film = f.id
JOIN salle sal ON s.id_salle = sal.id
LEFT JOIN reservation r ON s.id = r.id_seance 
    AND r.id_statut IN (3, 4)  -- IDs pour PAYEE et CONFIRMEE
LEFT JOIN paiement p ON r.id = p.id_reservation 
    AND p.statut = 'ACCEPTE'  -- Seulement les paiements acceptés
LEFT JOIN ticket t ON r.id = t.id_reservation 
    AND t.id_statut NOT IN (3, 5)  -- Exclut ANNULE et REMBOURSE
LEFT JOIN place pl ON t.id_place = pl.id
LEFT JOIN type_place tp ON pl.id_type_place = tp.id
LEFT JOIN categorie_personne cp ON t.id_categorie_personne = cp.id
GROUP BY s.id, s.debut, f.titre, sal.nom, sal.capacite
ORDER BY s.debut DESC;




--Créer des réservations payées pour les séances existantes
INSERT INTO reservation (id_personne, id_seance, id_statut, montant_total, date_reservation) VALUES
-- Séance 1 (id=1): Le Dernier Royaume - Salle 1
(3, 1, 3, 180000, '2024-06-14 09:00:00+02'),  -- 180,000 Ar
(4, 1, 3, 120000, '2024-06-14 09:30:00+02'),  -- 120,000 Ar
(5, 1, 4, 90000, '2024-06-14 10:00:00+02'),   -- 90,000 Ar

-- Séance 2 (id=2): Echos de l'Espace - Salle 2
(6, 2, 3, 200000, '2024-06-14 11:00:00+02'),  -- 200,000 Ar
(7, 2, 4, 150000, '2024-06-14 11:30:00+02'),  -- 150,000 Ar

-- Séance 3 (id=3): Rires a Paris - Salle 3
(3, 3, 3, 80000, '2024-06-14 12:00:00+02'),   -- 80,000 Ar
(4, 3, 3, 60000, '2024-06-14 12:30:00+02'),   -- 60,000 Ar

-- Séance 5 (id=5): Les Aventuriers du Temps - Salle 5
(5, 5, 3, 250000, '2024-06-14 13:00:00+02'),  -- 250,000 Ar

-- Séance 11 (id=11): Le Dernier Royaume VIP - Salle 6
(6, 11, 4, 300000, '2024-06-14 14:00:00+02'); -- 300,000 Ar


-- ------------------------------
-- PAIEMENTS pour les nouvelles réservations
-- ------------------------------
-- Note: Les IDs des nouvelles réservations commencent après les 5 existantes
INSERT INTO paiement (id_reservation, id_moyen_paiement, montant, date_paiement, reference, statut) VALUES
-- Séance 1 (nouvelles réservations 6, 7, 8)
(6, 1, 180000, '2024-06-14 09:01:00+02', 'CB_TRX_789015', 'ACCEPTE'),
(7, 1, 120000, '2024-06-14 09:31:00+02', 'CB_TRX_789016', 'ACCEPTE'),
(8, 2, 90000, '2024-06-14 10:01:00+02', 'ESP-002', 'ACCEPTE'),

-- Séance 2 (nouvelles réservations 9, 10)
(9, 1, 200000, '2024-06-14 11:01:00+02', 'CB_TRX_789017', 'ACCEPTE'),
(10, 1, 150000, '2024-06-14 11:31:00+02', 'CB_TRX_789018', 'ACCEPTE'),

-- Séance 3 (nouvelles réservations 11, 12)
(11, 2, 80000, '2024-06-14 12:01:00+02', 'ESP-003', 'ACCEPTE'),
(12, 1, 60000, '2024-06-14 12:31:00+02', 'CB_TRX_789019', 'ACCEPTE'),

-- Séance 5 (nouvelle réservation 13)
(13, 1, 250000, '2024-06-14 13:01:00+02', 'CB_TRX_789020', 'ACCEPTE'),

-- Séance 11 (nouvelle réservation 14)
(14, 1, 300000, '2024-06-14 14:01:00+02', 'CB_TRX_789021', 'ACCEPTE');


-- Vérifier les tickets enfants STANDARD
SELECT 
    t.id,
    cp.libelle as categorie,
    tp.libelle as type_place,
    t.prix,
    CASE 
        WHEN cp.libelle = 'ENFANT' AND tp.libelle = 'STANDARD' AND t.prix = 15000
        THEN 'REMISE APPLIQUEE'
        WHEN cp.libelle = 'ENFANT' AND tp.libelle = 'STANDARD' AND t.prix != 15000
        THEN ' REMISE NON APPLIQUEE'
        ELSE 'Autre'
    END as verification_remise
FROM ticket t
JOIN categorie_personne cp ON t.id_categorie_personne = cp.id
JOIN place pl ON t.id_place = pl.id
JOIN type_place tp ON pl.id_type_place = tp.id
WHERE cp.libelle = 'ENFANT' AND tp.libelle = 'STANDARD';


-- Mettre à jour les tickets enfants STANDARD
UPDATE ticket 
SET prix = 15000 
WHERE id IN (6, 7);

-- Vérifier
SELECT 
    t.id,
    cp.libelle as categorie,
    tp.libelle as type_place,
    t.prix,
    CASE 
        WHEN t.prix = 15000 THEN 'CORRECT'
        ELSE 'A CORRIGER'
    END as statut
FROM ticket t
JOIN categorie_personne cp ON t.id_categorie_personne = cp.id
JOIN place pl ON t.id_place = pl.id
JOIN type_place tp ON pl.id_type_place = tp.id
WHERE cp.libelle = 'ENFANT' AND tp.libelle = 'STANDARD';