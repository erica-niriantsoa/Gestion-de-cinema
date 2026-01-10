<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Business Management Suite</title>
    <style>
        /* Variables CSS - Palette Dark Fire & Sand */
        :root {
            --dark-fire: #52130C;
            --dark-fire-light: #6B2A23;
            --sand: #FFECD1;
            --sand-dark: #E8D4B9;
            --accent: #C44536;
            --accent-light: #D67A6F;
            --chocolate: #3E000C;
            --chocolate-light: #5A1A24;
            --light: #FFF9F0;
            --dark: #2C1810;
            --gray: #8C7E6E;
            --gray-light: #E8E0D5;
            --border-radius: 12px;
            --box-shadow: 0 8px 30px rgba(82, 19, 12, 0.08);
            --transition: all 0.3s ease;
        }

        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', 'Segoe UI', sans-serif;
            line-height: 1.6;
            color: var(--dark);
            background: linear-gradient(135deg, var(--sand) 0%, var(--light) 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            overflow: hidden;
        }

        /* Conteneur principal */
        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        /* Carte principale */
        .card {
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--box-shadow);
            padding: 80px 60px;
            width: 100%;
            max-width: 1000px;
            margin: 0 auto;
            text-align: center;
            border: 1px solid var(--sand-dark);
            position: relative;
        }

        .card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--dark-fire), var(--chocolate));
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        /* En-tête */
        h1 {
            font-size: 3rem;
            font-weight: 700;
            color: var(--dark-fire);
            margin-bottom: 60px;
            line-height: 1.2;
        }

        /* Grille de boutons */
        .btn-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
            margin-top: 40px;
        }

        /* Boutons d'action */
        .action-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: white;
            color: var(--dark);
            padding: 40px 30px;
            border-radius: var(--border-radius);
            text-decoration: none;
            transition: var(--transition);
            border: 2px solid var(--sand-dark);
            cursor: pointer;
            min-height: 200px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
            position: relative;
            overflow: hidden;
        }

        .action-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(82, 19, 12, 0.03), transparent);
            transition: left 0.7s;
        }

        .action-btn:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 40px rgba(82, 19, 12, 0.15);
            border-color: transparent;
        }

        .action-btn:hover::before {
            left: 100%;
        }

        /* Icônes des boutons */
        .btn-icon {
            width: 70px;
            height: 70px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 20px;
            background: linear-gradient(135deg, var(--dark-fire), var(--chocolate));
            transition: var(--transition);
        }

        .action-btn:hover .btn-icon {
            transform: scale(1.1);
        }

        .icon-svg {
            width: 32px;
            height: 32px;
            fill: var(--sand);
        }

        /* Textes des boutons */
        .btn-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 12px;
            color: var(--dark-fire);
            transition: var(--transition);
        }

        .btn-desc {
            font-size: 1rem;
            color: var(--gray);
            line-height: 1.5;
            max-width: 200px;
        }

        /* Couleurs spécifiques pour chaque bouton */
        .btn-job {
            border-left: 4px solid var(--dark-fire);
        }

        .btn-job:hover .btn-title {
            color: var(--dark-fire);
        }

        .btn-rh {
            border-left: 4px solid var(--chocolate);
        }

        .btn-rh:hover .btn-title {
            color: var(--chocolate);
        }

        .btn-manager {
            border-left: 4px solid var(--accent);
        }

        .btn-manager:hover .btn-title {
            color: var(--accent);
        }

        /* Indicateurs visuels */
        .action-btn::after {
            content: '→';
            position: absolute;
            bottom: 25px;
            right: 30px;
            font-size: 1.2rem;
            color: var(--gray);
            opacity: 0;
            transition: var(--transition);
            transform: translateX(-10px);
        }

        .action-btn:hover::after {
            opacity: 1;
            transform: translateX(0);
            color: var(--dark-fire);
        }

        /* Animation d'entrée */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .action-btn {
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }

        .action-btn:nth-child(1) { animation-delay: 0.1s; }
        .action-btn:nth-child(2) { animation-delay: 0.2s; }
        .action-btn:nth-child(3) { animation-delay: 0.3s; }

        /* Responsive */
        @media (max-width: 768px) {
            .card {
                padding: 60px 30px;
            }
            
            h1 {
                font-size: 2.2rem;
                margin-bottom: 40px;
            }
            
            .btn-grid {
                grid-template-columns: 1fr;
                gap: 20px;
            }
            
            .action-btn {
                min-height: 160px;
                padding: 30px 25px;
            }
        }

        @media (max-width: 480px) {
            .card {
                padding: 40px 20px;
            }
            
            h1 {
                font-size: 1.8rem;
            }
            
            .btn-title {
                font-size: 1.2rem;
            }
            
            .btn-icon {
                width: 60px;
                height: 60px;
            }
            
            .icon-svg {
                width: 28px;
                height: 28px;
            }
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <div class="card">
            <h1>Bienvenue sur la page d'accueil</h1>
            
            <div class="btn-grid">
                <a href="${pageContext.request.contextPath}/client/accueil" class="action-btn btn-rh">
                    <div class="btn-icon">
                        <svg class="icon-svg" viewBox="0 0 24 24">
                            <path d="M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z"/>
                        </svg>
                    </div>
                    <span class="btn-title">Espace Client</span>
                </a>
                
                <a href="${pageContext.request.contextPath}/acceuilAdmin" class="action-btn btn-manager">
                    <div class="btn-icon">
                        <svg class="icon-svg" viewBox="0 0 24 24">
                            <path d="M19 3H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zM9 17H7v-7h2v7zm4 0h-2V7h2v10zm4 0h-2v-4h2v4z"/>
                        </svg>
                    </div>
                    <span class="btn-title">Espace Admin</span>
                </a>
            </div>
        </div>
    </div>
</body>
</html>