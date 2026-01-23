------------------
-- Diffusion Film Data
------------------
INSERT INTO film (id, titre, description, duree_minutes, date_sortie, age_min, langue_originale)
VALUES
(1, 'Titanic', 'Film romantique et dramatique', 195, '1997-12-19', 10, 'Anglais');

--SALLE
INSERT INTO salle (id, nom, capacite)
VALUES (1, 'Salle 1', 200);

--SEANCE
INSERT INTO seance (id, id_film, id_salle, debut, fin, langue)
VALUES
(1, 1, 1, '2026-01-20 10:00:00+03', '2026-01-20 13:15:00+03', 'FR'),
(2, 1, 1, '2026-01-21 10:00:00+03', '2026-01-21 13:15:00+03', 'FR'),
(3, 1, 1, '2026-01-21 15:00:00+03', '2026-01-21 18:15:00+03', 'FR');

--SOCIETE
INSERT INTO societe (id, nom, libelle)
VALUES
(1, 'Vaniala', 'Entreprise locale'),
(2, 'Lewis', 'Agence commerciale'),
(3, 'Socobis', 'Société de distribution');

--TYPE PUBLICITE
INSERT INTO type_publicite (id, libelle)
VALUES
(1, 'Spot vidéo');

--TARIF DIFFUSION PUBLICITAIRE
INSERT INTO tarif_diffusion_publicitaire (id, prix, libelle, actif)
VALUES
(1, 200000, 'Tarif standard par diffusion', true);

--DIFFUSIONS PUBLICITAIRES
INSERT INTO diffusion_publicitaire
(id_seance, id_societe, id_type_publicite, id_tarif, date_diffusion)
VALUES
-- 20 janvier 2026 - 10h
(1, 1, 1, 1, '2026-01-20'), -- Vaniala 1
(1, 2, 1, 1, '2026-01-20'), -- Lewis 1

-- 21 janvier 2026 - 10h
(2, 1, 1, 1, '2026-01-21'), -- Vaniala 1
(2, 1, 1, 1, '2026-01-21'), -- Vaniala 2
(2, 3, 1, 1, '2026-01-21'); -- Socobis 1

--. STATUT TICKET
INSERT INTO statut_ticket (id, code, libelle)
VALUES
(1, 'PAYE', 'Ticket payé');

--TICKETS PAYÉS
--20 janvier 2026 – 10h → 40 billets
INSERT INTO ticket (id_seance, id_statut, prix)
SELECT 1, 1, 30000
FROM generate_series(1,40);

--21 janvier 2026 – 10h → 30 billets
INSERT INTO ticket (id_seance, id_statut, prix)
SELECT 2, 1, 30000
FROM generate_series(1,30);

--21 janvier 2026 – 15h → 50 billets
INSERT INTO ticket (id_seance, id_statut, prix)
SELECT 3, 1, 30000
FROM generate_series(1,50);

--PAIEMENT PUBLICITAIRE
INSERT INTO paiement_publicite
(id_societe, montant, date_paiement, reference, commentaire)
VALUES
(1, 1000000, '2026-01-15', 'PAY-VAN-2026-01', 'Paiement partiel publicité janvier 2026');

