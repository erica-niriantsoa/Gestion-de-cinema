package repository;

import entity.ReservationComplete;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface ReservationCompleteRepository extends JpaRepository<ReservationComplete, Integer> {
}