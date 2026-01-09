package service;

import entity.CategoriePersonne;
import repository.CategoriePersonneRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CategoriePersonneService {

    @Autowired
    private CategoriePersonneRepository categoriePersonneRepository;

    public List<CategoriePersonne> getAllCategoriePersonnes() {
        return categoriePersonneRepository.findAll();
    }

    public Optional<CategoriePersonne> getCategoriePersonneById(Long id) {
        return categoriePersonneRepository.findById(id);
    }

    public CategoriePersonne saveCategoriePersonne(CategoriePersonne categoriePersonne) {
        return categoriePersonneRepository.save(categoriePersonne);
    }

    public void deleteCategoriePersonne(Long id) {
        categoriePersonneRepository.deleteById(id);
    }
}
