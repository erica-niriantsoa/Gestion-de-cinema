-- ------------------------------
-- TYPE DE PLACE
-- ------------------------------
INSERT INTO type_place (id, libelle) VALUES
(1, 'STANDARD'),
(2, 'VIP'),
(3, 'PMR');

-- ------------------------------
-- CATEGORIE PERSONNE
-- ------------------------------
INSERT INTO categorie_personne (id, libelle) VALUES
(1, 'ADULTE'),
(2, 'ENFANT'),
(3, 'SENIOR');

-- ------------------------------
-- CATEGORIES DE FILMS
-- ------------------------------
INSERT INTO categorie (id, libelle) VALUES
(1, 'ACTION'),
(2, 'AVENTURE'),
(3, 'COMEDIE'),
(4, 'DRAME'),
(5, 'ROMANCE'),
(6, 'SCIENCE-FICTION'),
(7, 'THRILLER'),
(8, 'HORREUR'),
(9, 'ANIMATION'),
(10, 'DOCUMENTAIRE');

-- ------------------------------
-- FILMS
-- ------------------------------
INSERT INTO film (id, titre, description, duree_minutes, date_sortie, age_min, langue_originale) VALUES
(1, 'Le Dernier Royaume', 'Un jeune guerrier cherche a reconquerir son heritage dans l''Angleterre du IXe siecle.', 138, '2024-03-15', 12, 'Francais'),
(2, 'Echos de l''Espace', 'Une equipe d''astronautes decouvre un signal mysterieux provenant d''une galaxie lointaine.', 156, '2024-04-22', 10, 'Anglais'),
(3, 'Rires a Paris', 'Comedie romantique situee dans les rues de Paris, ou deux etrangers se rencontrent par hasard.', 112, '2024-02-10', 6, 'Francais'),
(4, 'L''Ombre du Passe', 'Un thriller psychologique ou un detective doit resoudre une affaire liee a son propre passe.', 127, '2024-01-18', 16, 'Anglais'),
(5, 'Les Aventuriers du Temps', 'Un groupe de scientifiques voyage a travers le temps pour sauver l''avenir de l''humanite.', 142, '2024-05-30', 8, 'Anglais'),
(6, 'Coeurs Brisees', 'Drame romantique sur l''amour, la perte et la redemption.', 118, '2024-03-28', 12, 'Francais'),
(7, 'Monstres et Cie : La Nouvelle Generation', 'Animation familiale ou les monstres doivent s''adapter a un monde en changement.', 105, '2024-06-12', 0, 'Anglais'),
(8, 'Le Secret de la Foret', 'Aventure fantastique dans une foret enchantee pleine de creatures magiques.', 96, '2024-04-05', 6, 'Francais'),
(9, 'Avatar', 'Un marine paraplégique est envoyé sur la lune Pandora pour une mission unique mais qui tourne mal.', 162, '2009-12-18', 12, 'Anglais');

-- ------------------------------
-- FILM_CATEGORIE
-- ------------------------------
INSERT INTO film_categorie (id_film, id_categorie) VALUES
(1, 1), (1, 2),
(2, 6), (2, 2),
(3, 3), (3, 5),
(4, 7), (4, 4),
(5, 1), (5, 2), (5, 6),
(6, 4), (6, 5),
(7, 9), (7, 3),
(8, 2), (8, 9);

-- ------------------------------
-- SALLES
-- ------------------------------
INSERT INTO salle (id, nom, capacite) VALUES
(1, 'Salle 1 - Odeon', 120),
(2, 'Salle 2 - Majestic', 80),
(3, 'Salle 3 - Paradisio', 200),
(4, 'Salle 4 - Lumiere', 60),
(5, 'Salle 5 - IMAX', 150),
(6, 'Salle VIP - Prestige', 40);

-- ------------------------------
-- PLACES (exemples reduits)
-- ------------------------------
-- Note: Les IDs de place 123, 124, 201, 202, 301, 302, 303, 401, 402, 403, 404 n'existent pas dans les donnees
-- Nous allons creer un jeu de donnees coherent

