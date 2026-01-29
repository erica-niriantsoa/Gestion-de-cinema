package repository;

import entity.Ticket;
import entity.Seance;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TicketRepository extends JpaRepository<Ticket, Integer> {
    boolean existsBySeance_IdAndPlace_IdAndStatut_CodeIn(Integer seanceId, Integer placeId, List<String> codes);
    List<Ticket> findBySeance_IdAndPlace_Id(Integer seanceId, Integer placeId);
    List<Ticket> findBySeance_Id(Integer seanceId);
    long countBySeance(Seance seance);
    long countByReservationId(Integer reservationId);
}
