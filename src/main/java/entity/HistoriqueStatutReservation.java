package entity;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "historique_statut_reservation")
public class HistoriqueStatutReservation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_reservation")
    private Reservation reservation;

    @ManyToOne
    @JoinColumn(name = "id_statut")
    private StatutReservation statut;

    @Column(name = "date_changement")
    private LocalDateTime dateChangement;

    @ManyToOne
    @JoinColumn(name = "change_par")
    private Personne changePar;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Reservation getReservation() {
        return reservation;
    }

    public void setReservation(Reservation reservation) {
        this.reservation = reservation;
    }

    public StatutReservation getStatut() {
        return statut;
    }

    public void setStatut(StatutReservation statut) {
        this.statut = statut;
    }

    public LocalDateTime getDateChangement() {
        return dateChangement;
    }

    public void setDateChangement(LocalDateTime dateChangement) {
        this.dateChangement = dateChangement;
    }

    public Personne getChangePar() {
        return changePar;
    }

    public void setChangePar(Personne changePar) {
        this.changePar = changePar;
    }
}