-- Salle 1 (Odéon) - 20 premieres places
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
(1, 1, 'A', 1, 'A1', 1), (2, 1, 'A', 2, 'A2', 1), (3, 1, 'A', 3, 'A3', 1),
(4, 1, 'A', 4, 'A4', 1), (5, 1, 'A', 5, 'A5', 1), (6, 1, 'A', 6, 'A6', 1),
(7, 1, 'A', 7, 'A7', 1), (8, 1, 'A', 8, 'A8', 1), (9, 1, 'A', 9, 'A9', 1),
(10, 1, 'A', 10, 'A10', 1), (11, 1, 'A', 11, 'A11', 1), (12, 1, 'A', 12, 'A12', 1),
(13, 1, 'A', 13, 'A13', 1), (14, 1, 'A', 14, 'A14', 1), (15, 1, 'A', 15, 'A15', 1),
(16, 1, 'A', 16, 'A16', 1), (17, 1, 'A', 17, 'A17', 1), (18, 1, 'A', 18, 'A18', 1),
(19, 1, 'A', 19, 'A19', 1), (20, 1, 'A', 20, 'A20', 1);

-- Salle 2 (Majestic) - 6 places
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
(101, 2, 'A', 1, 'A1', 1), (102, 2, 'A', 2, 'A2', 1), (103, 2, 'A', 3, 'A3', 1),
(121, 2, 'B', 1, 'B1', 2), (122, 2, 'B', 2, 'B2', 2), (141, 2, 'C', 1, 'C1', 3);

-- Salle 6 (VIP) - 4 places
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
(301, 6, 'A', 1, 'A1', 2), (302, 6, 'A', 2, 'A2', 2),
(303, 6, 'A', 3, 'A3', 2), (304, 6, 'A', 4, 'A4', 2);

-- Salle 5 (IMAX) - 4 places
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
(401, 5, 'A', 1, 'A1', 1), (402, 5, 'A', 2, 'A2', 1),
(403, 5, 'A', 3, 'A3', 1), (404, 5, 'A', 4, 'A4', 1);

-- Salle 3 (Paradisio) - 2 places (pour les tickets 8 et 9)
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
(201, 3, 'A', 1, 'A1', 1), (202, 3, 'A', 2, 'A2', 1);

-- ------------------------------
-- SEANCES
-- ------------------------------
INSERT INTO seance (id, id_film, id_salle, debut, fin, langue) VALUES
(1, 1, 1, '2024-06-15 14:00:00+02', '2024-06-15 16:18:00+02', 'VF'),
(2, 2, 2, '2024-06-15 15:30:00+02', '2024-06-15 18:06:00+02', 'VO'),
(3, 3, 3, '2024-06-15 17:00:00+02', '2024-06-15 18:52:00+02', 'VF'),
(4, 4, 4, '2024-06-15 20:00:00+02', '2024-06-15 22:07:00+02', 'VO'),
(5, 5, 5, '2024-06-15 21:30:00+02', '2024-06-15 23:52:00+02', 'VF'),
(6, 6, 1, '2024-06-16 13:00:00+02', '2024-06-16 14:58:00+02', 'VF'),
(7, 7, 2, '2024-06-16 14:30:00+02', '2024-06-16 16:15:00+02', 'VO'),
(8, 8, 3, '2024-06-16 16:00:00+02', '2024-06-16 17:36:00+02', 'VF'),
(9, 1, 4, '2024-06-16 18:30:00+02', '2024-06-16 20:48:00+02', 'VO'),
(10, 2, 5, '2024-06-16 20:00:00+02', '2024-06-16 22:36:00+02', 'VF'),
(11, 1, 6, '2024-06-15 19:00:00+02', '2024-06-15 21:18:00+02', 'VO'),
(12, 5, 6, '2024-06-16 19:00:00+02', '2024-06-16 21:22:00+02', 'VF'),
(13, 2, 6, '2024-06-17 20:00:00+02', '2024-06-17 22:36:00+02', 'VO'),
(14, 9, 1, '2026-01-10 10:00:00+02', '2026-01-10 12:42:00+02', 'VO');

