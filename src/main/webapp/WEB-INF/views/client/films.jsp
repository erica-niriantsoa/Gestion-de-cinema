<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Films Disponibles</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 25px; border-radius: 15px; margin-bottom: 20px; text-align: center; }
        .films-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .film-card { background: white; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); overflow: hidden; transition: transform 0.3s; }
        .film-card:hover { transform: translateY(-5px); }
        .film-image { height: 200px; background: linear-gradient(135deg, #667eea, #764ba2); display: flex; align-items: center; justify-content: center; color: white; font-size: 48px; }
        .film-content { padding: 20px; }
        .film-title { font-size: 18px; font-weight: bold; margin-bottom: 10px; color: #333; }
        .film-description { color: #666; margin-bottom: 15px; display: -webkit-box; -webkit-line-clamp: 3; -webkit-box-orient: vertical; overflow: hidden; }
        .film-details { display: flex; justify-content: space-between; font-size: 14px; color: #888; }
        .film-details span { display: flex; align-items: center; gap: 5px; }
        .back-btn { display: inline-block; margin-bottom: 20px; padding: 10px 20px; background: #667eea; color: white; text-decoration: none; border-radius: 5px; }
        .back-btn:hover { background: #5a67d8; }
    </style>
</head>
<body>
<div class="container">
    <a href="${pageContext.request.contextPath}/client/accueil" class="back-btn">
        <i class="fas fa-arrow-left"></i> Retour à l'accueil
    </a>
    
    <div class="header">
        <h1><i class="fas fa-film"></i> Films Disponibles</h1>
        <p>Découvrez notre sélection de films</p>
    </div>

    <div class="films-grid">
        <c:forEach var="film" items="${films}">
            <div class="film-card">
                <div class="film-image">
                    <i class="fas fa-film"></i>
                </div>
                <div class="film-content">
                    <div class="film-title">${film.titre}</div>
                    <div class="film-description">${film.description}</div>
                    <div class="film-details">
                        <span><i class="fas fa-clock"></i> ${film.dureeMinutes} min</span>
                       <span><i class="fas fa-language"></i> ${film.langueOriginale}</span>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    
    <c:if test="${empty films}">
        <div style="text-align: center; padding: 50px; color: #666;">
            <i class="fas fa-film" style="font-size: 48px; margin-bottom: 20px;"></i>
            <p>Aucun film disponible pour le moment.</p>
        </div>
    </c:if>
</div>
</body>
</html>