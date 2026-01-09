package service;

import entity.Seance;
import repository.SeanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class SeanceService {

    @Autowired
    private SeanceRepository seanceRepository;

    public List<Seance> getAllSeances() {
        return seanceRepository.findAll();
    }

    public Optional<Seance> getSeanceById(Long id) {
        return seanceRepository.findById(id);
    }

    public Seance saveSeance(Seance seance) {
        return seanceRepository.save(seance);
    }

    public void deleteSeance(Long id) {
        seanceRepository.deleteById(id);
    }
}