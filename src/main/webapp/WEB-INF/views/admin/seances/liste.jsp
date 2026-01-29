<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="seances" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Séances - CinéManager</title>
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
                        <h1>Gestion des Séances</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Séances</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/seances/nouveau" class="btn-modern btn-primary-modern">
                        <i class="fas fa-plus"></i> Nouvelle Séance
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
                            <input type="text" id="searchInput" placeholder="Rechercher par film..." onkeyup="filterSeances()">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-calendar"></i> Date</label>
                            <input type="date" id="dateFilter" onchange="filterSeances()">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-clock"></i> Heure</label>
                            <select id="heureFilter" onchange="filterSeances()">
                                <option value="">Toutes les heures</option>
                                <option value="matin">Matin (avant 12h)</option>
                                <option value="aprem">Après-midi (12h-18h)</option>
                                <option value="soir">Soir (après 18h)</option>
                            </select>
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-language"></i> Langue</label>
                            <select id="langueFilter" onchange="filterSeances()">
                                <option value="">Toutes les langues</option>
                                <option value="VF">VF</option>
                                <option value="VO">VO</option>
                                <option value="VOST">VOST</option>
                            </select>
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-door-open"></i> Salle</label>
                            <select id="salleFilter" onchange="filterSeances()">
                                <option value="">Toutes les salles</option>
                            </select>
                        </div>
                    </div>
                    <div style="margin-top: 16px; text-align: right;">
                        <span id="resultsCount" style="color: var(--text-muted); font-size: 0.9rem;"></span>
                    </div>
                </div>
                
                <!-- Table des séances -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <h3>Liste des Séances</h3>
                        </div>
                    </div>
                    <table class="data-table">
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
                                    <td><strong style="color: var(--text-primary);">${seance.film.titre}</strong></td>
                                    <td><span class="status-badge" style="background: rgba(52, 152, 219, 0.15); color: #3498db;">${seance.salle.nom}</span></td>
                                    <td>${seance.debutFormatted}</td>
                                    <td>${seance.finFormatted}</td>
                                    <td><span class="status-badge active">${seance.langue}</span></td>
                                    <td>
                                        <div class="table-actions">
                                            <a href="${pageContext.request.contextPath}/admin/seances/${seance.id}/editer" 
                                               class="table-action-btn edit" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/seances/${seance.id}/supprimer" 
                                               class="table-action-btn delete" title="Supprimer"
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette séance ?');">
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
    function filterSeances() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const dateFilter = document.getElementById('dateFilter').value;
        const heureFilter = document.getElementById('heureFilter').value;
        const langueFilter = document.getElementById('langueFilter').value;
        const salleFilter = document.getElementById('salleFilter').value;
        
        const rows = document.querySelectorAll('.data-table tbody tr');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const film = cells[1].textContent.toLowerCase();
            const salle = cells[2].textContent.toLowerCase();
            const dateHeure = cells[3].textContent;
            const langue = cells[5].textContent;
            
            const matchesSearch = film.includes(searchTerm);
            const matchesDate = !dateFilter || dateHeure.startsWith(dateFilter);
            
            let matchesHeure = true;
            if (heureFilter) {
                const heure = dateHeure.split(' ')[1];
                const heureNum = parseInt(heure.split(':')[0]);
                if (heureFilter === 'matin') matchesHeure = heureNum < 12;
                else if (heureFilter === 'aprem') matchesHeure = heureNum >= 12 && heureNum < 18;
                else if (heureFilter === 'soir') matchesHeure = heureNum >= 18;
            }
            
            const matchesLangue = !langueFilter || langue.includes(langueFilter);
            const matchesSalle = !salleFilter || salle.includes(salleFilter.toLowerCase());
            
            const isVisible = matchesSearch && matchesDate && matchesHeure && matchesLangue && matchesSalle;
            row.style.display = isVisible ? '' : 'none';
            if (isVisible) visibleCount++;
        });
        
        document.getElementById('resultsCount').textContent = visibleCount + ' séance(s) trouvée(s)';
    }
    
    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('dateFilter').value = '';
        document.getElementById('heureFilter').value = '';
        document.getElementById('langueFilter').value = '';
        document.getElementById('salleFilter').value = '';
        filterSeances();
    }
    
    function populateSalleOptions() {
        const salleSelect = document.getElementById('salleFilter');
        const salles = new Set();
        
        document.querySelectorAll('.data-table tbody tr').forEach(row => {
            const salleCell = row.querySelectorAll('td')[2];
            if (salleCell) {
                salles.add(salleCell.textContent.trim());
            }
        });
        
        salles.forEach(salle => {
            const option = document.createElement('option');
            option.value = salle;
            option.textContent = salle;
            salleSelect.appendChild(option);
        });
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        populateSalleOptions();
        filterSeances();
    });
    </script>
</body>
</html>
