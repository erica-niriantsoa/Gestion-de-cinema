package entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.IdClass;
import jakarta.persistence.Table;

/**
 * Entité basée sur la vue v_chiffre_affaire_seance_affichage
 * Représente le chiffre d'affaire total (tickets + publicités + produits extra) par séance
 */
@Entity
@Table(name = "v_chiffre_affaire_seance_affichage")
@IdClass(ChiffreAffaireSeanceAffichageId.class)
public class ChiffreAffaireSeanceAffichage {

    @Id
    @Column(name = "film")
    private String film;

    @Id
    @Column(name = "date_diffusion")
    private LocalDate dateDiffusion;

    @Id
    @Column(name = "heure_diffusion")
    private String heureDiffusion;

    @Column(name = "montant_ticket")
    private BigDecimal montantTicket;

    @Column(name = "montant_pub_total")
    private BigDecimal montantPubTotal;

    @Column(name = "montant_pub_paye")
    private BigDecimal montantPubPaye;

    @Column(name = "montant_pub_restant")
    private BigDecimal montantPubRestant;

    @Column(name = "montant_extra")
    private BigDecimal montantExtra;

    @Column(name = "ca_total")
    private BigDecimal caTotal;

    @Column(name = "ca_encaisse")
    private BigDecimal caEncaisse;

    @Column(name = "ca_restant")
    private BigDecimal caRestant;

    // Constructeurs
    public ChiffreAffaireSeanceAffichage() {
    }

    public ChiffreAffaireSeanceAffichage(String film, LocalDate dateDiffusion, String heureDiffusion,
                                        BigDecimal montantTicket, BigDecimal montantPubTotal,
                                        BigDecimal montantPubPaye, BigDecimal montantPubRestant,
                                        BigDecimal montantExtra,
                                        BigDecimal caTotal, BigDecimal caEncaisse, BigDecimal caRestant) {
        this.film = film;
        this.dateDiffusion = dateDiffusion;
        this.heureDiffusion = heureDiffusion;
        this.montantTicket = montantTicket;
        this.montantPubTotal = montantPubTotal;
        this.montantPubPaye = montantPubPaye;
        this.montantPubRestant = montantPubRestant;
        this.montantExtra = montantExtra;
        this.caTotal = caTotal;
        this.caEncaisse = caEncaisse;
        this.caRestant = caRestant;
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

    public BigDecimal getMontantTicket() {
        return montantTicket;
    }

    public void setMontantTicket(BigDecimal montantTicket) {
        this.montantTicket = montantTicket;
    }

    public BigDecimal getMontantPubTotal() {
        return montantPubTotal;
    }

    public void setMontantPubTotal(BigDecimal montantPubTotal) {
        this.montantPubTotal = montantPubTotal;
    }

    public BigDecimal getMontantPubPaye() {
        return montantPubPaye;
    }

    public void setMontantPubPaye(BigDecimal montantPubPaye) {
        this.montantPubPaye = montantPubPaye;
    }

    public BigDecimal getMontantPubRestant() {
        return montantPubRestant;
    }

    public void setMontantPubRestant(BigDecimal montantPubRestant) {
        this.montantPubRestant = montantPubRestant;
    }

    public BigDecimal getMontantExtra() {
        return montantExtra;
    }

    public void setMontantExtra(BigDecimal montantExtra) {
        this.montantExtra = montantExtra;
    }

    public BigDecimal getCaTotal() {
        return caTotal;
    }

    public void setCaTotal(BigDecimal caTotal) {
        this.caTotal = caTotal;
    }

    public BigDecimal getCaEncaisse() {
        return caEncaisse;
    }

    public void setCaEncaisse(BigDecimal caEncaisse) {
        this.caEncaisse = caEncaisse;
    }

    public BigDecimal getCaRestant() {
        return caRestant;
    }

    public void setCaRestant(BigDecimal caRestant) {
        this.caRestant = caRestant;
    }
}
