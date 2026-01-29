<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="tickets" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${ticket.id == null ? 'Nouveau Ticket' : 'Modifier Ticket'} - CinéManager</title>
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
                        <h1>${ticket.id == null ? 'Nouveau Ticket' : 'Modifier Ticket'}</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/tickets">Tickets</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>${ticket.id == null ? 'Nouveau' : 'Modifier'}</span>
                        </div>
                    </div>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <c:if test="${not empty error}">
                    <div class="alert-modern error">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert-modern success">
                        <i class="fas fa-check-circle"></i> ${success}
                    </div>
                </c:if>
                
                <div class="form-card">
                    <div class="form-header">
                        <h2>
                            <i class="fas ${ticket.id == null ? 'fa-plus-circle' : 'fa-edit'}"></i>
                            ${ticket.id == null ? 'Créer un nouveau ticket' : 'Modifier le ticket'}
                        </h2>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/admin/tickets/sauvegarder" method="post">
                        <input type="hidden" name="id" value="${ticket.id}">
                        
                        <div class="form-body">
                            <div class="form-group-modern">
                                <label for="seanceId">Séance <span class="required">*</span></label>
                                <select id="seanceId" name="seanceId" required>
                                    <option value="">-- Sélectionnez une séance --</option>
                                    <c:forEach var="seance" items="${seances}">
                                        <option value="${seance.id}" ${ticket.seance != null && ticket.seance.id == seance.id ? 'selected' : ''}>
                                            ${seance.film.titre} - ${seance.salle.nom} (${seance.debut})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="placeId">Place <span class="required">*</span></label>
                                <select id="placeId" name="placeId" required>
                                    <option value="">-- Sélectionnez une place --</option>
                                    <c:forEach var="place" items="${places}">
                                        <option value="${place.id}" ${ticket.place != null && ticket.place.id == place.id ? 'selected' : ''}>
                                            ${place.salle.nom} - ${place.codePlace} (${place.typePlace.libelle})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-row-modern">
                                <div class="form-group-modern">
                                    <label for="categorieId">Catégorie personne <span class="required">*</span></label>
                                    <select id="categorieId" name="categorieId" required>
                                        <option value="">-- Sélectionnez --</option>
                                        <c:forEach var="cat" items="${categories}">
                                            <option value="${cat.id}" ${ticket.categoriePersonne != null && ticket.categoriePersonne.id == cat.id ? 'selected' : ''}>
                                                ${cat.libelle}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="form-group-modern">
                                    <label for="statutId">Statut <span class="required">*</span></label>
                                    <select id="statutId" name="statutId" required>
                                        <option value="">-- Sélectionnez --</option>
                                        <c:forEach var="statut" items="${statuts}">
                                            <option value="${statut.id}" ${ticket.statut != null && ticket.statut.id == statut.id ? 'selected' : ''}>
                                                ${statut.libelle}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="reservationId">Réservation (optionnel)</label>
                                <select id="reservationId" name="reservationId">
                                    <option value="">-- Sans réservation --</option>
                                    <c:forEach var="res" items="${reservations}">
                                        <option value="${res.id}" ${ticket.reservation != null && ticket.reservation.id == res.id ? 'selected' : ''}>
                                            #${res.id} - ${res.personne.nomComplet} (${res.dateReservation})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="prix">Prix (Ar) <span class="required">*</span></label>
                                <input type="number" id="prix" name="prix" step="0.01" min="0" required 
                                       value="${ticket.prix}" placeholder="Ex: 5000">
                            </div>
                        </div>
                        
                        <div class="form-footer">
                            <a href="${pageContext.request.contextPath}/admin/tickets" class="btn-modern btn-secondary-modern">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                            <button type="submit" class="btn-modern btn-primary-modern">
                                <i class="fas fa-save"></i> Enregistrer
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
