<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Espace Admin - Cinéma</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; padding: 20px; }
        .container { max-width: 1200px; margin: 0 auto; }
        .header { background: white; padding: 30px; border-radius: 15px; margin-bottom: 30px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); text-align: center; }
        h1 { color: #333; margin-bottom: 10px; }
        .subtitle { color: #666; font-size: 16px; }
        .stats { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 25px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); text-align: center; }
        .stat-number { font-size: 36px; font-weight: bold; color: #667eea; margin-bottom: 5px; }
        .stat-label { color: #666; font-size: 14px; }
        .grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 25px; }
        .card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); transition: all 0.3s; text-decoration: none; color: inherit; display: block; }
        .card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.2); }
        .card-icon { font-size: 48px; margin-bottom: 15px; }
        .card-title { font-size: 22px; font-weight: bold; margin-bottom: 10px; color: #333; }
        .card-desc { color: #666; font-size: 14px; line-height: 1.6; }
        .icon-film { color: #e74c3c; }
        .icon-salle { color: #3498db; }
        .icon-seance { color: #f39c12; }
        .icon-tarif { color: #27ae60; }
        .icon-client { color: #9b59b6; }
        .back-link { display: inline-block; background: white; color: #667eea; padding: 12px 25px; border-radius: 8px; text-decoration: none; margin-top: 20px; font-weight: bold; transition: all 0.3s; }
        .back-link:hover { background: #667eea; color: white; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1><i class="fas fa-user-shield"></i> Espace Administration</h1>
            <p class="subtitle">Gestion complète du cinéma</p>
        </div>
        
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">${nbFilms}</div>
                <div class="stat-label">Films</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${nbSalles}</div>
                <div class="stat-label">Salles</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">${nbSeances}</div>
                <div class="stat-label">Séances</div>
            </div>
        </div>
        
        <div class="grid">
            <a href="${pageContext.request.contextPath}/admin/films" class="card">
                <div class="card-icon icon-film">
                    <i class="fas fa-film"></i>
                </div>
                <div class="card-title">Gestion des Films</div>
                <div class="card-desc">Ajouter, modifier ou supprimer des films au catalogue</div>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/salles" class="card">
                <div class="card-icon icon-salle">
                    <i class="fas fa-door-open"></i>
                </div>
                <div class="card-title">Gestion des Salles</div>
                <div class="card-desc">Gérer les salles et leur capacité</div>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/seances" class="card">
                <div class="card-icon icon-seance">
                    <i class="fas fa-calendar-alt"></i>
                </div>
                <div class="card-title">Gestion des Séances</div>
                <div class="card-desc">Créer et planifier les séances de projection</div>
            </a>
            
            <a href="${pageContext.request.contextPath}/client/reservationDetail" class="card">
                <div class="card-icon icon-client">
                    <i class="fas fa-ticket-alt"></i>
                </div>
                <div class="card-title">Réservations & Tickets</div>
                <div class="card-desc">Consulter toutes les réservations et billets vendus</div>
            </a>
        </div>
        
        <center>
            <a href="${pageContext.request.contextPath}/" class="back-link">
                <i class="fas fa-home"></i> Retour à l'accueil
            </a>
        </center>
    </div>
</body>
</html>
