<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/client.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/reservation.css">
</head>
<body>
<div class="container">
    <div class="hero">
        <div class="hero-content">
            <h1 class="hero-title"><i class="fas fa-ticket-alt"></i> Réservation</h1>
            <h2 style="color: var(--accent-color); margin-top: 1rem;">${seance.film.titre}</h2>
            <div class="seance-details" style="justify-content: center; margin-top: 1rem;">
                <div class="seance-detail"><i class="fas fa-calendar"></i> ${seance.debutFormatted}</div>
                <div class="seance-detail"><i class="fas fa-language"></i> ${seance.langue}</div>
                <div class="seance-detail"><i class="fas fa-door-open"></i> ${seance.salle.nom}</div>
                <div class="seance-detail"><i class="fas fa-clock"></i> ${seance.film.dureeMinutes} min</div>
            </div>
        </div>
    </div>

    <div id="message" class="alert"></div>

    <div class="main-grid">
        <!-- Plan de salle -->
        <div class="plan-container">
            <h3><i class="fas fa-chair"></i> Sélectionnez vos places</h3>
            <p style="color: #666; margin-bottom: 20px;">Cliquez sur les places pour les sélectionner</p>
            <div class="screen"><i class="fas fa-film"></i> ÉCRAN</div>
            <div class="places-list" id="placesList">
                <c:forEach var="place" items="${places}">
                    <c:if test="${!reservedPlaceIds.contains(place.id)}">
                        <div class="place-item">
                            <input type="checkbox" class="place-checkbox" id="place_${place.id}" data-place-id="${place.id}" data-code="${place.codePlace}" data-type="${place.typePlace.libelle}" data-type-id="${place.typePlace.id}" onchange="togglePlace(this)">
                            <label for="place_${place.id}" class="place-label">${place.codePlace}</label>
                            <span class="place-type">${place.typePlace.libelle}</span>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
            <div class="legend">
                <div class="legend-item"><span>Places disponibles : Cochez les cases pour sélectionner</span></div>
            </div>
        </div>

        <!-- Panier + Formulaire -->
        <div class="sidebar">
            <!-- Places sélectionnées -->
            <div class="card">
                <div class="card-title"><i class="fas fa-shopping-cart"></i> Vos places (<span id="selectedCount">0</span>)</div>
                <div class="selected-places" id="selectedPlaces">
                    <div style="text-align: center; color: #666; padding: 20px;">
                        <i class="fas fa-chair" style="font-size: 30px; margin-bottom: 10px;"></i>
                        <p>Aucune place sélectionnée</p>
                    </div>
                </div>
                <div class="total">
                    <div>Total à payer</div>
                    <div class="total-amount" id="totalAmount">0 AR</div>
                </div>
            </div>

            <!-- Formulaire d'informations -->
            <div class="card">
                <div class="card-title"><i class="fas fa-user"></i> Vos informations</div>
                <form id="clientForm">
                    <div class="form-group">
                        <label class="form-label">Catégorie de personne *</label>
                        <select id="defaultCategorie" class="form-control" required>
                            <option value="">Choisissez une catégorie</option>
                            <c:forEach var="cat" items="${categories}">
                                <option value="${cat.id}">${cat.libelle}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Nom complet *</label>
                        <input type="text" id="nomComplet" class="form-control" placeholder="Votre nom complet" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email *</label>
                        <input type="email" id="email" class="form-control" placeholder="votre@email.com" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Téléphone</label>
                        <input type="tel" id="telephone" class="form-control" placeholder="0612345678">
                    </div>
                </form>
            </div>

            <!-- Bouton de confirmation -->
            <button class="btn btn-success btn-lg" id="confirmBtn" disabled onclick="confirmReservation()">
                <i class="fas fa-check-circle"></i> Confirmer la réservation
            </button>
        </div>
    </div>
</div>

<script>
let selectedPlaces = new Map();
let categories = [];

// Charger les catégories depuis le serveur
try {
    // Créer un tableau JavaScript directement depuis les données JSP
    categories = [
        <c:forEach var="cat" items="${categories}" varStatus="status">
            {
                id: ${cat.id},
                libelle: "${cat.libelle}"
            }<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];

    console.log('Categories chargées depuis le serveur:', categories);
} catch (e) {
    console.error('Erreur lors du chargement des catégories:', e);
}

