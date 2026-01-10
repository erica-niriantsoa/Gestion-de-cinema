# Guide d'achat de places - Système de gestion de cinéma

## 📋 Procédure pour acheter des places

### Exemple : Un client veut acheter des places pour regarder "Avatar" le 10 janvier à 10h, salle 1

---

## 🎯 Étape par étape

### 1️⃣ **Accéder à la liste des films**
   - **URL** : `http://localhost:8080/films`
   - Le client voit tous les films disponibles avec leurs informations (titre, durée, âge minimum, description, date de sortie)

### 2️⃣ **Sélectionner un film**
   - Sur chaque carte de film, il y a un bouton **"🎫 Réserver des places"**
   - Cliquer sur ce bouton pour le film souhaité (par exemple "Avatar")
   - **Alternative** : Utiliser le lien de navigation **"🎫 Voir les séances"** en haut de la page pour voir toutes les séances disponibles

### 3️⃣ **Filtrer les séances**
   - **URL automatique** : `http://localhost:8080/reservations/rechercher?filmId=<id_du_film>`
   - La page affiche toutes les séances pour le film sélectionné
   - **Filtres disponibles** :
     - 🎬 **Film** : Déjà pré-sélectionné si vous avez cliqué depuis la liste des films
     - 📅 **Date** : Sélectionner le 10 janvier 2026
     - 🏢 **Salle** : Sélectionner "Salle 1"

### 4️⃣ **Choisir la séance**
   - Parmi les séances filtrées, trouver celle du **10 janvier à 10h00** dans **Salle 1**
   - Cliquer sur le bouton **"Acheter des billets"** pour cette séance

### 5️⃣ **Sélectionner les places**
   - La page affiche :
     - Les informations de la séance (film, date, heure, salle)
     - Le nombre de places disponibles
     - Un formulaire pour choisir :
       - **Type de place** : STANDARD, VIP, PMR
       - **Catégorie de personne** : ADULTE, ENFANT, SENIOR
       - **Nombre de places**
   - Le prix est calculé automatiquement selon les tarifs

### 6️⃣ **Confirmer l'achat**
   - Vérifier le récapitulatif :
     - Détails de la séance
     - Places sélectionnées
     - Prix total
   - Cliquer sur **"Confirmer l'achat"**

### 7️⃣ **Confirmation**
   - Une page de confirmation affiche :
     - Numéro de réservation
     - Détails des billets
     - QR code ou code de confirmation (si implémenté)
   - Les places sont maintenant réservées

---

## 🌐 URLs principales

| Fonctionnalité | URL | Description |
|---------------|-----|-------------|
| **Liste des films** | `/films` | Voir tous les films disponibles |
| **Rechercher des séances** | `/reservations/rechercher` | Voir toutes les séances avec filtres |
| **Séances d'un film** | `/reservations/rechercher?filmId=<id>` | Séances pour un film spécifique |
| **Acheter des billets** | `/reservations/acheter?seanceId=<id>` | Formulaire d'achat pour une séance |
| **Mes billets** | `/reservations/billets` | Voir les billets achetés |

---

## 📊 Exemple concret pour "Avatar"

### Prérequis dans la base de données :
1. **Film "Avatar"** doit exister dans la table `film`
2. **Salle 1** doit exister dans la table `salle`
3. **Une séance** doit être créée :
   ```sql
   INSERT INTO seance (id_film, id_salle, debut, fin, langue)
   VALUES (
       (SELECT id FROM film WHERE titre = 'Avatar'),
       (SELECT id FROM salle WHERE nom = 'Salle 1'),
       '2026-01-10 10:00:00',
       '2026-01-10 12:30:00',
       'Français'
   );
   ```
4. **Places** doivent être disponibles dans Salle 1
5. **Tarifs** doivent être définis dans `tarif_defaut`

### Navigation complète :
```
1. http://localhost:8080/films
   ↓ (cliquer sur "Réserver" pour Avatar)
   
2. http://localhost:8080/reservations/rechercher?filmId=<id_avatar>
   ↓ (filtrer par date: 10/01/2026 et salle: Salle 1)
   
3. http://localhost:8080/reservations/rechercher?filmId=<id>&date=2026-01-10&salleId=<id_salle1>
   ↓ (cliquer sur "Acheter des billets" pour la séance de 10h)
   
4. http://localhost:8080/reservations/acheter?seanceId=<id_seance>
   ↓ (remplir le formulaire et soumettre)
   
5. http://localhost:8080/reservations/confirmation?reservationId=<id>
   ✅ Confirmation de l'achat !
```

---

## 🎨 Interface utilisateur

### Page des films (`/films`)
- **Design** : Grille de cartes avec gradient violet
- **Chaque carte contient** :
  - 🎥 Icône du film
  - 📝 Titre
  - ⏱️ Durée (badge rose)
  - 👶 Âge minimum (badge orange)
  - 📄 Description (3 lignes max)
  - 📅 Date de sortie
  - 🎫 **Bouton "Réserver des places"** (gradient violet)

### Navigation
- **Menu en haut** :
  - 📽️ Tous les films
  - 🎫 Voir les séances

---

## ⚠️ Points importants

1. **Données nécessaires** :
   - Le film "Avatar" doit être dans la base de données
   - Une séance doit être créée pour le 10 janvier à 10h dans Salle 1
   - Des places doivent être disponibles
   - Les tarifs doivent être configurés

2. **Vérifications** :
   - Vérifier que le serveur est démarré
   - Vérifier que la base de données contient les données nécessaires
   - Vérifier que les tables sont à jour (notamment la colonne `est_affiche` si nécessaire)

3. **Liens directs** :
   - Depuis la page des films → Bouton "Réserver" → Filtrage automatique par film
   - Depuis le menu → "Voir les séances" → Filtrage manuel possible

---

## 🔧 Commandes SQL utiles

### Vérifier si Avatar existe :
```sql
SELECT * FROM film WHERE titre LIKE '%Avatar%';
```

### Vérifier les séances pour Avatar :
```sql
SELECT s.*, f.titre, sa.nom as salle
FROM seance s
JOIN film f ON s.id_film = f.id
JOIN salle sa ON s.id_salle = sa.id
WHERE f.titre LIKE '%Avatar%'
AND s.debut >= '2026-01-10'
AND s.debut < '2026-01-11';
```

### Ajouter une séance pour Avatar le 10 janvier à 10h :
```sql
INSERT INTO seance (id_film, id_salle, debut, fin, langue)
VALUES (
    (SELECT id FROM film WHERE titre LIKE '%Avatar%' LIMIT 1),
    (SELECT id FROM salle WHERE nom = 'Salle 1' LIMIT 1),
    '2026-01-10 10:00:00',
    '2026-01-10 12:30:00',
    'Français'
);
```

---

## 📞 Support

Si vous rencontrez des problèmes :
1. Vérifiez que le serveur Tomcat est démarré
2. Vérifiez les logs du serveur pour les erreurs
3. Vérifiez que la base de données est accessible
4. Vérifiez que les données nécessaires existent dans la base

---

**Date de création** : 9 janvier 2026
**Système** : Gestion de cinéma - Spring MVC + PostgreSQL
