package service;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import entity.ChiffreAffaireSeanceAffichage;
import repository.ChiffreAffaireSeanceAffichageRepository;

/**
 * Service pour gérer les données de la vue v_chiffre_affaire_seance_affichage
 * Chiffre d'affaire total (tickets + publicités + produits extra) par séance
 */
@Service
public class ChiffreAffaireSeanceAffichageService {

    @Autowired
    private ChiffreAffaireSeanceAffichageRepository repository;

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    /**
     * Récupère toutes les données
     */
    public List<ChiffreAffaireSeanceAffichage> findAll() {
        return repository.findAll();
    }

    /**
     * Récupère les données pour une date donnée
     */
    public List<ChiffreAffaireSeanceAffichage> findByDate(LocalDate date) {
        return repository.findByDateDiffusion(date);
    }

    /**
     * Récupère les données pour un film donné
     */
    public List<ChiffreAffaireSeanceAffichage> findByFilm(String film) {
        return repository.findByFilm(film);
    }

    /**
     * Récupère les données pour un mois donné
     */
    public List<ChiffreAffaireSeanceAffichage> findByMois(YearMonth mois) {
        LocalDate debutMois = mois.atDay(1);
        LocalDate finMois = mois.atEndOfMonth();
        return repository.findByMois(debutMois, finMois);
    }

    /**
     * Récupère les données pour une plage de dates
     */
    public List<ChiffreAffaireSeanceAffichage> findByDateRange(LocalDate dateDebut, LocalDate dateFin) {
        return repository.findByDateDiffusionBetween(dateDebut, dateFin);
    }

    /**
     * Récupère les données pour un film et une plage de dates
     */
    public List<ChiffreAffaireSeanceAffichage> findByFilmAndDateRange(String film, LocalDate dateDebut, LocalDate dateFin) {
        return repository.findByFilmAndDateRange(film, dateDebut, dateFin);
    }

    /**
     * DTO pour l'affichage avec dates formatées
     */
    public static class ChiffreAffaireSeanceDTO {
        private String film;
        private String dateDiffusion;        // Formatée (dd/MM/yyyy)
        private String heureDiffusion;
        private java.math.BigDecimal montantTicket;
        private java.math.BigDecimal montantPubTotal;
        private java.math.BigDecimal montantPubPaye;
        private java.math.BigDecimal montantPubRestant;
        private java.math.BigDecimal montantExtra;
        private java.math.BigDecimal caTotal;
        private java.math.BigDecimal caEncaisse;
        private java.math.BigDecimal caRestant;

        public ChiffreAffaireSeanceDTO(String film, LocalDate dateDiffusion, String heureDiffusion,
                                      java.math.BigDecimal montantTicket, java.math.BigDecimal montantPubTotal,
                                      java.math.BigDecimal montantPubPaye, java.math.BigDecimal montantPubRestant,
                                      java.math.BigDecimal montantExtra,
                                      java.math.BigDecimal caTotal, java.math.BigDecimal caEncaisse,
                                      java.math.BigDecimal caRestant) {
            this.film = film;
            this.dateDiffusion = dateDiffusion.format(DATE_FORMATTER);
            this.heureDiffusion = heureDiffusion;
            this.montantTicket = montantTicket;
            this.montantPubTotal = montantPubTotal;
            this.montantPubPaye = montantPubPaye;
            this.montantPubRestant = montantPubRestant;
            this.montantExtra = montantExtra;
            this.caTotal = caTotal;
            this.caEncaisse = caEncaisse;
            this.caRestant = caRestant;
        }

        // Getters
        public String getFilm() { return film; }
        public String getDateDiffusion() { return dateDiffusion; }
        public String getHeureDiffusion() { return heureDiffusion; }
        public java.math.BigDecimal getMontantTicket() { return montantTicket; }
        public java.math.BigDecimal getMontantPubTotal() { return montantPubTotal; }
        public java.math.BigDecimal getMontantPubPaye() { return montantPubPaye; }
        public java.math.BigDecimal getMontantPubRestant() { return montantPubRestant; }
        public java.math.BigDecimal getMontantExtra() { return montantExtra; }
        public java.math.BigDecimal getCaTotal() { return caTotal; }
        public java.math.BigDecimal getCaEncaisse() { return caEncaisse; }
        public java.math.BigDecimal getCaRestant() { return caRestant; }
    }

    /**
     * Récupère les données formatées pour l'affichage pour un mois
     */
    public List<ChiffreAffaireSeanceDTO> findByMoisFormatted(YearMonth mois) {
        return findByMois(mois).stream()
            .map(c -> new ChiffreAffaireSeanceDTO(
                c.getFilm(),
                c.getDateDiffusion(),
                c.getHeureDiffusion(),
                c.getMontantTicket(),
                c.getMontantPubTotal(),
                c.getMontantPubPaye(),
                c.getMontantPubRestant(),
                c.getMontantExtra(),
                c.getCaTotal(),
                c.getCaEncaisse(),
                c.getCaRestant()
            ))
            .collect(Collectors.toList());
    }

    /**
     * Récupère les données formatées pour l'affichage pour une plage de dates
     */
    public List<ChiffreAffaireSeanceDTO> findByDateRangeFormatted(LocalDate dateDebut, LocalDate dateFin) {
        return findByDateRange(dateDebut, dateFin).stream()
            .map(c -> new ChiffreAffaireSeanceDTO(
                c.getFilm(),
                c.getDateDiffusion(),
                c.getHeureDiffusion(),
                c.getMontantTicket(),
                c.getMontantPubTotal(),
                c.getMontantPubPaye(),
                c.getMontantPubRestant(),
                c.getMontantExtra(),
                c.getCaTotal(),
                c.getCaEncaisse(),
                c.getCaRestant()
            ))
            .collect(Collectors.toList());
    }
}
