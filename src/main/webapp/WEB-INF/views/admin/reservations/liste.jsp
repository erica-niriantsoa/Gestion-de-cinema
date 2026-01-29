<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="currentPage" value="reservations" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Réservations - CinéManager</title>
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
                        <h1>Gestion des Réservations</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Réservations</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/reservations/nouveau" class="btn-modern btn-primary-modern">
                        <i class="fas fa-plus"></i> Nouvelle Réservation
                    </a>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
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
                            <span>Filtres</span>
                        </div>
                        <span id="resultsCount" class="status-badge" style="background: rgba(102, 126, 234, 0.15); color: #667eea;"></span>
                    </div>
                    <div class="filters-grid">
                        <div class="filter-group-modern">
                            <label><i class="fas fa-search"></i> Recherche</label>
                            <input type="text" id="searchInput" placeholder="Client, email..." onkeyup="filterTable()">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-tag"></i> Statut</label>
                            <select id="statutFilter" onchange="filterTable()">
                                <option value="">Tous</option>
                                <option value="PAYE">Payé</option>
                                <option value="EN_ATTENTE">En attente</option>
                                <option value="ANNULE">Annulé</option>
                            </select>
                        </div>
                        <div class="filter-actions-modern">
                            <button type="button" class="btn-modern btn-secondary-modern" onclick="clearFilters()">
                                <i class="fas fa-times"></i> Effacer
                            </button>
                        </div>
                    </div>
                </div>
                
                <!-- Table -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-calendar-check"></i>
                            </div>
                            <h3>Liste des Réservations</h3>
                        </div>
                    </div>
                    
                    <c:if test="${empty reservations}">
                        <div class="empty-state-modern">
                            <div class="empty-icon"><i class="fas fa-calendar-times"></i></div>
                            <h3>Aucune réservation</h3>
                            <p>Commencez par créer une nouvelle réservation</p>
                            <a href="${pageContext.request.contextPath}/admin/reservations/nouveau" class="btn-modern btn-primary-modern">
                                <i class="fas fa-plus"></i> Nouvelle Réservation
                            </a>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty reservations}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Client</th>
                                    <th>Séance</th>
                                    <th>Date Réservation</th>
                                    <th style="text-align: right;">Montant</th>
                                    <th>Statut</th>
                                    <th style="text-align: center;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="res" items="${reservations}">
                                    <tr>
                                        <td><strong>#${res.id}</strong></td>
                                        <td>
                                            <strong style="color: var(--text-primary);">${res.personne.nomComplet}</strong>
                                            <div style="font-size: 0.8rem; color: var(--text-muted);">${res.personne.email}</div>
                                        </td>
                                        <td>
                                            <c:if test="${res.seance != null}">
                                                ${res.seance.film.titre}
                                                <div style="font-size: 0.8rem; color: var(--text-muted);">${res.seance.salle.nom}</div>
                                            </c:if>
                                        </td>
                                        <td>${res.dateReservation}</td>
                                        <td style="text-align: right; font-family: monospace; font-weight: 600; color: #27ae60;">
                                            ${res.montantTotal} Ar
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${res.statut.code == 'PAYE'}">
                                                    <span class="status-badge" style="background: rgba(39, 174, 96, 0.15); color: #27ae60;">
                                                        <i class="fas fa-check-circle"></i> Payé
                                                    </span>
                                                </c:when>
                                                <c:when test="${res.statut.code == 'EN_ATTENTE'}">
                                                    <span class="status-badge" style="background: rgba(243, 156, 18, 0.15); color: #f39c12;">
                                                        <i class="fas fa-clock"></i> En attente
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge" style="background: rgba(231, 76, 60, 0.15); color: #e74c3c;">
                                                        <i class="fas fa-times-circle"></i> ${res.statut.libelle}
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td style="text-align: center;">
                                            <div class="action-buttons">
                                                <a href="${pageContext.request.contextPath}/admin/reservations/${res.id}/editer" class="btn-action edit" title="Modifier">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/reservations/${res.id}/supprimer" class="btn-action delete" title="Supprimer" onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette réservation ?');">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>
        </main>
    </div>

<script>
function filterTable() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const statutFilter = document.getElementById('statutFilter').value.toLowerCase();
    const rows = document.querySelectorAll('tbody tr');
    let visibleCount = 0;

    rows.forEach(row => {
        const text = row.textContent.toLowerCase();
        const matchesSearch = text.includes(searchTerm);
        const matchesStatut = !statutFilter || text.includes(statutFilter);
        
        const isVisible = matchesSearch && matchesStatut;
        row.style.display = isVisible ? '' : 'none';
        if (isVisible) visibleCount++;
    });

    document.getElementById('resultsCount').textContent = visibleCount + ' réservation(s)';
}

function clearFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('statutFilter').value = '';
    filterTable();
}

document.addEventListener('DOMContentLoaded', filterTable);
</script>
</body>
</html>
