package service;

import entity.StatutTicket;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.StatutTicketRepository;

import java.util.List;
import java.util.Optional;

@Service
public class StatutTicketService {

    @Autowired
    private StatutTicketRepository statutTicketRepository;

    public List<StatutTicket> findAll() {
        return statutTicketRepository.findAll();
    }

    public Optional<StatutTicket> findById(Integer id) {
        return statutTicketRepository.findById(id);
    }

    public Optional<StatutTicket> findByCode(String code) {
        return statutTicketRepository.findByCode(code);
    }

    public StatutTicket save(StatutTicket s) {
        return statutTicketRepository.save(s);
    }

    public void deleteById(Integer id) {
        statutTicketRepository.deleteById(id);
    }
}
