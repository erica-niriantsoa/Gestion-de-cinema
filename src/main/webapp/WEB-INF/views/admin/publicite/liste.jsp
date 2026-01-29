<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="currentPage" value="publicite" scope="request"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Publicités - CinéManager</title>
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
                        <h1>Gestion des Publicités</h1>
                        <div class="breadcrumb">
                            <a href="${pageContext.request.contextPath}/admin/accueil"><i class="fas fa-home"></i></a>
                            <i class="fas fa-chevron-right"></i>
                            <span>Publicités</span>
                        </div>
                    </div>
                </div>
                <div class="topbar-right">
                    <a href="${pageContext.request.contextPath}/admin/publicite/nouveau" class="btn-modern btn-primary-modern">
                        <i class="fas fa-plus"></i> Nouvelle Publicité
                    </a>
                </div>
            </header>
            
            <!-- Page Content -->
            <div class="admin-page">
                <c:if test="${not empty success}">
                    <div class="alert-modern success">
                        <i class="fas fa-check-circle"></i> ${success}
                    </div>
                </c:if>
                <c:if test="${not empty error}">
                    <div class="alert-modern error">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                    </div>
                </c:if>
                
                <!-- Quick Actions -->
                <div class="quick-actions-grid" style="margin-bottom: 32px;">
                    <a href="${pageContext.request.contextPath}/admin/publicite/seance-societe" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(102, 126, 234, 0.15); color: #667eea;">
                            <i class="fas fa-building"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Par Société</h4>
                            <p>CA par séance et société</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/publicite/seance-affichage" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(39, 174, 96, 0.15); color: #27ae60;">
                            <i class="fas fa-chart-pie"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Vue Complète</h4>
                            <p>Total des revenues (tickets + pub)</p>
                        </div>
                    </a>
                    
                    <a href="${pageContext.request.contextPath}/admin/accueil" class="quick-action-card">
                        <div class="quick-action-icon" style="background: rgba(243, 156, 18, 0.15); color: #f39c12;">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <div class="quick-action-text">
                            <h4>Tableau de Bord</h4>
                            <p>Retour au dashboard principal</p>
                        </div>
                    </a>
                </div>
                
                <!-- Table du solde publicité -->
                <div class="data-table-container">
                    <div class="data-table-header">
                        <div class="data-table-title">
                            <div class="table-icon">
                                <i class="fas fa-chart-bar"></i>
                            </div>
                            <h3>Solde publicité par mois</h3>
                        </div>
                    </div>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>Mois</th>
                                <th>Société</th>
                                <th style="text-align: right;">Chiffre d'affaire</th>
                                <th style="text-align: right;">Total payé</th>
                                <th style="text-align: right;">Reste à payer</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="s" items="${chiffres}">
                                <tr>
                                    <td><strong style="color: var(--text-primary);">${s.mois}</strong></td>
                                    <td>${s.societe}</td>
                                    <td style="text-align: right; font-family: monospace;">${s.chiffreAffaire}</td>
                                    <td style="text-align: right; font-family: monospace; color: #27ae60;">${s.totalPaye}</td>
                                    <td style="text-align: right; font-family: monospace; color: #e74c3c;">${s.resteAPayer}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>