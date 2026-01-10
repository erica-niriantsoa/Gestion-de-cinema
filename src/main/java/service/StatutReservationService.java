package service;

import entity.StatutReservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.StatutReservationRepository;

import java.util.List;
import java.util.Optional;

@Service
public class StatutReservationService {

    @Autowired
    private StatutReservationRepository statutReservationRepository;

    public List<StatutReservation> findAll() {
        return statutReservationRepository.findAll();
    }

    public Optional<StatutReservation> findById(Integer id) {
        return statutReservationRepository.findById(id);
    }

    public StatutReservation save(StatutReservation s) {
        return statutReservationRepository.save(s);
    }

    public void deleteById(Integer id) {
        statutReservationRepository.deleteById(id);
    }
}
