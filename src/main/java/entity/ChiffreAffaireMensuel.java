// ChiffreAffaireMensuel.java
package entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "v_chiffre_affaire_publicite_mensuel")
public class ChiffreAffaireMensuel {

    @Id
    @Column(name = "mois")
    private LocalDate mois;  // On peut utiliser "mois + id_societe" si besoin pour ID composite

    @Column(name = "id_societe")
    private Integer idSociete;

    @Column(name = "societe")
    private String societe;

    @Column(name = "nombre_diffusions")
    private Integer nombreDiffusions;

    @Column(name = "chiffre_affaire")
    private BigDecimal chiffreAffaire;

    // Getters & Setters
    public LocalDate getMois() { return mois; }
    public void setMois(LocalDate mois) { this.mois = mois; }

    public Integer getIdSociete() { return idSociete; }
    public void setIdSociete(Integer idSociete) { this.idSociete = idSociete; }

    public String getSociete() { return societe; }
    public void setSociete(String societe) { this.societe = societe; }

    public Integer getNombreDiffusions() { return nombreDiffusions; }
    public void setNombreDiffusions(Integer nombreDiffusions) { this.nombreDiffusions = nombreDiffusions; }

    public BigDecimal getChiffreAffaire() { return chiffreAffaire; }
    public void setChiffreAffaire(BigDecimal chiffreAffaire) { this.chiffreAffaire = chiffreAffaire; }
}
