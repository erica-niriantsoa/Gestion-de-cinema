// ChiffreAffaireTotalMensuel.java
package entity;

import java.math.BigDecimal;
import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "v_chiffre_affaire_publicite_mois_total")
public class ChiffreAffaireTotalMensuel {

    @Id
    @Column(name = "mois")
    private LocalDate mois;

    @Column(name = "nombre_diffusions")
    private Integer nombreDiffusions;

    @Column(name = "chiffre_affaire_total")
    private BigDecimal chiffreAffaireTotal;

    // Getters & Setters
    public LocalDate getMois() { return mois; }
    public void setMois(LocalDate mois) { this.mois = mois; }

    public Integer getNombreDiffusions() { return nombreDiffusions; }
    public void setNombreDiffusions(Integer nombreDiffusions) { this.nombreDiffusions = nombreDiffusions; }

    public BigDecimal getChiffreAffaireTotal() { return chiffreAffaireTotal; }
    public void setChiffreAffaireTotal(BigDecimal chiffreAffaireTotal) { this.chiffreAffaireTotal = chiffreAffaireTotal; }
}
