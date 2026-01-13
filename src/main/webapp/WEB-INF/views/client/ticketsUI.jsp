<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8" />
    <title>Tickets UI</title>
    <style>
        body{font-family:Segoe UI,Arial;background:#f6f8fb;padding:20px}
        table{width:100%;border-collapse:collapse;background:#fff}
        th,td{padding:10px;border:1px solid #e6e9ef;text-align:left}
        th{background:#f0f4f8}
        .badge{display:inline-block;padding:4px 8px;border-radius:6px;font-size:12px}
        .payee{background:#d4edda;color:#155724}
        .reserve{background:#fff3cd;color:#856404}
    </style>
</head>
<body>
    <h1>Liste des Tickets (UI dynamique)</h1>
    <div id="loader">Chargement...</div>
    <table id="ticketsTable" style="display:none">
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
            document.getElementById('ticketsTable').style.display='table';
        }
        loadTickets().catch(e=>{document.getElementById('loader').innerText='Erreur: '+e.message});
    </script>
</body>
</html>
