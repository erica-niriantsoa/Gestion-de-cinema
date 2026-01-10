<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Séances - Cinéma</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        .error {
            color: red;
            padding: 10px;
            border: 1px solid red;
            background-color: #ffe6e6;
        }
        
        /* Styles pour les filtres */
        .filters-container {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        
        .filter-group {
            margin-bottom: 15px;
        }
        
        .filter-label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #333;
        }
        
        .filter-input, .filter-select {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        
        .filter-row {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        
        .filter-col {
            flex: 1;
            min-width: 200px;
        }
        
        .filter-actions {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }
        
        .btn {
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-weight: bold;
            transition: all 0.3s;
        }
        
        .btn-primary {
            background: #007bff;
            color: white;
        }
        
        .btn-primary:hover {
            background: #0056b3;
        }
        
        .btn-secondary {
            background: #6c757d;
            color: white;
        }
        
        .btn-secondary:hover {
            background: #5a6268;
        }
        
        /* Bouton Réserver */
        .btn-reserver {
            padding: 6px 12px;
            background: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-size: 14px;
            display: inline-block;
            transition: all 0.3s;
        }
        
        .btn-reserver:hover {
            background: #218838;
            transform: translateY(-2px);
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
        }
        
        .btn-reserver i {
            margin-right: 5px;
        }
        
        .langue-badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: bold;
        }
        
        .langue-vf {
            background-color: #28a745;
            color: white;
        }
        
        .langue-vo {
            background-color: #17a2b8;
            color: white;
        }
        
        .no-results {
            text-align: center;
            padding: 40px;
            color: #6c757d;
            font-style: italic;
        }
        
        .results-info {
            margin: 10px 0;
            color: #666;
            font-size: 14px;
        }
        
        /* Animation pour le filtrage */
        .fade-in {
            animation: fadeIn 0.5s;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        
        /* Style pour le bouton dans le tableau */
        .action-cell {
            text-align: center;
            min-width: 120px;
        }
        
        /* En-tête du tableau modifié */
        th:last-child {
            text-align: center;
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <h1>Cinéma - Liste des Séances</h1>
    
    <!-- Afficher les erreurs -->
    <c:if test="${not empty error}">
        <div class="error">
            Erreur: ${error}
        </div>
    </c:if>
    
    <h2>Liste des Séances</h2>

    <!-- Bouton d'action rapide -->
    <div style="text-align: center; margin: 20px 0;">
        <a href="${pageContext.request.contextPath}/client/films" class="btn-reserver" style="background: #007bff;">
            <i class="fas fa-film"></i> Voir tous les films
        </a>
        <a href="${pageContext.request.contextPath}/client/reservationDetail" class="btn-reserver" style="background: #ffc107; color: black;">
            <i class="fas fa-list"></i> Voir les réservations
        </a>
        <a href="${pageContext.request.contextPath}/client/accueil" class="btn-reserver" style="background: #6c757d;">
            <i class="fas fa-home"></i> Retour à l'accueil
        </a>
    </div>
    
    <!-- Filtres multicritères -->
    <div class="filters-container">
        <h3 style="margin-top: 0; color: #333;">Filtres</h3>
        
        <div class="filter-row">
            <div class="filter-col">
                <label class="filter-label"> Recherche</label>
                <input type="text" id="searchInput" class="filter-input" 
                       placeholder="Rechercher par film, salle..." onkeyup="filterSeances()">
            </div>
            
            <div class="filter-col">
                <label class="filter-label"> Date</label>
                <input type="date" id="dateFilter" class="filter-input" onchange="filterSeances()">
            </div>
            
            <div class="filter-col">
                <label class="filter-label">🗣️ Langue</label>
                <select id="langueFilter" class="filter-select" onchange="filterSeances()">
                    <option value="">Toutes les langues</option>
                    <option value="VF">Version Française (VF)</option>
                    <option value="VO">Version Originale (VO)</option>
                </select>
            </div>
        </div>
        
        <div class="filter-row">
            <div class="filter-col">
                <label class="filter-label">Heure de début</label>
                <select id="heureFilter" class="filter-select" onchange="filterSeances()">
                    <option value="">Toutes les heures</option>
                    <option value="matin">Matin (avant 12h)</option>
                    <option value="aprem">Après-midi (12h-18h)</option>
                    <option value="soir">Soir (après 18h)</option>
                </select>
            </div>
            
            <div class="filter-col">
                <label class="filter-label">Salle</label>
                <select id="salleFilter" class="filter-select" onchange="filterSeances()">
                    <option value="">Toutes les salles</option>
                    <!-- Options seront générées dynamiquement en JS -->
                </select>
            </div>
            
            <div class="filter-col">
                <label class="filter-label">Durée</label>
                <select id="dureeFilter" class="filter-select" onchange="filterSeances()">
                    <option value="">Toutes les durées</option>
                    <option value="court">Court (< 90 min)</option>
                    <option value="moyen">Moyen (90-120 min)</option>
                    <option value="long">Long (> 120 min)</option>
                </select>
            </div>
        </div>
        
        <div class="filter-actions">
            <button class="btn btn-primary" onclick="filterSeances()">
                Appliquer les filtres
            </button>
            <button class="btn btn-secondary" onclick="resetFilters()">
                Réinitialiser
            </button>
            <span id="resultsCount" class="results-info"></span>
        </div>
    </div>
    
    <!-- Tableau des séances -->
    <div id="seancesTableContainer">
        <c:choose>
            <c:when test="${not empty seances}">
                <!-- Table original (sera caché après chargement JS) -->
                <table id="originalTable" border="1">
                    <thead>
                        <tr>
                            <th>Film</th>
                            <th>Durée</th>
                            <th>Salle</th>
                            <th>Début</th>
                            <th>Fin</th>
                            <th>Langue</th>
                            <th>Chiffre d'Affaires</th>
                            <th>Action</th> <!-- NOUVELLE COLONNE -->
                        </tr>
                    </thead>
                    <tbody id="seancesBody">
                        <c:forEach var="row" items="${seances}">
                            <tr class="seance-row" 
                                data-film="${row.seance.film.titre}"
                                data-salle="${row.seance.salle.nom}"
                                data-duree="${row.seance.film.dureeMinutes}"
                                data-langue="${row.seance.langue}"
                                data-debut="${row.debutFormatted}"
                                data-debut-time="${row.debutFormatted}"
                                data-salle-id="${row.seance.salle.id}"
                                data-seance-id="${row.seance.id}"
                                data-revenue="${row.revenue}"> <!-- Ajout de l'ID de séance -->
                                <td class="film-cell">
                                    <c:choose>
                                        <c:when test="${not empty row.seance.film}">
                                            ${row.seance.film.titre}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: gray;">Film non trouvé</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="duree-cell">
                                    <c:if test="${not empty row.seance.film and not empty row.seance.film.dureeMinutes}">
                                        ${row.seance.film.dureeMinutes} min
                                    </c:if>
                                </td>
                                <td class="salle-cell">
                                    <c:choose>
                                        <c:when test="${not empty row.seance.salle}">
                                            ${row.seance.salle.nom}
                                        </c:when>
                                        <c:otherwise>
                                            <span style="color: gray;">Salle non trouvée</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="debut-cell">
                                    ${row.debutFormatted}
                                </td>
                                <td class="fin-cell">
                                    <c:if test="${not empty row.finFormatted}">
                                        ${row.finFormatted}
                                    </c:if>
                                </td>
                                <td class="langue-cell">
                                    <span class="langue-badge ${row.seance.langue == 'VF' ? 'langue-vf' : 'langue-vo'}">
                                        ${row.seance.langue}
                                    </span>
                                </td>
                                <td class="revenue-cell">
                                    ${row.revenue} €
                                </td>
                                <td class="action-cell">
                                    <!-- LIEN VERS LA RÉSERVATION -->
                                    <a href="${pageContext.request.contextPath}/client/seances/${row.seance.id}/reserver" 
                                       class="btn-reserver" 
                                       title="Réserver cette séance">
                                        <i class="fas fa-ticket-alt"></i> Réserver
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
                <p id="originalCount">Total: ${seances.size()} séance(s)</p>
            </c:when>
            <c:otherwise>
                <div style="text-align: center; padding: 40px;">
                    <p>Aucune séance programmée pour le moment.</p>
                    <a href="${pageContext.request.contextPath}/client/accueil" class="btn-reserver" style="margin-top: 20px;">
                        <i class="fas fa-home"></i> Retour à l'accueil
                    </a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <script>
        // Données des séances
        let allSeances = [];
        let uniqueSalles = new Set();
        
        document.addEventListener('DOMContentLoaded', function() {
            // Récupérer toutes les séances du tableau
            const rows = document.querySelectorAll('.seance-row');
            allSeances = Array.from(rows).map(row => ({
                element: row,
                film: row.dataset.film.toLowerCase(),
                salle: row.dataset.salle.toLowerCase(),
                salleId: row.dataset.salleId,
                seanceId: row.dataset.seanceId, // Ajout de l'ID
                duree: parseInt(row.dataset.duree) || 0,
                langue: row.dataset.langue,
                debut: row.dataset.debut,
                debutTime: row.dataset.debutTime,
                revenue: parseFloat(row.dataset.revenue) || 0,
                dureeText: row.querySelector('.duree-cell').textContent.trim(),
                salleText: row.querySelector('.salle-cell').textContent.trim(),
                actionHtml: row.querySelector('.action-cell').innerHTML // Garder le bouton
            }));
            
            // Récupérer les salles uniques
            allSeances.forEach(seance => {
                if (seance.salleText && seance.salleText !== 'Salle non trouvée') {
                    uniqueSalles.add(seance.salleText);
                }
            });
            
            // Remplir le filtre des salles
            const salleSelect = document.getElementById('salleFilter');
            uniqueSalles.forEach(salle => {
                const option = document.createElement('option');
                option.value = salle;
                option.textContent = salle;
                salleSelect.appendChild(option);
            });
            
            // Initialiser le compteur
            updateResultsCount(allSeances.length);
            
            // Masquer le tableau original et créer une copie pour le filtrage
            const originalTable = document.getElementById('originalTable');
            if (originalTable) {
                originalTable.style.display = 'none';
                document.getElementById('originalCount').style.display = 'none';
                createFilteredTable();
            }
        });
        
        function createFilteredTable() {
            const container = document.getElementById('seancesTableContainer');
            
            // Créer un nouveau tableau
            const newTable = document.createElement('table');
            newTable.border = "1";
            newTable.id = "filteredTable";
            newTable.className = "fade-in";
            
            // Copier l'en-tête
            const originalTable = document.getElementById('originalTable');
            if (originalTable) {
                newTable.appendChild(originalTable.querySelector('thead').cloneNode(true));
            }
            
            // Ajouter le corps (vide pour l'instant)
            const tbody = document.createElement('tbody');
            tbody.id = "filteredBody";
            newTable.appendChild(tbody);
            
            // Ajouter le tableau au container
            container.appendChild(newTable);
            
            // Appliquer le filtre initial
            filterSeances();
        }
        
        function filterSeances() {
            // Récupérer les valeurs des filtres
            const searchText = document.getElementById('searchInput').value.toLowerCase();
            const dateFilter = document.getElementById('dateFilter').value;
            const langueFilter = document.getElementById('langueFilter').value;
            const heureFilter = document.getElementById('heureFilter').value;
            const salleFilter = document.getElementById('salleFilter').value.toLowerCase();
            const dureeFilter = document.getElementById('dureeFilter').value;
            
            // Filtrer les séances
            const filteredSeances = allSeances.filter(seance => {
                // Filtre texte (film ou salle)
                if (searchText && 
                    !seance.film.includes(searchText) && 
                    !seance.salle.includes(searchText)) {
                    return false;
                }
                
                // Filtre langue
                if (langueFilter && seance.langue !== langueFilter) {
                    return false;
                }
                
                // Filtre salle
                if (salleFilter && !seance.salle.includes(salleFilter)) {
                    return false;
                }
                
                // Filtre date
                if (dateFilter) {
                    const seanceDate = extractDateFromString(seance.debut);
                    const filterDate = new Date(dateFilter);
                    if (!isSameDate(seanceDate, filterDate)) {
                        return false;
                    }
                }
                
                // Filtre heure
                if (heureFilter) {
                    const heure = extractHourFromString(seance.debutTime);
                    switch(heureFilter) {
                        case 'matin':
                            if (heure >= 12) return false;
                            break;
                        case 'aprem':
                            if (heure < 12 || heure >= 18) return false;
                            break;
                        case 'soir':
                            if (heure < 18) return false;
                            break;
                    }
                }
                
                // Filtre durée
                if (dureeFilter) {
                    switch(dureeFilter) {
                        case 'court':
                            if (seance.duree >= 90) return false;
                            break;
                        case 'moyen':
                            if (seance.duree < 90 || seance.duree > 120) return false;
                            break;
                        case 'long':
                            if (seance.duree <= 120) return false;
                            break;
                    }
                }
                
                return true;
            });
            
            // Afficher les résultats filtrés
            displayFilteredSeances(filteredSeances);
            updateResultsCount(filteredSeances.length);
        }
        
        function displayFilteredSeances(seances) {
            const tbody = document.getElementById('filteredBody');
            if (!tbody) return;
            
            // Vider le tableau
            tbody.innerHTML = '';
            
            if (seances.length === 0) {
                // Afficher message "aucun résultat"
                const row = tbody.insertRow();
                const cell = row.insertCell();
                cell.colSpan = 8; // Changé de 7 à 8 pour la nouvelle colonne
                cell.className = 'no-results';
                cell.textContent = 'Aucune séance ne correspond aux critères de recherche';
                return;
            }
            
            // Ajouter chaque séance filtrée
            seances.forEach(seanceData => {
                const originalRow = seanceData.element;
                const newRow = tbody.insertRow();
                newRow.className = 'fade-in';
                
                // Créer les cellules (6 cellules + 1 pour l'action)
                const filmCell = newRow.insertCell();
                filmCell.innerHTML = originalRow.querySelector('.film-cell').innerHTML;
                filmCell.className = 'film-cell';
                
                const dureeCell = newRow.insertCell();
                dureeCell.innerHTML = originalRow.querySelector('.duree-cell').innerHTML;
                dureeCell.className = 'duree-cell';
                
                const salleCell = newRow.insertCell();
                salleCell.innerHTML = originalRow.querySelector('.salle-cell').innerHTML;
                salleCell.className = 'salle-cell';
                
                const debutCell = newRow.insertCell();
                debutCell.innerHTML = originalRow.querySelector('.debut-cell').innerHTML;
                debutCell.className = 'debut-cell';
                
                const finCell = newRow.insertCell();
                finCell.innerHTML = originalRow.querySelector('.fin-cell').innerHTML;
                finCell.className = 'fin-cell';
                
                const langueCell = newRow.insertCell();
                langueCell.innerHTML = originalRow.querySelector('.langue-cell').innerHTML;
                langueCell.className = 'langue-cell';
                
                const revenueCell = newRow.insertCell();
                revenueCell.textContent = seanceData.revenue.toFixed(2) + ' €';
                revenueCell.className = 'revenue-cell';
                
                // Cellule d'action avec le bouton Réserver
                const actionCell = newRow.insertCell();
                actionCell.className = 'action-cell';
                
                // Créer le bouton Réserver avec le bon lien
                const reserverBtn = document.createElement('a');
                reserverBtn.href = `${pageContext.request.contextPath}/client/seances/` + seanceData.seanceId + `/reserver`;
                reserverBtn.className = 'btn-reserver';
                reserverBtn.title = 'Réserver cette séance';
                reserverBtn.innerHTML = '<i class="fas fa-ticket-alt"></i> Réserver';
                
                actionCell.appendChild(reserverBtn);
            });
        }
        
        function updateResultsCount(count) {
            const resultsCount = document.getElementById('resultsCount');
            if (resultsCount) {
                resultsCount.textContent = `${count} séance(s) trouvée(s)`;
            }
        }
        
        function resetFilters() {
            document.getElementById('searchInput').value = '';
            document.getElementById('dateFilter').value = '';
            document.getElementById('langueFilter').value = '';
            document.getElementById('heureFilter').value = '';
            document.getElementById('salleFilter').value = '';
            document.getElementById('dureeFilter').value = '';
            
            filterSeances(); // Réappliquer les filtres (tous vides = tout afficher)
        }
        
        // Fonctions utilitaires
        function extractDateFromString(dateString) {
            // Format: "15/06/2024 12:00"
            const parts = dateString.split(' ')[0].split('/');
            if (parts.length === 3) {
                return new Date(parts[2], parts[1] - 1, parts[0]);
            }
            return new Date();
        }
        
        function extractHourFromString(timeString) {
            // Format: "15/06/2024 12:00"
            const timePart = timeString.split(' ')[1];
            if (timePart) {
                return parseInt(timePart.split(':')[0]);
            }
            return 0;
        }
        
        function isSameDate(date1, date2) {
            return date1.getDate() === date2.getDate() &&
                   date1.getMonth() === date2.getMonth() &&
                   date1.getFullYear() === date2.getFullYear();
        }
        
        // Fonction pour trier le tableau
        function sortTable(columnIndex, type = 'text') {
            const tbody = document.getElementById('filteredBody');
            const rows = Array.from(tbody.querySelectorAll('tr'));
            
            rows.sort((a, b) => {
                const aValue = a.cells[columnIndex].textContent.trim();
                const bValue = b.cells[columnIndex].textContent.trim();
                
                if (type === 'number') {
                    const aNum = parseInt(aValue) || 0;
                    const bNum = parseInt(bValue) || 0;
                    return aNum - bNum;
                } else if (type === 'date') {
                    const aDate = extractDateFromString(aValue);
                    const bDate = extractDateFromString(bValue);
                    return aDate - bDate;
                } else {
                    return aValue.localeCompare(bValue);
                }
            });
            
            // Réorganiser les lignes
            rows.forEach(row => tbody.appendChild(row));
        }
        
        // Ajouter des événements de tri aux en-têtes
        document.addEventListener('DOMContentLoaded', function() {
            setTimeout(() => {
                const headers = document.querySelectorAll('#filteredTable th');
                if (headers.length > 0) {
                    headers[0].style.cursor = 'pointer';
                    headers[0].title = 'Cliquer pour trier par film';
                    headers[0].onclick = () => sortTable(0, 'text');
                    
                    headers[1].style.cursor = 'pointer';
                    headers[1].title = 'Cliquer pour trier par durée';
                    headers[1].onclick = () => sortTable(1, 'number');
                    
                    headers[2].style.cursor = 'pointer';
                    headers[2].title = 'Cliquer pour trier par salle';
                    headers[2].onclick = () => sortTable(2, 'text');
                    
                    headers[3].style.cursor = 'pointer';
                    headers[3].title = 'Cliquer pour trier par date';
                    headers[3].onclick = () => sortTable(3, 'date');
                    
                    // Ne pas permettre de trier sur la colonne Action
                }
            }, 100);
        });
        
        // Fonction pour rediriger vers la réservation
        function reserverSeance(seanceId) {
            window.location.href = `${pageContext.request.contextPath}/client/seances/` + seanceId + `/reserver`;
        }
    </script>
</body>
</html>