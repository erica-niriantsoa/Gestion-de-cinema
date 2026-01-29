<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="films" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${film.id == null ? 'Nouveau Film' : 'Modifier Film'} - CinéManager</title>
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
                        <h1>${film.id == null ? 'Nouveau Film' : 'Modifier Film'}</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/films">Films</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>${film.id == null ? 'Nouveau' : 'Modifier'}</span>
                        </div>
                    </div>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <div class="form-card">
                    <div class="form-header">
                        <h2>
                            <i class="fas ${film.id == null ? 'fa-plus-circle' : 'fa-edit'}"></i>
                            ${film.id == null ? 'Ajouter un nouveau film' : 'Modifier le film'}
                        </h2>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/admin/films/sauvegarder" method="post">
                        <input type="hidden" name="id" value="${film.id}">
                        
                        <div class="form-body">
                            <div class="form-group-modern">
                                <label for="titre">Titre <span class="required">*</span></label>
                                <input type="text" id="titre" name="titre" value="${film.titre}" required placeholder="Titre du film">
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="description">Description</label>
                                <textarea id="description" name="description" rows="4" placeholder="Description du film">${film.description}</textarea>
                            </div>
                            
                            <div class="form-row-modern">
                                <div class="form-group-modern">
                                    <label for="dureeMinutes">Durée (minutes) <span class="required">*</span></label>
                                    <input type="number" id="dureeMinutes" name="dureeMinutes" value="${film.dureeMinutes}" required min="1" placeholder="120">
                                </div>
                                
                                <div class="form-group-modern">
                                    <label for="dateSortie">Date de sortie</label>
                                    <input type="date" id="dateSortie" name="dateSortie" value="${film.dateSortie}">
                                </div>
                            </div>
                            
                            <div class="form-row-modern">
                                <div class="form-group-modern">
                                    <label for="ageMin">Âge minimum</label>
                                    <input type="number" id="ageMin" name="ageMin" value="${film.ageMin != null ? film.ageMin : 0}" min="0" placeholder="0">
                                </div>
                                
                                <div class="form-group-modern">
                                    <label for="langueOriginale">Langue originale</label>
                                    <input type="text" id="langueOriginale" name="langueOriginale" value="${film.langueOriginale}" placeholder="Français, Anglais...">
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-footer">
                            <a href="${pageContext.request.contextPath}/admin/films" class="btn-modern btn-secondary-modern">
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
