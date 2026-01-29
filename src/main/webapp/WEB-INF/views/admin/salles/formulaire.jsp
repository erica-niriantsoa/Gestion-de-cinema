<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="salles" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${salle.id == null ? 'Nouvelle Salle' : 'Modifier Salle'} - CinéManager</title>
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
                        <h1>${salle.id == null ? 'Nouvelle Salle' : 'Modifier Salle'}</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/salles">Salles</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>${salle.id == null ? 'Nouvelle' : 'Modifier'}</span>
                        </div>
                    </div>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <div class="form-card">
                    <div class="form-header">
                        <h2>
                            <i class="fas ${salle.id == null ? 'fa-plus-circle' : 'fa-edit'}"></i>
                            ${salle.id == null ? 'Ajouter une nouvelle salle' : 'Modifier la salle'}
                        </h2>
                    </div>
                    
                    <form action="${pageContext.request.contextPath}/admin/salles/sauvegarder" method="post">
                        <input type="hidden" name="id" value="${salle.id}">
                        
                        <div class="form-body">
                            <div class="form-group-modern">
                                <label for="nom">Nom de la salle <span class="required">*</span></label>
                                <input type="text" id="nom" name="nom" value="${salle.nom}" required placeholder="Ex: Salle 1">
                            </div>
                            
                            <div class="form-group-modern">
                                <label for="capacite">Capacité (nombre de places) <span class="required">*</span></label>
                                <input type="number" id="capacite" name="capacite" value="${salle.capacite}" required min="1" placeholder="Ex: 150">
                            </div>
                        </div>
                        
                        <div class="form-footer">
                            <a href="${pageContext.request.contextPath}/admin/salles" class="btn-modern btn-secondary-modern">
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