-- ------------------------------
-- PERSONNES
-- ------------------------------
INSERT INTO personne (id, nom_complet, email, telephone, mot_de_passe, role) VALUES
(1, 'Jean Martin', 'admin@cinema.com', '0123456789', '$2a$10$N9qo8uLOickgx2ZMRZoMyeRHYJ8vQp9X9Jgxq5fZ4QbB1B2C3D4E5F', 'ADMIN'),
(2, 'Marie Dubois', 'marie.admin@cinema.com', '0234567891', '$2a$10$ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210zyxwvutsrqponmlkjihg', 'ADMIN'),
(3, 'Thomas Bernard', 'thomas@mail.com', '0645123789', '$2a$10$ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', 'CLIENT'),
(4, 'Sophie Laurent', 'sophie@mail.com', '0655123789', '$2a$10$1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRST', 'CLIENT'),
(5, 'Lucas Petit', 'lucas@mail.com', '0678123456', '$2a$10$qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM', 'CLIENT'),
(6, 'Emma Robert', 'emma@mail.com', '0698765432', '$2a$10$passwordhashedexample1234567890abcdefghijkl', 'CLIENT'),
(7, 'Mohamed Ali', 'mohamed@mail.com', '0612345678', '$2a$10$examplehash1234567890abcdefghijklmnopqrstuv', 'CLIENT');

-- ------------------------------
-- STATUTS RESERVATION
-- ------------------------------
INSERT INTO statut_reservation (id, code, libelle) VALUES
(1, 'CREEE', 'Creee'),
(2, 'EN_ATTENTE', 'En attente de paiement'),
(3, 'PAYEE', 'Payee'),
(4, 'CONFIRMEE', 'Confirmee'),
(5, 'ANNULEE', 'Annulee'),
(6, 'EXPIREE', 'Expiree');

-- ------------------------------
-- RESERVATIONS (corrigé - manquait dans le script original)
-- ------------------------------
INSERT INTO reservation (id, id_personne, id_seance, id_statut, montant_total, date_reservation) VALUES
(1, 3, 1, 3, 29.70, '2024-06-14 10:30:00+02'),
(2, 4, 2, 3, 48.70, '2024-06-14 11:45:00+02'),
(3, 5, 3, 2, 19.80, '2024-06-14 14:20:00+02'),
(4, 6, 11, 3, 59.70, '2024-06-14 16:10:00+02'),
(5, 7, 5, 4, 39.60, '2024-06-14 18:30:00+02');

-- ------------------------------
-- HISTORIQUE STATUT RESERVATION
-- ------------------------------
INSERT INTO historique_statut_reservation (id, id_reservation, id_statut, date_changement, change_par) VALUES
(1, 1, 1, '2024-06-14 10:30:00+02', 3),
(2, 1, 2, '2024-06-14 10:31:00+02', 3),
(3, 1, 3, '2024-06-14 10:32:00+02', 3),
(4, 2, 1, '2024-06-14 11:45:00+02', 4),
(5, 2, 3, '2024-06-14 11:46:00+02', 4),
(6, 3, 1, '2024-06-14 14:20:00+02', 5),
(7, 3, 2, '2024-06-14 14:21:00+02', 5),
(8, 4, 1, '2024-06-14 16:10:00+02', 6),
(9, 4, 3, '2024-06-14 16:11:00+02', 6),
(10, 5, 1, '2024-06-14 18:30:00+02', 7),
(11, 5, 2, '2024-06-14 18:31:00+02', 7),
(12, 5, 4, '2024-06-14 18:32:00+02', 7);

