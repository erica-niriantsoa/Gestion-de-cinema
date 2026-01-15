<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Films</title>
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
                    <i class="fas fa-film"></i>
                    <h1>Gestion des Films</h1>
                </div>
                <a href="${pageContext.request.contextPath}/admin/films/nouveau" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nouveau Film
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
                           placeholder="Rechercher par titre..." onkeyup="filterFilms()">
                </div>
                
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-language"></i> Langue</label>
                    <select id="langueFilter" class="form-control" onchange="filterFilms()">
                        <option value="">Toutes les langues</option>
                        <option value="VF">Version Française (VF)</option>
                        <option value="VO">Version Originale (VO)</option>
                        <option value="VOST">Sous-titrée (VOST)</option>
                    </select>
                </div>
                
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-clock"></i> Durée</label>
                    <select id="dureeFilter" class="form-control" onchange="filterFilms()">
                        <option value="">Toutes les durées</option>
                        <option value="court">Court (< 90 min)</option>
                        <option value="moyen">Moyen (90-120 min)</option>
                        <option value="long">Long (> 120 min)</option>
                    </select>
                </div>
            </div>
            
            <div class="filter-row">
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-calendar"></i> Année de sortie</label>
                    <select id="anneeFilter" class="form-control" onchange="filterFilms()">
                        <option value="">Toutes les années</option>
                        <option value="2024">2024</option>
                        <option value="2023">2023</option>
                        <option value="2022">2022</option>
                        <option value="2021">2021</option>
                        <option value="2020">2020</option>
                        <option value="ancien">Avant 2020</option>
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
                    <th>Titre</th>
                    <th>Durée (min)</th>
                    <th>Date de sortie</th>
                    <th>Langue</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="film" items="${films}">
                    <tr>
                        <td>${film.id}</td>
                        <td><strong>${film.titre}</strong></td>
                        <td>${film.dureeMinutes}</td>
                        <td>${film.dateSortie}</td>
                        <td>${film.langueOriginale}</td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/admin/films/${film.id}/editer" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/films/${film.id}/supprimer" 
                                   class="btn btn-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce film ?');">
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
    function filterFilms() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const langueFilter = document.getElementById('langueFilter').value;
        const dureeFilter = document.getElementById('dureeFilter').value;
        const anneeFilter = document.getElementById('anneeFilter').value;
        
        const rows = document.querySelectorAll('tbody tr');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const titre = cells[1].textContent.toLowerCase();
            const duree = parseInt(cells[2].textContent);
            const dateSortie = cells[3].textContent;
            const langue = cells[4].textContent;
            
            // Filtre de recherche
            const matchesSearch = titre.includes(searchTerm);
            
            // Filtre de langue
            const matchesLangue = !langueFilter || langue.includes(langueFilter);
            
            // Filtre de durée
            let matchesDuree = true;
            if (dureeFilter) {
                if (dureeFilter === 'court') matchesDuree = duree < 90;
                else if (dureeFilter === 'moyen') matchesDuree = duree >= 90 && duree <= 120;
                else if (dureeFilter === 'long') matchesDuree = duree > 120;
            }
            
            // Filtre d'année
            let matchesAnnee = true;
            if (anneeFilter) {
                const annee = dateSortie.split('-')[0];
                if (anneeFilter === 'ancien') {
                    matchesAnnee = parseInt(annee) < 2020;
                } else {
                    matchesAnnee = annee === anneeFilter;
                }
            }
            
            const isVisible = matchesSearch && matchesLangue && matchesDuree && matchesAnnee;
            row.style.display = isVisible ? '' : 'none';
            if (isVisible) visibleCount++;
        });
        
        // Mettre à jour le compteur
        const resultsCount = document.getElementById('resultsCount');
        resultsCount.textContent = visibleCount + ' film(s) trouvé(s)';
    }
    
    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('langueFilter').value = '';
        document.getElementById('dureeFilter').value = '';
        document.getElementById('anneeFilter').value = '';
        filterFilms();
    }
    
    // Initialiser le compteur au chargement
    document.addEventListener('DOMContentLoaded', function() {
        filterFilms();
    });
    </script>
</body>
</html>
