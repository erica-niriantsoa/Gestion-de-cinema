package repository;

import entity.StatutReservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface StatutReservationRepository extends JpaRepository<StatutReservation, Integer> {
}
