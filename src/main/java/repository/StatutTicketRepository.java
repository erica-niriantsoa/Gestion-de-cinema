package repository;

import entity.StatutTicket;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface StatutTicketRepository extends JpaRepository<StatutTicket, Integer> {
    Optional<StatutTicket> findByCode(String code);
}
