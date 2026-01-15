<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Tickets</title>
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
                <i class="fas fa-tags"></i>
                <h1>Gestion des Tickets</h1>
            </div>
        </div>
    </div>

    <!-- Filtres multicritères -->
    <div class="card filter-section">
        <h3 class="filter-title"><i class="fas fa-filter"></i> Filtres de recherche</h3>

        <div class="filter-row">
            <div class="filter-col">
                <label class="form-label"><i class="fas fa-search"></i> Recherche</label>
                <input type="text" id="searchInput" class="form-control"
                       placeholder="Film, place, client..." onkeyup="filterTickets()">
            </div>

            <div class="filter-col">
                <label class="form-label"><i class="fas fa-film"></i> Film</label>
                <select id="filmFilter" class="form-control" onchange="filterTickets()">
                    <option value="">Tous les films</option>
                </select>
            </div>

            <div class="filter-col">
                <label class="form-label"><i class="fas fa-tag"></i> Statut</label>
                <select id="statutFilter" class="form-control" onchange="filterTickets()">
                    <option value="">Tous les statuts</option>
                    <option value="PAYE">Payé</option>
                    <option value="EN_ATTENTE">En attente</option>
                    <option value="ANNULE">Annulé</option>
                </select>
            </div>
        </div>

        <div class="filter-row">
            <div class="filter-col">
                <label class="form-label"><i class="fas fa-calendar"></i> Date de séance</label>
                <input type="date" id="dateFilter" class="form-control" onchange="filterTickets()">
            </div>

            <div class="filter-col">
                <label class="form-label"><i class="fas fa-user"></i> Catégorie</label>
                <select id="categorieFilter" class="form-control" onchange="filterTickets()">
                    <option value="">Toutes les catégories</option>
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

    <!-- Tous les Tickets -->
    <div class="card">
        <h2 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--secondary-color);"><i class="fas fa-tags"></i> Tous les Tickets</h2>
        <div class="table-wrapper">
        <table>
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
                        <td>${ticket.seance.film.titre}</td>
                        <td>${ticket.seance.debutFormatted}</td>
                        <td>${ticket.seance.salle.nom}</td>
                        <td>${ticket.place.codePlace}</td>
                        <td>${ticket.categoriePersonne.libelle}</td>
                        <td>${ticket.prix} AR</td>
                        <td><span class="status ${ticket.statut.code == 'PAYE' ? 'payé' : 'en_attente'}">${ticket.statut.libelle}</span></td>
                        <td>
                            <c:choose>
                                <c:when test="${ticket.reservation != null && ticket.reservation.personne != null}">
                                    ${ticket.reservation.personne.nomComplet} (${ticket.reservation.personne.email})
                                </c:when>
                                <c:otherwise>
                                    <em>Non réservé</em>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        </div>
    </div>
</div>

<script>
function filterTickets() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const filmFilter = document.getElementById('filmFilter').value;
    const statutFilter = document.getElementById('statutFilter').value;
    const dateFilter = document.getElementById('dateFilter').value;
    const categorieFilter = document.getElementById('categorieFilter').value;

    const rows = document.querySelectorAll('tbody tr');
    let visibleCount = 0;

    rows.forEach(row => {
        const cells = row.querySelectorAll('td');
        const film = cells[1].textContent.toLowerCase();
        const seance = cells[2].textContent;
        const salle = cells[3].textContent.toLowerCase();
        const place = cells[4].textContent.toLowerCase();
        const categorie = cells[5].textContent.toLowerCase();
        const statut = cells[7].textContent.toLowerCase();
        const client = cells[8].textContent.toLowerCase();

        // Filtre de recherche
        const matchesSearch = film.includes(searchTerm) ||
                             place.includes(searchTerm) ||
                             client.includes(searchTerm);

        // Filtre de film
        const matchesFilm = !filmFilter || film.includes(filmFilter.toLowerCase());

        // Filtre de statut
        const matchesStatut = !statutFilter || statut.includes(statutFilter.toLowerCase());

        // Filtre de date
        const matchesDate = !dateFilter || seance.includes(dateFilter);

        // Filtre de catégorie
        const matchesCategorie = !categorieFilter || categorie.includes(categorieFilter.toLowerCase());

        const isVisible = matchesSearch && matchesFilm && matchesStatut && matchesDate && matchesCategorie;
        row.style.display = isVisible ? '' : 'none';
        if (isVisible) visibleCount++;
    });

    // Mettre à jour le compteur
    const resultsCount = document.getElementById('resultsCount');
    resultsCount.textContent = visibleCount + ' ticket(s) trouvé(s)';
}

function clearFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('filmFilter').value = '';
    document.getElementById('statutFilter').value = '';
    document.getElementById('dateFilter').value = '';
    document.getElementById('categorieFilter').value = '';
    filterTickets();
}

// Générer les options de films et catégories dynamiquement
function populateFilters() {
    const filmSelect = document.getElementById('filmFilter');
    const categorieSelect = document.getElementById('categorieFilter');
    const films = new Set();
    const categories = new Set();

    // Collecter toutes les valeurs uniques
    document.querySelectorAll('tbody tr').forEach(row => {
        const cells = row.querySelectorAll('td');
        if (cells.length >= 6) {
            films.add(cells[1].textContent.trim());
            categories.add(cells[5].textContent.trim());
        }
    });

    // Ajouter les options
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

// Initialiser au chargement
document.addEventListener('DOMContentLoaded', function() {
    populateFilters();
    filterTickets();
});
</script>
</body>
</html>