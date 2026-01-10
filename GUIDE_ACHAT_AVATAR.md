# 🎬 Guide : Acheter des places pour Avatar - 10 janvier 10h - Salle 1

## 📋 Étapes à suivre

### 1️⃣ Préparer la base de données
```bash
# Dans PowerShell, exécutez :
psql -U postgres -d cinema -f sql/insert_demo_seances.sql
```

Ce script va créer :
- ✅ Les films (Avatar, Titanic, The Matrix, etc.)
- ✅ 6 salles (Salle 1 à Salle 6)
- ✅ 12 séances dont **Avatar le 10 janvier à 10h dans Salle 1**

---

### 2️⃣ Démarrer l'application
1. Assurez-vous que Tomcat est démarré
2. L'application doit être accessible sur `http://localhost:8080`

---

### 3️⃣ Accéder à la liste de TOUTES les séances

**URL directe :**
```
http://localhost:8080/reservations/seances
```

**Ou via navigation :**
1. Aller sur `http://localhost:8080/films`
2. Cliquer sur **"🎬 Toutes les séances"** dans le menu

---

### 4️⃣ Ce que vous verrez

```
┌─────────────────────────────────────────────┐
│   🎬 Toutes les Séances Disponibles         │
│                                             │
│  [Films] [Toutes séances] [Rechercher] [Mes billets]
│                                             │
│  ┌───────────────────────────────────────┐ │
│  │ 12 Séances | 10 Films | 6 Salles     │ │
│  └───────────────────────────────────────┘ │
│                                             │
│  [Toutes] [Aujourd'hui] [Cette semaine] [Ce mois]
│                                             │
│  ┌──────────────────────────────┐         │
│  │ 🎬 AVATAR                    │         │
│  │ 162 min | 12+                │         │
│  │ 🌍 Français                  │         │
│  │                              │         │
│  │ 📅 10 jan 2026  🕐 10:00    │ ◄─── CETTE SÉANCE !
│  │ 🏢 Salle 1      💺 120 places│         │
│  │                              │         │
│  │  [🎫 Réserver des places]   │ ◄─── CLIQUER ICI
│  └──────────────────────────────┘         │
│                                             │
│  ┌──────────────────────────────┐         │
│  │ 🎬 AVATAR                    │         │
│  │ 162 min | 12+                │         │
│  │ 🌍 Français                  │         │
│  │                              │         │
│  │ 📅 10 jan 2026  🕐 14:00    │         │
│  │ 🏢 Salle 1      💺 120 places│         │
│  │                              │         │
│  │  [🎫 Réserver des places]   │         │
│  └──────────────────────────────┘         │
│                                             │
│  ... (autres séances) ...                  │
└─────────────────────────────────────────────┘
```

---

### 5️⃣ Acheter des places pour Avatar 10h - Salle 1

#### Option A : Depuis "Toutes les séances"
1. Sur la page `/reservations/seances`
2. Trouver la carte **"Avatar - 10 jan 2026 - 10:00 - Salle 1"**
3. Cliquer sur **"🎫 Réserver des places"**

#### Option B : Depuis la liste des films
1. Aller sur `/films`
2. Trouver la carte **"Avatar"**
3. Cliquer sur **"🎫 Réserver des places"**
4. Dans les filtres, sélectionner :
   - Date : **10/01/2026**
   - Salle : **Salle 1**
5. Cliquer sur **"🔍 Filtrer"**
6. Cliquer sur **"🎫 Réserver"** pour la séance de 10h00

---

### 6️⃣ Processus d'achat

```
ÉTAPE 1 : Toutes les séances
    ↓
ÉTAPE 2 : Cliquer sur "Réserver" pour Avatar 10h Salle 1
    ↓
ÉTAPE 3 : Formulaire d'achat
    ├─ Type de place : STANDARD / VIP / PMR
    ├─ Catégorie : ADULTE / ENFANT / SENIOR
    └─ Nombre de places : [2]
    
Prix calculé automatiquement
    ↓
ÉTAPE 4 : Cliquer sur "Confirmer l'achat"
    ↓
ÉTAPE 5 : Confirmation
    ✅ Réservation #12345
    ✅ 2 places pour Avatar
    ✅ 10 jan 2026 à 10:00
    ✅ Salle 1
```

---

## 🔍 Filtres rapides (sur la page Toutes les séances)

Les boutons en haut de la page permettent de filtrer instantanément :

| Bouton | Affiche |
|--------|---------|
| **Toutes** | Toutes les 12 séances |
| **Aujourd'hui** | Séances du 10 janvier uniquement |
| **Cette semaine** | Séances des 7 prochains jours |
| **Ce mois** | Séances de janvier 2026 |

**Exemple :** 
- Cliquer sur **"Aujourd'hui"** pour voir uniquement les séances du 10 janvier
- Vous verrez Avatar 10h, Avatar 14h, Avatar 18h, Titanic 19h, etc.

---

## 📊 Statistiques affichées

En haut de la page, vous verrez :
```
┌───────────────────────────────────────┐
│ 12                 10           6     │
│ Séances         Films      Salles     │
│ disponibles   à l'affiche  actives    │
└───────────────────────────────────────┘
```

---

## 🎯 URLs importantes

| Page | URL complète | Raccourci |
|------|-------------|-----------|
| **Toutes les séances** | `http://localhost:8080/reservations/seances` | La plus directe |
| **Rechercher avec filtres** | `http://localhost:8080/reservations/rechercher` | Pour filtrage avancé |
| **Liste des films** | `http://localhost:8080/films` | Point de départ |
| **Mes billets** | `http://localhost:8080/reservations/billets` | Voir achats |

---

## ✅ Checklist de vérification

Avant de tester, assurez-vous que :
- ✅ La base de données PostgreSQL est démarrée
- ✅ Le script `insert_demo_seances.sql` a été exécuté
- ✅ Tomcat est démarré
- ✅ L'application est accessible sur `http://localhost:8080`

---

## 🐛 Dépannage

### Si aucune séance n'apparaît :
```sql
-- Vérifier qu'il y a des séances dans la base
SELECT COUNT(*) FROM seance;

-- Vérifier la séance Avatar 10h Salle 1
SELECT 
    f.titre, 
    s.debut, 
    sa.nom as salle
FROM seance s
JOIN film f ON s.id_film = f.id
JOIN salle sa ON s.id_salle = sa.id
WHERE f.titre = 'Avatar'
AND s.debut >= '2026-01-10 10:00:00'
AND s.debut < '2026-01-10 11:00:00';
```

### Si le serveur ne démarre pas :
- Vérifiez les logs Tomcat
- Assurez-vous qu'il n'y a pas d'erreur de compilation
- Le conflit de mapping a été résolu dans ReservationController

---

## 🎉 Résultat attendu

Après avoir suivi ces étapes, vous devriez pouvoir :
1. ✅ Voir la liste complète des 12 séances
2. ✅ Identifier facilement la séance **Avatar 10h Salle 1**
3. ✅ Cliquer sur le bouton de réservation
4. ✅ Acheter des places
5. ✅ Recevoir une confirmation

**C'est prêt !** 🚀
