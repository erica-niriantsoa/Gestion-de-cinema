package service;

import entity.TypePlace;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.TypePlaceRepository;

import java.util.List;
import java.util.Optional;

@Service
public class TypePlaceService {

    @Autowired
    private TypePlaceRepository typePlaceRepository;

    public List<TypePlace> findAll() {
        return typePlaceRepository.findAll();
    }

    public Optional<TypePlace> findById(Integer id) {
        return typePlaceRepository.findById(id);
    }

    public TypePlace save(TypePlace typePlace) {
        return typePlaceRepository.save(typePlace);
    }

    public void deleteById(Integer id) {
        typePlaceRepository.deleteById(id);
    }
}
