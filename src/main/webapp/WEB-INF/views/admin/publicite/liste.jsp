<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Solde publicité par mois</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        h1 { color: #333; margin-bottom: 20px; }
        table { border-collapse: collapse; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 10px; text-align: center; }
        th { background-color: #f0f0f0; }
        .actions { margin-top: 20px; }
        .btn { display: inline-block; padding: 10px 15px; background-color: #007bff; color: #fff; text-decoration: none; border-radius: 5px; }
        .btn:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <h1>Solde publicité par mois</h1>

    <table>
        <thead>
            <tr>
                <th>Mois</th>
                <th>Société</th>
                <th>Chiffre d'affaire</th>
                <th>Total payé</th>
                <th>Reste à payer</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="s" items="${chiffres}">
                <tr>
                    <td>${s.mois}</td>
                    <td>${s.societe}</td>
                    <td>${s.chiffreAffaire}</td>
                    <td>${s.totalPaye}</td>
                    <td>${s.resteAPayer}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>

    <div class="actions">
        <a href="<c:url value='/admin/accueil'/>" class="btn">Retour à l'accueil</a>
    </div>
</body>
</html>