package service;

import entity.ReservationComplete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.ReservationCompleteRepository;

import java.util.List;

@Service
public class ReservationCompleteService {

    @Autowired
    private ReservationCompleteRepository reservationCompleteRepository;

    public List<ReservationComplete> findAll() {
        return reservationCompleteRepository.findAll();
    }

    public ReservationComplete findById(Integer id) {
        return reservationCompleteRepository.findById(id).orElse(null);
    }
}