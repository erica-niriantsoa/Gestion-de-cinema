<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Films</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 1400px; margin: 0 auto; }
        .header { background: white; padding: 25px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
        h1 { color: #333; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: bold; transition: all 0.3s; display: inline-block; border: none; cursor: pointer; }
        .btn-primary { background: #667eea; color: white; }
        .btn-primary:hover { background: #5568d3; }
        .btn-success { background: #27ae60; color: white; }
        .btn-success:hover { background: #229954; }
        .btn-danger { background: #e74c3c; color: white; font-size: 14px; padding: 8px 15px; }
        .btn-danger:hover { background: #c0392b; }
        .btn-warning { background: #f39c12; color: white; font-size: 14px; padding: 8px 15px; }
        .btn-warning:hover { background: #e67e22; }
        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        table { width: 100%; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #667eea; color: white; font-weight: bold; }
        tr:hover { background: #f8f9fa; }
        .actions { display: flex; gap: 10px; }
        .back-link { display: inline-block; color: #667eea; text-decoration: none; margin-bottom: 20px; font-weight: bold; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/accueil" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à l'espace admin
        </a>
        
        <div class="header">
            <h1><i class="fas fa-film"></i> Gestion des Films</h1>
            <a href="${pageContext.request.contextPath}/admin/films/nouveau" class="btn btn-primary">
                <i class="fas fa-plus"></i> Nouveau Film
            </a>
        </div>
        
        <c:if test="${not empty success}">
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i> ${success}
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-error">
                <i class="fas fa-exclamation-triangle"></i> ${error}
            </div>
        </c:if>
        
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Titre</th>
                    <th>Durée (min)</th>
                    <th>Date de sortie</th>
                    <th>Langue</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="film" items="${films}">
                    <tr>
                        <td>${film.id}</td>
                        <td><strong>${film.titre}</strong></td>
                        <td>${film.dureeMinutes}</td>
                        <td>${film.dateSortie}</td>
                        <td>${film.langueOriginale}</td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/admin/films/${film.id}/editer" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/films/${film.id}/supprimer" 
                                   class="btn btn-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer ce film ?');">
                                    <i class="fas fa-trash"></i> Supprimer
                                </a>
                            </div>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</body>
</html>
