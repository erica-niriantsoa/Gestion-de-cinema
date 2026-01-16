<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Salles</title>
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
                    <i class="fas fa-door-open"></i>
                    <h1>Gestion des Salles</h1>
                </div>
                <a href="${pageContext.request.contextPath}/admin/salles/nouveau" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Nouvelle Salle
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
        
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/admin/sallesDetail" class="btn btn-primary">
                <i class="fas fa-film"></i> Voir detail Salles
            </a>
        </div>
        <!-- Filtres multicritères -->
        <div class="card filter-section">
            <h3 class="filter-title"><i class="fas fa-filter"></i> Filtres de recherche</h3>
            
            <div class="filter-row">
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-search"></i> Recherche</label>
                    <input type="text" id="searchInput" class="form-control" 
                           placeholder="Rechercher par nom..." onkeyup="filterSalles()">
                </div>
                
                <div class="filter-col">
                    <label class="form-label"><i class="fas fa-users"></i> Capacité</label>
                    <select id="capaciteFilter" class="form-control" onchange="filterSalles()">
                        <option value="">Toutes les capacités</option>
                        <option value="petite">Petite (< 100 places)</option>
                        <option value="moyenne">Moyenne (100-200 places)</option>
                        <option value="grande">Grande (> 200 places)</option>
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
                    <th>Nom</th>
                    <th>Capacité</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="salle" items="${salles}">
                    <tr>
                        <td>${salle.id}</td>
                        <td><strong>${salle.nom}</strong></td>
                        <td>${salle.capacite} places</td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/admin/salles/${salle.id}/editer" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/salles/${salle.id}/supprimer" 
                                   class="btn btn-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?');">
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
    function filterSalles() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const capaciteFilter = document.getElementById('capaciteFilter').value;
        
        const rows = document.querySelectorAll('tbody tr');
        let visibleCount = 0;
        
        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const nom = cells[1].textContent.toLowerCase();
            const capaciteText = cells[2].textContent;
            const capacite = parseInt(capaciteText.replace(' places', ''));
            
            // Filtre de recherche
            const matchesSearch = nom.includes(searchTerm);
            
            // Filtre de capacité
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
        
        // Mettre à jour le compteur
        const resultsCount = document.getElementById('resultsCount');
        resultsCount.textContent = visibleCount + ' salle(s) trouvée(s)';
    }
    
    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('capaciteFilter').value = '';
        filterSalles();
    }
    
    // Initialiser le compteur au chargement
    document.addEventListener('DOMContentLoaded', function() {
        filterSalles();
    });
    </script>
</body>
</html>
