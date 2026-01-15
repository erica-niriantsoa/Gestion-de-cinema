package service;

import entity.RevenuMaximalSeance;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import repository.RevenuMaximalSeanceRepository;

import java.math.BigDecimal;
import java.util.List;
import java.util.Optional;

@Service
@Transactional(readOnly = true)
public class RevenuMaximalSeanceService {

    @Autowired
    private RevenuMaximalSeanceRepository revenuMaximalSeanceRepository;

    /**
     * Récupère tous les revenus maximaux de toutes les séances
     */
    public List<RevenuMaximalSeance> findAll() {
        return revenuMaximalSeanceRepository.findAll();
    }

    /**
     * Récupère le revenu maximal d'une séance par son ID
     */
    public Optional<RevenuMaximalSeance> findBySeanceId(Integer seanceId) {
        return revenuMaximalSeanceRepository.findBySeanceId(seanceId);
    }

    /**
     * Récupère les revenus maximaux de toutes les séances d'une salle
     */
    public List<RevenuMaximalSeance> findBySalleId(Integer salleId) {
        return revenuMaximalSeanceRepository.findBySalleId(salleId);
    }

    /**
     * Récupère les revenus maximaux de toutes les séances d'un film
     */
    public List<RevenuMaximalSeance> findByFilmTitre(String filmTitre) {
        return revenuMaximalSeanceRepository.findByFilmTitre(filmTitre);
    }

    /**
     * Récupère toutes les séances triées par revenu maximal décroissant
     */
    public List<RevenuMaximalSeance> findAllOrderByRevenuMaximalDesc() {
        return revenuMaximalSeanceRepository.findAllOrderByRevenuMaximalDesc();
    }

    /**
     * Calcule le revenu maximal total de toutes les séances
     */
    public BigDecimal calculateTotalRevenuMaximal() {
        return revenuMaximalSeanceRepository.findAll().stream()
                .map(RevenuMaximalSeance::getRevenuMaximal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    /**
     * Calcule le revenu maximal total pour une salle spécifique
     */
    public BigDecimal calculateTotalRevenuMaximalBySalle(Integer salleId) {
        return revenuMaximalSeanceRepository.findBySalleId(salleId).stream()
                .map(RevenuMaximalSeance::getRevenuMaximal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    /**
     * Calcule le revenu maximal total pour un film spécifique
     */
    public BigDecimal calculateTotalRevenuMaximalByFilm(String filmTitre) {
        return revenuMaximalSeanceRepository.findByFilmTitre(filmTitre).stream()
                .map(RevenuMaximalSeance::getRevenuMaximal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
    }

    /**
     * Trouve la séance avec le plus grand revenu maximal
     */
    public Optional<RevenuMaximalSeance> findSeanceWithHighestRevenu() {
        List<RevenuMaximalSeance> seances = revenuMaximalSeanceRepository.findAllOrderByRevenuMaximalDesc();
        return seances.isEmpty() ? Optional.empty() : Optional.of(seances.get(0));
    }
}
