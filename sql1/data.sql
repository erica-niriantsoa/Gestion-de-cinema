
-- ------------------------------
-- DONNÉES
-- ------------------------------

-- TYPE DE PLACE
INSERT INTO type_place (id, libelle) VALUES
(1, 'STANDARD'),
(2, 'PREMIUM'),
(3, 'VIP');

-- CATEGORIE PERSONNE
INSERT INTO categorie_personne (id, libelle) VALUES
(1, 'ADULTE'),
(2, 'ENFANT'),
(3, 'SENIOR');

-- CATEGORIES DE FILMS
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

-- FILMS
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

-- FILM_CATEGORIE
INSERT INTO film_categorie (id_film, id_categorie) VALUES
(1, 1), (1, 2),
(2, 6), (2, 2),
(3, 3), (3, 5),
(4, 7), (4, 4),
(5, 1), (5, 2), (5, 6),
(6, 4), (6, 5),
(7, 9), (7, 3),
(8, 2), (8, 9);

-- SALLES
INSERT INTO salle (id, nom, capacite) VALUES
(1, 'Salle 1 - Odeon', 100),
(2, 'Salle 2 - Majestic', 80),
(3, 'Salle 3 - Paradisio', 200),
(4, 'Salle 4 - Lumiere', 60),
(5, 'Salle 5 - IMAX', 150),
(6, 'Salle VIP - Prestige', 40);

