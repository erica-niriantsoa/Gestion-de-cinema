<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Réservations</title>
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
                <i class="fas fa-ticket-alt"></i>
                <h1>Gestion des Réservations</h1>
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
                       placeholder="Client, email, film..." onkeyup="filterReservations()">
            </div>

            <div class="filter-col">
                <label class="form-label"><i class="fas fa-film"></i> Film</label>
                <select id="filmFilter" class="form-control" onchange="filterReservations()">
                    <option value="">Tous les films</option>
                </select>
            </div>

            <div class="filter-col">
                <label class="form-label"><i class="fas fa-tag"></i> Statut</label>
                <select id="statutFilter" class="form-control" onchange="filterReservations()">
                    <option value="">Tous les statuts</option>
                    <option value="PAYE">Payé</option>
                    <option value="EN_ATTENTE">En attente</option>
                    <option value="ANNULE">Annulé</option>
                </select>
            </div>
        </div>

        <div class="filter-row">
            <div class="filter-col">
                <label class="form-label"><i class="fas fa-calendar"></i> Date de réservation</label>
                <input type="date" id="dateFilter" class="form-control" onchange="filterReservations()">
            </div>

            <div class="filter-col">
                <label class="form-label"><i class="fas fa-door-open"></i> Salle</label>
                <select id="salleFilter" class="form-control" onchange="filterReservations()">
                    <option value="">Toutes les salles</option>
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

    <!-- Réservations -->
    <div class="card">
        <h2 style="font-size: 1.5rem; margin-bottom: 1rem; color: var(--secondary-color);"><i class="fas fa-ticket-alt"></i> Toutes les Réservations</h2>
        <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Date Réservation</th>
                    <th>Montant Total</th>
                    <th>Client</th>
                    <th>Email</th>
                    <th>Film</th>
                    <th>Séance</th>
                    <th>Salle</th>
                    <th>Statut</th>
                    <th>Nb Tickets</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="res" items="${reservations}">
                    <tr>
                        <td>${res.reservationId}</td>
                        <td><c:if test="${res.dateReservation != null}">${res.dateReservationFormatted}</c:if></td>
                        <td>${res.montantTotal} AR</td>
                        <td>${res.clientNom}</td>
                        <td>${res.clientEmail}</td>
                        <td>${res.filmTitre}</td>
                        <td><c:if test="${res.seanceDebut != null}">${res.seanceDebutFormatted}</c:if></td>
                        <td>${res.salleNom}</td>
                        <td><span class="status ${res.statutReservation == 'PAYE' ? 'payé' : 'en_attente'}">${res.statutReservation}</span></td>
                        <td>${res.nbTickets}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        </div>
    </div>
</div>

<script>
function filterReservations() {
    const searchTerm = document.getElementById('searchInput').value.toLowerCase();
    const filmFilter = document.getElementById('filmFilter').value;
    const statutFilter = document.getElementById('statutFilter').value;
    const dateFilter = document.getElementById('dateFilter').value;
    const salleFilter = document.getElementById('salleFilter').value;

    const rows = document.querySelectorAll('tbody tr');
    let visibleCount = 0;

    rows.forEach(row => {
        const cells = row.querySelectorAll('td');
        const id = cells[0].textContent;
        const dateReservation = cells[1].textContent.toLowerCase();
        const client = cells[3].textContent.toLowerCase();
        const email = cells[4].textContent.toLowerCase();
        const film = cells[5].textContent.toLowerCase();
        const salle = cells[7].textContent.toLowerCase();
        const statut = cells[8].textContent.toLowerCase();

        // Filtre de recherche
        const matchesSearch = id.includes(searchTerm) ||
                             client.includes(searchTerm) ||
                             email.includes(searchTerm) ||
                             film.includes(searchTerm);

        // Filtre de film
        const matchesFilm = !filmFilter || film.includes(filmFilter.toLowerCase());

        // Filtre de statut
        const matchesStatut = !statutFilter || statut.includes(statutFilter.toLowerCase());

        // Filtre de date
        const matchesDate = !dateFilter || dateReservation.includes(dateFilter);

        // Filtre de salle
        const matchesSalle = !salleFilter || salle.includes(salleFilter.toLowerCase());

        const isVisible = matchesSearch && matchesFilm && matchesStatut && matchesDate && matchesSalle;
        row.style.display = isVisible ? '' : 'none';
        if (isVisible) visibleCount++;
    });

    // Mettre à jour le compteur
    const resultsCount = document.getElementById('resultsCount');
    resultsCount.textContent = visibleCount + ' réservation(s) trouvée(s)';
}

function clearFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('filmFilter').value = '';
    document.getElementById('statutFilter').value = '';
    document.getElementById('dateFilter').value = '';
    document.getElementById('salleFilter').value = '';
    filterReservations();
}

// Générer les options de films et salles dynamiquement
function populateFilters() {
    const filmSelect = document.getElementById('filmFilter');
    const salleSelect = document.getElementById('salleFilter');
    const films = new Set();
    const salles = new Set();

    // Collecter toutes les valeurs uniques
    document.querySelectorAll('tbody tr').forEach(row => {
        const cells = row.querySelectorAll('td');
        if (cells.length >= 8) {
            films.add(cells[5].textContent.trim());
            salles.add(cells[7].textContent.trim());
        }
    });

    // Ajouter les options
    films.forEach(film => {
        const option = document.createElement('option');
        option.value = film;
        option.textContent = film;
        filmSelect.appendChild(option);
    });

    salles.forEach(salle => {
        const option = document.createElement('option');
        option.value = salle;
        option.textContent = salle;
        salleSelect.appendChild(option);
    });
}

// Initialiser au chargement
document.addEventListener('DOMContentLoaded', function() {
    populateFilters();
    filterReservations();
});
</script>
</body>
</html>