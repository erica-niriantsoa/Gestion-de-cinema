<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CinéMax - Gestion de Cinéma</title>
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
            --border-radius: 16px;
            --box-shadow: 0 20px 60px rgba(10, 14, 39, 0.3);
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
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

        /* Background animé */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: 
                radial-gradient(circle at 20% 50%, rgba(124, 58, 237, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 80% 80%, rgba(220, 38, 38, 0.15) 0%, transparent 50%),
                radial-gradient(circle at 40% 20%, rgba(30, 58, 138, 0.15) 0%, transparent 50%);
            animation: gradient 15s ease infinite;
            z-index: 0;
        }

        @keyframes gradient {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.8; }
        }

        /* Étoiles décoratives */
        .stars {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            z-index: 1;
        }

        .star {
            position: absolute;
            width: 2px;
            height: 2px;
            background: white;
            border-radius: 50%;
            animation: twinkle 3s infinite;
        }

        @keyframes twinkle {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 1; }
        }

        /* Conteneur principal */
        .container {
            width: 100%;
            max-width: 1400px;
            margin: 0 auto;
            padding: 40px 20px;
            position: relative;
            z-index: 2;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        /* En-tête avec logo */
        .header {
            text-align: center;
            margin-bottom: 60px;
        }

        .logo {
            font-size: 4rem;
            margin-bottom: 10px;
            animation: float 3s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        h1 {
            font-size: 3.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--cinema-gold), var(--cinema-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 15px;
            text-shadow: 0 0 30px rgba(251, 191, 36, 0.3);
        }

        .subtitle {
            font-size: 1.3rem;
            color: var(--cinema-light);
            opacity: 0.8;
            font-weight: 300;
        }

        /* Section principale */
        .main-content {
            display: flex;
            gap: 40px;
            align-items: center;
            margin-top: 40px;
        }

        /* Carte de présentation */
        .welcome-card {
            flex: 1;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: var(--border-radius);
            padding: 50px;
            box-shadow: var(--box-shadow);
        }

        .welcome-title {
            font-size: 2rem;
            margin-bottom: 20px;
            color: var(--cinema-gold);
        }

        .welcome-text {
            font-size: 1.1rem;
            line-height: 1.8;
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 30px;
        }

        /* Bouton principal */
        .cta-btn {
            display: inline-flex;
            align-items: center;
            gap: 15px;
            background: linear-gradient(135deg, var(--cinema-red), var(--cinema-purple));
            color: white;
            padding: 20px 50px;
            border-radius: 50px;
            text-decoration: none;
            font-size: 1.2rem;
            font-weight: 700;
            transition: var(--transition);
            box-shadow: 0 10px 40px rgba(220, 38, 38, 0.4);
            position: relative;
            overflow: hidden;
        }

        .cta-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.6s;
        }

        .cta-btn:hover {
            transform: translateY(-5px) scale(1.05);
            box-shadow: 0 20px 60px rgba(220, 38, 38, 0.6);
        }

        .cta-btn:hover::before {
            left: 100%;
        }

        .cta-icon {
            font-size: 1.8rem;
            animation: pulse 2s infinite;
        }

        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.1); }
        }

        /* Carte de statistiques */
        .stats-card {
            flex: 1;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 20px;
        }

        .stat-item {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: var(--border-radius);
            padding: 30px;
            text-align: center;
            transition: var(--transition);
        }

        .stat-item:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.08);
            border-color: var(--cinema-gold);
        }

        .stat-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }

        .stat-value {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, var(--cinema-gold), var(--cinema-red));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 10px;
        }

        .stat-label {
            font-size: 1rem;
            color: rgba(255, 255, 255, 0.7);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        /* Caractéristiques */
        .features {
            margin-top: 60px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        .feature-item {
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: var(--border-radius);
            padding: 30px;
            transition: var(--transition);
        }

        .feature-item:hover {
            transform: translateY(-10px);
            background: rgba(255, 255, 255, 0.08);
        }

        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 15px;
        }

        .feature-title {
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--cinema-gold);
        }

        .feature-desc {
            color: rgba(255, 255, 255, 0.7);
            line-height: 1.6;
        }

        /* Responsive */
        @media (max-width: 1024px) {
            .main-content {
                flex-direction: column;
            }

            h1 {
                font-size: 2.5rem;
            }

            .welcome-card {
                padding: 40px;
            }
        }

        @media (max-width: 768px) {
            h1 {
                font-size: 2rem;
            }

            .subtitle {
                font-size: 1rem;
            }

            .stats-card {
                grid-template-columns: 1fr;
            }

            .welcome-card {
                padding: 30px;
            }

            .cta-btn {
                padding: 18px 40px;
                font-size: 1.1rem;
            }
        }

        @media (max-width: 480px) {
            .logo {
                font-size: 3rem;
            }

            h1 {
                font-size: 1.8rem;
            }

            .features {
                grid-template-columns: 1fr;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700;800&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Étoiles décoratives -->
    <div class="stars">
        <div class="star" style="top: 10%; left: 20%;"></div>
        <div class="star" style="top: 20%; left: 80%; animation-delay: 1s;"></div>
        <div class="star" style="top: 60%; left: 10%; animation-delay: 2s;"></div>
        <div class="star" style="top: 80%; left: 70%; animation-delay: 0.5s;"></div>
        <div class="star" style="top: 30%; left: 50%; animation-delay: 1.5s;"></div>
    </div>

    <div class="container">
        <!-- En-tête -->
        <div class="header">
            <div class="logo">🎬</div>
            <h1>CinéMax</h1>
            <p class="subtitle">Votre expérience cinéma commence ici</p>
        </div>

        <!-- Contenu principal -->
        <div class="main-content">
            <!-- Carte de bienvenue -->
            <div class="welcome-card">
                <h2 class="welcome-title">Bienvenue au CinéMax</h2>
                <p class="welcome-text">
                    Découvrez notre sélection de films exceptionnels. Des blockbusters aux films d'art et d'essai, 
                    vivez une expérience cinématographique inoubliable dans nos salles ultramodernes.
                </p>
                <a href="${pageContext.request.contextPath}/films" class="cta-btn">
                    <span class="cta-icon">🎥</span>
                    <span>Découvrir nos films</span>
                </a>
            </div>

            <!-- Statistiques -->
            <div class="stats-card">
                <div class="stat-item">
                    <div class="stat-icon">🎞️</div>
                    <div class="stat-value">120+</div>
                    <div class="stat-label">Films</div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon">🪑</div>
                    <div class="stat-value">15</div>
                    <div class="stat-label">Salles</div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon">⭐</div>
                    <div class="stat-value">4.8/5</div>
                    <div class="stat-label">Satisfaction</div>
                </div>
                <div class="stat-item">
                    <div class="stat-icon">🎟️</div>
                    <div class="stat-value">500K+</div>
                    <div class="stat-label">Spectateurs</div>
                </div>
            </div>
        </div>

        <!-- Caractéristiques -->
        <div class="features">
            <div class="feature-item">
                <div class="feature-icon">🎭</div>
                <div class="feature-title">Tous les genres</div>
                <p class="feature-desc">Action, comédie, drame, science-fiction et bien plus encore</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">🍿</div>
                <div class="feature-title">Confort optimal</div>
                <p class="feature-desc">Sièges premium et expérience VIP disponibles</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">📱</div>
                <div class="feature-title">Réservation facile</div>
                <p class="feature-desc">Réservez vos places en quelques clics</p>
            </div>
            <div class="feature-item">
                <div class="feature-icon">🎬</div>
                <div class="feature-title">Qualité IMAX</div>
                <p class="feature-desc">Image et son de qualité cinématographique</p>
            </div>
        </div>
    </div>

    <script>
        // Créer des étoiles supplémentaires dynamiquement
        const starsContainer = document.querySelector('.stars');
        for (let i = 0; i < 50; i++) {
            const star = document.createElement('div');
            star.className = 'star';
            star.style.top = Math.random() * 100 + '%';
            star.style.left = Math.random() * 100 + '%';
            star.style.animationDelay = Math.random() * 3 + 's';
            starsContainer.appendChild(star);
        }
    </script>
</body>
</html>