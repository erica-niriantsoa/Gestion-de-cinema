package service;

import entity.TarifDefaut;
import repository.TarifDefautRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TarifDefautService {

    @Autowired
    private TarifDefautRepository tarifDefautRepository;

    public List<TarifDefaut> getAllTarifDefauts() {
        return tarifDefautRepository.findAll();
    }

    public Optional<TarifDefaut> getTarifDefautById(Long id) {
        return tarifDefautRepository.findById(id);
    }

    public Optional<TarifDefaut> getTarifDefautByTypePlaceAndCategoriePersonne(Long typePlaceId, Long categoriePersonneId) {
        return tarifDefautRepository.findByTypePlaceIdAndCategoriePersonneId(typePlaceId, categoriePersonneId);
    }

    public TarifDefaut saveTarifDefaut(TarifDefaut tarifDefaut) {
        return tarifDefautRepository.save(tarifDefaut);
    }

    public void deleteTarifDefaut(Long id) {
        tarifDefautRepository.deleteById(id);
    }
}
