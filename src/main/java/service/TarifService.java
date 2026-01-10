package service;

import entity.TarifDefaut;
import entity.TarifSeance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.TarifDefautRepository;
import repository.TarifSeanceRepository;

import java.util.List;

@Service
public class TarifService {

    @Autowired
    private TarifDefautRepository tarifDefautRepository;

    @Autowired
    private TarifSeanceRepository tarifSeanceRepository;

    public List<TarifDefaut> findAllDefauts() {
        return tarifDefautRepository.findAll();
    }

    public List<TarifDefaut> findDefautsByTypeAndCategorie(Integer typePlaceId, Integer categoriePersonneId) {
        return tarifDefautRepository.findByTypePlaceIdAndCategoriePersonneId(typePlaceId, categoriePersonneId);
    }

    public TarifDefaut saveDefaut(TarifDefaut t) {
        return tarifDefautRepository.save(t);
    }

    public List<TarifSeance> findBySeance(Integer seanceId) {
        return tarifSeanceRepository.findBySeanceId(seanceId);
    }

    public TarifSeance saveSeanceTarif(TarifSeance t) {
        return tarifSeanceRepository.save(t);
    }
}
