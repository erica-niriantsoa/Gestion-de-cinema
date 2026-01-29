<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="salles" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Salles - CinéManager</title>
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
                        <h1>Gestion des Salles</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Salles</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/sallesDetail" class="btn-modern btn-secondary-modern">
                        <i class="fas fa-eye"></i> Détails
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/salles/nouveau" class="btn-modern btn-primary-modern">
                        <i class="fas fa-plus"></i> Nouvelle Salle
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
                            <input type="text" id="searchInput" placeholder="Rechercher par nom..." onkeyup="filterSalles()">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-users"></i> Capacité</label>
                            <select id="capaciteFilter" onchange="filterSalles()">
                                <option value="">Toutes les capacités</option>
                                <option value="petite">Petite (< 100 places)</option>
                                <option value="moyenne">Moyenne (100-200 places)</option>
                                <option value="grande">Grande (> 200 places)</option>
                            </select>
                        </div>
                    </div>
                    <div style="margin-top: 16px; text-align: right;">
                        <span id="resultsCount" style="color: var(--text-muted); font-size: 0.9rem;"></span>
                    </div>
                </div>
                
                <!-- Table des salles -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-door-open"></i>
                            </div>
                            <h3>Liste des Salles</h3>
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Nom</th>
                                <th>Capacité</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="salle" items="${salles}">
                                <tr>
                                    <td>${salle.id}</td>
                                    <td><strong style="color: var(--text-primary);">${salle.nom}</strong></td>
                                    <td><span class="status-badge active">${salle.capacite} places</span></td>
                                    <td>
                                        <div class="table-actions">
                                            <a href="${pageContext.request.contextPath}/admin/salles/${salle.id}/editer" 
                                               class="table-action-btn edit" title="Modifier">
                                                <i class="fas fa-edit"></i>
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/salles/${salle.id}/supprimer" 
                                               class="table-action-btn delete" title="Supprimer"
                                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?');">
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
    function filterSalles() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const capaciteFilter = document.getElementById('capaciteFilter').value;
        
        const rows = document.querySelectorAll('.data-table tbody tr');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const nom = cells[1].textContent.toLowerCase();
            const capaciteText = cells[2].textContent;
            const capacite = parseInt(capaciteText.replace(' places', ''));
            
            const matchesSearch = nom.includes(searchTerm);
            
            let matchesCapacite = true;
            if (capaciteFilter) {
                if (capaciteFilter === 'petite') matchesCapacite = capacite < 100;
                else if (capaciteFilter === 'moyenne') matchesCapacite = capacite >= 100 && capacite <= 200;
                else if (capaciteFilter === 'grande') matchesCapacite = capacite > 200;
            }
            
            const isVisible = matchesSearch && matchesCapacite;
            row.style.display = isVisible ? '' : 'none';
            if (isVisible) visibleCount++;
        });
        
        document.getElementById('resultsCount').textContent = visibleCount + ' salle(s) trouvée(s)';
    }
    
    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('capaciteFilter').value = '';
        filterSalles();
    }
    
    document.addEventListener('DOMContentLoaded', function() {
        filterSalles();
    });
    </script>
</body>
</html>
