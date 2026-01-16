package service;

import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.Salle;
import entity.Seance;
import repository.SalleRepository;
import repository.SeanceRepository;
@Service
public class SalleService {

    @Autowired
    private SalleRepository salleRepository;
    
    @Autowired
    private SeanceRepository seanceRepository;
    @Autowired
    private SeanceService seanceService;

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
    }     public Map<String, Double> getRevenueParSalle() {
        List<Salle> salles = salleRepository.findAll();

        return salles.stream().collect(Collectors.toMap(
                Salle::getNom, // clé = nom de la salle
                salle -> {
                    // récupérer toutes les séances de cette salle
                    List<Seance> seances = seanceService.findAll().stream()
                            .filter(s -> s.getSalle().getId().equals(salle.getId()))
                            .toList();

                    // calcul du revenu total
                    return seances.stream()
                            .mapToDouble(s -> seanceService.getRevenueForSeance(s.getId()))
                            .sum();
                }
        ));
    }


}