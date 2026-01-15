package repository;

import entity.RevenuMaximalSeance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface RevenuMaximalSeanceRepository extends JpaRepository<RevenuMaximalSeance, Integer> {
    
    // Trouver le revenu maximal d'une séance spécifique
    Optional<RevenuMaximalSeance> findBySeanceId(Integer seanceId);
    
    // Trouver tous les revenus maximaux pour une salle spécifique
    List<RevenuMaximalSeance> findBySalleId(Integer salleId);
    
    // Trouver tous les revenus maximaux pour un film spécifique (par titre)
    List<RevenuMaximalSeance> findByFilmTitre(String filmTitre);
    
    // Trouver les séances avec le revenu maximal le plus élevé
    @Query("SELECT r FROM RevenuMaximalSeance r ORDER BY r.revenuMaximal DESC")
    List<RevenuMaximalSeance> findAllOrderByRevenuMaximalDesc();
}
