-- ------------------------------
-- TRUNCATE TOUTES LES TABLES (CASCADE)
-- ------------------------------
TRUNCATE TABLE 
    historique_statut_ticket,
    historique_statut_reservation,
    reservation_promotion,
    paiement,
    ticket,
    reservation,
    tarif_seance,
    tarif_defaut,
    seance,
    film_categorie,
    place,
    personne,
    film,
    categorie,
    categorie_personne,
    type_place,
    salle,
    statut_ticket,
    statut_reservation,
    moyen_paiement,
    promotion
CASCADE;



-- RESET DES SEQUENCES POUR AUTO-INCREMENT
SELECT setval('reservation_id_seq', (SELECT MAX(id) FROM reservation));
SELECT setval('ticket_id_seq', (SELECT MAX(id) FROM ticket));
SELECT setval('historique_statut_reservation_id_seq', (SELECT MAX(id) FROM historique_statut_reservation));
SELECT setval('personne_id_seq', (SELECT MAX(id) FROM personne));
SELECT setval('seance_id_seq', (SELECT MAX(id) FROM seance));
SELECT setval('place_id_seq', (SELECT MAX(id) FROM place));
SELECT setval('salle_id_seq', (SELECT MAX(id) FROM salle));
SELECT setval('film_id_seq', (SELECT MAX(id) FROM film));
SELECT setval('categorie_id_seq', (SELECT MAX(id) FROM categorie));
SELECT setval('type_place_id_seq', (SELECT MAX(id) FROM type_place));
SELECT setval('categorie_personne_id_seq', (SELECT MAX(id) FROM categorie_personne));
SELECT setval('statut_reservation_id_seq', (SELECT MAX(id) FROM statut_reservation));
SELECT setval('statut_ticket_id_seq', (SELECT MAX(id) FROM statut_ticket));
SELECT setval('tarif_defaut_id_seq', (SELECT MAX(id) FROM tarif_defaut));
SELECT setval('tarif_seance_id_seq', (SELECT MAX(id) FROM tarif_seance));


-- ------------------------------
-- RESET DES SEQUENCES
-- ------------------------------
SELECT setval('moyen_paiement_id_seq', (SELECT MAX(id) FROM moyen_paiement));
SELECT setval('paiement_id_seq', (SELECT MAX(id) FROM paiement));
SELECT setval('promotion_id_seq', (SELECT MAX(id) FROM promotion));
SELECT setval('reservation_promotion_id_seq', (SELECT MAX(id) FROM reservation_promotion));