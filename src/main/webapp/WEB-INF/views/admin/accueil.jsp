<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="dashboard" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - CinéManager Admin</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-layout.css">
</head>
<body>
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <jsp:include page="includes/sidebar.jsp"/>
        
        <!-- Contenu Principal -->
        <main class="admin-content">
            <!-- Top Bar -->
            <header class="admin-topbar">
                <div class="topbar-left">
                    <button class="mobile-menu-toggle" onclick="toggleSidebar()">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="topbar-title">
                        <h1>Tableau de bord</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil">
                                <i class="fas fa-home"></i> Accueil
                            </a>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <div class="topbar-search">
                        <i class="fas fa-search"></i>
                        <input type="text" placeholder="Rechercher...">
                    </div>
                    <div class="topbar-actions">
                        <button class="topbar-btn" title="Notifications">
                            <i class="fas fa-bell"></i>
                            <span class="notification-dot"></span>
                        </button>
                        <button class="topbar-btn" title="Paramètres">
                            <i class="fas fa-cog"></i>
                        </button>
                    </div>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <!-- Statistiques -->
                <div class="stats-row">
                    <div class="stat-card-modern films">
                        <div class="stat-header-modern">
                            <div class="stat-icon-modern">
                                <i class="fas fa-film"></i>
                            </div>
                            <div class="stat-trend-modern up">
                                <i class="fas fa-arrow-up"></i> +12%
                            </div>
                        </div>
                        <div class="stat-value-modern">${nbFilms}</div>
                        <div class="stat-label-modern">
                            <span>Films au catalogue</span>
                        </div>
                    </div>
                    
                    <div class="stat-card-modern salles">
                        <div class="stat-header-modern">
                            <div class="stat-icon-modern">
                                <i class="fas fa-door-open"></i>
                            </div>
                            <div class="stat-trend-modern up">
                                <i class="fas fa-check"></i> Actives
                            </div>
                        </div>
                        <div class="stat-value-modern">${nbSalles}</div>
                        <div class="stat-label-modern">
                            <span>Salles disponibles</span>
                        </div>
                    </div>
                    
                    <div class="stat-card-modern seances">
                        <div class="stat-header-modern">
                            <div class="stat-icon-modern">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                            <div class="stat-trend-modern up">
                                <i class="fas fa-arrow-up"></i> +8%
                            </div>
                        </div>
                        <div class="stat-value-modern">${nbSeances}</div>
                        <div class="stat-label-modern">
                            <span>Séances programmées</span>
                        </div>
                    </div>
                    
                    <div class="stat-card-modern revenus">
                        <div class="stat-header-modern">
                            <div class="stat-icon-modern">
                                <i class="fas fa-euro-sign"></i>
                            </div>
                            <div class="stat-trend-modern up">
                                <i class="fas fa-arrow-up"></i> +25%
                            </div>
                        </div>
                        <div class="stat-value-modern">--</div>
                        <div class="stat-label-modern">
                            <span>Revenus du mois</span>
                        </div>
                    </div>
                </div>
                
                <!-- Actions Rapides -->
                <h3 style="color: var(--text-primary); margin-bottom: 20px; font-size: 1.25rem;">
                    <i class="fas fa-bolt" style="color: var(--secondary-color);"></i> Actions rapides
                </h3>
                <div class="quick-actions-grid">
                    <a href="${pageContext.request.contextPath}/admin/films/nouveau" class="quick-action-card">
                        <div class="quick-action-icon">
                            <i class="fas fa-plus"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Nouveau Film</h4>
                            <p>Ajouter un film au catalogue</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/seances/nouveau" class="quick-action-card">
                        <div class="quick-action-icon">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Nouvelle Séance</h4>
                            <p>Programmer une projection</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/salles/nouveau" class="quick-action-card">
                        <div class="quick-action-icon">
                            <i class="fas fa-door-open"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Nouvelle Salle</h4>
                            <p>Créer une nouvelle salle</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/publicite" class="quick-action-card">
                        <div class="quick-action-icon">
                            <i class="fas fa-chart-bar"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Voir Statistiques</h4>
                            <p>Chiffre d'affaires & analytics</p>
                        </div>
                    </a>
                </div>
                
                <!-- Liens vers les modules -->
                <h3 style="color: var(--text-primary); margin: 32px 0 20px; font-size: 1.25rem;">
                    <i class="fas fa-th-large" style="color: var(--secondary-color);"></i> Modules de gestion
                </h3>
                <div class="quick-actions-grid">
                    <a href="${pageContext.request.contextPath}/admin/films" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(231, 76, 60, 0.15); color: #e74c3c;">
                            <i class="fas fa-film"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Gestion des Films</h4>
                            <p>Ajouter, modifier ou supprimer des films</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/salles" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(52, 152, 219, 0.15); color: #3498db;">
                            <i class="fas fa-door-open"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Gestion des Salles</h4>
                            <p>Gérer les salles et leur capacité</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/seances" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(243, 156, 18, 0.15); color: #f39c12;">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Gestion des Séances</h4>
                            <p>Créer et planifier les projections</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/tickets" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(39, 174, 96, 0.15); color: #27ae60;">
                            <i class="fas fa-ticket-alt"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Tickets</h4>
                            <p>Consulter tous les billets vendus</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/client/reservationDetail" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(155, 89, 182, 0.15); color: #9b59b6;">
                            <i class="fas fa-bookmark"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Réservations</h4>
                            <p>Consulter toutes les réservations</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/publicite" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(233, 30, 99, 0.15); color: #e91e63;">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Publicité & Finances</h4>
                            <p>Chiffre d'affaires mensuel</p>
                        </div>
                    </a>
                </div>
            </div>
        </main>
    </div>
</body>
</html>