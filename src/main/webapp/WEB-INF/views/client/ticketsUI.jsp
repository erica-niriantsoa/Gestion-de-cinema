<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Tickets UI</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/client.css">
</head>
<body>
    <div class="container">
        <div class="hero">
            <div class="hero-content">
                <h1 class="hero-title"><i class="fas fa-ticket-alt"></i> Tickets UI</h1>
                <p class="hero-subtitle">Liste dynamique des tickets</p>
            </div>
        </div>
        
        <div class="card">
            <div id="loader" class="alert alert-info">
                <i class="fas fa-spinner fa-spin"></i> Chargement...
            </div>
            <div class="table-wrapper" style="display:none" id="tableContainer">
                <table class="table" id="ticketsTable">
                    <thead>
                        <tr>
                            <th>Film</th>
                            <th>Séance</th>
                            <th>Place</th>
                            <th>Catégorie</th>
                            <th>Prix</th>
                            <th>Statut</th>
                        </tr>
                    </thead>
                    <tbody id="ticketsBody"></tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        async function loadTickets(){
            const res = await fetch(window.location.pathname.replace('/tickets-ui','') + '/tickets/json');
            const data = await res.json();
            const tbody = document.getElementById('ticketsBody');
            tbody.innerHTML='';
            data.forEach(t=>{
                const tr = document.createElement('tr');
                tr.innerHTML = `
                    <td>${t.film||''}</td>
                    <td>${t.seanceDebut||''}</td>
                    <td>${t.place||''}</td>
                    <td>${t.categorie||''}</td>
                    <td>${t.prix!=null?t.prix + ' €': ''}</td>
                    <td>${t.statut?'<span class="badge '+(t.statut.toLowerCase().includes('pay')? 'payee':'reserve')+'">'+t.statut+'</span>':''}</td>
                `;
                tbody.appendChild(tr);
            });
            document.getElementById('loader').style.display='none';
            document.getElementById('tableContainer').style.display='block';
        }
        loadTickets().catch(e=>{
            const loader = document.getElementById('loader');
            loader.className = 'alert alert-danger';
            loader.innerHTML = '<i class="fas fa-exclamation-circle"></i> Erreur: '+e.message;
        });
    </script>
</body>
</html>
