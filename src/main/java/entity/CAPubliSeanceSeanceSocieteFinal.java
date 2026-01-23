package entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;

/**
 * Entité basée sur la vue v_ca_pub_seance_societe_final
 * Représente le chiffre d'affaire des publicités par séance et par société
 */
@Entity
@Table(name = "v_ca_pub_seance_societe_final")
@IdClass(CAPubliSeanceSeanceSocieteFinalId.class)
public class CAPubliSeanceSeanceSocieteFinal {

    @Id
    @Column(name = "film")
    private String film;

    @Id
    @Column(name = "date_diffusion")
    private LocalDate dateDiffusion;

    @Id
    @Column(name = "heure_diffusion")
    private String heureDiffusion;

    @Id
    @Column(name = "societe")
    private String societe;

    @Column(name = "ca_diffusion")
    private BigDecimal caDiffusion;

    @Column(name = "pourcentage_paye")
    private BigDecimal pourcentagePaye;

    @Column(name = "montant_paye_diffusion")
    private BigDecimal montantPayeDiffusion;

    @Column(name = "reste_a_payer_diffusion")
    private BigDecimal resteAPayerDiffusion;

    // Constructeurs
    public CAPubliSeanceSeanceSocieteFinal() {
    }

    public CAPubliSeanceSeanceSocieteFinal(String film, LocalDate dateDiffusion, String heureDiffusion, String societe,
                                          BigDecimal caDiffusion, BigDecimal pourcentagePaye,
                                          BigDecimal montantPayeDiffusion, BigDecimal resteAPayerDiffusion) {
        this.film = film;
        this.dateDiffusion = dateDiffusion;
        this.heureDiffusion = heureDiffusion;
        this.societe = societe;
        this.caDiffusion = caDiffusion;
        this.pourcentagePaye = pourcentagePaye;
        this.montantPayeDiffusion = montantPayeDiffusion;
        this.resteAPayerDiffusion = resteAPayerDiffusion;
    }

    // Getters & Setters
    public String getFilm() {
        return film;
    }

    public void setFilm(String film) {
        this.film = film;
    }

    public LocalDate getDateDiffusion() {
        return dateDiffusion;
    }

    public void setDateDiffusion(LocalDate dateDiffusion) {
        this.dateDiffusion = dateDiffusion;
    }

    public String getHeureDiffusion() {
        return heureDiffusion;
    }

    public void setHeureDiffusion(String heureDiffusion) {
        this.heureDiffusion = heureDiffusion;
    }

    public String getSociete() {
        return societe;
    }

    public void setSociete(String societe) {
        this.societe = societe;
    }

    public BigDecimal getCaDiffusion() {
        return caDiffusion;
    }

    public void setCaDiffusion(BigDecimal caDiffusion) {
        this.caDiffusion = caDiffusion;
    }

    public BigDecimal getPourcentagePaye() {
        return pourcentagePaye;
    }

    public void setPourcentagePaye(BigDecimal pourcentagePaye) {
        this.pourcentagePaye = pourcentagePaye;
    }

    public BigDecimal getMontantPayeDiffusion() {
        return montantPayeDiffusion;
    }

    public void setMontantPayeDiffusion(BigDecimal montantPayeDiffusion) {
        this.montantPayeDiffusion = montantPayeDiffusion;
    }

    public BigDecimal getResteAPayerDiffusion() {
        return resteAPayerDiffusion;
    }

    public void setResteAPayerDiffusion(BigDecimal resteAPayerDiffusion) {
        this.resteAPayerDiffusion = resteAPayerDiffusion;
    }
}
