<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${pageTitle}</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background:#f5f7fa; padding:20px }
        .card { max-width:700px; margin:0 auto; background:white; padding:20px; border-radius:8px; box-shadow:0 6px 18px rgba(0,0,0,0.06) }
        .row { display:flex; gap:10px; margin-bottom:12px }
        label { flex:0 0 140px; font-weight:600 }
        input, select { flex:1; padding:8px; border:1px solid #ddd; border-radius:4px }
        .actions { text-align:right }
        .btn { padding:10px 16px; border-radius:6px; border:none; cursor:pointer }
        .btn-primary { background:#007bff; color:white }
        .btn-secondary { background:#6c757d; color:white }
    </style>
</head>
<body>
<div class="card">
    <h2>Réservation — ${seance.film.titre}</h2>
    <p><strong>Date :</strong> ${seance.debutFormatted} &nbsp; <strong>Salle :</strong> ${seance.salle.nom}</p>

    <form id="reservationForm" method="post" action="${pageContext.request.contextPath}/client/seances/${seance.id}/reserver/simple">
        <input type="hidden" name="seanceId" value="${seance.id}" />
        <div class="row">
            <label>Nombre de places</label>
            <select id="nbPlaces" name="nbPlaces">
                <option value="1">1</option>
                <option value="2">2</option>
                <option value="3">3</option>
                <option value="4">4</option>
            </select>
        </div>
        <div class="row">
            <label>Catégorie</label>
            <select id="categorie" name="categorieId">
                <c:forEach var="cat" items="${categories}">
                    <option value="${cat.id}">${cat.libelle}</option>
                </c:forEach>
            </select>
        </div>
        <div class="row">
            <label>Nom complet</label>
            <input type="text" name="nom_complet" placeholder="Votre nom" />
        </div>
        <div class="row">
            <label>Email</label>
            <input type="email" name="email" placeholder="votre@email.com" />
        </div>
        <div class="actions">
            <button type="button" class="btn btn-secondary" onclick="history.back()">Annuler</button>
            <button type="button" class="btn btn-primary" onclick="goToMap()">Choisir les places</button>
            <button type="submit" class="btn btn-primary" style="margin-left:8px">Confirmer</button>
        </div>
    </form>
    <p style="margin-top:12px; font-size:13px; color:#666">Cliquez sur "Choisir les places" pour ouvrir le plan de salle et sélectionner des places.</p>
</div>

    <script>
    function goToMap() {
        const seanceId = ${seance.id};
        const nb = document.getElementById('nbPlaces').value;
        const cat = document.getElementById('categorie').value;
        const name = document.querySelector('input[name="nom_complet"]').value;
        const email = document.querySelector('input[name="email"]').value;

        const base = `${location.origin}${pageContext.request.contextPath}`;
        const params = new URLSearchParams();
        params.set('prefillNb', nb);
        params.set('prefillCategorieId', cat);
        if (name) params.set('prefillName', name);
        if (email) params.set('prefillEmail', email);

        window.location.href = base + '/client/seances/' + seanceId + '/reserver/form?' + params.toString();
    }
    </script>
</body>
</html>
