<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="films" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Films - CinéManager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-layout.css">
</head>
<body>
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <jsp:include page="../includes/sidebar.jsp"/>
        
        <!-- Contenu Principal -->
        <main class="admin-content">
            <!-- Top Bar -->
            <header class="admin-topbar">
                <div class="topbar-left">
                    <button class="mobile-menu-toggle" onclick="toggleSidebar()">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="topbar-title">
                        <h1>Gestion des Films</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Films</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/films/nouveau" class="btn-modern btn-primary-modern">
                        <i class="fas fa-plus"></i> Nouveau Film
                    </a>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <!-- Alertes -->
                <c:if test="${not empty success}">
                    <div class="alert-modern success">
                        <i class="fas fa-check-circle"></i> ${success}
                    </div>
                </c:if>
                
                <c:if test="${not empty error}">
                    <div class="alert-modern error">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                
                <!-- Filtres -->
                <div class="filters-card">
                    <div class="filters-header">
                        <div class="filters-title">
                            <i class="fas fa-filter"></i>
                            <span>Filtres de recherche</span>
                        </div>
                        <button type="button" class="btn-ghost" onclick="clearFilters()">
                            <i class="fas fa-times"></i> Effacer
                        </button>
                    </div>
                    <div class="filters-grid">
                        <div class="filter-group-modern">
                            <label><i class="fas fa-search"></i> Recherche</label>
                            <input type="text" id="searchInput" placeholder="Rechercher par titre..." onkeyup="filterFilms()">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-language"></i> Langue</label>
                            <select id="langueFilter" onchange="filterFilms()">
                                <option value="">Toutes les langues</option>
                                <option value="VF">Version Française (VF)</option>
                                <option value="VO">Version Originale (VO)</option>
                                <option value="VOST">Sous-titrée (VOST)</option>
                            </select>
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-clock"></i> Durée</label>
                            <select id="dureeFilter" onchange="filterFilms()">
                                <option value="">Toutes les durées</option>
                                <option value="court">Court (< 90 min)</option>
                                <option value="moyen">Moyen (90-120 min)</option>
                                <option value="long">Long (> 120 min)</option>
                            </select>
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-calendar"></i> Année</label>
                            <select id="anneeFilter" onchange="filterFilms()">
                                <option value="">Toutes les années</option>
                                <option value="2024">2024</option>
                                <option value="2023">2023</option>
                                <option value="2022">2022</option>
                                <option value="2021">2021</option>
                                <option value="2020">2020</option>
                                <option value="ancien">Avant 2020</option>
                            </select>
                        </div>
                    </div>
                    <div style="margin-top: 16px; text-align: right;">
                        <span id="resultsCount" style="color: var(--text-muted); font-size: 0.9rem;"></span>
                    </div>
                </div>
                
                <!-- Table des films -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-film"></i>
                            </div>
                            <h3>Liste des Films</h3>
                        </div>
                    </div>
                    <table class="data-table">
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
                                    <td><strong style="color: var(--text-primary);">${film.titre}</strong></td>
                                    <td>${film.dureeMinutes}</td>
                                    <td>${film.dateSortie}</td>
                                    <td><span class="status-badge active">${film.langueOriginale}</span></td>
                                    <td>
                                        <div class="table-actions">
                                            <a href="${pageContext.request.contextPath}/admin/films/${film.id}/editer" 
                                               class="table-action-btn edit" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/films/${film.id}/supprimer" 
                                               class="table-action-btn delete" title="Supprimer"
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce film ?');">
                                                <i class="fas fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>

    <script>
    function filterFilms() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const langueFilter = document.getElementById('langueFilter').value;
        const dureeFilter = document.getElementById('dureeFilter').value;
        const anneeFilter = document.getElementById('anneeFilter').value;
        
        const rows = document.querySelectorAll('.data-table tbody tr');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const titre = cells[1].textContent.toLowerCase();
            const duree = parseInt(cells[2].textContent);
            const dateSortie = cells[3].textContent;
            const langue = cells[4].textContent;
            
            const matchesSearch = titre.includes(searchTerm);
            const matchesLangue = !langueFilter || langue.includes(langueFilter);
            
            let matchesDuree = true;
            if (dureeFilter) {
                if (dureeFilter === 'court') matchesDuree = duree < 90;
                else if (dureeFilter === 'moyen') matchesDuree = duree >= 90 && duree <= 120;
                else if (dureeFilter === 'long') matchesDuree = duree > 120;
            }
            
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
        
        document.getElementById('resultsCount').textContent = visibleCount + ' film(s) trouvé(s)';
    }
    
    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('langueFilter').value = '';
        document.getElementById('dureeFilter').value = '';
        document.getElementById('anneeFilter').value = '';
        filterFilms();
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        filterFilms();
    });
    </script>
</body>
</html>
