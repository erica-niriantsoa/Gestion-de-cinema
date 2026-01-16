package entity;

import jakarta.persistence.*;
import org.hibernate.annotations.Immutable;
import java.math.BigDecimal;
import java.time.ZonedDateTime;

@Entity
@Immutable
@Table(name = "revenu_maximal_seance")
public class RevenuMaximalSeance {

    @Id
    @Column(name = "seance_id")
    private Integer seanceId;

    @Column(name = "film_titre")
    private String filmTitre;

    @Column(name = "seance_debut")
    private ZonedDateTime seanceDebut;

    @Column(name = "seance_fin")
    private ZonedDateTime seanceFin;

    @Column(name = "salle_nom")
    private String salleNom;

    @Column(name = "salle_id")
    private Integer salleId;

    @Column(name = "capacite")
    private Integer capacite;

    @Column(name = "nb_places_total")
    private Long nbPlacesTotal;

    @Column(name = "nb_places_standard")
    private Long nbPlacesStandard;

    @Column(name = "nb_places_premium")
    private Long nbPlacesPremium;

    @Column(name = "revenu_maximal")
    private BigDecimal revenuMaximal;

    // Constructeurs
    public RevenuMaximalSeance() {
    }

    // Getters et Setters
    public Integer getSeanceId() {
        return seanceId;
    }

    public void setSeanceId(Integer seanceId) {
        this.seanceId = seanceId;
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

    public Integer getSalleId() {
        return salleId;
    }

    public void setSalleId(Integer salleId) {
        this.salleId = salleId;
    }

    public Integer getCapacite() {
        return capacite;
    }

    public void setCapacite(Integer capacite) {
        this.capacite = capacite;
    }

    public Long getNbPlacesTotal() {
        return nbPlacesTotal;
    }

    public void setNbPlacesTotal(Long nbPlacesTotal) {
        this.nbPlacesTotal = nbPlacesTotal;
    }

    public Long getNbPlacesStandard() {
        return nbPlacesStandard;
    }

    public void setNbPlacesStandard(Long nbPlacesStandard) {
        this.nbPlacesStandard = nbPlacesStandard;
    }

    public Long getNbPlacesPremium() {
        return nbPlacesPremium;
    }

    public void setNbPlacesPremium(Long nbPlacesPremium) {
        this.nbPlacesPremium = nbPlacesPremium;
    }

    public BigDecimal getRevenuMaximal() {
        return revenuMaximal;
    }

    public void setRevenuMaximal(BigDecimal revenuMaximal) {
        this.revenuMaximal = revenuMaximal;
    }
}
