<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détails des Salles - Revenus Maximaux</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        .stats-card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }
        .stat-item {
            background: rgba(255,255,255,0.2);
            padding: 15px;
            border-radius: 8px;
            text-align: center;
        }
        .stat-value {
            font-size: 24px;
            font-weight: bold;
            margin: 5px 0;
        }
        .stat-label {
            font-size: 12px;
            opacity: 0.9;
        }
        .revenu-badge {
            background: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-weight: bold;
        }
        .capacity-bar {
            width: 100%;
            height: 20px;
            background: #f0f0f0;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 5px;
        }
        .capacity-fill {
            height: 100%;
            background: linear-gradient(90deg, #4CAF50, #45a049);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 11px;
            color: white;
            font-weight: bold;
        }
        .filter-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .filter-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-top: 15px;
        }
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        .filter-group label {
            font-size: 14px;
            font-weight: 500;
            margin-bottom: 5px;
            color: #333;
        }
        .filter-group input, .filter-group select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
        }
        .filter-actions {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }
        .btn-filter {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s;
        }
        .btn-apply {
            background: #667eea;
            color: white;
        }
        .btn-apply:hover {
            background: #5568d3;
        }
        .btn-reset {
            background: #e0e0e0;
            color: #333;
        }
        .btn-reset:hover {
            background: #d0d0d0;
        }
        .hidden-row {
            display: none !important;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="${pageContext.request.contextPath}/admin/salles" class="back-link">
            <i class="fas fa-arrow-left"></i> Retour à la liste des salles
        </a>
        
        <div class="header">
            <div class="header-content">
                <div class="header-title">
                    <i class="fas fa-chart-line"></i>
                    <h1>Détails des Salles - Revenus Maximaux</h1>
                </div>
            </div>
        </div>
        
        <!-- Section de filtres -->
        <div class="filter-section">
            <h3><i class="fas fa-filter"></i> Filtres de Recherche</h3>
            <div class="filter-grid">
                <div class="filter-group">
                    <label for="filterSalle">Nom de la Salle</label>
                    <input type="text" id="filterSalle" placeholder="Ex: Salle 1">
                </div>
                
                <div class="filter-group">
                    <label for="filterCapaciteMin">Capacité Min</label>
                    <input type="number" id="filterCapaciteMin" placeholder="Ex: 50">
                </div>
                
                <div class="filter-group">
                    <label for="filterCapaciteMax">Capacité Max</label>
                    <input type="number" id="filterCapaciteMax" placeholder="Ex: 200">
                </div>
                
                <div class="filter-group">
                    <label for="filterStandardMin">Places Standard Min</label>
                    <input type="number" id="filterStandardMin" placeholder="Ex: 20">
                </div>
                
                <div class="filter-group">
                    <label for="filterPremiumMin">Places Premium Min</label>
                    <input type="number" id="filterPremiumMin" placeholder="Ex: 20">
                </div>
                
                <div class="filter-group">
                    <label for="filterRevenuMin">Revenu Min (AR)</label>
                    <input type="number" id="filterRevenuMin" placeholder="Ex: 1000000">
                </div>
            </div>
            
            <div class="filter-actions">
                <button class="btn-filter btn-apply" onclick="applyFilters()">
                    <i class="fas fa-search"></i> Appliquer les filtres
                </button>
                <button class="btn-filter btn-reset" onclick="resetFilters()">
                    <i class="fas fa-times"></i> Réinitialiser
                </button>
            </div>
        </div>
        
        <!-- Statistiques globales -->
        <div class="stats-card">
            <h3><i class="fas fa-chart-pie"></i> Statistiques Globales</h3>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-label">Nombre de Salles</div>
                    <div class="stat-value">${revenusMaximaux.size()}</div>
                </div>
                <div class="stat-item">
                    <div class="stat-label">Capacité Totale</div>
                    <div class="stat-value">
                        <c:set var="totalCapacite" value="0" />
                        <c:forEach var="revenu" items="${revenusMaximaux}">
                            <c:set var="totalCapacite" value="${totalCapacite + revenu.capacite}" />
                        </c:forEach>
                        ${totalCapacite}
                    </div>
                </div>
                <div class="stat-item">
                    <div class="stat-label">Revenu Maximal Total</div>
                    <div class="stat-value">
                        <c:set var="totalRevenu" value="0" />
                        <c:forEach var="revenu" items="${revenusMaximaux}">
                            <c:set var="totalRevenu" value="${totalRevenu + revenu.revenuMaximal}" />
                        </c:forEach>
                        ${totalRevenu} AR
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Tableau des détails -->
        <div class="card">
            <h3><i class="fas fa-table"></i> Détails par Salle</h3>
            
            <div class="table-wrapper">
                <table>
                    <thead>
                        <tr>
                            <th>Salle</th>
                            <th>Capacité</th>
                            <th>Places Standard</th>
                            <th>Places Premium</th>
                            <th>Revenu Maximal</th>
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
                                <td>
                                    <strong>${revenu.salleNom}</strong>
                                </td>
                                <td>
                                    <div>${revenu.capacite} places</div>
                                    <div class="capacity-bar">
                                        <div class="capacity-fill" style="width: 100%;">
                                            100%
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge badge-info">
                                        <i class="fas fa-chair"></i> ${revenu.nbPlacesStandard} places
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-warning">
                                        <i class="fas fa-star"></i> ${revenu.nbPlacesPremium} places
                                    </span>
                                </td>
                                <td>
                                    <span class="revenu-badge">
                                        <i class="fas fa-coins"></i> ${revenu.revenuMaximal} AR
                                    </span>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        
        <!-- Graphique visuel -->
        <div class="card">
            <h3><i class="fas fa-chart-bar"></i> Répartition des Places</h3>
            <div style="padding: 20px;">
                <c:forEach var="revenu" items="${revenusMaximaux}">
                    <div style="margin-bottom: 20px;">
                        <div style="margin-bottom: 5px;">
                            <strong>${revenu.salleNom}</strong> - ${revenu.capacite} places
                        </div>
                        <div style="display: flex; gap: 2px; height: 30px;">
                            <div style="flex: ${revenu.nbPlacesStandard}; background: #4CAF50; display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; font-weight: bold;">
                                Standard (${revenu.nbPlacesStandard})
                            </div>
                            <div style="flex: ${revenu.nbPlacesPremium}; background: #FF9800; display: flex; align-items: center; justify-content: center; color: white; font-size: 12px; font-weight: bold;">
                                Premium (${revenu.nbPlacesPremium})
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
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
            
            // Mise à jour des statistiques
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
            const statItems = document.querySelectorAll('.stat-value');
            if (statItems.length >= 3) {
                statItems[0].textContent = count;
                statItems[1].textContent = capacite;
                statItems[2].textContent = Math.round(revenu) + ' AR';
            }
        }
        
        // Filtrage en temps réel sur le nom de salle
        document.getElementById('filterSalle').addEventListener('input', function() {
            if (this.value.length > 2 || this.value.length === 0) {
                applyFilters();
            }
        });
    </script>
</body>
</html>
