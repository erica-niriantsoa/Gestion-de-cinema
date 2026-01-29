<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<c:set var="currentPage" value="salles" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Détails des Salles - CinéManager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-layout.css">
    <style>
        .capacity-bar {
            width: 100%;
            height: 20px;
            background: rgba(0,0,0,0.1);
            border-radius: 10px;
            overflow: hidden;
            margin-top: 5px;
        }
        .capacity-fill {
            height: 100%;
            background: linear-gradient(90deg, #27ae60, #2ecc71);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            color: white;
            font-weight: bold;
        }
        .chart-card {
            background: var(--card-bg);
            border-radius: 16px;
            padding: 24px;
            margin-top: 24px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
        }
        .chart-card h3 {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 20px;
            color: var(--text-primary);
            font-size: 18px;
        }
        .chart-card h3 i {
            color: var(--primary-color);
        }
        .bar-chart-item {
            margin-bottom: 20px;
        }
        .bar-chart-label {
            margin-bottom: 5px;
            font-weight: 600;
            color: var(--text-primary);
        }
        .bar-chart-container {
            display: flex;
            gap: 2px;
            height: 30px;
            border-radius: 8px;
            overflow: hidden;
        }
        .bar-standard {
            background: linear-gradient(135deg, #27ae60, #2ecc71);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
        }
        .bar-premium {
            background: linear-gradient(135deg, #f39c12, #e67e22);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 12px;
            font-weight: bold;
        }
        .hidden-row {
            display: none !important;
        }
    </style>
</head>
<body>
    <div class="admin-wrapper">
        <!-- Sidebar -->
        <jsp:include page="../includes/sidebar.jsp"/>
        
        <!-- Contenu Principal -->
        <main class="admin-content">
            <!-- Top Bar -->
            <header class="admin-topbar">
                <div class="topbar-left">
                    <button class="mobile-menu-toggle" onclick="toggleSidebar()">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="topbar-title">
                        <h1>Détails des Salles</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/salles">Salles</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Revenus Maximaux</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/salles" class="btn-modern btn-secondary-modern">
                        <i class="fas fa-arrow-left"></i> Retour
                    </a>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <!-- Stats Row -->
                <div class="stats-row">
                    <c:set var="totalCapacite" value="0" />
                    <c:set var="totalRevenu" value="0" />
                    <c:forEach var="revenu" items="${revenusMaximaux}">
                        <c:set var="totalCapacite" value="${totalCapacite + revenu.capacite}" />
                        <c:set var="totalRevenu" value="${totalRevenu + revenu.revenuMaximal}" />
                    </c:forEach>
                    
                    <div class="stat-card-modern">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                            <i class="fas fa-door-open"></i>
                        </div>
                        <div class="stat-info">
                            <span class="stat-label">Nombre de Salles</span>
                            <span class="stat-value" id="statCount">${revenusMaximaux.size()}</span>
                        </div>
                    </div>
                    <div class="stat-card-modern">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <span class="stat-label">Capacité Totale</span>
                            <span class="stat-value" id="statCapacite">${totalCapacite}</span>
                        </div>
                    </div>
                    <div class="stat-card-modern">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                            <i class="fas fa-coins"></i>
                        </div>
                        <div class="stat-info">
                            <span class="stat-label">Revenu Maximal Total</span>
                            <span class="stat-value" id="statRevenu">${totalRevenu} Ar</span>
                        </div>
                    </div>
                </div>
                
                <!-- Filtres -->
                <div class="filters-card">
                    <div class="filters-header">
                        <div class="filters-title">
                            <i class="fas fa-filter"></i>
                            <span>Filtres de Recherche</span>
                        </div>
                    </div>
                    <div class="filters-grid">
                        <div class="filter-group-modern">
                            <label><i class="fas fa-door-open"></i> Nom de la Salle</label>
                            <input type="text" id="filterSalle" placeholder="Ex: Salle 1">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-users"></i> Capacité Min</label>
                            <input type="number" id="filterCapaciteMin" placeholder="Ex: 50">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-users"></i> Capacité Max</label>
                            <input type="number" id="filterCapaciteMax" placeholder="Ex: 200">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-chair"></i> Places Standard Min</label>
                            <input type="number" id="filterStandardMin" placeholder="Ex: 20">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-star"></i> Places Premium Min</label>
                            <input type="number" id="filterPremiumMin" placeholder="Ex: 20">
                        </div>
                        <div class="filter-group-modern">
                            <label><i class="fas fa-coins"></i> Revenu Min (Ar)</label>
                            <input type="number" id="filterRevenuMin" placeholder="Ex: 1000000">
                        </div>
                    </div>
                    <div class="filter-actions-modern" style="margin-top: 15px;">
                        <button type="button" class="btn-modern btn-primary-modern" onclick="applyFilters()">
                            <i class="fas fa-search"></i> Appliquer
                        </button>
                        <button type="button" class="btn-modern btn-secondary-modern" onclick="resetFilters()">
                            <i class="fas fa-times"></i> Réinitialiser
                        </button>
                    </div>
                </div>
                
                <!-- Table -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-table"></i>
                            </div>
                            <h3>Détails par Salle</h3>
                        </div>
                    </div>
                    
                    <c:if test="${empty revenusMaximaux}">
                        <div class="empty-state-modern">
                            <div class="empty-icon"><i class="fas fa-door-closed"></i></div>
                            <h3>Aucune salle trouvée</h3>
                            <p>Aucune donnée de revenus maximaux disponible</p>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty revenusMaximaux}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Salle</th>
                                    <th>Capacité</th>
                                    <th>Places Standard</th>
                                    <th>Places Premium</th>
                                    <th style="text-align: right;">Revenu Maximal</th>
                                </tr>
                            </thead>
                            <tbody id="tableBody">
                                <c:forEach var="revenu" items="${revenusMaximaux}">
                                    <tr class="salle-row" 
                                        data-salle="${revenu.salleNom}"
                                        data-capacite="${revenu.capacite}"
                                        data-standard="${revenu.nbPlacesStandard}"
                                        data-premium="${revenu.nbPlacesPremium}"
                                        data-revenu="${revenu.revenuMaximal}">
                                        <td><strong style="color: var(--text-primary);">${revenu.salleNom}</strong></td>
                                        <td>
                                            <div>${revenu.capacite} places</div>
                                            <div class="capacity-bar">
                                                <div class="capacity-fill" style="width: 100%;">100%</div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="status-badge" style="background: rgba(39, 174, 96, 0.15); color: #27ae60;">
                                                <i class="fas fa-chair"></i> ${revenu.nbPlacesStandard} places
                                            </span>
                                        </td>
                                        <td>
                                            <span class="status-badge" style="background: rgba(243, 156, 18, 0.15); color: #f39c12;">
                                                <i class="fas fa-star"></i> ${revenu.nbPlacesPremium} places
                                            </span>
                                        </td>
                                        <td style="text-align: right;">
                                            <span class="status-badge" style="background: rgba(102, 126, 234, 0.15); color: #667eea; font-weight: 600;">
                                                <i class="fas fa-coins"></i> ${revenu.revenuMaximal} Ar
                                            </span>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
                
                <!-- Graphique visuel -->
                <c:if test="${not empty revenusMaximaux}">
                    <div class="chart-card">
                        <h3><i class="fas fa-chart-bar"></i> Répartition des Places</h3>
                        <c:forEach var="revenu" items="${revenusMaximaux}">
                            <div class="bar-chart-item">
                                <div class="bar-chart-label">${revenu.salleNom} - ${revenu.capacite} places</div>
                                <div class="bar-chart-container">
                                    <div class="bar-standard" style="flex: ${revenu.nbPlacesStandard};">
                                        Standard (${revenu.nbPlacesStandard})
                                    </div>
                                    <div class="bar-premium" style="flex: ${revenu.nbPlacesPremium};">
                                        Premium (${revenu.nbPlacesPremium})
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
    
    <script>
        function applyFilters() {
            const filterSalle = document.getElementById('filterSalle').value.toLowerCase();
            const filterCapaciteMin = parseFloat(document.getElementById('filterCapaciteMin').value) || 0;
            const filterCapaciteMax = parseFloat(document.getElementById('filterCapaciteMax').value) || Infinity;
            const filterStandardMin = parseFloat(document.getElementById('filterStandardMin').value) || 0;
            const filterPremiumMin = parseFloat(document.getElementById('filterPremiumMin').value) || 0;
            const filterRevenuMin = parseFloat(document.getElementById('filterRevenuMin').value) || 0;
            
            const rows = document.querySelectorAll('.salle-row');
            let visibleCount = 0;
            let totalCapacite = 0;
            let totalRevenu = 0;
            
            rows.forEach(row => {
                const salle = row.getAttribute('data-salle').toLowerCase();
                const capacite = parseFloat(row.getAttribute('data-capacite'));
                const standard = parseFloat(row.getAttribute('data-standard'));
                const premium = parseFloat(row.getAttribute('data-premium'));
                const revenu = parseFloat(row.getAttribute('data-revenu'));
                
                const matchSalle = !filterSalle || salle.includes(filterSalle);
                const matchCapacite = capacite >= filterCapaciteMin && capacite <= filterCapaciteMax;
                const matchStandard = standard >= filterStandardMin;
                const matchPremium = premium >= filterPremiumMin;
                const matchRevenu = revenu >= filterRevenuMin;
                
                if (matchSalle && matchCapacite && matchStandard && matchPremium && matchRevenu) {
                    row.classList.remove('hidden-row');
                    visibleCount++;
                    totalCapacite += capacite;
                    totalRevenu += revenu;
                } else {
                    row.classList.add('hidden-row');
                }
            });
            
            updateStats(visibleCount, totalCapacite, totalRevenu);
        }
        
        function resetFilters() {
            document.getElementById('filterSalle').value = '';
            document.getElementById('filterCapaciteMin').value = '';
            document.getElementById('filterCapaciteMax').value = '';
            document.getElementById('filterStandardMin').value = '';
            document.getElementById('filterPremiumMin').value = '';
            document.getElementById('filterRevenuMin').value = '';
            
            const rows = document.querySelectorAll('.salle-row');
            let totalCapacite = 0;
            let totalRevenu = 0;
            
            rows.forEach(row => {
                row.classList.remove('hidden-row');
                totalCapacite += parseFloat(row.getAttribute('data-capacite'));
                totalRevenu += parseFloat(row.getAttribute('data-revenu'));
            });
            
            updateStats(rows.length, totalCapacite, totalRevenu);
        }
        
        function updateStats(count, capacite, revenu) {
            document.getElementById('statCount').textContent = count;
            document.getElementById('statCapacite').textContent = capacite;
            document.getElementById('statRevenu').textContent = Math.round(revenu) + ' Ar';
        }
        
        document.getElementById('filterSalle').addEventListener('input', function() {
            if (this.value.length > 2 || this.value.length === 0) {
                applyFilters();
            }
        });
    </script>
</body>
</html>
