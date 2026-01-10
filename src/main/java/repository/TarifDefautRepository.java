package repository;

import entity.TarifDefaut;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TarifDefautRepository extends JpaRepository<TarifDefaut, Integer> {
    List<TarifDefaut> findByTypePlaceIdAndCategoriePersonneId(Integer typePlaceId, Integer categoriePersonneId);
}
