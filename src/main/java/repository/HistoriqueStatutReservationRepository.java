package repository;

import entity.HistoriqueStatutReservation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface HistoriqueStatutReservationRepository extends JpaRepository<HistoriqueStatutReservation, Long> {
    List<HistoriqueStatutReservation> findByReservationId(Long reservationId);
}
