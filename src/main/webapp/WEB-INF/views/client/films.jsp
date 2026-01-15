<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Films Disponibles</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/client.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/films.css">
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/client/accueil" class="btn btn-secondary">
        <i class="fas fa-arrow-left"></i> Retour à l'accueil
    </a>
    
    <div class="hero">
        <div class="hero-content">
            <h1 class="hero-title"><i class="fas fa-film"></i> Films Disponibles</h1>
            <p class="hero-subtitle">Découvrez notre sélection de films</p>
        </div>
    </div>

    <!-- Filtres multicritères -->
    <div class="card" style="margin-bottom: 2rem;">
        <h3 style="margin-top: 0; color: var(--secondary-color); margin-bottom: 1.5rem;"><i class="fas fa-filter"></i> Filtres de recherche</h3>
        
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
                <label class="form-label"><i class="fas fa-language"></i> Langue</label>
                <select id="langueFilter" class="form-control" onchange="filterFilms()">
                    <option value="">Toutes les langues</option>
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
            
            <div class="filter-col">
                <label class="form-label"><i class="fas fa-calendar"></i> Année</label>
                <select id="anneeFilter" class="form-control" onchange="filterFilms()">
                    <option value="">Toutes les années</option>
                </select>
            </div>
        </div>
        
        <div style="display: flex; gap: 1rem; margin-top: 1.5rem; align-items: center;">
            <button class="btn btn-primary" onclick="filterFilms()">
                <i class="fas fa-search"></i> Appliquer les filtres
            </button>
            <button class="btn btn-secondary" onclick="resetFilters()">
                <i class="fas fa-redo"></i> Réinitialiser
            </button>
            <span id="resultsCount" style="color: var(--text-secondary); margin-left: auto;"></span>
        </div>
    </div>

    <div class="films-grid" id="filmsGrid">
        <c:forEach var="film" items="${films}">
            <div class="film-card" 
                 data-langue="${film.langueOriginale}"
                 data-duree="${film.dureeMinutes != null ? film.dureeMinutes : 0}"
                 data-annee="${film.dateSortie != null ? film.dateSortie.year : 0}">
                <div class="film-poster">
                    <i class="fas fa-film"></i>
                </div>
                <div class="film-info">
                    <div class="film-title">${film.titre}</div>
                    <p class="film-description">
                        <c:choose>
                            <c:when test="${not empty film.description}">
                                ${film.description}
                            </c:when>
                            <c:otherwise>
                                Aucune description disponible.
                            </c:otherwise>
                        </c:choose>
                    </p>
                    <div class="film-meta">
                        <span><i class="fas fa-clock"></i> 
                            <c:choose>
                                <c:when test="${film.dureeMinutes != null}">
                                    ${film.dureeMinutes} min
                                </c:when>
                                <c:otherwise>
                                    Durée inconnue
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <span><i class="fas fa-language"></i> 
                            <c:choose>
                                <c:when test="${not empty film.langueOriginale}">
                                    ${film.langueOriginale}
                                </c:when>
                                <c:otherwise>
                                    Langue inconnue
                                </c:otherwise>
                            </c:choose>
                        </span>
                        <c:if test="${film.dateSortie != null}">
                            <span><i class="fas fa-calendar"></i> ${film.dateSortie.year}</span>
                        </c:if>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <c:if test="${empty films}">
        <div style="text-align: center; padding: 50px; color: #666;">
            <i class="fas fa-film" style="font-size: 48px; margin-bottom: 20px;"></i>
            <p>Aucun film disponible pour le moment.</p>
        </div>
    </c:if>
</div>

<script>
let allFilms = [];
let uniqueLangues = new Set();
let uniqueAnnees = new Set();

document.addEventListener('DOMContentLoaded', function() {
    // Récupérer tous les films
    const filmCards = document.querySelectorAll('.film-card');
    allFilms = Array.from(filmCards).map(card => ({
        element: card,
        titre: card.querySelector('.film-title').textContent.toLowerCase(),
        description: card.querySelector('.film-description').textContent.toLowerCase(),
        duree: parseInt(card.dataset.duree) || 0,
        langue: card.dataset.langue ? card.dataset.langue.toLowerCase() : '',
        annee: parseInt(card.dataset.annee) || 0
    }));
    
    // Récupérer les valeurs uniques pour les filtres
    allFilms.forEach(film => {
        if (film.langue) uniqueLangues.add(film.langue);
        if (film.annee > 0) uniqueAnnees.add(film.annee);
    });
    
    // Remplir les filtres dynamiques
    populateFilter('langueFilter', uniqueLangues);
    populateFilter('anneeFilter', uniqueAnnees);
    
    updateResultsCount(allFilms.length);
});

function populateFilter(filterId, values) {
    const select = document.getElementById(filterId);
    const sortedValues = Array.from(values).sort();
    
    sortedValues.forEach(value => {
        const option = document.createElement('option');
        option.value = value;
        option.textContent = value.charAt(0).toUpperCase() + value.slice(1);
        select.appendChild(option);
    });
}

function filterFilms() {
    const searchText = document.getElementById('searchInput').value.toLowerCase();
    const langueFilter = document.getElementById('langueFilter').value;
    const dureeFilter = document.getElementById('dureeFilter').value;
    const anneeFilter = document.getElementById('anneeFilter').value;
    
    const filteredFilms = allFilms.filter(film => {
        // Filtre texte (titre, description)
        if (searchText && 
            !film.titre.includes(searchText) && 
            !film.description.includes(searchText)) {
            return false;
        }
        
        // Filtre langue
        if (langueFilter && film.langue !== langueFilter) {
            return false;
        }
        
        // Filtre durée
        if (dureeFilter) {
            switch(dureeFilter) {
                case 'court':
                    if (film.duree >= 90) return false;
                    break;
                case 'moyen':
                    if (film.duree < 90 || film.duree > 120) return false;
                    break;
                case 'long':
                    if (film.duree <= 120) return false;
                    break;
            }
        }
        
        // Filtre année
        if (anneeFilter && film.annee !== parseInt(anneeFilter)) {
            return false;
        }
        
        return true;
    });
    
    // Afficher/masquer les films
    allFilms.forEach(film => {
        film.element.style.display = filteredFilms.includes(film) ? 'block' : 'none';
    });
    
    updateResultsCount(filteredFilms.length);
}

function resetFilters() {
    document.getElementById('searchInput').value = '';
    document.getElementById('langueFilter').value = '';
    document.getElementById('dureeFilter').value = '';
    document.getElementById('anneeFilter').value = '';
    
    filterFilms(); // Réappliquer les filtres (tous vides = tout afficher)
}

function updateResultsCount(count) {
    const resultsCount = document.getElementById('resultsCount');
    if (resultsCount) {
        resultsCount.textContent = `${count} film(s) trouvé(s)`;
    }
}
</script>
</body>
</html>