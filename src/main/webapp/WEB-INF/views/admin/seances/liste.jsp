<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Séances</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/accueil" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à l'espace admin
        </a>
        
        <div class="header">
            <div class="header-content">
                <div class="header-title">
                    <i class="fas fa-calendar-alt"></i>
                    <h1>Gestion des Séances</h1>
                </div>
                <a href="${pageContext.request.contextPath}/admin/seances/nouveau" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nouvelle Séance
                </a>
            </div>
        </div>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        
        <!-- Filtres multicritères -->
        <div class="card filter-section">
            <h3 class="filter-title"><i class="fas fa-filter"></i> Filtres de recherche</h3>
            
            <div class="filter-row">
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-search"></i> Recherche</label>
                    <input type="text" id="searchInput" class="form-control" 
                           placeholder="Rechercher par film..." onkeyup="filterSeances()">
                </div>
                
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-calendar"></i> Date</label>
                    <input type="date" id="dateFilter" class="form-control" onchange="filterSeances()">
                </div>
                
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-clock"></i> Heure de début</label>
                    <select id="heureFilter" class="form-control" onchange="filterSeances()">
                        <option value="">Toutes les heures</option>
                        <option value="matin">Matin (avant 12h)</option>
                        <option value="aprem">Après-midi (12h-18h)</option>
                        <option value="soir">Soir (après 18h)</option>
                    </select>
                </div>
            </div>
            
            <div class="filter-row">
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-language"></i> Langue</label>
                    <select id="langueFilter" class="form-control" onchange="filterSeances()">
                        <option value="">Toutes les langues</option>
                        <option value="VF">Version Française (VF)</option>
                        <option value="VO">Version Originale (VO)</option>
                        <option value="VOST">Sous-titrée (VOST)</option>
                    </select>
                </div>
                
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-door-open"></i> Salle</label>
                    <select id="salleFilter" class="form-control" onchange="filterSeances()">
                        <option value="">Toutes les salles</option>
                        <!-- Options seront générées dynamiquement en JS -->
                    </select>
                </div>
                
                <div class="filter-actions">
                    <button type="button" class="btn btn-secondary" onclick="clearFilters()">
                        <i class="fas fa-times"></i> Effacer les filtres
                    </button>
                    <span id="resultsCount" class="results-count"></span>
                </div>
            </div>
        </div>
        
        <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Film</th>
                    <th>Salle</th>
                    <th>Date & Heure</th>
                    <th>Fin</th>
                    <th>Langue</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="seance" items="${seances}">
                    <tr>
                        <td>${seance.id}</td>
                        <td><strong>${seance.film.titre}</strong></td>
                        <td>${seance.salle.nom}</td>
                        <td>${seance.debutFormatted}</td>
                        <td>${seance.finFormatted}</td>
                        <td>${seance.langue}</td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/admin/seances/${seance.id}/editer" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/seances/${seance.id}/supprimer" 
                                   class="btn btn-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette séance ?');">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        </div>
    </div>

    <script>
    function filterSeances() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const dateFilter = document.getElementById('dateFilter').value;
        const heureFilter = document.getElementById('heureFilter').value;
        const langueFilter = document.getElementById('langueFilter').value;
        const salleFilter = document.getElementById('salleFilter').value;
        
        const rows = document.querySelectorAll('tbody tr');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const film = cells[1].textContent.toLowerCase();
            const salle = cells[2].textContent.toLowerCase();
            const dateHeure = cells[3].textContent;
            const langue = cells[5].textContent;
            
            // Filtre de recherche (film)
            const matchesSearch = film.includes(searchTerm);
            
            // Filtre de date
            const matchesDate = !dateFilter || dateHeure.startsWith(dateFilter);
            
            // Filtre d'heure
            let matchesHeure = true;
            if (heureFilter) {
                const heure = dateHeure.split(' ')[1]; // Format: "DD/MM/YYYY HH:MM"
                const heureNum = parseInt(heure.split(':')[0]);
                
                if (heureFilter === 'matin') matchesHeure = heureNum < 12;
                else if (heureFilter === 'aprem') matchesHeure = heureNum >= 12 && heureNum < 18;
                else if (heureFilter === 'soir') matchesHeure = heureNum >= 18;
            }
            
            // Filtre de langue
            const matchesLangue = !langueFilter || langue.includes(langueFilter);
            
            // Filtre de salle
            const matchesSalle = !salleFilter || salle.includes(salleFilter.toLowerCase());
            
            const isVisible = matchesSearch && matchesDate && matchesHeure && matchesLangue && matchesSalle;
            row.style.display = isVisible ? '' : 'none';
            if (isVisible) visibleCount++;
        });
        
        // Mettre à jour le compteur
        const resultsCount = document.getElementById('resultsCount');
        resultsCount.textContent = visibleCount + ' séance(s) trouvée(s)';
    }
    
    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('dateFilter').value = '';
        document.getElementById('heureFilter').value = '';
        document.getElementById('langueFilter').value = '';
        document.getElementById('salleFilter').value = '';
        filterSeances();
    }
    
    // Générer les options de salles dynamiquement
    function populateSalleOptions() {
        const salleSelect = document.getElementById('salleFilter');
        const salles = new Set();
        
        // Collecter toutes les salles uniques
        document.querySelectorAll('tbody tr').forEach(row => {
            const salleCell = row.querySelectorAll('td')[2];
            if (salleCell) {
                salles.add(salleCell.textContent.trim());
            }
        });
        
        // Ajouter les options
        salles.forEach(salle => {
            const option = document.createElement('option');
            option.value = salle;
            option.textContent = salle;
            salleSelect.appendChild(option);
        });
    }
    
    // Initialiser au chargement
    document.addEventListener('DOMContentLoaded', function() {
        populateSalleOptions();
        filterSeances();
    });
    </script>
</body>
</html>
