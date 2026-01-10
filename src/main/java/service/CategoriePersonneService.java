package service;

import entity.CategoriePersonne;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.CategoriePersonneRepository;

import java.util.List;
import java.util.Optional;

@Service
public class CategoriePersonneService {

    @Autowired
    private CategoriePersonneRepository categoriePersonneRepository;

    public List<CategoriePersonne> findAll() {
        return categoriePersonneRepository.findAll();
    }

    public Optional<CategoriePersonne> findById(Integer id) {
        return categoriePersonneRepository.findById(id);
    }

    public CategoriePersonne save(CategoriePersonne c) {
        return categoriePersonneRepository.save(c);
    }

    public void deleteById(Integer id) {
        categoriePersonneRepository.deleteById(id);
    }
}
