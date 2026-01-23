<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Solde publicité par mois</title>
    <link rel="stylesheet" href="<c:url value='/css/style.css'/>">
    <style>
        body { 
            font-family: Arial, sans-serif; 
            padding: 20px; 
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 { 
            color: #333; 
            margin-bottom: 30px;
            border-bottom: 3px solid #007bff;
            padding-bottom: 10px;
        }
        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }
        .card {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 25px;
            border-radius: 8px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
            cursor: pointer;
            transition: transform 0.3s, box-shadow 0.3s;
            text-decoration: none;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0,0,0,0.15);
        }
        .card.blue {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        .card.green {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        }
        .card.orange {
            background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        }
        .card h2 {
            margin: 0 0 10px 0;
            font-size: 20px;
        }
        .card p {
            margin: 0;
            font-size: 14px;
            opacity: 0.9;
        }
        .card .icon {
            font-size: 40px;
            margin-bottom: 10px;
        }
        table { 
            border-collapse: collapse; 
            width: 100%; 
            margin-top: 20px;
        }
        th, td { 
            border: 1px solid #ccc; 
            padding: 12px; 
            text-align: left;
        }
        th { 
            background-color: #007bff; 
            color: white;
            font-weight: bold;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        tr:hover {
            background-color: #e8f4f8;
        }
        .actions { 
            margin-top: 20px;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }
        .btn { 
            display: inline-block; 
            padding: 10px 15px; 
            background-color: #007bff; 
            color: #fff; 
            text-decoration: none; 
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover { 
            background-color: #0056b3; 
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .amount {
            text-align: right;
            font-family: 'Courier New', monospace;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>📊 Gestion des Publicités</h1>

        <!-- Dashboard Cards -->
        <div class="dashboard">
            <a href="<c:url value='/admin/publicite/seance-societe'/>" class="card blue">
                <div class="icon">🏢</div>
                <h2>Par Société</h2>
                <p>Chiffre d'affaire par séance et société</p>
            </a>

            <a href="<c:url value='/admin/publicite/seance-affichage'/>" class="card green">
                <div class="icon">💰</div>
                <h2>Vue Complète</h2>
                <p>Total des revenues (tickets + pub)</p>
            </a>

            <a href="<c:url value='/admin/accueil'/>" class="card orange">
                <div class="icon">📈</div>
                <h2>Tableau de Bord</h2>
                <p>Retour au tableau de bord principal</p>
            </a>
        </div>

        <hr style="margin: 30px 0; border: none; border-top: 2px solid #ddd;">

        <h1>Solde publicité par mois</h1>

        <table>
            <thead>
                <tr>
                    <th>Mois</th>
                    <th>Société</th>
                    <th class="amount">Chiffre d'affaire</th>
                    <th class="amount">Total payé</th>
                    <th class="amount">Reste à payer</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="s" items="${chiffres}">
                    <tr>
                        <td>${s.mois}</td>
                        <td>${s.societe}</td>
                        <td class="amount">${s.chiffreAffaire}</td>
                        <td class="amount">${s.totalPaye}</td>
                        <td class="amount">${s.resteAPayer}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="actions">
            <a href="<c:url value='/admin/accueil'/>" class="btn">Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>