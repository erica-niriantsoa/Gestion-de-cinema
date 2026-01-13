package repository;

import entity.Seance;
import entity.Salle;
import entity.Film;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SeanceRepository extends JpaRepository<Seance, Integer> {
    long countBySalle(Salle salle);
    long countByFilm(Film film);
}