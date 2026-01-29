<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="reservations" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${reservation.id == null ? 'Nouvelle Réservation' : 'Modifier Réservation'} - CinéManager</title>
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
                        <h1>${reservation.id == null ? 'Nouvelle Réservation' : 'Modifier Réservation'}</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/reservations">Réservations</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>${reservation.id == null ? 'Nouvelle' : 'Modifier'}</span>
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
                
                <div class="form-card">
                    <div class="form-header">
                        <h2>
                            <i class="fas ${reservation.id == null ? 'fa-plus-circle' : 'fa-edit'}"></i>
                            ${reservation.id == null ? 'Créer une nouvelle réservation' : 'Modifier la réservation'}
                        </h2>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/admin/reservations/sauvegarder" method="post">
                        <input type="hidden" name="id" value="${reservation.id}">
                        
                        <div class="form-body">
                            <div class="form-group-modern">
                                <label for="personneId">Client <span class="required">*</span></label>
                                <select id="personneId" name="personneId" required>
                                    <option value="">-- Sélectionnez un client --</option>
                                    <c:forEach var="personne" items="${personnes}">
                                        <option value="${personne.id}" ${reservation.personne != null && reservation.personne.id == personne.id ? 'selected' : ''}>
                                            ${personne.nomComplet} (${personne.email})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="seanceId">Séance <span class="required">*</span></label>
                                <select id="seanceId" name="seanceId" required>
                                    <option value="">-- Sélectionnez une séance --</option>
                                    <c:forEach var="seance" items="${seances}">
                                        <option value="${seance.id}" ${reservation.seance != null && reservation.seance.id == seance.id ? 'selected' : ''}>
                                            ${seance.film.titre} - ${seance.salle.nom} (${seance.debut})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-row-modern">
                                <div class="form-group-modern">
                                    <label for="statutId">Statut <span class="required">*</span></label>
                                    <select id="statutId" name="statutId" required>
                                        <option value="">-- Sélectionnez --</option>
                                        <c:forEach var="statut" items="${statuts}">
                                            <option value="${statut.id}" ${reservation.statut != null && reservation.statut.id == statut.id ? 'selected' : ''}>
                                                ${statut.libelle}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="form-group-modern">
                                    <label for="montantTotal">Montant Total (Ar) <span class="required">*</span></label>
                                    <input type="number" id="montantTotal" name="montantTotal" step="0.01" min="0" required 
                                           value="${reservation.montantTotal}" placeholder="Ex: 15000">
                                </div>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="dateReservation">Date de réservation</label>
                                <input type="datetime-local" id="dateReservation" name="dateReservation" 
                                       value="${reservation.dateReservation}">
                            </div>
                        </div>
                        
                        <div class="form-footer">
                            <a href="${pageContext.request.contextPath}/admin/reservations" class="btn-modern btn-secondary-modern">
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
