// DiffusionPublicitaire.java
package entity;

import java.time.LocalDate;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "diffusion_publicitaire")
public class DiffusionPublicitaire {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(name = "id_seance", nullable = false)
    private Integer idSeance;

    @ManyToOne
    @JoinColumn(name = "id_societe", nullable = false)
    private Societe societe;

    @ManyToOne
    @JoinColumn(name = "id_type_publicite", nullable = false)
    private TypePublicite typePublicite;

    @ManyToOne
    @JoinColumn(name = "id_tarif", nullable = false)
    private TarifDiffusionPublicitaire tarif;

    @Column(name = "date_diffusion", nullable = false)
    private LocalDate dateDiffusion;

    // Getters & Setters
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }

    public Integer getIdSeance() { return idSeance; }
    public void setIdSeance(Integer idSeance) { this.idSeance = idSeance; }

    public Societe getSociete() { return societe; }
    public void setSociete(Societe societe) { this.societe = societe; }

    public TypePublicite getTypePublicite() { return typePublicite; }
    public void setTypePublicite(TypePublicite typePublicite) { this.typePublicite = typePublicite; }

    public TarifDiffusionPublicitaire getTarif() { return tarif; }
    public void setTarif(TarifDiffusionPublicitaire tarif) { this.tarif = tarif; }

    public LocalDate getDateDiffusion() { return dateDiffusion; }
    public void setDateDiffusion(LocalDate dateDiffusion) { this.dateDiffusion = dateDiffusion; }
}
