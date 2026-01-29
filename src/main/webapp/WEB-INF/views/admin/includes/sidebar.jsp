<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<!-- Sidebar -->
<aside class="admin-sidebar" id="adminSidebar">
    <a href="${pageContext.request.contextPath}/admin/accueil" class="sidebar-brand">
        <div class="brand-icon">
            <i class="fas fa-film"></i>
        </div>
        <div class="brand-text">
            <span class="brand-title">CinéManager</span>
            <span class="brand-subtitle">Administration</span>
        </div>
    </a>
    
    <nav class="sidebar-nav">
        <div class="nav-section">
            <div class="nav-section-title">Menu Principal</div>
            
            <a href="${pageContext.request.contextPath}/admin/accueil" 
               class="nav-item ${currentPage == 'dashboard' ? 'active' : ''}" 
               data-section="dashboard">
                <span class="nav-icon"><i class="fas fa-th-large"></i></span>
                <span class="nav-text">Tableau de bord</span>
            </a>
        </div>
        
        <div class="nav-section">
            <div class="nav-section-title">Gestion</div>
            
            <a href="${pageContext.request.contextPath}/admin/films" 
               class="nav-item ${currentPage == 'films' ? 'active' : ''}" 
               data-section="films">
                <span class="nav-icon"><i class="fas fa-film"></i></span>
                <span class="nav-text">Films</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/salles" 
               class="nav-item ${currentPage == 'salles' ? 'active' : ''}" 
               data-section="salles">
                <span class="nav-icon"><i class="fas fa-door-open"></i></span>
                <span class="nav-text">Salles</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/admin/seances" 
               class="nav-item ${currentPage == 'seances' ? 'active' : ''}" 
               data-section="seances">
                <span class="nav-icon"><i class="fas fa-calendar-alt"></i></span>
                <span class="nav-text">Séances</span>
            </a>
        </div>
        
        <div class="nav-section">
            <div class="nav-section-title">Ventes</div>
            
            <a href="${pageContext.request.contextPath}/admin/tickets" 
               class="nav-item ${currentPage == 'tickets' ? 'active' : ''}" 
               data-section="tickets">
                <span class="nav-icon"><i class="fas fa-ticket-alt"></i></span>
                <span class="nav-text">Tickets</span>
            </a>
            
            <a href="${pageContext.request.contextPath}/client/reservationDetail" 
               class="nav-item ${currentPage == 'reservations' ? 'active' : ''}" 
               data-section="reservations">
                <span class="nav-icon"><i class="fas fa-bookmark"></i></span>
                <span class="nav-text">Réservations</span>
            </a>
        </div>
        
        <div class="nav-section">
            <div class="nav-section-title">Finance</div>
            
            <a href="${pageContext.request.contextPath}/admin/publicite" 
               class="nav-item ${currentPage == 'publicite' ? 'active' : ''}" 
               data-section="publicite">
                <span class="nav-icon"><i class="fas fa-chart-line"></i></span>
                <span class="nav-text">Publicité & CA</span>
            </a>
        </div>
    </nav>
    
    <div class="sidebar-footer">
        <div class="sidebar-user">
            <div class="user-avatar">
                <i class="fas fa-user-shield"></i>
            </div>
            <div class="user-info">
                <div class="user-name">Administrateur</div>
                <div class="user-role">Super Admin</div>
            </div>
            <a href="${pageContext.request.contextPath}/" class="btn-logout" title="Retour à l'accueil">
                <i class="fas fa-sign-out-alt"></i>
            </a>
        </div>
    </div>
</aside>

<!-- Overlay pour mobile -->
<div class="sidebar-overlay" id="sidebarOverlay" onclick="toggleSidebar()"></div>

<script>
    function toggleSidebar() {
        document.getElementById('adminSidebar').classList.toggle('open');
        document.getElementById('sidebarOverlay').classList.toggle('active');
    }
</script>
