<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${seance.id == null ? 'Nouvelle Séance' : 'Modifier Séance'}</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        .card { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; margin-bottom: 30px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color: #555; }
        input, select { width: 100%; padding: 12px; border: 2px solid #ddd; border-radius: 8px; font-size: 16px; transition: border-color 0.3s; }
        input:focus, select:focus { outline: none; border-color: #f39c12; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: bold; transition: all 0.3s; display: inline-block; border: none; cursor: pointer; font-size: 16px; }
        .btn-primary { background: #f39c12; color: white; }
        .btn-primary:hover { background: #e67e22; }
        .btn-secondary { background: #95a5a6; color: white; margin-left: 10px; }
        .btn-secondary:hover { background: #7f8c8d; }
        .back-link { display: inline-block; color: #f39c12; text-decoration: none; margin-bottom: 20px; font-weight: bold; }
        .back-link:hover { text-decoration: underline; }
        .row { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/seances" class="back-link">← Retour à la liste</a>
        
        <div class="card">
            <h1>${seance.id == null ? '➕ Nouvelle Séance' : '✏️ Modifier Séance'}</h1>
            
            <form action="${pageContext.request.contextPath}/admin/seances/sauvegarder" method="post">
                <input type="hidden" name="id" value="${seance.id}">
                
                <div class="form-group">
                    <label for="filmId">Film *</label>
                    <select id="filmId" name="filmId" required>
                        <option value="">-- Sélectionnez un film --</option>
                        <c:forEach var="film" items="${films}">
                            <option value="${film.id}" ${seance.film != null && seance.film.id == film.id ? 'selected' : ''}>
                                ${film.titre} (${film.dureeMinutes} min)
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="salleId">Salle *</label>
                    <select id="salleId" name="salleId" required>
                        <option value="">-- Sélectionnez une salle --</option>
                        <c:forEach var="salle" items="${salles}">
                            <option value="${salle.id}" ${seance.salle != null && seance.salle.id == salle.id ? 'selected' : ''}>
                                ${salle.nom} (${salle.capacite} places)
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="row">
                    <div class="form-group">
                        <label for="dateDebut">Date *</label>
                        <input type="date" id="dateDebut" name="dateDebut" required 
                               value="${seance.debut != null ? seance.debut.toLocalDate() : ''}">
                    </div>
                    
                    <div class="form-group">
                        <label for="heureDebut">Heure *</label>
                        <input type="time" id="heureDebut" name="heureDebut" required
                               value="${seance.debut != null ? seance.debut.toLocalTime() : ''}">
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="langue">Langue</label>
                    <input type="text" id="langue" name="langue" value="${seance.langue}" placeholder="Ex: Français, Anglais VOST">
                </div>
                
                <div>
                    <button type="submit" class="btn btn-primary">💾 Enregistrer</button>
                    <a href="${pageContext.request.contextPath}/admin/seances" class="btn btn-secondary">❌ Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
