<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineManagement Pro</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/homepage.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <div class="cinema-grid">
            <!-- Section contenu -->
            <div class="content-section">
                <div class="brand">
                    <div class="brand-name">CineManagement Pro</div>
                    <div class="brand-tagline">Systeme de Gestion Cinematographique</div>
                </div>
                
                <h1>Bienvenue au Cinema</h1>
                <p class="lead-text">Accedez a votre espace pour reserver vos places et profiter des meilleures seances.</p>
                
                <div class="button-group">
                    <a href="client/accueil" class="btn-primary">
                        <i class="fas fa-film"></i> Espace Client
                    </a>
                    <a href="admin/accueil" class="btn-secondary">
                        <i class="fas fa-lock"></i> Administration
                    </a>
                </div>
            </div>

            <!-- Section visuelle -->
            <div class="visual-section">
                <div class="features-list">
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="feature-content">
                            <h3>Gestion des Seances</h3>
                            <p>Programmation et gestion complete des projections et horaires</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-ticket-alt"></i>
                        </div>
                        <div class="feature-content">
                            <h3>Billetterie Intelligente</h3>
                            <p>Systeme de reservation et vente de billets en temps reel</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="feature-content">
                            <h3>Analytics & Rapports</h3>
                            <p>Statistiques detaillees et analyse de frequentation</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>