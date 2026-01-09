package service;

import entity.HistoriqueStatutTicket;
import repository.HistoriqueStatutTicketRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class HistoriqueStatutTicketService {

    @Autowired
    private HistoriqueStatutTicketRepository historiqueStatutTicketRepository;

    public List<HistoriqueStatutTicket> getAllHistoriqueStatutTickets() {
        return historiqueStatutTicketRepository.findAll();
    }

    public Optional<HistoriqueStatutTicket> getHistoriqueStatutTicketById(Long id) {
        return historiqueStatutTicketRepository.findById(id);
    }

    public List<HistoriqueStatutTicket> getHistoriqueStatutTicketsByTicketId(Long ticketId) {
        return historiqueStatutTicketRepository.findByTicketId(ticketId);
    }

    public HistoriqueStatutTicket saveHistoriqueStatutTicket(HistoriqueStatutTicket historiqueStatutTicket) {
        return historiqueStatutTicketRepository.save(historiqueStatutTicket);
    }

    public void deleteHistoriqueStatutTicket(Long id) {
        historiqueStatutTicketRepository.deleteById(id);
    }
}
