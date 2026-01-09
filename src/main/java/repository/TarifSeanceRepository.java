package repository;

import entity.TarifSeance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface TarifSeanceRepository extends JpaRepository<TarifSeance, Long> {
    List<TarifSeance> findBySeanceId(Long seanceId);
    Optional<TarifSeance> findBySeanceIdAndTypePlaceIdAndCategoriePersonneId(Long seanceId, Long typePlaceId, Long categoriePersonneId);
}
