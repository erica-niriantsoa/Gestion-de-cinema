package repository;

import entity.TarifSeance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TarifSeanceRepository extends JpaRepository<TarifSeance, Integer> {
    List<TarifSeance> findBySeanceId(Integer seanceId);
}
