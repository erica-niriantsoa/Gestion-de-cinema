package service;

import entity.TarifSeance;
import repository.TarifSeanceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TarifSeanceService {

    @Autowired
    private TarifSeanceRepository tarifSeanceRepository;

    public List<TarifSeance> getAllTarifSeances() {
        return tarifSeanceRepository.findAll();
    }

    public Optional<TarifSeance> getTarifSeanceById(Long id) {
        return tarifSeanceRepository.findById(id);
    }

    public List<TarifSeance> getTarifSeancesBySeanceId(Long seanceId) {
        return tarifSeanceRepository.findBySeanceId(seanceId);
    }

    public Optional<TarifSeance> getTarifSeanceBySeanceAndTypePlaceAndCategoriePersonne(Long seanceId, Long typePlaceId, Long categoriePersonneId) {
        return tarifSeanceRepository.findBySeanceIdAndTypePlaceIdAndCategoriePersonneId(seanceId, typePlaceId, categoriePersonneId);
    }

    public TarifSeance saveTarifSeance(TarifSeance tarifSeance) {
        return tarifSeanceRepository.save(tarifSeance);
    }

    public void deleteTarifSeance(Long id) {
        tarifSeanceRepository.deleteById(id);
    }
}
