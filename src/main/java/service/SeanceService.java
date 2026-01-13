package service;

import entity.Seance;
import entity.Ticket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.SeanceRepository;
import repository.TicketRepository;
import repository.ReservationRepository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.Comparator;

@Service
@Transactional
public class SeanceService {

    @Autowired
    private SeanceRepository seanceRepository;

    @Autowired
    private TicketRepository ticketRepository;
    
    @Autowired
    private ReservationRepository reservationRepository;

    public List<Seance> findAll() {
        return seanceRepository.findAll();
    }

    public Optional<Seance> findById(Integer id) {
        return seanceRepository.findById(id);
    }

    public Seance save(Seance seance) {
        return seanceRepository.save(seance);
    }

    public void deleteById(Integer id) {
        seanceRepository.deleteById(id);
    }

    public List<Seance> getAllSeance() {
        return seanceRepository.findAll();
    }

    public List<Seance> findProchainesSeances(int limit) {
        List<Seance> all = seanceRepository.findAll();
        all.sort(Comparator.comparing(Seance::getDebut));
        if (limit <= 0) return all;
        return all.subList(0, Math.min(limit, all.size()));
    }

    public double getRevenueForSeance(Integer seanceId) {
        List<Ticket> tickets = ticketRepository.findBySeance_Id(seanceId);
        return tickets.stream().mapToDouble(ticket -> ticket.getPrix().doubleValue()).sum();
    }
    
    public long countTicketsBySeance(Integer seanceId) {
        Optional<Seance> seance = findById(seanceId);
        if (seance.isPresent()) {
            return ticketRepository.countBySeance(seance.get());
        }
        return 0;
    }
    
    public long countReservationsBySeance(Integer seanceId) {
        Optional<Seance> seance = findById(seanceId);
        if (seance.isPresent()) {
            return reservationRepository.countBySeance(seance.get());
        }
        return 0;
    }
}