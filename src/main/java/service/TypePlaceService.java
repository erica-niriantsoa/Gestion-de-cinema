package service;

import entity.TypePlace;
import repository.TypePlaceRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class TypePlaceService {

    @Autowired
    private TypePlaceRepository typePlaceRepository;

    public List<TypePlace> getAllTypePlaces() {
        return typePlaceRepository.findAll();
    }

    public Optional<TypePlace> getTypePlaceById(Long id) {
        return typePlaceRepository.findById(id);
    }

    public TypePlace saveTypePlace(TypePlace typePlace) {
        return typePlaceRepository.save(typePlace);
    }

    public void deleteTypePlace(Long id) {
        typePlaceRepository.deleteById(id);
    }
}
