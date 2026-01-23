// DiffusionPublicitaireService.java
package service;

import java.util.List;

import org.springframework.stereotype.Service;

import entity.DiffusionPublicitaire;
import repository.DiffusionPublicitaireRepository;

@Service
public class DiffusionPublicitaireService {

    private final DiffusionPublicitaireRepository repository;

    public DiffusionPublicitaireService(DiffusionPublicitaireRepository repository) {
        this.repository = repository;
    }

    public List<DiffusionPublicitaire> findAll() {
        return repository.findAll();
    }

    public DiffusionPublicitaire save(DiffusionPublicitaire diffusion) {
        return repository.save(diffusion);
    }

    public void deleteById(Integer id) {
        repository.deleteById(id);
    }
}
