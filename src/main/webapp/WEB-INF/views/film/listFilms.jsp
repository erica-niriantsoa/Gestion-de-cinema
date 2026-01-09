<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Films</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
        }

        h1 {
            color: white;
            text-align: center;
            margin-bottom: 30px;
            font-size: 2.5em;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .films-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 25px;
            padding: 20px 0;
        }

        .film-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .film-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
        }

        .film-poster {
            width: 100%;
            height: 350px;
            object-fit: cover;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 1.2em;
        }

        .film-poster img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .film-info {
            padding: 20px;
        }

        .film-title {
            font-size: 1.4em;
            font-weight: bold;
            color: #333;
            margin-bottom: 10px;
        }

        .film-meta {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 10px;
        }

        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 0.85em;
            font-weight: 600;
        }

        .badge-genre {
            background: #667eea;
            color: white;
        }

        .badge-duree {
            background: #f093fb;
            color: white;
        }

        .badge-age {
            background: #ffa726;
            color: white;
        }

        .film-description {
            color: #666;
            font-size: 0.95em;
            line-height: 1.5;
            margin-bottom: 10px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .film-realisateur {
            color: #888;
            font-size: 0.9em;
            font-style: italic;
            margin-bottom: 10px;
        }

        .film-date {
            color: #999;
            font-size: 0.85em;
        }

        .no-films {
            background: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            color: #666;
            font-size: 1.2em;
        }

        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            padding: 8px 15px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 0.85em;
        }

        .status-affiche {
            background: #4caf50;
            color: white;
        }

        .status-non-affiche {
            background: #f44336;
            color: white;
        }

        .film-card {
            position: relative;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🎬 Films Disponibles</h1>
        
        <c:choose>
            <c:when test="${not empty films}">
                <div class="films-grid">
                    <c:forEach var="film" items="${films}">
                        <div class="film-card">
                            <c:if test="${film.estAffiche}">
                                <span class="status-badge status-affiche">À l'affiche</span>
                            </c:if>
                            <c:if test="${!film.estAffiche}">
                                <span class="status-badge status-non-affiche">Non affiché</span>
                            </c:if>
                            
                            <div class="film-poster">
                                <c:choose>
                                    <c:when test="${not empty film.afficheUrl}">
                                        <img src="${film.afficheUrl}" alt="${film.titre}">
                                    </c:when>
                                    <c:otherwise>
                                        🎥
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            
                            <div class="film-info">
                                <div class="film-title">${film.titre}</div>
                                
                                <div class="film-meta">
                                    <c:if test="${not empty film.genre}">
                                        <span class="badge badge-genre">${film.genre}</span>
                                    </c:if>
                                    <span class="badge badge-duree">${film.dureeMinutes} min</span>
                                    <span class="badge badge-age">${film.ageMin}+</span>
                                </div>
                                
                                <c:if test="${not empty film.description}">
                                    <div class="film-description">${film.description}</div>
                                </c:if>
                                
                                <c:if test="${not empty film.realisateur}">
                                    <div class="film-realisateur">Par ${film.realisateur}</div>
                                </c:if>
                                
                                <c:if test="${not empty film.dateSortie}">
                                    <div class="film-date">Sortie: ${film.dateSortie}</div>
                                </c:if>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="no-films">
                    Aucun film disponible pour le moment.
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
