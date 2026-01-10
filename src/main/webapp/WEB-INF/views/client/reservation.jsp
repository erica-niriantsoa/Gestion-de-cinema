<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 1400px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 25px; border-radius: 15px; margin-bottom: 20px; }
        .seance-info { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px; margin-top: 15px; }
        .info-item { background: rgba(255, 255, 255, 0.1); padding: 10px; border-radius: 8px; }
        .main-grid { display: grid; grid-template-columns: 2fr 1fr; gap: 25px; }
        @media (max-width: 968px) { .main-grid { grid-template-columns: 1fr; } }
        
        /* Plan de salle */
        .plan-container { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); }
        .screen { text-align: center; background: linear-gradient(to bottom, #333, #666); color: white; padding: 15px; margin: 0 0 30px; border-radius: 5px; font-weight: bold; letter-spacing: 2px; }
        .places-list { display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 10px; max-height: 400px; overflow-y: auto; }
        .place-item { display: flex; align-items: center; gap: 10px; padding: 10px; background: #f8f9fa; border-radius: 6px; }
        .place-checkbox { margin: 0; }
        .place-label { flex: 1; font-weight: bold; }
        .place-type { font-size: 12px; color: #666; }
        
        /* Panier et Formulaire */
        .sidebar { display: flex; flex-direction: column; gap: 20px; }
        .card { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); }
        .card-title { font-size: 18px; font-weight: bold; margin-bottom: 15px; padding-bottom: 10px; border-bottom: 2px solid #f8f9fa; }
        .selected-places { max-height: 200px; overflow-y: auto; margin-bottom: 15px; }
        .place-item { display: flex; justify-content: space-between; align-items: center; padding: 10px; background: #f8f9fa; border-radius: 6px; margin-bottom: 8px; }
        .remove-btn { background: #dc3545; color: white; border: none; width: 25px; height: 25px; border-radius: 50%; cursor: pointer; font-size: 12px; }
        .form-group { margin-bottom: 15px; }
        .form-label { display: block; margin-bottom: 5px; font-weight: 600; color: #333; }
        .form-input, .form-select { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 6px; font-size: 14px; }
        .form-input:focus, .form-select:focus { outline: none; border-color: #667eea; }
        .total { background: #f8f9fa; padding: 20px; border-radius: 8px; text-align: center; margin: 15px 0; }
        .total-amount { font-size: 32px; font-weight: bold; color: #333; margin: 10px 0; }
        .btn-confirm { width: 100%; padding: 15px; background: linear-gradient(135deg, #28a745, #20c997); color: white; border: none; border-radius: 8px; font-size: 18px; font-weight: bold; cursor: pointer; transition: all 0.3s; }
        .btn-confirm:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3); }
        .btn-confirm:disabled { background: #6c757d; cursor: not-allowed; transform: none; }
        .legend { display: flex; gap: 15px; justify-content: center; margin-top: 20px; flex-wrap: wrap; font-size: 14px; }
        .legend-item { display: flex; align-items: center; gap: 5px; }
        .legend-color { width: 20px; height: 20px; border-radius: 3px; }
        .message { padding: 15px; border-radius: 8px; margin-bottom: 20px; display: none; }
        .message.success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .message.error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-ticket-alt"></i> Réservation</h1>
        <h2>${seance.film.titre}</h2>
        <div class="seance-info">
            <div class="info-item"><i class="fas fa-calendar"></i> <strong>Date:</strong> ${seance.debutFormatted}</div>
            <div class="info-item"><i class="fas fa-language"></i> <strong>Langue:</strong> ${seance.langue}</div>
            <div class="info-item"><i class="fas fa-door-open"></i> <strong>Salle:</strong> ${seance.salle.nom}</div>
            <div class="info-item"><i class="fas fa-clock"></i> <strong>Durée:</strong> ${seance.film.dureeMinutes} min</div>
        </div>
    </div>

    <div id="message" class="message"></div>

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
                    <div class="total-amount" id="totalAmount">0.00 €</div>
                </div>
            </div>

            <!-- Formulaire d'informations -->
            <div class="card">
                <div class="card-title"><i class="fas fa-user"></i> Vos informations</div>
                <form id="clientForm">
                    <div class="form-group">
                        <label class="form-label">Nom complet *</label>
                        <input type="text" id="nomComplet" class="form-input" placeholder="Votre nom complet" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Email *</label>
                        <input type="email" id="email" class="form-input" placeholder="votre@email.com" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Téléphone</label>
                        <input type="tel" id="telephone" class="form-input" placeholder="0612345678">
                    </div>
                </form>
            </div>

            <!-- Bouton de confirmation -->
            <button class="btn-confirm" id="confirmBtn" disabled onclick="confirmReservation()">
                <i class="fas fa-check-circle"></i> Confirmer la réservation
            </button>
        </div>
    </div>
</div>

<script>
let selectedPlaces = new Map();
const categories = JSON.parse('${categoriesJson}'); // Depuis le serveur

document.addEventListener('DOMContentLoaded', function() {
    // Initial setup if needed
});

function togglePlace(checkbox) {
    const placeId = checkbox.dataset.placeId;
    if (checkbox.checked) {
        selectedPlaces.set(placeId, {
            element: checkbox,
            placeId: placeId,
            code: checkbox.dataset.code,
            type: checkbox.dataset.type,
            typeId: checkbox.dataset.typeId,
            categorieId: 1, // Par défaut ADULTE
            prix: 0
        });
    } else {
        selectedPlaces.delete(placeId);
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
        document.getElementById('totalAmount').textContent = '0.00 €';
        return;
    }
    
    let html = '';
    let total = 0;
    
    // Utiliser une boucle for...of au lieu de forEach pour éviter les problèmes de closure
    for (const [placeId, place] of selectedPlaces.entries()) {
        const prix = calculerPrix(place);
        place.prix = prix;
        total += prix;
        
        // Générer les options de catégories manuellement
        let optionsHtml = '';
        for (let i = 0; i < categories.length; i++) {
            const cat = categories[i];
            const selected = cat.id == place.categorieId ? 'selected' : '';
            optionsHtml += '<option value="' + cat.id + '" ' + selected + '>' + cat.libelle + '</option>';
        }
        
        // Construction du HTML SANS expressions EL
        html += '<div class="place-item">' +
                '<div>' +
                '<div style="font-weight: bold;">' + place.code + ' - ' + place.type + '</div>' +
                '<select onchange="updateCategorie(\'' + placeId + '\', this.value)" style="margin-top: 5px; padding: 5px; border: 1px solid #ddd; border-radius: 4px;">' +
                optionsHtml +
                '</select>' +
                '</div>' +
                '<div style="font-weight: bold; color: #28a745;">' + prix.toFixed(2) + ' €</div>' +
                '<button class="remove-btn" onclick="removePlace(\'' + placeId + '\')"><i class="fas fa-times"></i></button>' +
                '</div>';
    }
    
    container.innerHTML = html;
    document.getElementById('totalAmount').textContent = total.toFixed(2) + ' €';
}

function calculerPrix(place) {
    let prix = 9.90;
    if (place.type === 'VIP') prix = 14.90;
    else if (place.type === 'PMR') prix = 8.90;
    
    if (place.categorieId === 2) prix *= 0.7; // ENFANT -30%
    else if (place.categorieId === 3) prix *= 0.8; // SENIOR -20%
    
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
    if (place && place.element) place.element.checked = false;
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
            showMessage(`Réservation confirmée ! ID: ${data.reservationId} - Total: ${data.total} €`, 'success');
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
