<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${salle.id == null ? 'Nouvelle Salle' : 'Modifier Salle'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/salles" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à la liste
        </a>
        
        <div class="form-container">
            <h1>${salle.id == null ? '➕ Nouvelle Salle' : '✏️ Modifier Salle'}</h1>
            
            <form action="${pageContext.request.contextPath}/admin/salles/sauvegarder" method="post">
                <input type="hidden" name="id" value="${salle.id}">
                
                <div class="form-group">
                    <label class="form-label" for="nom">Nom de la salle *</label>
                    <input type="text" class="form-control" id="nom" name="nom" value="${salle.nom}" required placeholder="Ex: Salle 1">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="capacite">Capacité (nombre de places) *</label>
                    <input type="number" class="form-control" id="capacite" name="capacite" value="${salle.capacite}" required min="1" placeholder="Ex: 150">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Enregistrer</button>
                    <a href="${pageContext.request.contextPath}/admin/salles" class="btn btn-secondary"><i class="fas fa-times"></i> Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
