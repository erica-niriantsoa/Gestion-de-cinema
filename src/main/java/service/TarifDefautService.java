package service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.TarifDefaut;
import entity.ViewTarifDefautAll;
import repository.TarifDefautRepository;
import repository.ViewTarifDefautAllRepository;

@Service
public class TarifDefautService {

    @Autowired
    private TarifDefautRepository tarifDefautRepository;
    
    @Autowired
    private ViewTarifDefautAllRepository viewRepository;

    public List<TarifDefaut> findAll() {
        return tarifDefautRepository.findAll();
    }
    
 
    public List<ViewTarifDefautAll> getTarifsParTypePlace(Integer idTypePlace) {
        return viewRepository.findByIdTypePlace(idTypePlace);
    }

    public List<ViewTarifDefautAll> getTousLesTarifs() {
        return viewRepository.findAll();
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
