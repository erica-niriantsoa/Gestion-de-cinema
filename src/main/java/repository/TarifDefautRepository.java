package repository;

import entity.TarifDefaut;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface TarifDefautRepository extends JpaRepository<TarifDefaut, Long> {
    Optional<TarifDefaut> findByTypePlaceIdAndCategoriePersonneId(Long typePlaceId, Long categoriePersonneId);
}
