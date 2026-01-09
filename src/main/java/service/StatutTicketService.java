package service;

import entity.StatutTicket;
import repository.StatutTicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StatutTicketService {

    @Autowired
    private StatutTicketRepository statutTicketRepository;

    public List<StatutTicket> getAllStatutTickets() {
        return statutTicketRepository.findAll();
    }

    public Optional<StatutTicket> getStatutTicketById(Long id) {
        return statutTicketRepository.findById(id);
    }

    public Optional<StatutTicket> getStatutTicketByCode(String code) {
        return statutTicketRepository.findByCode(code);
    }

    public StatutTicket saveStatutTicket(StatutTicket statutTicket) {
        return statutTicketRepository.save(statutTicket);
    }

    public void deleteStatutTicket(Long id) {
        statutTicketRepository.deleteById(id);
    }
}
