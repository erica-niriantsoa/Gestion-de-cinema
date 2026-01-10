package entity;

import jakarta.persistence.*;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;

@Entity
@Table(name = "seance")
public class Seance {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @ManyToOne
    @JoinColumn(name = "id_film")
    private Film film;

    @ManyToOne
    @JoinColumn(name = "id_salle")
    private Salle salle;

    @Column(name = "debut", nullable = false)
    private ZonedDateTime debut;

    @Column(name = "fin")
    private ZonedDateTime fin;

    @Column(name = "langue")
    private String langue;

    // Getters and Setters
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Film getFilm() {
        return film;
    }

    public void setFilm(Film film) {
        this.film = film;
    }

    public Salle getSalle() {
        return salle;
    }

    public void setSalle(Salle salle) {
        this.salle = salle;
    }

    public ZonedDateTime getDebut() {
        return debut;
    }

    public void setDebut(ZonedDateTime debut) {
        this.debut = debut;
    }

    public ZonedDateTime getFin() {
        return fin;
    }

    public void setFin(ZonedDateTime fin) {
        this.fin = fin;
    }

    public String getLangue() {
        return langue;
    }

    public void setLangue(String langue) {
        this.langue = langue;
    }

     @Transient
    public String getDebutFormatted() {
        if (debut != null) {
            return debut.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return null;
    }
    
    @Transient
    public String getFinFormatted() {
        if (fin != null) {
            return fin.format(DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm"));
        }
        return null;
    }
}