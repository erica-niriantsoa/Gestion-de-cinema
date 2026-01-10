package service;

import entity.TarifDefaut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.TarifDefautRepository;

import java.util.List;
import java.util.Optional;

@Service
public class TarifDefautService {

    @Autowired
    private TarifDefautRepository tarifDefautRepository;

    public List<TarifDefaut> findAll() {
        return tarifDefautRepository.findAll();
    }

    public Optional<TarifDefaut> findById(Integer id) {
        return tarifDefautRepository.findById(id);
    }

    public TarifDefaut save(TarifDefaut tarif) {
        return tarifDefautRepository.save(tarif);
    }

    public void deleteById(Integer id) {
        tarifDefautRepository.deleteById(id);
    }
}
