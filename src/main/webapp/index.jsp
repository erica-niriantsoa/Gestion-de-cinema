<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinéMax - Tableau de bord</title>
    <style>
        /* Variables CSS - Thème Cinéma */
        :root {
            --cinema-dark: #0a0e27;
            --cinema-blue: #1e3a8a;
            --cinema-red: #dc2626;
            --cinema-gold: #fbbf24;
            --cinema-purple: #7c3aed;
            --cinema-light: #f8fafc;
            --cinema-gray: #475569;
            --border-radius: 12px;
            --box-shadow: 0 10px 40px rgba(10, 14, 39, 0.2);
            --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: white;
            background: var(--cinema-dark);
            min-height: 100vh;
            position: relative;
            overflow-x: hidden;
        }

        /* Background */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 50%, rgba(124, 58, 237, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(220, 38, 38, 0.1) 0%, transparent 50%),
                radial-gradient(circle at 40% 20%, rgba(30, 58, 138, 0.1) 0%, transparent 50%);
            z-index: 0;
        }

        /* Navigation */
        .navbar {
            background: rgba(10, 14, 39, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            padding: 20px 40px;
            position: sticky;
            top: 0;
            z-index: 1000;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-logo {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .logo-icon {
            font-size: 2rem;
        }

        .logo-text {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--cinema-gold), var(--cinema-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .nav-links {
            display: flex;
            gap: 30px;
        }

        .nav-link {
            color: var(--cinema-light);
            text-decoration: none;
            padding: 10px 20px;
            border-radius: 8px;
            transition: var(--transition);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .nav-link:hover {
            background: rgba(251, 191, 36, 0.1);
            color: var(--cinema-gold);
        }

        .nav-link.active {
            background: var(--cinema-gold);
            color: var(--cinema-dark);
        }

        /* Conteneur principal */
        .container {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            padding: 30px 20px;
            position: relative;
            z-index: 2;
        }

        /* Header du tableau de bord */
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header-title {
            font-size: 2rem;
            font-weight: 700;
        }

        .header-actions {
            display: flex;
            gap: 15px;
        }

        .btn {
            padding: 12px 25px;
            border-radius: 8px;
            border: none;
            font-family: inherit;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--cinema-red), var(--cinema-purple));
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 30px rgba(220, 38, 38, 0.3);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        /* Grille principale */
        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: 25px;
            margin-bottom: 30px;
        }

        /* Cartes */
        .card {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: var(--border-radius);
            padding: 25px;
            transition: var(--transition);
        }

        .card:hover {
            border-color: var(--cinema-gold);
            transform: translateY(-5px);
            box-shadow: var(--box-shadow);
        }

        .card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .card-title {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--cinema-gold);
        }

        .card-icon {
            font-size: 2rem;
            opacity: 0.8;
        }

        /* Statistiques */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            text-align: center;
            padding: 25px;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 800;
            margin-bottom: 10px;
            background: linear-gradient(135deg, var(--cinema-gold), var(--cinema-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .stat-label {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Liste des films */
        .film-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .film-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 8px;
            transition: var(--transition);
        }

        .film-item:hover {
            background: rgba(255, 255, 255, 0.08);
        }

        .film-poster {
            width: 60px;
            height: 80px;
            background: linear-gradient(135deg, var(--cinema-purple), var(--cinema-blue));
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
        }

        .film-info {
            flex: 1;
        }

        .film-title {
            font-weight: 600;
            margin-bottom: 5px;
        }

        .film-details {
            font-size: 0.9rem;
            color: rgba(255, 255, 255, 0.6);
            display: flex;
            gap: 15px;
        }

        .film-status {
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .status-active {
            background: rgba(34, 197, 94, 0.2);
            color: #4ade80;
        }

        .status-upcoming {
            background: rgba(251, 191, 36, 0.2);
            color: var(--cinema-gold);
        }

        /* Séances */
        .seances-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .seance-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px;
            background: rgba(255, 255, 255, 0.03);
            border-radius: 8px;
        }

        .seance-time {
            font-weight: 700;
            font-size: 1.2rem;
        }

        .seance-film {
            flex: 1;
            margin-left: 20px;
        }

        .seance-salle {
            color: var(--cinema-gold);
            font-weight: 600;
        }

        .seance-places {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        /* Table */
        .table-container {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th {
            background: rgba(255, 255, 255, 0.05);
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--cinema-gold);
            border-bottom: 2px solid rgba(255, 255, 255, 0.1);
        }

        td {
            padding: 15px;
            border-bottom: 1px solid rgba(255, 255, 255, 0.05);
        }

        tr:hover {
            background: rgba(255, 255, 255, 0.03);
        }

        /* Actions */
        .actions {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 6px 12px;
            border-radius: 6px;
            border: none;
            background: rgba(255, 255, 255, 0.1);
            color: white;
            cursor: pointer;
            transition: var(--transition);
            font-size: 0.9rem;
        }

        .action-btn:hover {
            background: rgba(251, 191, 36, 0.2);
        }

        /* Footer */
        .footer {
            margin-top: 50px;
            padding: 30px;
            text-align: center;
            color: rgba(255, 255, 255, 0.5);
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .navbar {
                padding: 15px 20px;
            }
            
            .nav-links {
                gap: 10px;
            }
            
            .dashboard-grid {
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            }
        }

        @media (max-width: 768px) {
            .navbar {
                flex-direction: column;
                gap: 20px;
            }
            
            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .dashboard-header {
                flex-direction: column;
                gap: 20px;
            }
            
            .header-actions {
                flex-wrap: wrap;
                justify-content: center;
            }
            
            .film-item, .seance-item {
                flex-direction: column;
                text-align: center;
            }
            
            .seance-film {
                margin-left: 0;
                margin: 10px 0;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-logo">
            <div class="logo-icon">🎬</div>
            <div class="logo-text">CinéMax Admin</div>
        </div>
        <div class="nav-links">
            <a href="#" class="nav-link active">
                <i class="fas fa-home"></i>
                Tableau de bord
            </a>
            <a href="${pageContext.request.contextPath}/films" class="nav-link">
                <i class="fas fa-film"></i>
                Films
            </a>
            <a href="${pageContext.request.contextPath}/seances" class="nav-link">
                <i class="fas fa-calendar-alt"></i>
                Séances
            </a>
            <a href="${pageContext.request.contextPath}/salles" class="nav-link">
                <i class="fas fa-chair"></i>
                Salles
            </a>
            <a href="${pageContext.request.contextPath}/reservations" class="nav-link">
                <i class="fas fa-ticket-alt"></i>
                Réservations
            </a>
            <a href="${pageContext.request.contextPath}/utilisateurs" class="nav-link">
                <i class="fas fa-users"></i>
                Utilisateurs
            </a>
        </div>
    </nav>

    <div class="container">
        <!-- Header du tableau de bord -->
        <div class="dashboard-header">
            <h1 class="header-title">Tableau de bord</h1>
            <div class="header-actions">
                <button class="btn btn-primary">
                    <i class="fas fa-plus"></i>
                    Nouvelle séance
                </button>
                <button class="btn btn-secondary">
                    <i class="fas fa-upload"></i>
                    Importer film
                </button>
                <button class="btn btn-secondary">
                    <i class="fas fa-chart-bar"></i>
                    Rapport
                </button>
            </div>
        </div>

        <!-- Statistiques principales -->
        <div class="stats-grid">
            <div class="card stat-card">
                <div class="card-icon">🎟️</div>
                <div class="stat-value">1,247</div>
                <div class="stat-label">Réservations aujourd'hui</div>
            </div>
            <div class="card stat-card">
                <div class="card-icon">💰</div>
                <div class="stat-value">€8,450</div>
                <div class="stat-label">Chiffre d'affaires</div>
            </div>
            <div class="card stat-card">
                <div class="card-icon">🎬</div>
                <div class="stat-value">15</div>
                <div class="stat-label">Films à l'affiche</div>
            </div>
            <div class="card stat-card">
                <div class="card-icon">🪑</div>
                <div class="stat-value">82%</div>
                <div class="stat-label">Taux d'occupation</div>
            </div>
        </div>

        <!-- Grille principale -->
        <div class="dashboard-grid">
            <!-- Films à l'affiche -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Films à l'affiche</h2>
                    <div class="card-icon">🎬</div>
                </div>
                <div class="film-list">
                    <div class="film-item">
                        <div class="film-poster">🎥</div>
                        <div class="film-info">
                            <div class="film-title">Dune : Deuxième Partie</div>
                            <div class="film-details">
                                <span>2h46 • Sci-Fi</span>
                                <span>3 séances/jour</span>
                            </div>
                        </div>
                        <div class="film-status status-active">À l'affiche</div>
                    </div>
                    <div class="film-item">
                        <div class="film-poster">👽</div>
                        <div class="film-info">
                            <div class="film-title">Alien: Romulus</div>
                            <div class="film-details">
                                <span>1h55 • Horreur</span>
                                <span>4 séances/jour</span>
                            </div>
                        </div>
                        <div class="film-status status-active">À l'affiche</div>
                    </div>
                    <div class="film-item">
                        <div class="film-poster">🦸</div>
                        <div class="film-info">
                            <div class="film-title">Deadpool & Wolverine</div>
                            <div class="film-details">
                                <span>2h07 • Action</span>
                                <span>5 séances/jour</span>
                            </div>
                        </div>
                        <div class="film-status status-active">À l'affiche</div>
                    </div>
                </div>
            </div>

            <!-- Prochaines séances -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Prochaines séances</h2>
                    <div class="card-icon">⏰</div>
                </div>
                <div class="seances-list">
                    <div class="seance-item">
                        <div class="seance-time">14:30</div>
                        <div class="seance-film">
                            <div>Dune : Deuxième Partie</div>
                            <div class="seance-salle">Salle IMAX</div>
                        </div>
                        <div class="seance-places">124/250 places</div>
                    </div>
                    <div class="seance-item">
                        <div class="seance-time">16:45</div>
                        <div class="seance-film">
                            <div>Alien: Romulus</div>
                            <div class="seance-salle">Salle 7</div>
                        </div>
                        <div class="seance-places">98/120 places</div>
                    </div>
                    <div class="seance-item">
                        <div class="seance-time">19:00</div>
                        <div class="seance-film">
                            <div>Deadpool & Wolverine</div>
                            <div class="seance-salle">Salle 3D</div>
                        </div>
                        <div class="seance-places">250/250 places</div>
                    </div>
                    <div class="seance-item">
                        <div class="seance-time">21:15</div>
                        <div class="seance-film">
                            <div>Dune : Deuxième Partie</div>
                            <div class="seance-salle">Salle VIP</div>
                        </div>
                        <div class="seance-places">45/80 places</div>
                    </div>
                </div>
            </div>

            <!-- Réservations récentes -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">Réservations récentes</h2>
                    <div class="card-icon">📝</div>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Client</th>
                                <th>Film</th>
                                <th>Séance</th>
                                <th>Places</th>
                                <th>Montant</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Martin Dupont</td>
                                <td>Dune 2</td>
                                <td>14:30 - Salle IMAX</td>
                                <td>4</td>
                                <td>€56.00</td>
                            </tr>
                            <tr>
                                <td>Sophie Bernard</td>
                                <td>Alien: Romulus</td>
                                <td>16:45 - Salle 7</td>
                                <td>2</td>
                                <td>€28.00</td>
                            </tr>
                            <tr>
                                <td>Thomas Leroy</td>
                                <td>Deadpool 3</td>
                                <td>19:00 - Salle 3D</td>
                                <td>3</td>
                                <td>€45.00</td>
                            </tr>
                            <tr>
                                <td>Julie Moreau</td>
                                <td>Dune 2</td>
                                <td>21:15 - Salle VIP</td>
                                <td>2</td>
                                <td>€40.00</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Gestion des salles -->
            <div class="card">
                <div class="card-header">
                    <h2 class="card-title">État des salles</h2>
                    <div class="card-icon">🏢</div>
                </div>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>Salle</th>
                                <th>Capacité</th>
                                <th>Type</th>
                                <th>Statut</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Salle IMAX</td>
                                <td>250 places</td>
                                <td>IMAX 3D</td>
                                <td><span class="film-status status-active">Disponible</span></td>
                                <td class="actions">
                                    <button class="action-btn">Modifier</button>
                                    <button class="action-btn">Maintenance</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Salle VIP</td>
                                <td>80 places</td>
                                <td>Premium</td>
                                <td><span class="film-status status-active">Disponible</span></td>
                                <td class="actions">
                                    <button class="action-btn">Modifier</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Salle 3D</td>
                                <td>200 places</td>
                                <td>3D</td>
                                <td><span class="film-status status-active">Disponible</span></td>
                                <td class="actions">
                                    <button class="action-btn">Modifier</button>
                                </td>
                            </tr>
                            <tr>
                                <td>Salle 4</td>
                                <td>150 places</td>
                                <td>Standard</td>
                                <td><span class="film-status status-upcoming">Maintenance</span></td>
                                <td class="actions">
                                    <button class="action-btn">Réparer</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- Films à venir -->
        <div class="card">
            <div class="card-header">
                <h2 class="card-title">Films à venir</h2>
                <div class="card-icon">📅</div>
            </div>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>Titre</th>
                            <th>Date de sortie</th>
                            <th>Durée</th>
                            <th>Genre</th>
                            <th>Statut</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Venom: The Last Dance</td>
                            <td>25/10/2024</td>
                            <td>2h15</td>
                            <td>Action/Sci-Fi</td>
                            <td><span class="film-status status-upcoming">Programmé</span></td>
                            <td class="actions">
                                <button class="action-btn">Planifier</button>
                                <button class="action-btn">Détails</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Joker: Folie à Deux</td>
                            <td>04/10/2024</td>
                            <td>2h45</td>
                            <td>Drame/Musical</td>
                            <td><span class="film-status status-upcoming">Programmé</span></td>
                            <td class="actions">
                                <button class="action-btn">Planifier</button>
                                <button class="action-btn">Détails</button>
                            </td>
                        </tr>
                        <tr>
                            <td>Gladiator 2</td>
                            <td>22/11/2024</td>
                            <td>2h30</td>
                            <td>Action/Drame</td>
                            <td><span class="film-status status-upcoming">Programmé</span></td>
                            <td class="actions">
                                <button class="action-btn">Planifier</button>
                                <button class="action-btn">Détails</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <div class="footer">
        <p>© 2024 CinéMax - Système de gestion de cinéma</p>
        <p>Dernière mise à jour : <%= new java.util.Date() %></p>
        <p>Version 2.1.0 • Serveur : Production</p>
    </div>

    <script>
        // Animation pour les cartes
        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-5px)';
            });
            
            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0)';
            });
        });

        // Gestion des boutons d'action
        document.querySelectorAll('.action-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                alert('Action: ' + this.textContent);
            });
        });

        // Mise à jour de l'heure
        function updateTime() {
            const now = new Date();
            document.querySelector('.footer p:nth-child(2)').textContent = 
                `Dernière mise à jour : ${now.toLocaleDateString('fr-FR')} ${now.toLocaleTimeString('fr-FR')}`;
        }
        
        setInterval(updateTime, 60000);
        updateTime();
    </script>
</body>
</html>