<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="currentPage" value="tickets" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Tickets - CinéManager</title>
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
                        <h1>Gestion des Tickets</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Tickets</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/tickets/nouveau" class="btn-modern btn-primary-modern">
                        <i class="fas fa-plus"></i> Nouveau Ticket
                    </a>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
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
                            <input type="text" id="searchInput" placeholder="Film, place, client..." onkeyup="filterTickets()">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-film"></i> Film</label>
                            <select id="filmFilter" onchange="filterTickets()">
                                <option value="">Tous les films</option>
                            </select>
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-tag"></i> Statut</label>
                            <select id="statutFilter" onchange="filterTickets()">
                                <option value="">Tous les statuts</option>
                                <option value="PAYE">Payé</option>
                                <option value="EN_ATTENTE">En attente</option>
                                <option value="ANNULE">Annulé</option>
                            </select>
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-calendar"></i> Date</label>
                            <input type="date" id="dateFilter" onchange="filterTickets()">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-user"></i> Catégorie</label>
                            <select id="categorieFilter" onchange="filterTickets()">
                                <option value="">Toutes les catégories</option>
                            </select>
                        </div>
                    </div>
                    <div style="margin-top: 16px; text-align: right;">
                        <span id="resultsCount" style="color: var(--text-muted); font-size: 0.9rem;"></span>
                    </div>
                </div>
                
                <!-- Table des tickets -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-ticket-alt"></i>
                            </div>
                            <h3>Tous les Tickets</h3>
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Film</th>
                                <th>Séance</th>
                                <th>Salle</th>
                                <th>Place</th>
                                <th>Catégorie</th>
                                <th>Prix</th>
                                <th>Statut</th>
                                <th>Client</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ticket" items="${tickets}">
                                <tr>
                                    <td>${ticket.id}</td>
                                    <td><strong style="color: var(--text-primary);">${ticket.seance.film.titre}</strong></td>
                                    <td>${ticket.seance.debutFormatted}</td>
                                    <td>${ticket.seance.salle.nom}</td>
                                    <td><span class="status-badge" style="background: rgba(52, 152, 219, 0.15); color: #3498db;">${ticket.place.codePlace}</span></td>
                                    <td>${ticket.categoriePersonne.libelle}</td>
                                    <td><strong>${ticket.prix} AR</strong></td>
                                    <td>
                                        <span class="status-badge ${ticket.statut.code == 'PAYE' ? 'paye' : 'en-attente'}">
                                            ${ticket.statut.libelle}
                                        </span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${ticket.reservation != null && ticket.reservation.personne != null}">
                                                ${ticket.reservation.personne.nomComplet}
                                            </c:when>
                                            <c:otherwise>
                                                <em style="color: var(--text-muted);">Non réservé</em>
                                            </c:otherwise>
                                        </c:choose>
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
    function filterTickets() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const filmFilter = document.getElementById('filmFilter').value;
        const statutFilter = document.getElementById('statutFilter').value;
        const dateFilter = document.getElementById('dateFilter').value;
        const categorieFilter = document.getElementById('categorieFilter').value;

        const rows = document.querySelectorAll('.data-table tbody tr');
        let visibleCount = 0;

        rows.forEach(row => {
            const cells = row.querySelectorAll('td');
            const film = cells[1].textContent.toLowerCase();
            const seance = cells[2].textContent;
            const place = cells[4].textContent.toLowerCase();
            const categorie = cells[5].textContent.toLowerCase();
            const statut = cells[7].textContent.toLowerCase();
            const client = cells[8].textContent.toLowerCase();

            const matchesSearch = film.includes(searchTerm) || place.includes(searchTerm) || client.includes(searchTerm);
            const matchesFilm = !filmFilter || film.includes(filmFilter.toLowerCase());
            const matchesStatut = !statutFilter || statut.includes(statutFilter.toLowerCase());
            const matchesDate = !dateFilter || seance.includes(dateFilter);
            const matchesCategorie = !categorieFilter || categorie.includes(categorieFilter.toLowerCase());

            const isVisible = matchesSearch && matchesFilm && matchesStatut && matchesDate && matchesCategorie;
            row.style.display = isVisible ? '' : 'none';
            if (isVisible) visibleCount++;
        });

        document.getElementById('resultsCount').textContent = visibleCount + ' ticket(s) trouvé(s)';
    }

    function clearFilters() {
        document.getElementById('searchInput').value = '';
        document.getElementById('filmFilter').value = '';
        document.getElementById('statutFilter').value = '';
        document.getElementById('dateFilter').value = '';
        document.getElementById('categorieFilter').value = '';
        filterTickets();
    }

    function populateFilters() {
        const filmSelect = document.getElementById('filmFilter');
        const categorieSelect = document.getElementById('categorieFilter');
        const films = new Set();
        const categories = new Set();

        document.querySelectorAll('.data-table tbody tr').forEach(row => {
            const cells = row.querySelectorAll('td');
            if (cells.length >= 6) {
                films.add(cells[1].textContent.trim());
                categories.add(cells[5].textContent.trim());
            }
        });

        films.forEach(film => {
            const option = document.createElement('option');
            option.value = film;
            option.textContent = film;
            filmSelect.appendChild(option);
        });

        categories.forEach(categorie => {
            const option = document.createElement('option');
            option.value = categorie;
            option.textContent = categorie;
            categorieSelect.appendChild(option);
        });
    }

    document.addEventListener('DOMContentLoaded', function() {
        populateFilters();
        filterTickets();
    });
    </script>
</body>
</html>