<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${film.id == null ? 'Nouveau Film' : 'Modifier Film'}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .card { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input, textarea, select { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 8px; font-size: 16px; transition: border-color 0.3s; }
        input:focus, textarea:focus, select:focus { outline: none; border-color: #667eea; }
        textarea { min-height: 100px; resize: vertical; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: bold; transition: all 0.3s; display: inline-block; border: none; cursor: pointer; font-size: 16px; }
        .btn-primary { background: #667eea; color: white; }
        .btn-primary:hover { background: #5568d3; }
        .btn-secondary { background: #95a5a6; color: white; margin-left: 10px; }
        .btn-secondary:hover { background: #7f8c8d; }
        .back-link { display: inline-block; color: #667eea; text-decoration: none; margin-bottom: 20px; font-weight: bold; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/films" class="back-link">← Retour à la liste</a>
        
        <div class="card">
            <h1>${film.id == null ? '➕ Nouveau Film' : '✏️ Modifier Film'}</h1>
            
            <form action="${pageContext.request.contextPath}/admin/films/sauvegarder" method="post">
                <input type="hidden" name="id" value="${film.id}">
                
                <div class="form-group">
                    <label for="titre">Titre *</label>
                    <input type="text" id="titre" name="titre" value="${film.titre}" required>
                </div>
                
                <div class="form-group">
                    <label for="description">Description</label>
                    <textarea id="description" name="description">${film.description}</textarea>
                </div>
                
                <div class="form-group">
                    <label for="dureeMinutes">Durée (minutes) *</label>
                    <input type="number" id="dureeMinutes" name="dureeMinutes" value="${film.dureeMinutes}" required min="1">
                </div>
                
                <div class="form-group">
                    <label for="dateSortie">Date de sortie</label>
                    <input type="date" id="dateSortie" name="dateSortie" value="${film.dateSortie}">
                </div>
                
                <div class="form-group">
                    <label for="ageMin">Âge minimum</label>
                    <input type="number" id="ageMin" name="ageMin" value="${film.ageMin != null ? film.ageMin : 0}" min="0">
                </div>
                
                <div class="form-group">
                    <label for="langueOriginale">Langue originale</label>
                    <input type="text" id="langueOriginale" name="langueOriginale" value="${film.langueOriginale}">
                </div>
                
                <div>
                    <button type="submit" class="btn btn-primary">💾 Enregistrer</button>
                    <a href="${pageContext.request.contextPath}/admin/films" class="btn btn-secondary">❌ Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
