<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib uri="jakarta.tags.core" prefix="c" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>Espace Admin - Cinéma</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
        </head>

        <body>
            <div class="container">
                <div class="header">
                    <h1><i class="fas fa-user-shield"></i> Espace Administration</h1>
                    <p class="text-muted">Gestion complète du cinéma</p>
                </div>

                <div class="stats-grid">
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-film"></i>
                            </div>
                        </div>
                        <div class="stat-number">${nbFilms}</div>
                        <div class="stat-label">Films</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-door-open"></i>
                            </div>
                        </div>
                        <div class="stat-number">${nbSalles}</div>
                        <div class="stat-label">Salles</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-header">
                            <div class="stat-icon">
                                <i class="fas fa-calendar-alt"></i>
                            </div>
                        </div>
                        <div class="stat-number">${nbSeances}</div>
                        <div class="stat-label">Séances</div>
                    </div>
                </div>

                <div class="menu-grid">
                    <a href="${pageContext.request.contextPath}/admin/films" class="menu-card">
                        <div class="menu-icon icon-film">
                            <i class="fas fa-film"></i>
                        </div>
                        <div class="menu-title">Gestion des Films</div>
                        <div class="menu-description">Ajouter, modifier ou supprimer des films au catalogue</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/salles" class="menu-card">
                        <div class="menu-icon icon-salle">
                            <i class="fas fa-door-open"></i>
                        </div>
                        <div class="menu-title">Gestion des Salles</div>
                        <div class="menu-description">Gérer les salles et leur capacité</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/seances" class="menu-card">
                        <div class="menu-icon icon-seance">
                            <i class="fas fa-calendar-alt"></i>
                        </div>
                        <div class="menu-title">Gestion des Séances</div>
                        <div class="menu-description">Créer et planifier les séances de projection</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/client/reservationDetail" class="menu-card">
                        <div class="menu-icon icon-client">
                            <i class="fas fa-ticket-alt"></i>
                        </div>
                        <div class="menu-title">Réservations</div>
                        <div class="menu-description">Consulter toutes les réservations</div>
                    </a>

                    <a href="${pageContext.request.contextPath}/admin/tickets" class="menu-card">
                        <div class="menu-icon icon-client">
                            <i class="fas fa-tags"></i>
                        </div>
                        <div class="menu-title">Tickets</div>
                        <div class="menu-description">Consulter tous les billets vendus</div>
                    </a>
                    <a href="${pageContext.request.contextPath}/admin/publicite" class="menu-card">
                        <div class="menu-icon icon-client">
                            <i class="fas fa-tags"></i>
                        </div>
                        <div class="menu-title">Gestion de publicite</div>
                        <div class="menu-description">Consulter tous le chifre d'affaire selon le mois</div>
                    </a>
                </div>

                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                        <i class="fas fa-home"></i> Retour à l'accueil
                    </a>
                </div>
            </div>
        </body>

        </html>