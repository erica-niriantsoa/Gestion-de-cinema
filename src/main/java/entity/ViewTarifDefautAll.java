package entity;

import org.hibernate.annotations.Immutable;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Immutable
@Table(name = "view_tarif_defaut_all")
public class ViewTarifDefautAll {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id; // tu peux ajouter un @Transient si la vue n'a pas d'id unique

    @Column(name = "id_type_place")
    private Integer idTypePlace;

    @Column(name = "id_categorie_personne")
    private Integer idCategoriePersonne;

    @Column(name = "categorie_personne")
    private String categoriePersonne;

    @Column(name = "prix_calcule")
    private Double prixCalcule;

    // Getters et Setters
    public Integer getIdTypePlace() { return idTypePlace; }
    public void setIdTypePlace(Integer idTypePlace) { this.idTypePlace = idTypePlace; }

    public Integer getIdCategoriePersonne() { return idCategoriePersonne; }
    public void setIdCategoriePersonne(Integer idCategoriePersonne) { this.idCategoriePersonne = idCategoriePersonne; }

    public String getCategoriePersonne() { return categoriePersonne; }
    public void setCategoriePersonne(String categoriePersonne) { this.categoriePersonne = categoriePersonne; }

    public Double getPrixCalcule() { return prixCalcule; }
    public void setPrixCalcule(Double prixCalcule) { this.prixCalcule = prixCalcule; }
}
