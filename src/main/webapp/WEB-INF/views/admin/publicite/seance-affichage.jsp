<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="currentPage" value="publicite" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CA Total par Séance - CinéManager</title>
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
                        <h1>CA Total par Séance</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <a href="${pageContext.request.contextPath}/admin/publicite">Publicité</a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Vue Complète</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/publicite/seance-societe" class="btn-modern btn-secondary-modern">
                        <i class="fas fa-building"></i> Par Société
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
                    <form method="get" action="${pageContext.request.contextPath}/admin/publicite/seance-affichage">
                        <div class="filters-grid">
                            <div class="filter-group-modern">
                                <label><i class="fas fa-calendar"></i> Mois</label>
                                <input type="month" name="mois" value="${moisFiltre}">
                            </div>
                            <div class="filter-actions-modern">
                                <button type="submit" class="btn-modern btn-primary-modern">
                                    <i class="fas fa-search"></i> Filtrer
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/publicite/seance-affichage" class="btn-modern btn-secondary-modern">
                                    <i class="fas fa-times"></i> Réinitialiser
                                </a>
                            </div>
                        </div>
                    </form>
                </div>
                
                <!-- Stats Summary -->
                <c:if test="${not empty caSeances}">
                    <c:set var="totalMontantTicket" value="0" />
                    <c:set var="totalMontantPubTotal" value="0" />
                    <c:set var="totalMontantPubPaye" value="0" />
                    <c:set var="totalMontantPubRestant" value="0" />
                    <c:set var="totalMontantExtra" value="0" />
                    <c:set var="totalCaTotal" value="0" />
                    <c:set var="totalCaEncaisse" value="0" />
                    <c:set var="totalCaRestant" value="0" />
                    
                    <c:forEach var="seance" items="${caSeances}">
                        <c:set var="totalMontantTicket" value="${totalMontantTicket + seance.montantTicket}" />
                        <c:set var="totalMontantPubTotal" value="${totalMontantPubTotal + seance.montantPubTotal}" />
                        <c:set var="totalMontantPubPaye" value="${totalMontantPubPaye + seance.montantPubPaye}" />
                        <c:set var="totalMontantPubRestant" value="${totalMontantPubRestant + seance.montantPubRestant}" />
                        <c:set var="totalMontantExtra" value="${totalMontantExtra + seance.montantExtra}" />
                        <c:set var="totalCaTotal" value="${totalCaTotal + seance.caTotal}" />
                        <c:set var="totalCaEncaisse" value="${totalCaEncaisse + seance.caEncaisse}" />
                        <c:set var="totalCaRestant" value="${totalCaRestant + seance.caRestant}" />
                    </c:forEach>
                    
                    <div class="stats-row">
                        <div class="stat-card-modern">
                            <div class="stat-icon" style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);">
                                <i class="fas fa-ticket-alt"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-label">Total Tickets</span>
                                <span class="stat-value"><fmt:formatNumber value="${totalMontantTicket}" type="number" maxFractionDigits="0" /> Ar</span>
                            </div>
                        </div>
                        <div class="stat-card-modern">
                            <div class="stat-icon" style="background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);">
                                <i class="fas fa-ad"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-label">Total Publicités</span>
                                <span class="stat-value"><fmt:formatNumber value="${totalMontantPubTotal}" type="number" maxFractionDigits="0" /> Ar</span>
                            </div>
                        </div>
                        <div class="stat-card-modern">
                            <div class="stat-icon" style="background: linear-gradient(135deg, #ff9a56 0%, #ff6b6b 100%);">
                                <i class="fas fa-utensils"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-label">Total Extras</span>
                                <span class="stat-value"><fmt:formatNumber value="${totalMontantExtra}" type="number" maxFractionDigits="0" /> Ar</span>
                            </div>
                        </div>
                        <div class="stat-card-modern">
                            <div class="stat-icon" style="background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);">
                                <i class="fas fa-coins"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-label">CA Total</span>
                                <span class="stat-value"><fmt:formatNumber value="${totalCaTotal}" type="number" maxFractionDigits="0" /> Ar</span>
                            </div>
                        </div>
                        <div class="stat-card-modern">
                            <div class="stat-icon" style="background: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-label">CA Encaissé</span>
                                <span class="stat-value"><fmt:formatNumber value="${totalCaEncaisse}" type="number" maxFractionDigits="0" /> Ar</span>
                            </div>
                        </div>
                        <div class="stat-card-modern">
                            <div class="stat-icon" style="background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);">
                                <i class="fas fa-hourglass-half"></i>
                            </div>
                            <div class="stat-info">
                                <span class="stat-label">CA en Attente</span>
                                <span class="stat-value"><fmt:formatNumber value="${totalCaRestant}" type="number" maxFractionDigits="0" /> Ar</span>
                            </div>
                        </div>
                    </div>
                </c:if>
                
                <!-- Table -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <h3>Détail par Séance (Tickets + Publicités + Extras)</h3>
                        </div>
                    </div>
                    
                    <c:if test="${empty caSeances}">
                        <div class="empty-state-modern">
                            <div class="empty-icon"><i class="fas fa-search"></i></div>
                            <h3>Aucune donnée trouvée</h3>
                            <p>Modifiez vos filtres pour voir les résultats</p>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty caSeances}">
                        <table class="data-table">
                            <thead>
                                <tr>
                                    <th>Film</th>
                                    <th>Date</th>
                                    <th>Heure</th>
                                    <th style="text-align: right; background: rgba(102, 126, 234, 0.3);">Montant Tickets</th>
                                    <th style="text-align: right; background: rgba(240, 147, 251, 0.3);">Pub Total</th>
                                    <th style="text-align: right; background: rgba(240, 147, 251, 0.3);">Pub Payée</th>
                                    <th style="text-align: right; background: rgba(240, 147, 251, 0.3);">Pub Restant</th>
                                    <th style="text-align: right; background: rgba(255, 154, 86, 0.3);">Extras</th>
                                    <th style="text-align: right; background: rgba(17, 153, 142, 0.3);">CA Total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="seance" items="${caSeances}">
                                    <tr>
                                        <td><strong style="color: var(--text-primary);">${seance.film}</strong></td>
                                        <td>${seance.dateDiffusion}</td>
                                        <td>${seance.heureDiffusion}</td>
                                        <td style="text-align: right; font-family: monospace; color: #27ae60; font-weight: 600;">
                                            <fmt:formatNumber value="${seance.montantTicket}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                        <td style="text-align: right; font-family: monospace;">
                                            <fmt:formatNumber value="${seance.montantPubTotal}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                        <td style="text-align: right; font-family: monospace; color: #27ae60;">
                                            <fmt:formatNumber value="${seance.montantPubPaye}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                        <td style="text-align: right; font-family: monospace; color: #e67e22;">
                                            <fmt:formatNumber value="${seance.montantPubRestant}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                        <td style="text-align: right; font-family: monospace; color: #ff6b6b;">
                                            <fmt:formatNumber value="${seance.montantExtra}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
                                        </td>
                                        <td style="text-align: right; font-family: monospace; font-weight: bold; background: rgba(17, 153, 142, 0.1);">
                                            <fmt:formatNumber value="${seance.caTotal}" type="currency" currencySymbol="Ar " maxFractionDigits="2" />
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
