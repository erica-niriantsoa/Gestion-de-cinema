package service;

import entity.StatutReservation;
import repository.StatutReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class StatutReservationService {

    @Autowired
    private StatutReservationRepository statutReservationRepository;

    public List<StatutReservation> getAllStatutReservations() {
        return statutReservationRepository.findAll();
    }

    public Optional<StatutReservation> getStatutReservationById(Long id) {
        return statutReservationRepository.findById(id);
    }

    public Optional<StatutReservation> getStatutReservationByCode(String code) {
        return statutReservationRepository.findByCode(code);
    }

    public StatutReservation saveStatutReservation(StatutReservation statutReservation) {
        return statutReservationRepository.save(statutReservation);
    }

    public void deleteStatutReservation(Long id) {
        statutReservationRepository.deleteById(id);
    }
}
