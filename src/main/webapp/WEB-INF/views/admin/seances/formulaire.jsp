<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${seance.id == null ? 'Nouvelle Séance' : 'Modifier Séance'}</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/seances" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à la liste
        </a>
        
        <div class="form-container">
            <h1>${seance.id == null ? '➕ Nouvelle Séance' : '✏️ Modifier Séance'}</h1>
            
            <form action="${pageContext.request.contextPath}/admin/seances/sauvegarder" method="post">
                <input type="hidden" name="id" value="${seance.id}">
                
                <div class="form-group">
                    <label class="form-label" for="filmId">Film *</label>
                    <select class="form-control" id="filmId" name="filmId" required>
                        <option value="">-- Sélectionnez un film --</option>
                        <c:forEach var="film" items="${films}">
                            <option value="${film.id}" ${seance.film != null && seance.film.id == film.id ? 'selected' : ''}>
                                ${film.titre} (${film.dureeMinutes} min)
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="salleId">Salle *</label>
                    <select class="form-control" id="salleId" name="salleId" required>
                        <option value="">-- Sélectionnez une salle --</option>
                        <c:forEach var="salle" items="${salles}">
                            <option value="${salle.id}" ${seance.salle != null && seance.salle.id == salle.id ? 'selected' : ''}>
                                ${salle.nom} (${salle.capacite} places)
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="dateDebut">Date *</label>
                        <input type="date" class="form-control" id="dateDebut" name="dateDebut" required 
                               value="${seance.debut != null ? seance.debut.toLocalDate() : ''}">
                    </div>
                    
                    <div class="form-group">
                        <label class="form-label" for="heureDebut">Heure *</label>
                        <input type="time" class="form-control" id="heureDebut" name="heureDebut" required
                               value="${seance.debut != null ? seance.debut.toLocalTime() : ''}">
                    </div>
                </div>
                
                <div class="form-group">
                    <label class="form-label" for="langue">Langue</label>
                    <input type="text" class="form-control" id="langue" name="langue" value="${seance.langue}" placeholder="Ex: Français, Anglais VOST">
                </div>
                
                <div class="form-actions">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Enregistrer</button>
                    <a href="${pageContext.request.contextPath}/admin/seances" class="btn btn-secondary"><i class="fas fa-times"></i> Annuler</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
