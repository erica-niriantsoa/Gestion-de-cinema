<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineManagement Pro</title>
    <style>
        /* Variables CSS - Palette Cinema */
        :root {
            --primary: #0A0E17;
            --secondary: #C41E3A;
            --accent: #FFD700;
            --accent-dark: #B8860B;
            --light: #FFF9F0;
            --dark: #1A1A1A;
            --gray: #8C7E6E;
            --gray-light: #E8E0D5;
            --screen-glow: rgba(255, 215, 0, 0.1);
            --border-radius: 16px;
            --box-shadow: 0 8px 30px rgba(10, 14, 23, 0.15);
            --transition: all 0.3s ease;
        }

        /* Reset et styles de base */
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, var(--primary) 0%, #1a1f2e 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
            color: var(--light);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            width: 100%;
        }

        /* Layout principal */
        .cinema-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 60px;
            align-items: center;
        }

        /* Section contenu */
        .content-section {
            padding: 40px 0;
        }

        .brand {
            margin-bottom: 50px;
        }

        .brand-name {
            font-size: 2.8rem;
            font-weight: 700;
            color: var(--accent);
            margin-bottom: 8px;
            letter-spacing: 1px;
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.3);
        }

        .brand-tagline {
            color: var(--gray-light);
            font-size: 1.1rem;
            font-weight: 500;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        h1 {
            font-size: 3.2rem;
            font-weight: 700;
            color: white;
            margin-bottom: 25px;
            line-height: 1.2;
        }

        .lead-text {
            font-size: 1.2rem;
            color: var(--gray-light);
            margin-bottom: 40px;
            line-height: 1.6;
            max-width: 400px;
        }

        /* Bouton principal */
        .btn-primary {
            display: inline-block;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            color: var(--primary);
            padding: 18px 45px;
            border-radius: var(--border-radius);
            text-decoration: none;
            font-weight: 700;
            font-size: 1.1rem;
            transition: var(--transition);
            box-shadow: 0 6px 20px rgba(196, 30, 58, 0.4);
            margin-bottom: 40px;
            letter-spacing: 1px;
            border: 2px solid transparent;
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px rgba(196, 30, 58, 0.6);
            border-color: var(--accent);
        }

        /* Indicateur de statut */
        .status-indicator {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px 20px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--border-radius);
            border-left: 4px solid var(--accent);
            backdrop-filter: blur(10px);
        }

        .status-dot {
            width: 10px;
            height: 10px;
            background: var(--accent);
            border-radius: 50%;
            animation: pulse 2s infinite;
            box-shadow: 0 0 10px var(--accent);
        }

        .status-text {
            color: var(--gray-light);
            font-size: 0.9rem;
            font-weight: 500;
        }

        @keyframes pulse {
            0% { 
                opacity: 1;
                box-shadow: 0 0 10px var(--accent);
            }
            50% { 
                opacity: 0.5;
                box-shadow: 0 0 20px var(--accent);
            }
            100% { 
                opacity: 1;
                box-shadow: 0 0 10px var(--accent);
            }
        }

        /* Section visuelle */
        .visual-section {
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--border-radius);
            padding: 50px;
            box-shadow: var(--box-shadow);
            border: 1px solid rgba(255, 215, 0, 0.1);
            position: relative;
            backdrop-filter: blur(10px);
            overflow: hidden;
        }

        .visual-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 6px;
            background: linear-gradient(90deg, var(--secondary), var(--accent));
            border-radius: var(--border-radius) var(--border-radius) 0 0;
        }

        .visual-section::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, var(--screen-glow) 0%, transparent 70%);
            animation: rotate 20s linear infinite;
            z-index: -1;
        }

        @keyframes rotate {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .features-list {
            margin-top: 10px;
        }

        .feature-item {
            display: flex;
            align-items: flex-start;
            gap: 20px;
            padding: 25px;
            margin-bottom: 20px;
            background: rgba(255, 255, 255, 0.08);
            border-radius: var(--border-radius);
            border: 1px solid rgba(255, 215, 0, 0.1);
            transition: var(--transition);
            position: relative;
            z-index: 1;
        }

        .feature-item:hover {
            transform: translateX(10px);
            border-color: var(--accent);
            background: rgba(255, 215, 0, 0.05);
        }

        .feature-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, var(--secondary), var(--accent));
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary);
            font-size: 1.3rem;
            flex-shrink: 0;
            font-weight: bold;
        }

        .feature-content h3 {
            font-size: 1.2rem;
            font-weight: 600;
            color: var(--accent);
            margin-bottom: 8px;
        }

        .feature-content p {
            color: var(--gray-light);
            line-height: 1.5;
            font-size: 0.95rem;
        }

        /* Animation */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes screenGlow {
            0%, 100% { opacity: 0.5; }
            50% { opacity: 0.8; }
        }

        .content-section > * {
            animation: fadeInUp 0.6s ease-out;
            animation-fill-mode: both;
        }

        .brand { animation-delay: 0.1s; }
        h1 { animation-delay: 0.2s; }
        .lead-text { animation-delay: 0.3s; }
        .btn-primary { animation-delay: 0.4s; }
        .status-indicator { animation-delay: 0.5s; }

        .feature-item:nth-child(1) { animation: fadeInUp 0.6s ease-out 0.6s both; }
        .feature-item:nth-child(2) { animation: fadeInUp 0.6s ease-out 0.7s both; }
        .feature-item:nth-child(3) { animation: fadeInUp 0.6s ease-out 0.8s both; }

        /* Responsive */
        @media (max-width: 968px) {
            .cinema-grid {
                grid-template-columns: 1fr;
                gap: 40px;
            }
            
            .content-section {
                text-align: center;
                padding: 20px 0;
            }
            
            .lead-text {
                margin: 0 auto 40px;
            }
            
            h1 {
                font-size: 2.5rem;
            }
        }

        @media (max-width: 480px) {
            .visual-section {
                padding: 30px 20px;
            }
            
            .feature-item {
                flex-direction: column;
                text-align: center;
                padding: 20px;
            }
            
            .brand-name {
                font-size: 2rem;
            }
            
            h1 {
                font-size: 2rem;
            }
        }

        /* Effet projecteur */
        .spotlight {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            pointer-events: none;
            background: radial-gradient(
                circle at var(--x, 50%) var(--y, 50%),
                transparent 100px,
                rgba(0, 0, 0, 0.95) 300px
            );
            z-index: -1;
        }
    </style>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <!-- Effet projecteur -->
    <div class="spotlight" id="spotlight"></div>

    <div class="container">
        <div class="cinema-grid">
            <!-- Section contenu -->
            <div class="content-section">
                <div class="brand">
                    <div class="brand-name">CineManagement Pro</div>
                    <div class="brand-tagline">Systeme de Gestion Cinematographique</div>
                </div>
                
                <h1>Bienvenue au Cinema</h1>
                <p class="lead-text">Accedez a votre espace de gestion professionnel pour optimiser l'experience cinematographique et simplifier votre exploitation.</p>
                
                <a href="${pageContext.request.contextPath}/entrer" class="btn-primary">Acceder au Systeme</a>

                <div class="status-indicator">
                    <div class="status-dot"></div>
                    <div class="status-text">Systeme en ligne - Prêt a projeter</div>
                </div>
                
                <div style="margin-top: 20px; opacity: 0.6;">
                    <a href="${pageContext.request.contextPath}/admin/accueil" style="color: var(--accent); text-decoration: none; font-size: 0.9rem;">
                        🔐 Espace Administration
                    </a>
                </div>
            </div>

            <!-- Section visuelle -->
            <div class="visual-section">
                <div class="features-list">
                    <div class="feature-item">
                        <div class="feature-icon"></div>
                        <div class="feature-content">
                            <h3>Gestion des Seances</h3>
                            <p>Programmation et gestion complete des projections et horaires</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon"></div>
                        <div class="feature-content">
                            <h3>Billetterie Intelligente</h3>
                            <p>Systeme de reservation et vente de billets en temps reel</p>
                        </div>
                    </div>
                    
                    <div class="feature-item">
                        <div class="feature-icon"></div>
                        <div class="feature-content">
                            <h3>Analytics & Rapports</h3>
                            <p>Statistiques detaillees et analyse de frequentation</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Effet projecteur qui suit la souris
        const spotlight = document.getElementById('spotlight');
        
        document.addEventListener('mousemove', (e) => {
            const x = (e.clientX / window.innerWidth) * 100;
            const y = (e.clientY / window.innerHeight) * 100;
            spotlight.style.setProperty('--x', `${x}%`);
            spotlight.style.setProperty('--y', `${y}%`);
        });

        // Effet d'eclairage sur les elements au survol
        document.querySelectorAll('.feature-item, .btn-primary').forEach(element => {
            element.addEventListener('mouseenter', (e) => {
                const rect = e.target.getBoundingClientRect();
                const x = ((rect.left + rect.width / 2) / window.innerWidth) * 100;
                const y = ((rect.top + rect.height / 2) / window.innerHeight) * 100;
                
                spotlight.style.setProperty('--x', `${x}%`);
                spotlight.style.setProperty('--y', `${y}%`);
                spotlight.style.background = `radial-gradient(
                    circle at ${x}% ${y}%,
                    transparent 100px,
                    rgba(0, 0, 0, 0.85) 300px
                )`;
            });

            element.addEventListener('mouseleave', () => {
                setTimeout(() => {
                    spotlight.style.background = `radial-gradient(
                        circle at var(--x, 50%) var(--y, 50%),
                        transparent 100px,
                        rgba(0, 0, 0, 0.95) 300px
                    )`;
                }, 500);
            });
        });
    </script>
</body>
</html>