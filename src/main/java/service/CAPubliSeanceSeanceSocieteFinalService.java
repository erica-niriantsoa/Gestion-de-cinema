package service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.CAPubliSeanceSeanceSocieteFinal;
import repository.CAPubliSeanceSeanceSocieteFinalRepository;

/**
 * Service pour gérer les données de la vue v_ca_pub_seance_societe_final
 * Chiffre d'affaire des publicités par séance et par société
 */
@Service
public class CAPubliSeanceSeanceSocieteFinalService {

    @Autowired
    private CAPubliSeanceSeanceSocieteFinalRepository repository;

    private static final DateTimeFormatter MOIS_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM");
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    /**
     * Récupère toutes les données
     */
    public List<CAPubliSeanceSeanceSocieteFinal> findAll() {
        return repository.findAll();
    }

    /**
     * Récupère les données pour une société donnée
     */
    public List<CAPubliSeanceSeanceSocieteFinal> findBySociete(String societe) {
        return repository.findBySociete(societe);
    }

    /**
     * Récupère les données pour une société et un mois donnés
     */
    public List<CAPubliSeanceSeanceSocieteFinal> findBySocieteAndMois(String societe, YearMonth mois) {
        LocalDate moislocalDate = mois.atDay(1);
        return repository.findBySocieteAndMois(societe, moislocalDate);
    }

    /**
     * Récupère les données pour un mois donnée
     */
    public List<CAPubliSeanceSeanceSocieteFinal> findByMois(YearMonth mois) {
        LocalDate moisLocalDate = mois.atDay(1);
        return repository.findByMois(moisLocalDate);
    }

    /**
     * Récupère les données pour une plage de dates
     */
    public List<CAPubliSeanceSeanceSocieteFinal> findByDateRange(LocalDate dateDebut, LocalDate dateFin) {
        return repository.findByDateDiffusionBetween(dateDebut, dateFin);
    }

    /**
     * Récupère les données pour une société et une plage de dates
     */
    public List<CAPubliSeanceSeanceSocieteFinal> findBySocieteAndDateRange(String societe, LocalDate dateDebut, LocalDate dateFin) {
        return repository.findBySocieteAndDateRange(societe, dateDebut, dateFin);
    }

    /**
     * DTO pour l'affichage avec dates formatées
     */
    public static class CAPubliSeanceDTO {
        private String film;
        private String dateDiffusion;        // Formatée (dd/MM/yyyy)
        private String heureDiffusion;
        private String societe;
        private java.math.BigDecimal caDiffusion;
        private java.math.BigDecimal pourcentagePaye;
        private java.math.BigDecimal montantPayeDiffusion;
        private java.math.BigDecimal resteAPayerDiffusion;

        public CAPubliSeanceDTO(String film, LocalDate dateDiffusion, String heureDiffusion, String societe,
                               java.math.BigDecimal caDiffusion, java.math.BigDecimal pourcentagePaye,
                               java.math.BigDecimal montantPayeDiffusion, java.math.BigDecimal resteAPayerDiffusion) {
            this.film = film;
            this.dateDiffusion = dateDiffusion.format(DATE_FORMATTER);
            this.heureDiffusion = heureDiffusion;
            this.societe = societe;
            this.caDiffusion = caDiffusion;
            this.pourcentagePaye = pourcentagePaye;
            this.montantPayeDiffusion = montantPayeDiffusion;
            this.resteAPayerDiffusion = resteAPayerDiffusion;
        }

        // Getters
        public String getFilm() { return film; }
        public String getDateDiffusion() { return dateDiffusion; }
        public String getHeureDiffusion() { return heureDiffusion; }
        public String getSociete() { return societe; }
        public java.math.BigDecimal getCaDiffusion() { return caDiffusion; }
        public java.math.BigDecimal getPourcentagePaye() { return pourcentagePaye; }
        public java.math.BigDecimal getMontantPayeDiffusion() { return montantPayeDiffusion; }
        public java.math.BigDecimal getResteAPayerDiffusion() { return resteAPayerDiffusion; }
    }

    /**
     * Récupère les données formatées pour l'affichage pour une société et un mois
     */
    public List<CAPubliSeanceDTO> findBySocieteAndMoisFormatted(String societe, YearMonth mois) {
        return findBySocieteAndMois(societe, mois).stream()
            .map(c -> new CAPubliSeanceDTO(
                c.getFilm(),
                c.getDateDiffusion(),
                c.getHeureDiffusion(),
                c.getSociete(),
                c.getCaDiffusion(),
                c.getPourcentagePaye(),
                c.getMontantPayeDiffusion(),
                c.getResteAPayerDiffusion()
            ))
            .collect(Collectors.toList());
    }

    /**
     * Récupère les données formatées pour l'affichage pour un mois
     */
    public List<CAPubliSeanceDTO> findByMoisFormatted(YearMonth mois) {
        return findByMois(mois).stream()
            .map(c -> new CAPubliSeanceDTO(
                c.getFilm(),
                c.getDateDiffusion(),
                c.getHeureDiffusion(),
                c.getSociete(),
                c.getCaDiffusion(),
                c.getPourcentagePaye(),
                c.getMontantPayeDiffusion(),
                c.getResteAPayerDiffusion()
            ))
            .collect(Collectors.toList());
    }
}