-- PLACES (séquences continues)
-- Salle 1: IDs 1-100
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
(1, 1, 'A', 1, 'A1', 3), (2, 1, 'A', 2, 'A2', 3), (3, 1, 'A', 3, 'A3', 3), (4, 1, 'A', 4, 'A4', 3), (5, 1, 'A', 5, 'A5', 3),
(6, 1, 'A', 6, 'A6', 3), (7, 1, 'A', 7, 'A7', 3), (8, 1, 'A', 8, 'A8', 3), (9, 1, 'A', 9, 'A9', 3), (10, 1, 'A', 10, 'A10', 3),
(11, 1, 'B', 1, 'B1', 2), (12, 1, 'B', 2, 'B2', 2), (13, 1, 'B', 3, 'B3', 2), (14, 1, 'B', 4, 'B4', 2), (15, 1, 'B', 5, 'B5', 2),
(16, 1, 'B', 6, 'B6', 2), (17, 1, 'B', 7, 'B7', 2), (18, 1, 'B', 8, 'B8', 2), (19, 1, 'B', 9, 'B9', 2), (20, 1, 'B', 10, 'B10', 2),
(21, 1, 'C', 1, 'C1', 2), (22, 1, 'C', 2, 'C2', 2), (23, 1, 'C', 3, 'C3', 2), (24, 1, 'C', 4, 'C4', 2), (25, 1, 'C', 5, 'C5', 2),
(26, 1, 'C', 6, 'C6', 2), (27, 1, 'C', 7, 'C7', 2), (28, 1, 'C', 8, 'C8', 2), (29, 1, 'C', 9, 'C9', 2), (30, 1, 'C', 10, 'C10', 2),
(31, 1, 'D', 1, 'D1', 1), (32, 1, 'D', 2, 'D2', 1), (33, 1, 'D', 3, 'D3', 1), (34, 1, 'D', 4, 'D4', 1), (35, 1, 'D', 5, 'D5', 1),
(36, 1, 'D', 6, 'D6', 1), (37, 1, 'D', 7, 'D7', 1), (38, 1, 'D', 8, 'D8', 1), (39, 1, 'D', 9, 'D9', 1), (40, 1, 'D', 10, 'D10', 1),
(41, 1, 'E', 1, 'E1', 1), (42, 1, 'E', 2, 'E2', 1), (43, 1, 'E', 3, 'E3', 1), (44, 1, 'E', 4, 'E4', 1), (45, 1, 'E', 5, 'E5', 1),
(46, 1, 'E', 6, 'E6', 1), (47, 1, 'E', 7, 'E7', 1), (48, 1, 'E', 8, 'E8', 1), (49, 1, 'E', 9, 'E9', 1), (50, 1, 'E', 10, 'E10', 1),
(51, 1, 'F', 1, 'F1', 1), (52, 1, 'F', 2, 'F2', 1), (53, 1, 'F', 3, 'F3', 1), (54, 1, 'F', 4, 'F4', 1), (55, 1, 'F', 5, 'F5', 1),
(56, 1, 'F', 6, 'F6', 1), (57, 1, 'F', 7, 'F7', 1), (58, 1, 'F', 8, 'F8', 1), (59, 1, 'F', 9, 'F9', 1), (60, 1, 'F', 10, 'F10', 1),
(61, 1, 'G', 1, 'G1', 1), (62, 1, 'G', 2, 'G2', 1), (63, 1, 'G', 3, 'G3', 1), (64, 1, 'G', 4, 'G4', 1), (65, 1, 'G', 5, 'G5', 1),
(66, 1, 'G', 6, 'G6', 1), (67, 1, 'G', 7, 'G7', 1), (68, 1, 'G', 8, 'G8', 1), (69, 1, 'G', 9, 'G9', 1), (70, 1, 'G', 10, 'G10', 1),
(71, 1, 'H', 1, 'H1', 1), (72, 1, 'H', 2, 'H2', 1), (73, 1, 'H', 3, 'H3', 1), (74, 1, 'H', 4, 'H4', 1), (75, 1, 'H', 5, 'H5', 1),
(76, 1, 'H', 6, 'H6', 1), (77, 1, 'H', 7, 'H7', 1), (78, 1, 'H', 8, 'H8', 1), (79, 1, 'H', 9, 'H9', 1), (80, 1, 'H', 10, 'H10', 1),
(81, 1, 'I', 1, 'I1', 1), (82, 1, 'I', 2, 'I2', 1), (83, 1, 'I', 3, 'I3', 1), (84, 1, 'I', 4, 'I4', 1), (85, 1, 'I', 5, 'I5', 1),
(86, 1, 'I', 6, 'I6', 1), (87, 1, 'I', 7, 'I7', 1), (88, 1, 'I', 8, 'I8', 1), (89, 1, 'I', 9, 'I9', 1), (90, 1, 'I', 10, 'I10', 1),
(91, 1, 'J', 1, 'J1', 1), (92, 1, 'J', 2, 'J2', 1), (93, 1, 'J', 3, 'J3', 1), (94, 1, 'J', 4, 'J4', 1), (95, 1, 'J', 5, 'J5', 1),
(96, 1, 'J', 6, 'J6', 1), (97, 1, 'J', 7, 'J7', 1), (98, 1, 'J', 8, 'J8', 1), (99, 1, 'J', 9, 'J9', 1), (100, 1, 'J', 10, 'J10', 1);

