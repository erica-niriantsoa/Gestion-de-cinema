<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="currentPage" value="publicite" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CA par Séance et Société - CinéManager</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin-layout.css">
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
                        <h1>CA par Séance et Société</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/publicite">Publicité</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Par Société</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/publicite/seance-affichage" class="btn-modern btn-secondary-modern">
                        <i class="fas fa-chart-pie"></i> Vue Complète
                    </a>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <c:if test="${not empty error}">
                    <div class="alert-modern error">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                
                <!-- Filtres -->
                <div class="filters-card">
                    <div class="filters-header">
                        <div class="filters-title">
                            <i class="fas fa-filter"></i>
                            <span>Filtres</span>
                        </div>
                    </div>
                    <form method="get" action="${pageContext.request.contextPath}/admin/publicite/seance-societe">
                        <div class="filters-grid">
                            <div class="filter-group-modern">
                                <label><i class="fas fa-building"></i> Société</label>
                                <select name="societe">
                                    <option value="">-- Toutes --</option>
                                    <option value="Vaniala" <c:if test="${societeFiltree eq 'Vaniala'}">selected</c:if>>Vaniala</option>
                                    <option value="Lewis" <c:if test="${societeFiltree eq 'Lewis'}">selected</c:if>>Lewis</option>
                                </select>
                            </div>
                            <div class="filter-group-modern">
                                <label><i class="fas fa-calendar"></i> Mois</label>
                                <input type="month" name="mois" value="${moisFiltre}">
                            </div>
                            <div class="filter-actions-modern">
                                <button type="submit" class="btn-modern btn-primary-modern">
                                    <i class="fas fa-search"></i> Filtrer
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/publicite/seance-societe" class="btn-modern btn-secondary-modern">
                                    <i class="fas fa-times"></i> Réinitialiser
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- Table -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-building"></i>
                            </div>
                            <h3>Chiffre d'affaires par Société</h3>
                        </div>
                    </div>
                    
                    <c:if test="${empty caPubliSeances}">
                        <div class="empty-state-modern">
                            <div class="empty-icon"><i class="fas fa-search"></i></div>
                            <h3>Aucune donnée trouvée</h3>
                            <p>Modifiez vos filtres pour voir les résultats</p>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty caPubliSeances}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Film</th>
                                    <th>Date</th>
                                    <th>Heure</th>
                                    <th>Société</th>
                                    <th style="text-align: right;">CA Diffusion</th>
                                    <th style="text-align: center;">% Payé</th>
                                    <th style="text-align: right;">Montant Payé</th>
                                    <th style="text-align: right;">Reste à Payer</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="seance" items="${caPubliSeances}">
                                    <tr>
                                        <td><strong style="color: var(--text-primary);">${seance.film}</strong></td>
                                        <td>${seance.dateDiffusion}</td>
                                        <td>${seance.heureDiffusion}</td>
                                        <td><span class="status-badge" style="background: rgba(102, 126, 234, 0.15); color: #667eea;">${seance.societe}</span></td>
                                        <td style="text-align: right; font-family: monospace;">
                                            <fmt:formatNumber value="${seance.caDiffusion}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                        <td style="text-align: center;">
                                            <span class="status-badge" style="background: rgba(52, 152, 219, 0.15); color: #3498db;">
                                                <fmt:formatNumber value="${seance.pourcentagePaye}" type="number" maxFractionDigits="2" />%
                                            </span>
                                        </td>
                                        <td style="text-align: right; font-family: monospace; color: #27ae60;">
                                            <fmt:formatNumber value="${seance.montantPayeDiffusion}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                        <td style="text-align: right; font-family: monospace; color: #e74c3c;">
                                            <fmt:formatNumber value="${seance.resteAPayerDiffusion}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </c:if>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
