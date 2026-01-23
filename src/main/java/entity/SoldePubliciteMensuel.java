package entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "v_solde_publicite_mensuel")
public class SoldePubliciteMensuel {

    @Id
    @Column(name = "id_societe")
    private Integer idSociete;

    @Column(name = "mois")
    private LocalDate mois;

    @Column(name = "societe")
    private String societe;

    @Column(name = "chiffre_affaire")
    private BigDecimal chiffreAffaire;

    @Column(name = "total_paye")
    private BigDecimal totalPaye;

    @Column(name = "reste_a_payer")
    private BigDecimal resteAPayer;

    // Getters et setters
    public Integer getIdSociete() { return idSociete; }
    public void setIdSociete(Integer idSociete) { this.idSociete = idSociete; }

    public LocalDate getMois() { return mois; }
    public void setMois(LocalDate mois) { this.mois = mois; }

    public String getSociete() { return societe; }
    public void setSociete(String societe) { this.societe = societe; }

    public BigDecimal getChiffreAffaire() { return chiffreAffaire; }
    public void setChiffreAffaire(BigDecimal chiffreAffaire) { this.chiffreAffaire = chiffreAffaire; }

    public BigDecimal getTotalPaye() { return totalPaye; }
    public void setTotalPaye(BigDecimal totalPaye) { this.totalPaye = totalPaye; }

    public BigDecimal getResteAPayer() { return resteAPayer; }
    public void setResteAPayer(BigDecimal resteAPayer) { this.resteAPayer = resteAPayer; }
}
