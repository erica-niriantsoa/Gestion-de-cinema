package service;

import entity.TarifSeance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.TarifSeanceRepository;

import java.util.List;
import java.util.Optional;

@Service
public class TarifSeanceService {

    @Autowired
    private TarifSeanceRepository tarifSeanceRepository;

    public List<TarifSeance> findAll() {
        return tarifSeanceRepository.findAll();
    }

    public List<TarifSeance> findBySeanceId(Integer seanceId) {
        return tarifSeanceRepository.findBySeanceId(seanceId);
    }

    public Optional<TarifSeance> findById(Integer id) {
        return tarifSeanceRepository.findById(id);
    }

    public TarifSeance save(TarifSeance tarif) {
        return tarifSeanceRepository.save(tarif);
    }

    public void deleteById(Integer id) {
        tarifSeanceRepository.deleteById(id);
    }
}
