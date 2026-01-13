<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des Salles</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { background: white; padding: 25px; border-radius: 10px; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); display: flex; justify-content: space-between; align-items: center; }
        h1 { color: #333; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: bold; transition: all 0.3s; display: inline-block; border: none; cursor: pointer; }
        .btn-primary { background: #3498db; color: white; }
        .btn-primary:hover { background: #2980b9; }
        .btn-danger { background: #e74c3c; color: white; font-size: 14px; padding: 8px 15px; }
        .btn-danger:hover { background: #c0392b; }
        .btn-warning { background: #f39c12; color: white; font-size: 14px; padding: 8px 15px; }
        .btn-warning:hover { background: #e67e22; }
        .alert { padding: 15px; border-radius: 8px; margin-bottom: 20px; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        table { width: 100%; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #3498db; color: white; font-weight: bold; }
        tr:hover { background: #f8f9fa; }
        .actions { display: flex; gap: 10px; }
        .back-link { display: inline-block; color: #3498db; text-decoration: none; margin-bottom: 20px; font-weight: bold; }
        .back-link:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/accueil" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à l'espace admin
        </a>
        
        <div class="header">
            <h1><i class="fas fa-door-open"></i> Gestion des Salles</h1>
            <a href="${pageContext.request.contextPath}/admin/salles/nouveau" class="btn btn-primary">
                <i class="fas fa-plus"></i> Nouvelle Salle
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
                    <th>Nom</th>
                    <th>Capacité</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="salle" items="${salles}">
                    <tr>
                        <td>${salle.id}</td>
                        <td><strong>${salle.nom}</strong></td>
                        <td>${salle.capacite} places</td>
                        <td>
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/admin/salles/${salle.id}/editer" class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="${pageContext.request.contextPath}/admin/salles/${salle.id}/supprimer" 
                                   class="btn btn-danger"
                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette salle ?');">
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