// Vérification finale
if (!categories || categories.length === 0) {
    console.error('ERREUR CRITIQUE: Aucune catégorie disponible!');
    alert('Erreur: Les catégories ne sont pas disponibles. Veuillez recharger la page.');
}

console.log('Categories finales:', categories); // Debug

document.addEventListener('DOMContentLoaded', function() {
    console.log('Page loaded, categories:', categories); // Debug

    // Écouteur pour le changement de catégorie par défaut
    const defaultCategorieSelect = document.getElementById('defaultCategorie');
    defaultCategorieSelect.addEventListener('change', function() {
        const newCategorieId = parseInt(this.value);
        if (newCategorieId && selectedPlaces.size > 0) {
            // Mettre à jour toutes les places sélectionnées avec la nouvelle catégorie
            for (const [placeId, place] of selectedPlaces.entries()) {
                place.categorieId = newCategorieId;
            }
            updateDisplay();
            console.log('Catégorie mise à jour pour toutes les places sélectionnées:', newCategorieId);
        }
    });

    // Ajouter des event listeners pour améliorer l'interactivité
    const placeItems = document.querySelectorAll('.place-item');
    placeItems.forEach(item => {
        const checkbox = item.querySelector('.place-checkbox');
        const label = item.querySelector('.place-label');

        // Permettre de cliquer sur tout l'élément place-item
        item.addEventListener('click', function(e) {
            // Ne pas déclencher si on clique sur le label ou checkbox directement
            if (e.target === label || e.target === checkbox) return;

            checkbox.checked = !checkbox.checked;
            togglePlace(checkbox);
        });

        // S'assurer que les places déjà cochées ont la classe selected
        if (checkbox.checked) {
            item.classList.add('selected');
        }
    });
});

function togglePlace(checkbox) {
    const placeId = checkbox.dataset.placeId;
    const placeItem = checkbox.closest('.place-item');

    // Récupérer la catégorie sélectionnée dans le formulaire
    const defaultCategorieSelect = document.getElementById('defaultCategorie');
    const categorieId = parseInt(defaultCategorieSelect.value) || 1; // Par défaut ADULTE si rien n'est sélectionné

    if (checkbox.checked) {
        selectedPlaces.set(placeId, {
            element: checkbox,
            placeId: placeId,
            code: checkbox.dataset.code,
            type: checkbox.dataset.type,
            typeId: checkbox.dataset.typeId,
            categorieId: categorieId, // Utiliser la catégorie sélectionnée
            prix: 0
        });
        placeItem.classList.add('selected');
        console.log('Place sélectionnée:', placeId, 'avec catégorie:', categorieId);
    } else {
        selectedPlaces.delete(placeId);
        placeItem.classList.remove('selected');
        console.log('Place désélectionnée:', placeId);
    }

    updateDisplay();
}
function updateDisplay() {
    const container = document.getElementById('selectedPlaces');
    const count = document.getElementById('selectedCount');
    const confirmBtn = document.getElementById('confirmBtn');
    
    count.textContent = selectedPlaces.size;
    confirmBtn.disabled = selectedPlaces.size === 0;
    
    if (selectedPlaces.size === 0) {
        container.innerHTML = '<div style="text-align: center; color: #666; padding: 20px;"><i class="fas fa-chair" style="font-size: 30px; margin-bottom: 10px;"></i><p>Aucune place sélectionnée</p></div>';
        document.getElementById('totalAmount').textContent = '0 AR';
        return;
    }
    
    let html = '';
    let total = 0;
    
    // Vérifier que les catégories sont disponibles
    if (!categories || categories.length === 0) {
        console.error('Catégories non disponibles!');
        container.innerHTML = '<div style="color: red; padding: 20px;">Erreur: Catégories non disponibles</div>';
        return;
    }
    
    // Utiliser une boucle for...of au lieu de forEach pour éviter les problèmes de closure
    for (const [placeId, place] of selectedPlaces.entries()) {
        const prix = calculerPrix(place);
        place.prix = prix;
        total += prix;
        
        // Générer les options de catégories manuellement
        let optionsHtml = '';
        console.log('Generating options for place:', placeId, 'categories:', categories); // Debug
        for (let i = 0; i < categories.length; i++) {
            const cat = categories[i];
            const selected = cat.id == place.categorieId ? 'selected' : '';
            optionsHtml += '<option value="' + cat.id + '" ' + selected + '>' + cat.libelle + '</option>';
        }
        
        // Construction du HTML SANS expressions EL
        html += '<div class="place-item">' +
                '<div>' +
                '<div style="font-weight: bold;">' + place.code + ' - ' + place.type + '</div>' +
                '<select onchange="updateCategorie(\'' + placeId + '\', this.value)" style="margin-top: 5px; padding: 5px; border: 1px solid #ddd; border-radius: 4px; width: 100%;">' +
                optionsHtml +
                '</select>' +
                '</div>' +
                '<div style="font-weight: bold; color: #28a745;">' + prix.toLocaleString('fr-FR') + ' AR</div>' +
                '<button class="remove-btn" onclick="removePlace(\'' + placeId + '\')"><i class="fas fa-times"></i></button>' +
                '</div>';
    }
    
    container.innerHTML = html;
    document.getElementById('totalAmount').textContent = total.toLocaleString('fr-FR') + ' AR';
}

