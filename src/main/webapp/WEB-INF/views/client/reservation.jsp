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
                <div class="header">
                    <h1><i class="fas fa-ticket-alt"></i> Réservation</h1>
                    <h2>${seance.film.titre}</h2>
                    <div class="seance-info">
                        <div class="info-item"><i class="fas fa-calendar"></i> <strong>Date:</strong>
                            ${seance.debutFormatted}</div>
                        <div class="info-item"><i class="fas fa-language"></i> <strong>Langue:</strong> ${seance.langue}
                        </div>
                        <div class="info-item"><i class="fas fa-door-open"></i> <strong>Salle:</strong>
                            ${seance.salle.nom}</div>
                        <div class="info-item"><i class="fas fa-clock"></i> <strong>Durée:</strong>
                            ${seance.film.dureeMinutes} min</div>
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
                                        <input type="checkbox" class="place-checkbox" id="place_${place.id}"
                                            data-place-id="${place.id}" data-code="${place.codePlace}"
                                            data-type="${place.typePlace.libelle}" data-type-id="${place.typePlace.id}"
                                            onchange="togglePlace(this)">
                                        <label for="place_${place.id}" class="place-label">${place.codePlace}</label>
                                        <span class="place-type">${place.typePlace.libelle}</span>
                                    </div>
                                </c:if>
                            </c:forEach>
                        </div>
                        <div class="legend">
                            <div class="legend-item"><span>Places disponibles : Cochez les cases pour
                                    sélectionner</span></div>
                        </div>
                    </div>

                    <!-- Panier + Formulaire -->
                    <div class="sidebar">
                        <!-- Places sélectionnées -->
                        <div class="card">
                            <div class="card-title"><i class="fas fa-shopping-cart"></i> Vos places (<span
                                    id="selectedCount">0</span>)</div>
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
                        <div class="form-group">
                            <label class="form-label">Nom complet *</label>
                            <input type="text" id="nomComplet" class="form-input" placeholder="Votre nom complet"
                                required value="${user.nom != null ? user.nom : 'Jean Martin'}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Email *</label>
                            <input type="email" id="email" class="form-input" placeholder="votre@email.com" required
                                value="${user.email != null ? user.email : 'admin@cinema.com'}">
                        </div>
                        <div class="form-group">
                            <label class="form-label">Téléphone</label>
                            <input type="tel" id="telephone" class="form-input" placeholder="0612345678"
                                value="${user.telephone != null ? user.telephone : '0123456789'}">
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

                document.addEventListener('DOMContentLoaded', function () {
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

                const tarifs = JSON.parse('${tarifsJson}');
                function calculerPrix(place) {
                    const typeId = parseInt(place.typeId);
                    console.log('Type ID:', typeId);
                    const categorieId = parseInt(place.categorieId);
                    console.log('Categorie ID:', categorieId);
                    // Chercher dans la liste des tarifs
                    const tarif = tarifs.find(t =>
                        t.typePlace.id === typeId &&
                        t.categoriePersonne.id === categorieId
                    );
                    console.log('Tarif trouvé:', tarif);
                    tarifs.forEach(element => {
                        console.log('Tarif élément:', element);
                    });

                    if (tarif) {
                        return tarif.prix;
                    } else {
                        console.warn(`Aucun tarif trouvé pour typePlace=${typeId}, categorie=${categorieId}`);
                        return 0; // ou un prix par défaut
                    }
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
                        seanceId: ${ seance.id },
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