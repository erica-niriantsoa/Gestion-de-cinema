package entity;

import java.io.Serializable;
import java.time.LocalDate;
import java.util.Objects;

/**
 * Classe ID composite pour CAPubliSeanceSeanceSocieteFinal
 */
public class CAPubliSeanceSeanceSocieteFinalId implements Serializable {

    private static final long serialVersionUID = 1L;

    private String film;
    private LocalDate dateDiffusion;
    private String heureDiffusion;
    private String societe;

    // Constructeurs
    public CAPubliSeanceSeanceSocieteFinalId() {
    }

    public CAPubliSeanceSeanceSocieteFinalId(String film, LocalDate dateDiffusion, String heureDiffusion, String societe) {
        this.film = film;
        this.dateDiffusion = dateDiffusion;
        this.heureDiffusion = heureDiffusion;
        this.societe = societe;
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

    // equals & hashCode
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        CAPubliSeanceSeanceSocieteFinalId that = (CAPubliSeanceSeanceSocieteFinalId) o;
        return Objects.equals(film, that.film) &&
               Objects.equals(dateDiffusion, that.dateDiffusion) &&
               Objects.equals(heureDiffusion, that.heureDiffusion) &&
               Objects.equals(societe, that.societe);
    }

    @Override
    public int hashCode() {
        return Objects.hash(film, dateDiffusion, heureDiffusion, societe);
    }
}