-- Salle 2: IDs 101-180
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
-- STANDARD (40 places)
(101, 2, 'A', 1, 'A1', 1), (102, 2, 'A', 2, 'A2', 1), (103, 2, 'A', 3, 'A3', 1), (104, 2, 'A', 4, 'A4', 1), (105, 2, 'A', 5, 'A5', 1),
(106, 2, 'A', 6, 'A6', 1), (107, 2, 'A', 7, 'A7', 1), (108, 2, 'A', 8, 'A8', 1), (109, 2, 'A', 9, 'A9', 1), (110, 2, 'A', 10, 'A10', 1),
(111, 2, 'B', 1, 'B1', 1), (112, 2, 'B', 2, 'B2', 1), (113, 2, 'B', 3, 'B3', 1), (114, 2, 'B', 4, 'B4', 1), (115, 2, 'B', 5, 'B5', 1),
(116, 2, 'B', 6, 'B6', 1), (117, 2, 'B', 7, 'B7', 1), (118, 2, 'B', 8, 'B8', 1), (119, 2, 'B', 9, 'B9', 1), (120, 2, 'B', 10, 'B10', 1),
(121, 2, 'C', 1, 'C1', 1), (122, 2, 'C', 2, 'C2', 1), (123, 2, 'C', 3, 'C3', 1), (124, 2, 'C', 4, 'C4', 1), (125, 2, 'C', 5, 'C5', 1),
(126, 2, 'C', 6, 'C6', 1), (127, 2, 'C', 7, 'C7', 1), (128, 2, 'C', 8, 'C8', 1), (129, 2, 'C', 9, 'C9', 1), (130, 2, 'C', 10, 'C10', 1),
(131, 2, 'D', 1, 'D1', 1), (132, 2, 'D', 2, 'D2', 1), (133, 2, 'D', 3, 'D3', 1), (134, 2, 'D', 4, 'D4', 1), (135, 2, 'D', 5, 'D5', 1),
(136, 2, 'D', 6, 'D6', 1), (137, 2, 'D', 7, 'D7', 1), (138, 2, 'D', 8, 'D8', 1), (139, 2, 'D', 9, 'D9', 1), (140, 2, 'D', 10, 'D10', 1),
-- PREMIUM (40 places)
(141, 2, 'E', 1, 'E1', 2), (142, 2, 'E', 2, 'E2', 2), (143, 2, 'E', 3, 'E3', 2), (144, 2, 'E', 4, 'E4', 2), (145, 2, 'E', 5, 'E5', 2),
(146, 2, 'E', 6, 'E6', 2), (147, 2, 'E', 7, 'E7', 2), (148, 2, 'E', 8, 'E8', 2), (149, 2, 'E', 9, 'E9', 2), (150, 2, 'E', 10, 'E10', 2),
(151, 2, 'F', 1, 'F1', 2), (152, 2, 'F', 2, 'F2', 2), (153, 2, 'F', 3, 'F3', 2), (154, 2, 'F', 4, 'F4', 2), (155, 2, 'F', 5, 'F5', 2),
(156, 2, 'F', 6, 'F6', 2), (157, 2, 'F', 7, 'F7', 2), (158, 2, 'F', 8, 'F8', 2), (159, 2, 'F', 9, 'F9', 2), (160, 2, 'F', 10, 'F10', 2),
(161, 2, 'G', 1, 'G1', 2), (162, 2, 'G', 2, 'G2', 2), (163, 2, 'G', 3, 'G3', 2), (164, 2, 'G', 4, 'G4', 2), (165, 2, 'G', 5, 'G5', 2),
(166, 2, 'G', 6, 'G6', 2), (167, 2, 'G', 7, 'G7', 2), (168, 2, 'G', 8, 'G8', 2), (169, 2, 'G', 9, 'G9', 2), (170, 2, 'G', 10, 'G10', 2),
(171, 2, 'H', 1, 'H1', 2), (172, 2, 'H', 2, 'H2', 2), (173, 2, 'H', 3, 'H3', 2), (174, 2, 'H', 4, 'H4', 2), (175, 2, 'H', 5, 'H5', 2),
(176, 2, 'H', 6, 'H6', 2), (177, 2, 'H', 7, 'H7', 2), (178, 2, 'H', 8, 'H8', 2), (179, 2, 'H', 9, 'H9', 2), (180, 2, 'H', 10, 'H10', 2);

