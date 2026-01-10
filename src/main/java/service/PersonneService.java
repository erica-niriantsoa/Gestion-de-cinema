package service;

import entity.Personne;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.PersonneRepository;

import java.util.Optional;

@Service
public class PersonneService {

    @Autowired
    private PersonneRepository personneRepository;

    public Optional<Personne> findById(Long id) {
        return personneRepository.findById(id);
    }

    public Personne savePersonne(Personne personne) {
        return personneRepository.save(personne);
    }
    public Optional<Personne> findByEmail(String email) {
        return personneRepository.findByEmail(email);
    }
}