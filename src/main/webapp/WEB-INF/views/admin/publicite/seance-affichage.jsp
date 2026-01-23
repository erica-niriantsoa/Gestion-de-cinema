<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Chiffre d'affaire Total par Séance</title>
    <link rel="stylesheet" href="<c:url value='/assets/css/style.css'/>">
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #f5f5f5;
        }
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
            border-bottom: 2px solid #28a745;
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
        .filter-group input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }
        .btn {
            display: inline-block;
            padding: 10px 20px;
            background-color: #28a745;
            color: white;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        .btn:hover {
            background-color: #218838;
        }
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #545b62;
        }
        .btn-info {
            background-color: #17a2b8;
        }
        .btn-info:hover {
            background-color: #138496;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th {
            background-color: #28a745;
            color: white;
            padding: 12px;
            text-align: left;
            font-weight: bold;
            position: sticky;
            top: 0;
        }
        th.tickets {
            background-color: #007bff;
        }
        th.publicite {
            background-color: #ffc107;
            color: #333;
        }
        th.totaux {
            background-color: #6f42c1;
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
            flex-wrap: wrap;
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
        .section-header {
            background-color: #e9ecef;
            padding: 10px;
            font-weight: bold;
            text-align: center;
            border: 1px solid #ddd;
        }
        .highlight-positive {
            color: #28a745;
            font-weight: bold;
        }
        .highlight-warning {
            color: #ffc107;
            font-weight: bold;
        }
        .summary {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }
        .summary-card {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            border-left: 4px solid #28a745;
        }
        .summary-card.tickets {
            border-left-color: #007bff;
        }
        .summary-card.publicite {
            border-left-color: #ffc107;
        }
        .summary-card.danger {
            border-left-color: #dc3545;
        }
        .summary-card h3 {
            margin: 0 0 10px 0;
            color: #555;
            font-size: 14px;
        }
        .summary-card .value {
            font-size: 20px;
            font-weight: bold;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="breadcrumb">
            <a href="<c:url value='/admin/accueil'/>">Accueil</a> > 
            <a href="<c:url value='/admin/publicite'/>">Publicité</a> > 
            Chiffre d'affaire Total par Séance
        </div>

        <h1>💰 Chiffre d'affaire Total (Tickets + Publicités) par Séance</h1>

        <c:if test="${not empty error}">
            <div class="error">${error}</div>
        </c:if>

        <!-- Filtres -->
        <div class="filters">
            <form method="get" action="<c:url value='/admin/publicite/seance-affichage'/>">
                <div class="filter-row">
                    <div class="filter-group">
                        <label for="mois">Mois:</label>
                        <input type="month" name="mois" id="mois" value="${moisFiltre}" />
                    </div>

                    <button type="submit" class="btn">Filtrer</button>
                    <a href="<c:url value='/admin/publicite/seance-affichage'/>" class="btn btn-secondary">Réinitialiser</a>
                </div>
            </form>
        </div>

        <!-- Tableau des données -->
        <c:if test="${empty caSeances}">
            <div class="no-data">
                Aucune donnée trouvée pour les filtres sélectionnés.
            </div>
        </c:if>

        <c:if test="${not empty caSeances}">
            <table>
                <thead>
                    <tr>
                        <th>Film</th>
                        <th>Date</th>
                        <th>Heure</th>
                        <th class="tickets">Montant Tickets</th>
                        <th class="publicite">Pub Total</th>
                        <th class="publicite">Pub Payée</th>
                        <th class="publicite">Pub Restant</th>
                        <th class="totaux">CA Total</th>
                        <th class="totaux">CA Encaissé</th>
                        <th class="totaux">CA Restant</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="seance" items="${caSeances}">
                        <tr>
                            <td>${seance.film}</td>
                            <td>${seance.dateDiffusion}</td>
                            <td>${seance.heureDiffusion}</td>
                            <td class="amount highlight-positive">
                                <fmt:formatNumber value="${seance.montantTicket}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="amount">
                                <fmt:formatNumber value="${seance.montantPubTotal}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="amount highlight-positive">
                                <fmt:formatNumber value="${seance.montantPubPaye}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="amount highlight-warning">
                                <fmt:formatNumber value="${seance.montantPubRestant}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="amount" style="background-color: #f0f0f0; font-weight: bold;">
                                <fmt:formatNumber value="${seance.caTotal}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="amount highlight-positive" style="background-color: #d4edda;">
                                <fmt:formatNumber value="${seance.caEncaisse}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                            <td class="amount" style="background-color: #fff3cd; color: #856404; font-weight: bold;">
                                <fmt:formatNumber value="${seance.caRestant}" type="currency" currencySymbol="Ar" maxFractionDigits="2" />
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Totaux -->
            <c:set var="totalMontantTicket" value="0" />
            <c:set var="totalMontantPubTotal" value="0" />
            <c:set var="totalMontantPubPaye" value="0" />
            <c:set var="totalMontantPubRestant" value="0" />
            <c:set var="totalCaTotal" value="0" />
            <c:set var="totalCaEncaisse" value="0" />
            <c:set var="totalCaRestant" value="0" />

            <c:forEach var="seance" items="${caSeances}">
                <c:set var="totalMontantTicket" value="${totalMontantTicket + seance.montantTicket}" />
                <c:set var="totalMontantPubTotal" value="${totalMontantPubTotal + seance.montantPubTotal}" />
                <c:set var="totalMontantPubPaye" value="${totalMontantPubPaye + seance.montantPubPaye}" />
                <c:set var="totalMontantPubRestant" value="${totalMontantPubRestant + seance.montantPubRestant}" />
                <c:set var="totalCaTotal" value="${totalCaTotal + seance.caTotal}" />
                <c:set var="totalCaEncaisse" value="${totalCaEncaisse + seance.caEncaisse}" />
                <c:set var="totalCaRestant" value="${totalCaRestant + seance.caRestant}" />
            </c:forEach>

            <div class="summary">
                <div class="summary-card tickets">
                    <h3>Total Tickets</h3>
                    <div class="value">
                        <fmt:formatNumber value="${totalMontantTicket}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                    </div>
                </div>
                <div class="summary-card publicite">
                    <h3>Total Publicités</h3>
                    <div class="value">
                        <fmt:formatNumber value="${totalMontantPubTotal}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                    </div>
                </div>
                <div class="summary-card">
                    <h3>Chiffre d'Affaire Total</h3>
                    <div class="value highlight-positive">
                        <fmt:formatNumber value="${totalCaTotal}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                    </div>
                </div>
                <div class="summary-card">
                    <h3>CA Encaissé</h3>
                    <div class="value highlight-positive">
                        <fmt:formatNumber value="${totalCaEncaisse}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                    </div>
                </div>
                <div class="summary-card danger">
                    <h3>CA en Attente</h3>
                    <div class="value">
                        <fmt:formatNumber value="${totalCaRestant}" type="currency" currencySymbol="Ar" maxFractionDigits="0" />
                    </div>
                </div>
            </div>
        </c:if>

        <!-- Actions -->
        <div class="actions">
            <a href="<c:url value='/admin/publicite'/>" class="btn">← Retour aux Soldes</a>
            <a href="<c:url value='/admin/publicite/seance-societe'/>" class="btn btn-info">← Vue par Société</a>
            <a href="<c:url value='/admin/accueil'/>" class="btn btn-secondary">Retour à l'accueil</a>
        </div>
    </div>
</body>
</html>