function calculerPrix(place) {
    // Prix basés sur tarif_defaut
    // STANDARD = 20000 AR, PREMIUM = 50000 AR (même prix pour toutes catégories)
    let prix = 20000; // STANDARD par défaut
    
    if (place.type === 'PREMIUM') {
        prix = 50000;
    }
    
    return prix;
}

function updateCategorie(placeId, categorieId) {
    const place = selectedPlaces.get(placeId);
    if (place) {
        place.categorieId = parseInt(categorieId);
        updateDisplay();
    }
}

function removePlace(placeId) {
    const place = selectedPlaces.get(placeId);
    if (place && place.element) {
        place.element.checked = false;
        const placeItem = place.element.closest('.place-item');
        if (placeItem) {
            placeItem.classList.remove('selected');
        }
    }
    selectedPlaces.delete(placeId);
    updateDisplay();
}

function showMessage(text, type = 'success') {
    const msg = document.getElementById('message');
    msg.textContent = text;
    msg.className = `message ${type}`;
    msg.style.display = 'block';
    setTimeout(() => msg.style.display = 'none', 5000);
}

function confirmReservation() {
    // Validation
    if (selectedPlaces.size === 0) {
        showMessage('Veuillez sélectionner au moins une place', 'error');
        return;
    }

    const defaultCategorie = document.getElementById('defaultCategorie').value;
    if (!defaultCategorie) {
        showMessage('Veuillez sélectionner une catégorie de personne', 'error');
        return;
    }
    
    const nomComplet = document.getElementById('nomComplet').value.trim();
    const email = document.getElementById('email').value.trim();
    const telephone = document.getElementById('telephone').value.trim();
    
    if (!nomComplet) {
        showMessage('Veuillez saisir votre nom complet', 'error');
        return;
    }
    
    if (!email) {
        showMessage('Veuillez saisir votre email', 'error');
        return;
    }
    
    // Préparer les données
    const selections = Array.from(selectedPlaces.values()).map(place => ({
        placeId: parseInt(place.placeId),
        categorieId: place.categorieId
    }));
    
    const payload = {
        seanceId: ${seance.id},
        selections: selections,
        nomComplet: nomComplet,
        email: email,
        telephone: telephone
    };
    
    // Envoyer au serveur
    fetch('${pageContext.request.contextPath}/client/reservation/confirmer', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload)
    })
    .then(response => response.json())
    .then(data => {
        if (data.success) {
            showMessage(`Réservation confirmée ! ID: ${data.reservationId} - Total: ${data.total} AR`, 'success');
            setTimeout(() => {
                window.location.href = '${pageContext.request.contextPath}/client/accueil';
            }, 2000);
        } else {
            showMessage(data.error || 'Erreur lors de la réservation', 'error');
        }
    })
    .catch(error => {
        console.error('Error:', error);
        showMessage('Erreur de connexion au serveur', 'error');
    });
}
</script>
</body>
</html>
