package service;

import entity.HistoriqueStatutReservation;
import repository.HistoriqueStatutReservationRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class HistoriqueStatutReservationService {

    @Autowired
    private HistoriqueStatutReservationRepository historiqueStatutReservationRepository;

    public List<HistoriqueStatutReservation> getAllHistoriqueStatutReservations() {
        return historiqueStatutReservationRepository.findAll();
    }

    public Optional<HistoriqueStatutReservation> getHistoriqueStatutReservationById(Long id) {
        return historiqueStatutReservationRepository.findById(id);
    }

    public List<HistoriqueStatutReservation> getHistoriqueStatutReservationsByReservationId(Long reservationId) {
        return historiqueStatutReservationRepository.findByReservationId(reservationId);
    }

    public HistoriqueStatutReservation saveHistoriqueStatutReservation(HistoriqueStatutReservation historiqueStatutReservation) {
        return historiqueStatutReservationRepository.save(historiqueStatutReservation);
    }

    public void deleteHistoriqueStatutReservation(Long id) {
        historiqueStatutReservationRepository.deleteById(id);
    }
}
