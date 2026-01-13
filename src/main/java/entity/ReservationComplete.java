package entity;

import jakarta.persistence.*;
import java.math.BigDecimal;
import java.time.ZonedDateTime;

@Entity
@Table(name = "vue_reservation_complete")
public class ReservationComplete {

    @Id
    @Column(name = "reservation_id")
    private Integer reservationId;

    @Column(name = "date_reservation")
    private ZonedDateTime dateReservation;

    @Column(name = "montant_total", precision = 6, scale = 2)
    private BigDecimal montantTotal;

    @Column(name = "client_nom")
    private String clientNom;

    @Column(name = "client_email")
    private String clientEmail;

    @Column(name = "film_titre")
    private String filmTitre;

    @Column(name = "seance_debut")
    private ZonedDateTime seanceDebut;

    @Column(name = "seance_fin")
    private ZonedDateTime seanceFin;

    @Column(name = "salle_nom")
    private String salleNom;

    @Column(name = "statut_reservation")
    private String statutReservation;

    @Column(name = "nb_tickets")
    private Integer nbTickets;

    @Column(name = "tickets", columnDefinition = "text")
    private String tickets; // JSON array as string

    // Getters and setters
    public Integer getReservationId() {
        return reservationId;
    }

    public void setReservationId(Integer reservationId) {
        this.reservationId = reservationId;
    }

    public ZonedDateTime getDateReservation() {
        return dateReservation;
    }

    public void setDateReservation(ZonedDateTime dateReservation) {
        this.dateReservation = dateReservation;
    }

    public BigDecimal getMontantTotal() {
        return montantTotal;
    }

    public void setMontantTotal(BigDecimal montantTotal) {
        this.montantTotal = montantTotal;
    }

    public String getClientNom() {
        return clientNom;
    }

    public void setClientNom(String clientNom) {
        this.clientNom = clientNom;
    }

    public String getClientEmail() {
        return clientEmail;
    }

    public void setClientEmail(String clientEmail) {
        this.clientEmail = clientEmail;
    }

    public String getFilmTitre() {
        return filmTitre;
    }

    public void setFilmTitre(String filmTitre) {
        this.filmTitre = filmTitre;
    }

    public ZonedDateTime getSeanceDebut() {
        return seanceDebut;
    }

    public void setSeanceDebut(ZonedDateTime seanceDebut) {
        this.seanceDebut = seanceDebut;
    }

    public ZonedDateTime getSeanceFin() {
        return seanceFin;
    }

    public void setSeanceFin(ZonedDateTime seanceFin) {
        this.seanceFin = seanceFin;
    }

    public String getSalleNom() {
        return salleNom;
    }

    public void setSalleNom(String salleNom) {
        this.salleNom = salleNom;
    }

    public String getStatutReservation() {
        return statutReservation;
    }

    public void setStatutReservation(String statutReservation) {
        this.statutReservation = statutReservation;
    }

    public Integer getNbTickets() {
        return nbTickets;
    }

    public void setNbTickets(Integer nbTickets) {
        this.nbTickets = nbTickets;
    }

    public String getTickets() {
        return tickets;
    }

    public void setTickets(String tickets) {
        this.tickets = tickets;
    }

    @Transient
    public String getDateReservationFormatted() {
        if (dateReservation != null) {
            return dateReservation.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return null;
    }

    @Transient
    public String getSeanceDebutFormatted() {
        if (seanceDebut != null) {
            return seanceDebut.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return null;
    }

    @Transient
    public String getSeanceFinFormatted() {
        if (seanceFin != null) {
            return seanceFin.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return null;
    }
}