package repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import entity.ViewTarifDefautAll;

@Repository
public interface ViewTarifDefautAllRepository extends JpaRepository<ViewTarifDefautAll, Integer> {
    List<ViewTarifDefautAll> findByIdTypePlace(Integer idTypePlace);
}