-- ------------------------------
-- STATUTS TICKET
-- ------------------------------
INSERT INTO statut_ticket (id, code, libelle) VALUES
(1, 'RESERVE', 'Reserve'),
(2, 'PAYE', 'Paye'),
(3, 'ANNULE', 'Annule'),
(4, 'UTILISE', 'Utilise'),
(5, 'REMBOURSE', 'Rembourse');

-- ------------------------------
-- TICKETS (corrigé pour correspondre aux places existantes)
-- ------------------------------
INSERT INTO ticket (id, id_reservation, id_seance, id_place, id_statut, id_categorie_personne, prix) VALUES
(1, 1, 1, 1, 2, 1, 9.90),
(2, 1, 1, 2, 2, 1, 9.90),
(3, 1, 1, 3, 2, 1, 9.90),
(4, 2, 2, 121, 2, 1, 14.90),
(5, 2, 2, 122, 2, 1, 14.90),
(6, 2, 2, 103, 2, 2, 9.90),   -- Changé de 123 à 103 (place existante)
(7, 2, 2, 102, 2, 2, 9.90),   -- Changé de 124 à 102 (place existante)
(8, 3, 3, 201, 1, 1, 9.90),
(9, 3, 3, 202, 1, 1, 9.90),
(10, 4, 11, 301, 2, 1, 19.90),
(11, 4, 11, 302, 2, 1, 19.90),
(12, 4, 11, 303, 2, 1, 19.90),
(13, 5, 5, 401, 4, 1, 9.90),
(14, 5, 5, 402, 4, 1, 9.90),
(15, 5, 5, 403, 4, 1, 9.90),
(16, 5, 5, 404, 4, 1, 9.90);

-- ------------------------------
-- HISTORIQUE STATUT TICKET
-- ------------------------------
INSERT INTO historique_statut_ticket (id, id_ticket, id_statut, date_changement, change_par, commentaire) VALUES
(1, 1, 1, '2024-06-14 10:30:00+02', 3, 'Reservation creee'),
(2, 1, 2, '2024-06-14 10:32:00+02', 3, 'Paiement confirme'),
(3, 4, 1, '2024-06-14 11:45:00+02', 4, 'Reservation VIP creee'),
(4, 4, 2, '2024-06-14 11:46:00+02', 4, 'Paiement VIP effectue'),
(5, 8, 1, '2024-06-14 14:20:00+02', 5, 'Reservation creee'),
(6, 8, 2, '2024-06-14 14:21:00+02', 5, 'Paiement en attente');

-- ------------------------------
-- TARIF PAR DEFAUT (corrigé - pas de catégorie 4 "ETUDIANT" dans categorie_personne)
-- ------------------------------
INSERT INTO tarif_defaut (id, id_type_place, id_categorie_personne, prix) VALUES
(1, 1, 1, 9.90),   -- STANDARD, ADULTE
(2, 1, 2, 6.50),   -- STANDARD, ENFANT
(3, 1, 3, 7.90),   -- STANDARD, SENIOR
(4, 2, 1, 14.90),  -- VIP, ADULTE
(5, 2, 2, 9.90),   -- VIP, ENFANT
(6, 2, 3, 12.90),  -- VIP, SENIOR
(7, 3, 1, 8.90),   -- PMR, ADULTE
(8, 3, 2, 5.90),   -- PMR, ENFANT
(9, 3, 3, 6.90);   -- PMR, SENIOR

-- ------------------------------
-- TARIF SPECIFIQUE PAR SEANCE (corrigé - pas de catégorie 4)
-- ------------------------------
INSERT INTO tarif_seance (id, id_seance, id_type_place, id_categorie_personne, prix) VALUES
(1, 11, 2, 1, 19.90),  -- VIP, ADULTE, séance spéciale
(2, 11, 2, 2, 14.90),  -- VIP, ENFANT, séance spéciale
(3, 6, 1, 1, 7.90),    -- STANDARD, ADULTE, tarif réduit dimanche
(4, 6, 1, 2, 5.50);    -- STANDARD, ENFANT, tarif réduit dimanche