<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${film.id == null ? 'Nouveau Film' : 'Modifier Film'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/films" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à la liste
        </a>
        
        <div class="form-container">
            <h1>${film.id == null ? '➕ Nouveau Film' : '✏️ Modifier Film'}</h1>
            
            <form action="${pageContext.request.contextPath}/admin/films/sauvegarder" method="post">
                <input type="hidden" name="id" value="${film.id}">
                
                <div class="form-group">
                    <label class="form-label" for="titre">Titre *</label>
                    <input type="text" class="form-control" id="titre" name="titre" value="${film.titre}" required>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="description">Description</label>
                    <textarea class="form-control" id="description" name="description">${film.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="dureeMinutes">Durée (minutes) *</label>
                    <input type="number" class="form-control" id="dureeMinutes" name="dureeMinutes" value="${film.dureeMinutes}" required min="1">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="dateSortie">Date de sortie</label>
                    <input type="date" class="form-control" id="dateSortie" name="dateSortie" value="${film.dateSortie}">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="ageMin">Âge minimum</label>
                    <input type="number" class="form-control" id="ageMin" name="ageMin" value="${film.ageMin != null ? film.ageMin : 0}" min="0">
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="langueOriginale">Langue originale</label>
                    <input type="text" class="form-control" id="langueOriginale" name="langueOriginale" value="${film.langueOriginale}">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Enregistrer</button>
                    <a href="${pageContext.request.contextPath}/admin/films" class="btn btn-secondary"><i class="fas fa-times"></i> Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
