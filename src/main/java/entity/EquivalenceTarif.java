package entity;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "equivalence_tarif")
public class EquivalenceTarif {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "id_categorie_personne", nullable = false)
    private Integer idCategoriePersonne;

    @Column(nullable = false, precision = 5, scale = 2)
    private BigDecimal coefficient; // ← changer Double en BigDecimal

    @Column(columnDefinition = "TEXT")
    private String description;

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Integer getIdCategoriePersonne() { return idCategoriePersonne; }
    public void setIdCategoriePersonne(Integer idCategoriePersonne) { this.idCategoriePersonne = idCategoriePersonne; }

    public BigDecimal getCoefficient() { return coefficient; }
    public void setCoefficient(BigDecimal coefficient) { this.coefficient = coefficient; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
