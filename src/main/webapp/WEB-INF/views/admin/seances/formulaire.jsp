<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="seances" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${seance.id == null ? 'Nouvelle Séance' : 'Modifier Séance'} - CinéManager</title>
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
                        <h1>${seance.id == null ? 'Nouvelle Séance' : 'Modifier Séance'}</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/seances">Séances</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>${seance.id == null ? 'Nouvelle' : 'Modifier'}</span>
                        </div>
                    </div>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <div class="form-card">
                    <div class="form-header">
                        <h2>
                            <i class="fas ${seance.id == null ? 'fa-plus-circle' : 'fa-edit'}"></i>
                            ${seance.id == null ? 'Programmer une nouvelle séance' : 'Modifier la séance'}
                        </h2>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/admin/seances/sauvegarder" method="post">
                        <input type="hidden" name="id" value="${seance.id}">
                        
                        <div class="form-body">
                            <div class="form-group-modern">
                                <label for="filmId">Film <span class="required">*</span></label>
                                <select id="filmId" name="filmId" required>
                                    <option value="">-- Sélectionnez un film --</option>
                                    <c:forEach var="film" items="${films}">
                                        <option value="${film.id}" ${seance.film != null && seance.film.id == film.id ? 'selected' : ''}>
                                            ${film.titre} (${film.dureeMinutes} min)
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="salleId">Salle <span class="required">*</span></label>
                                <select id="salleId" name="salleId" required>
                                    <option value="">-- Sélectionnez une salle --</option>
                                    <c:forEach var="salle" items="${salles}">
                                        <option value="${salle.id}" ${seance.salle != null && seance.salle.id == salle.id ? 'selected' : ''}>
                                            ${salle.nom} (${salle.capacite} places)
                                        </option>
                                    </c:forEach>
                                </select>
                            </div>
                            
                            <div class="form-row-modern">
                                <div class="form-group-modern">
                                    <label for="dateDebut">Date <span class="required">*</span></label>
                                    <input type="date" id="dateDebut" name="dateDebut" required 
                                           value="${seance.debut != null ? seance.debut.toLocalDate() : ''}">
                                </div>
                                
                                <div class="form-group-modern">
                                    <label for="heureDebut">Heure <span class="required">*</span></label>
                                    <input type="time" id="heureDebut" name="heureDebut" required
                                           value="${seance.debut != null ? seance.debut.toLocalTime() : ''}">
                                </div>
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="langue">Langue</label>
                                <input type="text" id="langue" name="langue" value="${seance.langue}" placeholder="Ex: VF, VO, VOST">
                            </div>
                        </div>
                        
                        <div class="form-footer">
                            <a href="${pageContext.request.contextPath}/admin/seances" class="btn-modern btn-secondary-modern">
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
