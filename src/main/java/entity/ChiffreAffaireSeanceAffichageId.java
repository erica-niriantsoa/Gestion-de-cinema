package entity;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

/**
 * Classe ID composite pour ChiffreAffaireSeanceAffichage
 */
public class ChiffreAffaireSeanceAffichageId implements Serializable {

    private static final long serialVersionUID = 1L;

    private String film;
    private LocalDate dateDiffusion;
    private String heureDiffusion;

    // Constructeurs
    public ChiffreAffaireSeanceAffichageId() {
    }

    public ChiffreAffaireSeanceAffichageId(String film, LocalDate dateDiffusion, String heureDiffusion) {
        this.film = film;
        this.dateDiffusion = dateDiffusion;
        this.heureDiffusion = heureDiffusion;
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

    // equals & hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        ChiffreAffaireSeanceAffichageId that = (ChiffreAffaireSeanceAffichageId) o;
        return Objects.equals(film, that.film) &&
               Objects.equals(dateDiffusion, that.dateDiffusion) &&
               Objects.equals(heureDiffusion, that.heureDiffusion);
    }

    @Override
    public int hashCode() {
        return Objects.hash(film, dateDiffusion, heureDiffusion);
    }
}
