package service;

import entity.Salle;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.SalleRepository;
import repository.SeanceRepository;

import java.util.List;
import java.util.Optional;

@Service
public class SalleService {

    @Autowired
    private SalleRepository salleRepository;
    
    @Autowired
    private SeanceRepository seanceRepository;

    public List<Salle> findAll() {
        return salleRepository.findAll();
    }

    public Optional<Salle> findById(Integer id) {
        return salleRepository.findById(id);
    }

    public Salle save(Salle salle) {
        return salleRepository.save(salle);
    }

    public void deleteById(Integer id) {
        salleRepository.deleteById(id);
    }
    
    public long countSeancesBySalle(Integer salleId) {
        Optional<Salle> salle = findById(salleId);
        if (salle.isPresent()) {
            return seanceRepository.countBySalle(salle.get());
        }
        return 0;
    }
}