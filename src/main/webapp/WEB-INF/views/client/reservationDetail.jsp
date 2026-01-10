<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des Réservations et Tickets</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background: #f5f7fa; padding: 20px; }
        .container { max-width: 1400px; margin: 0 auto; }
        .header { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 25px; border-radius: 15px; margin-bottom: 20px; text-align: center; }
        .section { background: white; padding: 25px; border-radius: 10px; box-shadow: 0 5px 15px rgba(0,0,0,0.08); margin-bottom: 20px; }
        .section-title { font-size: 24px; font-weight: bold; margin-bottom: 20px; padding-bottom: 10px; border-bottom: 2px solid #f8f9fa; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background: #f8f9fa; font-weight: bold; }
        tr:hover { background: #f5f5f5; }
        .status { padding: 4px 8px; border-radius: 4px; font-size: 12px; font-weight: bold; }
        .status.payé { background: #d4edda; color: #155724; }
        .status.en_attente { background: #fff3cd; color: #856404; }
        .json { font-family: monospace; font-size: 12px; background: #f8f9fa; padding: 10px; border-radius: 4px; max-height: 200px; overflow-y: auto; }
    </style>
</head>
<body>
<div class="container">
    <div class="header">
        <h1><i class="fas fa-list"></i> Liste des Réservations et Tickets</h1>
    </div>

    <!-- Réservations Complètes -->
    <div class="section">
        <div class="section-title"><i class="fas fa-ticket-alt"></i> Réservations Complètes</div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Date Réservation</th>
                    <th>Montant Total</th>
                    <th>Client</th>
                    <th>Email</th>
                    <th>Film</th>
                    <th>Séance Début</th>
                    <th>Séance Fin</th>
                    <th>Salle</th>
                    <th>Statut</th>
                    <th>Nb Tickets</th>
                    <th>Tickets (JSON)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="res" items="${reservations}">
                    <tr>
                        <td>${res.reservationId}</td>
                        <td><c:if test="${res.dateReservation != null}"><fmt:formatDate value="${java.util.Date.from(res.dateReservation.toInstant())}" pattern="dd/MM/yyyy HH:mm"/></c:if></td>
                        <td>${res.montantTotal} €</td>
                        <td>${res.clientNom}</td>
                        <td>${res.clientEmail}</td>
                        <td>${res.filmTitre}</td>
                        <td><c:if test="${res.seanceDebut != null}"><fmt:formatDate value="${java.util.Date.from(res.seanceDebut.toInstant())}" pattern="dd/MM/yyyy HH:mm"/></c:if></td>
                        <td><c:if test="${res.seanceFin != null}"><fmt:formatDate value="${java.util.Date.from(res.seanceFin.toInstant())}" pattern="dd/MM/yyyy HH:mm"/></c:if></td>
                        <td>${res.salleNom}</td>
                        <td><span class="status ${res.statutReservation == 'PAYE' ? 'payé' : 'en_attente'}">${res.statutReservation}</span></td>
                        <td>${res.nbTickets}</td>
                        <td><div class="json">${res.tickets}</div></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Tous les Tickets -->
    <div class="section">
        <div class="section-title"><i class="fas fa-tags"></i> Tous les Tickets</div>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Réservation ID</th>
                    <th>Séance ID</th>
                    <th>Place</th>
                    <th>Catégorie</th>
                    <th>Prix</th>
                    <th>Statut</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="ticket" items="${tickets}">
                    <tr>
                        <td>${ticket.id}</td>
                        <td>${ticket.reservation.id}</td>
                        <td>${ticket.seance.id}</td>
                        <td>${ticket.place.codePlace}</td>
                        <td>${ticket.categoriePersonne.libelle}</td>
                        <td>${ticket.prix} €</td>
                        <td><span class="status ${ticket.statut.code == 'PAYE' ? 'payé' : 'en_attente'}">${ticket.statut.libelle}</span></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>