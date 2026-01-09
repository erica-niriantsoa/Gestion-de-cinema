package entity;

import jakarta.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "tarif_defaut")
public class TarifDefaut {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "id_type_place")
    private TypePlace typePlace;

    @ManyToOne
    @JoinColumn(name = "id_categorie_personne")
    private CategoriePersonne categoriePersonne;

    @Column(nullable = false)
    private BigDecimal prix;

    // Getters and Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public TypePlace getTypePlace() {
        return typePlace;
    }

    public void setTypePlace(TypePlace typePlace) {
        this.typePlace = typePlace;
    }

    public CategoriePersonne getCategoriePersonne() {
        return categoriePersonne;
    }

    public void setCategoriePersonne(CategoriePersonne categoriePersonne) {
        this.categoriePersonne = categoriePersonne;
    }

    public BigDecimal getPrix() {
        return prix;
    }

    public void setPrix(BigDecimal prix) {
        this.prix = prix;
    }
}
