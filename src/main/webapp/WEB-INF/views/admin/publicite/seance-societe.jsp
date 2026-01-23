<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chiffre d'affaire Publicité par Séance et Société</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
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
            margin-bottom: 20px;
            border-bottom: 2px solid #007bff;
            padding-bottom: 10px;
        }
        .filters {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .filter-row {
            display: flex;
            gap: 15px;
            align-items: flex-end;
            flex-wrap: wrap;
        }
        .filter-group {
            display: flex;
            flex-direction: column;
        }
        .filter-group label {
            font-weight: bold;
            margin-bottom: 5px;
            color: #555;
        }
        .filter-group input,
        .filter-group select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #007bff;
            color: white;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background-color: #007bff;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
            position: sticky;
            top: 0;
        }
        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
        }
        tr:hover {
            background-color: #f5f5f5;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .amount {
            text-align: right;
            font-family: 'Courier New', monospace;
        }
        .percentage {
            text-align: center;
            background-color: #e3f2fd;
        }
        .no-data {
            text-align: center;
            padding: 40px;
            color: #999;
            font-size: 16px;
        }
        .error {
            background-color: #f8d7da;
            border: 1px solid #f5c6cb;
            color: #721c24;
            padding: 12px;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .actions {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        .breadcrumb {
            margin-bottom: 20px;
        }
        .breadcrumb a {
            color: #007bff;
            text-decoration: none;
        }
        .breadcrumb a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="breadcrumb">
            <a href="<c:url value='/admin/accueil'/>">Accueil</a> > 
            <a href="<c:url value='/admin/publicite'/>">Publicité</a> > 
            Chiffre d'affaire par Séance et Société
        </div>

        <h1>📊 Chiffre d'affaire Publicité par Séance et Société</h1>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <!-- Filtres -->
        <div class="filters">
            <form method="get" action="<c:url value='/admin/publicite/seance-societe'/>">
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="societe">Société:</label>
                        <select name="societe" id="societe">
                            <option value="">-- Tous --</option>
                            <option value="Vaniala" <c:if test="${societeFiltree eq 'Vaniala'}">selected</c:if>>Vaniala</option>
                            <option value="Lewis" <c:if test="${societeFiltree eq 'Lewis'}">selected</c:if>>Lewis</option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <label for="mois">Mois:</label>
                        <input type="month" name="mois" id="mois" value="${moisFiltre}" />
                    </div>

                    <button type="submit" class="btn">Filtrer</button>
                    <a href="<c:url value='/admin/publicite/seance-societe'/>" class="btn btn-secondary">Réinitialiser</a>
                </div>
            </form>
        </div>

        <!-- Tableau des données -->
        <c:if test="${empty caPubliSeances}">
            <div class="no-data">
                Aucune donnée trouvée pour les filtres sélectionnés.
            </div>
        </c:if>

        <c:if test="${not empty caPubliSeances}">
            <table>
                <thead>
                    <tr>
                        <th>Film</th>
                        <th>Date</th>
                        <th>Heure</th>
                        <th>Société</th>
                        <th class="amount">CA Diffusion</th>
                        <th class="percentage">% Payé</th>
                        <th class="amount">Montant Payé</th>
                        <th class="amount">Reste à Payer</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="seance" items="${caPubliSeances}">
                        <tr>
                            <td>${seance.film}</td>
                            <td>${seance.dateDiffusion}</td>
                            <td>${seance.heureDiffusion}</td>
                            <td>${seance.societe}</td>
                            <td class="amount">
                                <fmt:formatNumber value="${seance.caDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="percentage">
                                <fmt:formatNumber value="${seance.pourcentagePaye}" type="number" maxFractionDigits="2" />%
                            </td>
                            <td class="amount">
                                <fmt:formatNumber value="${seance.montantPayeDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="amount">
                                <fmt:formatNumber value="${seance.resteAPayerDiffusion}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <!-- Actions -->
        <div class="actions">
            <a href="<c:url value='/admin/publicite'/>" class="btn">← Retour aux Soldes</a>
            <a href="<c:url value='/admin/publicite/seance-affichage'/>" class="btn btn-secondary">Vue Complète →</a>
            <a href="<c:url value='/admin/accueil'/>" class="btn">Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>
