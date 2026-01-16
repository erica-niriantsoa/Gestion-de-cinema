<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineManagement Pro</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">
</head>
</head>
<body>
    <div class="container">
        <div class="cinema-grid">
            <!-- Section contenu -->
            <div class="content-section">
                <div class="brand">
                    <div class="brand-name">CineManagement Pro</div>
                    <div class="brand-tagline">Système de Gestion Cinématographique</div>
                </div>
                
                <h1>Bienvenue au Cinéma</h1>
                <p class="lead-text">Accédez à votre espace pour réserver vos places et profiter des meilleures séances.</p>
                
                <div style="margin-bottom: 30px;">
                    <a href="${pageContext.request.contextPath}/client/accueil" class="btn-primary">
                        🎬 Espace Client
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/accueil" class="btn-secondary">
                        🔐 Administration
                    </a>
                </div>
            </div>

            <!-- Section visuelle -->
            <div class="visual-section">
                <div class="features-list">
                    <div class="feature-item">
                        <div class="feature-icon">🎬</div>
                        <div class="feature-content">
                            <h3>Gestion des Séances</h3>
                            <p>Programmation et gestion complète des projections et horaires</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">🎫</div>
                        <div class="feature-content">
                            <h3>Billetterie Intelligente</h3>
                            <p>Système de réservation et vente de billets en temps réel</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">📊</div>
                        <div class="feature-content">
                            <h3>Analytics & Rapports</h3>
                            <p>Statistiques détaillées et analyse de fréquentation</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>