-- Salle 3: IDs 181-380 (simplifié pour l'exemple)
-- Note: En réalité, vous devriez insérer toutes les 200 places
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
-- Premières 20 places STANDARD
(181, 3, 'A', 1, 'A1', 1), (182, 3, 'A', 2, 'A2', 1), (183, 3, 'A', 3, 'A3', 1), (184, 3, 'A', 4, 'A4', 1), (185, 3, 'A', 5, 'A5', 1),
(186, 3, 'A', 6, 'A6', 1), (187, 3, 'A', 7, 'A7', 1), (188, 3, 'A', 8, 'A8', 1), (189, 3, 'A', 9, 'A9', 1), (190, 3, 'A', 10, 'A10', 1),
(191, 3, 'B', 1, 'B1', 1), (192, 3, 'B', 2, 'B2', 1), (193, 3, 'B', 3, 'B3', 1), (194, 3, 'B', 4, 'B4', 1), (195, 3, 'B', 5, 'B5', 1),
(196, 3, 'B', 6, 'B6', 1), (197, 3, 'B', 7, 'B7', 1), (198, 3, 'B', 8, 'B8', 1), (199, 3, 'B', 9, 'B9', 1), (200, 3, 'B', 10, 'B10', 1);

-- Salle 4: IDs 381-440 (simplifié)
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
-- Premières 10 places STANDARD
(381, 4, 'A', 1, 'A1', 1), (382, 4, 'A', 2, 'A2', 1), (383, 4, 'A', 3, 'A3', 1), (384, 4, 'A', 4, 'A4', 1), (385, 4, 'A', 5, 'A5', 1),
(386, 4, 'A', 6, 'A6', 1), (387, 4, 'A', 7, 'A7', 1), (388, 4, 'A', 8, 'A8', 1), (389, 4, 'A', 9, 'A9', 1), (390, 4, 'A', 10, 'A10', 1);

-- Salle 5: IDs 441-590 (simplifié)
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
-- Premières 10 places STANDARD
(441, 5, 'A', 1, 'A1', 1), (442, 5, 'A', 2, 'A2', 1), (443, 5, 'A', 3, 'A3', 1), (444, 5, 'A', 4, 'A4', 1), (445, 5, 'A', 5, 'A5', 1),
(446, 5, 'A', 6, 'A6', 1), (447, 5, 'A', 7, 'A7', 1), (448, 5, 'A', 8, 'A8', 1), (449, 5, 'A', 9, 'A9', 1), (450, 5, 'A', 10, 'A10', 1);

-- Salle 6: IDs 591-630 (simplifié)
INSERT INTO place (id, id_salle, rangee, numero, code_place, id_type_place) VALUES
-- STANDARD (20 places)
(591, 6, 'A', 1, 'A1', 1), (592, 6, 'A', 2, 'A2', 1), (593, 6, 'A', 3, 'A3', 1), (594, 6, 'A', 4, 'A4', 1), (595, 6, 'A', 5, 'A5', 1),
(596, 6, 'A', 6, 'A6', 1), (597, 6, 'A', 7, 'A7', 1), (598, 6, 'A', 8, 'A8', 1), (599, 6, 'A', 9, 'A9', 1), (600, 6, 'A', 10, 'A10', 1),
-- PREMIUM (20 places)
(601, 6, 'B', 1, 'B1', 2), (602, 6, 'B', 2, 'B2', 2), (603, 6, 'B', 3, 'B3', 2), (604, 6, 'B', 4, 'B4', 2), (605, 6, 'B', 5, 'B5', 2),
(606, 6, 'B', 6, 'B6', 2), (607, 6, 'B', 7, 'B7', 2), (608, 6, 'B', 8, 'B8', 2), (609, 6, 'B', 9, 'B9', 2), (610, 6, 'B', 10, 'B10', 2);

-- SEANCES
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

-- PERSONNES
INSERT INTO personne (id, nom_complet, email, telephone, mot_de_passe, role) VALUES
(1, 'Jean Martin', 'admin@cinema.com', '0123456789', '$2a$10$N9qo8uLOickgx2ZMRZoMyeRHYJ8vQp9X9Jgxq5fZ4QbB1B2C3D4E5F', 'ADMIN'),
(2, 'Marie Dubois', 'marie.admin@cinema.com', '0234567891', '$2a$10$ZYXWVUTSRQPONMLKJIHGFEDCBA9876543210zyxwvutsrqponmlkjihg', 'ADMIN'),
(3, 'Thomas Bernard', 'thomas@mail.com', '0645123789', '$2a$10$ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz', 'CLIENT'),
(4, 'Sophie Laurent', 'sophie@mail.com', '0655123789', '$2a$10$1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRST', 'CLIENT'),
(5, 'Lucas Petit', 'lucas@mail.com', '0678123456', '$2a$10$qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM', 'CLIENT'),
(6, 'Emma Robert', 'emma@mail.com', '0698765432', '$2a$10$passwordhashedexample1234567890abcdefghijkl', 'CLIENT'),
(7, 'Mohamed Ali', 'mohamed@mail.com', '0612345678', '$2a$10$examplehash1234567890abcdefghijklmnopqrstuv', 'CLIENT');

-- STATUTS RESERVATION
INSERT INTO statut_reservation (id, code, libelle) VALUES
(1, 'CREEE', 'Creee'),
(2, 'EN_ATTENTE', 'En attente de paiement'),
(3, 'PAYEE', 'Payee'),
(4, 'CONFIRMEE', 'Confirmee'),
(5, 'ANNULEE', 'Annulee'),
(6, 'EXPIREE', 'Expiree');

-- STATUTS TICKET
INSERT INTO statut_ticket (id, code, libelle) VALUES
(1, 'RESERVE', 'Reserve'),
(2, 'PAYE', 'Paye'),
(3, 'ANNULE', 'Annule'),
(4, 'UTILISE', 'Utilise'),
(5, 'REMBOURSE', 'Rembourse');

-- RESERVATIONS
INSERT INTO reservation (id, id_personne, id_seance, id_statut, montant_total, date_reservation) VALUES
(1, 3, 1, 3, 60000, '2024-06-14 10:30:00+02'),
(2, 4, 2, 3, 140000, '2024-06-14 11:45:00+02'),
(3, 5, 3, 2, 40000, '2024-06-14 14:20:00+02'),
(4, 6, 11, 3, 150000, '2024-06-14 16:10:00+02'),
(5, 7, 5, 4, 80000, '2024-06-14 18:30:00+02');

-- HISTORIQUE STATUT RESERVATION
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

-- TICKETS (corrigés avec les bons IDs de place)
INSERT INTO ticket (id, id_reservation, id_seance, id_place, id_statut, id_categorie_personne, prix) VALUES
(1, 1, 1, 1, 2, 1, 20000),   -- Salle 1, VIP
(2, 1, 1, 2, 2, 1, 20000),   -- Salle 1, VIP
(3, 1, 1, 3, 2, 1, 20000),   -- Salle 1, VIP
(4, 2, 2, 141, 2, 1, 50000), -- Salle 2, PREMIUM
(5, 2, 2, 142, 2, 1, 50000), -- Salle 2, PREMIUM
(6, 2, 2, 103, 2, 2, 20000), -- Salle 2, STANDARD
(7, 2, 2, 104, 2, 2, 20000), -- Salle 2, STANDARD
(8, 3, 3, 181, 1, 1, 20000), -- Salle 3, STANDARD
(9, 3, 3, 182, 1, 1, 20000), -- Salle 3, STANDARD
(10, 4, 11, 601, 2, 1, 50000), -- Salle 6, PREMIUM
(11, 4, 11, 602, 2, 1, 50000), -- Salle 6, PREMIUM
(12, 4, 11, 603, 2, 1, 50000), -- Salle 6, PREMIUM
(13, 5, 5, 441, 4, 1, 20000), -- Salle 5, STANDARD
(14, 5, 5, 442, 4, 1, 20000), -- Salle 5, STANDARD
(15, 5, 5, 443, 4, 1, 20000), -- Salle 5, STANDARD
(16, 5, 5, 444, 4, 1, 20000); -- Salle 5, STANDARD

-- HISTORIQUE STATUT TICKET
INSERT INTO historique_statut_ticket (id, id_ticket, id_statut, date_changement, change_par, commentaire) VALUES
(1, 1, 1, '2024-06-14 10:30:00+02', 3, 'Reservation creee'),
(2, 1, 2, '2024-06-14 10:32:00+02', 3, 'Paiement confirme'),
(3, 4, 1, '2024-06-14 11:45:00+02', 4, 'Reservation PREMIUM creee'),
(4, 4, 2, '2024-06-14 11:46:00+02', 4, 'Paiement PREMIUM effectue'),
(5, 8, 1, '2024-06-14 14:20:00+02', 5, 'Reservation creee'),
(6, 8, 2, '2024-06-14 14:21:00+02', 5, 'Paiement en attente');

-- TARIF PAR DEFAUT
INSERT INTO tarif_defaut (id, id_type_place, id_categorie_personne, prix) VALUES
(1, 1, 1, 30000),   -- STANDARD, ADULTE
(2, 1, 2, 15000),   -- STANDARD, ENFANT
(3, 1, 3, 20000),   -- STANDARD, SENIOR
(4, 2, 1, 40000),   -- PREMIUM, ADULTE
(5, 2, 2, 50000),   -- PREMIUM, ENFANT
(6, 2, 3, 30000),   -- PREMIUM, SENIOR
(7, 3, 1, 50000),   -- VIP, ADULTE
(8, 3, 2, 50000),   -- VIP, ENFANT
(9, 3, 3, 45000);   -- VIP, SENIOR


INSERT INTO tarif_defaut (id, id_type_place, id_categorie_personne, prix) VALUES
(1, 1, 1, 20000),   -- STANDARD, ENFANT
(2, 2, 1, 50000),   -- PREMIUM, ENFANT
(3, 3, 1, 90000);   -- VIP, ENFANT

-- TARIF SPECIFIQUE PAR SEANCE
INSERT INTO tarif_seance (id, id_seance, id_type_place, id_categorie_personne, prix) VALUES
(1, 11, 2, 1, 50000),  -- PREMIUM, ADULTE, séance spéciale
(2, 11, 2, 2, 50000),  -- PREMIUM, ENFANT, séance spéciale
(3, 6, 1, 1, 20000),   -- STANDARD, ADULTE, tarif réduit dimanche
(4, 6, 1, 2, 20000);   -- STANDARD, ENFANT, tarif réduit dimanche



-- ------------------------------
-- MOYENS DE PAIEMENT (données d'exemple)
-- ------------------------------
INSERT INTO moyen_paiement (id, libelle, description) VALUES
(1, 'CARTE_BANCAIRE', 'Paiement par carte bancaire (Visa, Mastercard)'),
(2, 'ESPECES', 'Paiement en espèces'),
(3, 'CHEQUE', 'Paiement par chèque bancaire'),
(4, 'CHEQUE_CADEAU', 'Chèque cadeau du cinéma'),
(5, 'CARTE_CADEAU', 'Carte cadeau du cinéma'),
(6, 'VIREMENT', 'Virement bancaire'),
(7, 'PAIEMENT_EN_LIGNE', 'Paiement sécurisé en ligne');

-- ------------------------------
-- PROMOTIONS (données d'exemple - montants en Ariary)
-- ------------------------------
INSERT INTO promotion (id, code, libelle, description, type_promotion, valeur, montant_minimum, date_debut, date_fin, utilisations_max, actif) VALUES
(1, 'ETE2024', 'Promotion été 2024', '15% de réduction pendant l''été', 'POURCENTAGE', 15.00, 0, '2024-06-01', '2024-08-31', 1000, true),
(2, 'FIDELITE20', 'Fidélité 20%', '20% de réduction fidélité', 'POURCENTAGE', 20.00, 50000, NULL, NULL, NULL, true), -- 50 000 Ar minimum
(3, 'OFFRE5000', '5 000 Ar de réduction', '5 000 Ar de réduction sur votre commande', 'MONTANT_FIXE', 5000.00, 30000, '2024-01-01', '2024-12-31', 500, true), -- 30 000 Ar minimum
(4, 'ETUDIANT', 'Tarif étudiant', '10% de réduction pour les étudiants', 'POURCENTAGE', 10.00, 0, NULL, NULL, NULL, true),
(5, 'MERCREDI', 'Mercredi promo', 'Réduction spéciale le mercredi', 'POURCENTAGE', 25.00, 0, NULL, NULL, NULL, true),
(6, 'FAMILLE4', 'Pack famille 4', 'Forfait famille 4 personnes', 'OFFRE_SPECIALE', 0, 0, NULL, NULL, 200, true),
(7, 'PREMIERE', 'Première séance', '10 000 Ar pour la première séance', 'MONTANT_FIXE', 10000.00, 0, '2024-01-01', '2024-12-31', 1000, true);

-- ------------------------------
-- PAIEMENTS (exemples en Ariary - cohérents avec vos tickets)
-- ------------------------------
-- Rappel de vos tickets :
-- Tickets 1-3 : 20 000 Ar chacun (VIP) = 60 000 Ar
-- Tickets 4-5 : 50 000 Ar chacun (PREMIUM) = 100 000 Ar
-- Tickets 6-7 : 20 000 Ar chacun (STANDARD enfant) = 40 000 Ar
-- Total réservation 2 = 140 000 Ar

INSERT INTO paiement (id, id_reservation, id_moyen_paiement, montant, date_paiement, reference, statut) VALUES
(1, 1, 1, 60000, '2024-06-14 10:32:00+02', 'CB_TRX_789012', 'ACCEPTE'),      -- 60 000 Ar
(2, 2, 1, 140000, '2024-06-14 11:46:00+02', 'CB_TRX_789013', 'ACCEPTE'),    -- 140 000 Ar
(3, 3, 2, 40000, '2024-06-14 14:21:00+02', 'ESP-001', 'ACCEPTE'),           -- 40 000 Ar
(4, 4, 1, 150000, '2024-06-14 16:11:00+02', 'CB_TRX_789014', 'ACCEPTE'),    -- 150 000 Ar
(5, 5, 3, 80000, '2024-06-14 18:32:00+02', 'CHQ_456789', 'ACCEPTE');        -- 80 000 Ar

-- ------------------------------
-- RESERVATION PROMOTION (montants en Ariary)
-- ------------------------------
INSERT INTO reservation_promotion (id, id_reservation, id_promotion, montant_reduction, date_utilisation) VALUES
(1, 1, 1, 9000, '2024-06-14 10:30:00+02'),     -- 15% de 60 000 Ar = 9 000 Ar
(2, 2, 3, 5000, '2024-06-14 11:45:00+02'),     -- 5 000 Ar de réduction
(3, 4, 2, 30000, '2024-06-14 16:10:00+02'),    -- 20% de 150 000 Ar = 30 000 Ar
(4, 5, 4, 8000, '2024-06-14 18:30:00+02');     -- 10% de 80 000 Ar = 8 000 Ar

-- ------------------------------
-- MISE A JOUR DES RESERVATIONS EXISTANTES (en Ariary)
-- ------------------------------
-- Ajuster les montants totaux après application des promotions
UPDATE reservation SET montant_total = 51000 WHERE id = 1;   -- 60 000 Ar - 9 000 Ar = 51 000 Ar
UPDATE reservation SET montant_total = 135000 WHERE id = 2;  -- 140 000 Ar - 5 000 Ar = 135 000 Ar
UPDATE reservation SET montant_total = 120000 WHERE id = 4;  -- 150 000 Ar - 30 000 Ar = 120 000 Ar
UPDATE reservation SET montant_total = 72000 WHERE id = 5;   -- 80 000 Ar - 8 000 Ar = 72 000 Ar

-- Mettre à jour les utilisations courantes des promotions
UPDATE promotion SET utilisations_courantes = 1 WHERE id = 1;
UPDATE promotion SET utilisations_courantes = 1 WHERE id = 2;
UPDATE promotion SET utilisations_courantes = 1 WHERE id = 3;
UPDATE promotion SET utilisations_courantes = 1 WHERE id = 4;

update tarif_defaut set prix=90000 WHERE id_type_place=3;



-- Exemple : appliquer un coefficient de 0.5 pour les enfants
UPDATE tarif_defaut AS t_enfant
SET prix = ROUND(t_adulte.prix * 0.5)
FROM tarif_defaut AS t_adulte
WHERE t_enfant.id_type_place = t_adulte.id_type_place
  AND t_enfant.id_categorie_personne = 2      -- ENFANT
  AND t_adulte.id_categorie_personne = 1;    -- ADULTE

-- Si tu veux que les seniors aient un prix différent, par exemple 80% du prix adulte
UPDATE tarif_defaut AS t_senior
SET prix = ROUND(t_adulte.prix * 0.8)
FROM tarif_defaut AS t_adulte
WHERE t_senior.id_type_place = t_adulte.id_type_place
  AND t_senior.id_categorie_personne = 3      -- SENIOR
  AND t_adulte.id_categorie_personne = 1;    -- ADULTE
