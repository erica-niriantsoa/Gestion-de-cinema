<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${salle.id == null ? 'Nouvelle Salle' : 'Modifier Salle'}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .card { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 8px; font-size: 16px; transition: border-color 0.3s; }
        input:focus { outline: none; border-color: #3498db; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: bold; transition: all 0.3s; display: inline-block; border: none; cursor: pointer; font-size: 16px; }
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; }
        .btn-secondary { background: #95a5a6; color: white; margin-left: 10px; }
        .btn-secondary:hover { background: #7f8c8d; }
        .back-link { display: inline-block; color: #3498db; text-decoration: none; margin-bottom: 20px; font-weight: bold; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/salles" class="back-link">← Retour à la liste</a>
        
        <div class="card">
            <h1>${salle.id == null ? '➕ Nouvelle Salle' : '✏️ Modifier Salle'}</h1>
            
            <form action="${pageContext.request.contextPath}/admin/salles/sauvegarder" method="post">
                <input type="hidden" name="id" value="${salle.id}">
                
                <div class="form-group">
                    <label for="nom">Nom de la salle *</label>
                    <input type="text" id="nom" name="nom" value="${salle.nom}" required placeholder="Ex: Salle 1">
                </div>
                
                <div class="form-group">
                    <label for="capacite">Capacité (nombre de places) *</label>
                    <input type="number" id="capacite" name="capacite" value="${salle.capacite}" required min="1" placeholder="Ex: 150">
                </div>
                
                <div>
                    <button type="submit" class="btn btn-primary">💾 Enregistrer</button>
                    <a href="${pageContext.request.contextPath}/admin/salles" class="btn btn-secondary">❌ Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
