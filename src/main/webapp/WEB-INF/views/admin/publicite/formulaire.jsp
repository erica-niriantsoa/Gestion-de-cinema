<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="publicite" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${publicite.id == null ? 'Nouvelle Publicité' : 'Modifier Publicité'} - CinéManager</title>
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
                        <h1>${publicite.id == null ? 'Nouvelle Publicité' : 'Modifier Publicité'}</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/publicite">Publicité</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>${publicite.id == null ? 'Nouvelle' : 'Modifier'}</span>
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
                            <i class="fas ${publicite.id == null ? 'fa-plus-circle' : 'fa-edit'}"></i>
                            ${publicite.id == null ? 'Programmer une diffusion publicitaire' : 'Modifier la diffusion'}
                        </h2>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/admin/publicite/sauvegarder" method="post">
                        <input type="hidden" name="id" value="${publicite.id}">
                        
                        <div class="form-body">
                            <div class="form-group-modern">
                                <label for="seanceId">Séance <span class="required">*</span></label>
                                <select id="seanceId" name="seanceId" required>
                                    <option value="">-- Sélectionnez une séance --</option>
                                    <c:forEach var="seance" items="${seances}">
                                        <option value="${seance.id}" ${publicite.idSeance != null && publicite.idSeance == seance.id ? 'selected' : ''}>
                                            ${seance.film.titre} - ${seance.salle.nom} (${seance.debut})
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="societeId">Société <span class="required">*</span></label>
                                <select id="societeId" name="societeId" required>
                                    <option value="">-- Sélectionnez une société --</option>
                                    <c:forEach var="societe" items="${societes}">
                                        <option value="${societe.id}" ${publicite.societe != null && publicite.societe.id == societe.id ? 'selected' : ''}>
                                            ${societe.nom} - ${societe.libelle}
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-row-modern">
                                <div class="form-group-modern">
                                    <label for="typePubliciteId">Type de Publicité <span class="required">*</span></label>
                                    <select id="typePubliciteId" name="typePubliciteId" required>
                                        <option value="">-- Sélectionnez --</option>
                                        <c:forEach var="type" items="${typesPublicite}">
                                            <option value="${type.id}" ${publicite.typePublicite != null && publicite.typePublicite.id == type.id ? 'selected' : ''}>
                                                ${type.libelle}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                
                                <div class="form-group-modern">
                                    <label for="tarifId">Tarif <span class="required">*</span></label>
                                    <select id="tarifId" name="tarifId" required>
                                        <option value="">-- Sélectionnez --</option>
                                        <c:forEach var="tarif" items="${tarifs}">
                                            <option value="${tarif.id}" ${publicite.tarif != null && publicite.tarif.id == tarif.id ? 'selected' : ''}>
                                                ${tarif.libelle} - ${tarif.prix} Ar
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="dateDiffusion">Date de diffusion <span class="required">*</span></label>
                                <input type="date" id="dateDiffusion" name="dateDiffusion" required 
                                       value="${publicite.dateDiffusion}">
                            </div>
                        </div>
                        
                        <div class="form-footer">
                            <a href="${pageContext.request.contextPath}/admin/publicite" class="btn-modern btn-secondary-modern">
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
