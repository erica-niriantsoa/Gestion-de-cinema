-- Nettoyage
DELETE FROM societe WHERE nom IN ('Vaniala','Lewis');

DELETE FROM type_publicite 
WHERE libelle IN ('Bande-annonce','Spot TV','Sponsorisation');

DELETE FROM diffusion_publicitaire
WHERE date_diffusion BETWEEN '2025-12-01' AND '2025-12-31';

-- Insertion unique
INSERT INTO societe (nom, libelle) VALUES
('Vaniala', 'Entreprise locale'),
('Lewis', 'Entreprise commerciale');



-- Insertion unique
INSERT INTO type_publicite (libelle) VALUES
('Bande-annonce'),
('Spot TV'),
('Sponsorisation');



INSERT INTO diffusion_publicitaire
(id_seance, id_societe, id_type_publicite, id_tarif, date_diffusion)
VALUES
(2, 2, 2, 1, '2025-12-01'),
(4, 2, 2, 1, '2025-12-02'),
(6, 2, 2, 1, '2025-12-03'),
(8, 2, 2, 1, '2025-12-04'),
(10,2, 2, 1, '2025-12-05'),
(12,2, 2, 1, '2025-12-06'),
(13,2, 2, 1, '2025-12-07'),
(2, 2, 2, 1, '2025-12-08'),
(4, 2, 2, 1, '2025-12-09'),
(6, 2, 2, 1, '2025-12-10');

INSERT INTO diffusion_publicitaire
(id_seance, id_societe, id_type_publicite, id_tarif, date_diffusion)
VALUES
(1, 1, 1, 1, '2025-12-01'),
(3, 1, 1, 1, '2025-12-02'),
(5, 1, 1, 1, '2025-12-03'),
(7, 1, 1, 1, '2025-12-04'),
(9, 1, 1, 1, '2025-12-05'),
(11,1, 1, 1, '2025-12-06'),
(1, 1, 1, 1, '2025-12-07'),
(3, 1, 1, 1, '2025-12-08'),
(5, 1, 1, 1, '2025-12-09'),
(7, 1, 1, 1, '2025-12-10'),
(9, 1, 1, 1, '2025-12-11'),
(11,1, 1, 1, '2025-12-12'),
(1, 1, 1, 1, '2025-12-13'),
(3, 1, 1, 1, '2025-12-14'),
(5, 1, 1, 1, '2025-12-15'),
(7, 1, 1, 1, '2025-12-16'),
(9, 1, 1, 1, '2025-12-17'),
(11,1, 1, 1, '2025-12-18'),
(1, 1, 1, 1, '2025-12-19'),
(3, 1, 1, 1, '2025-12-20');
