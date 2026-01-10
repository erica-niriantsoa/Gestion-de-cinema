package service;

import entity.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.ReservationRepository;

import java.util.List;
import java.util.Optional;
import org.springframework.transaction.annotation.Transactional;
import entity.Seance;
import entity.Place;
import entity.CategoriePersonne;
import entity.Ticket;
import entity.StatutTicket;
import entity.StatutReservation;
import repository.TicketRepository;
import service.SeanceService;
import service.PlaceService;
import service.CategoriePersonneService;
import service.TarifService;
import service.StatutTicketService;
import service.PersonneService;
import java.math.BigDecimal;
import java.util.Map;
import java.util.List;
import java.util.ArrayList;
import java.time.ZonedDateTime;
import java.util.Optional;

@Service
public class ReservationService {

    @Autowired
    private ReservationRepository reservationRepository;

    public List<Reservation> findAll() {
        return reservationRepository.findAll();
    }

    public Optional<Reservation> findById(Integer id) {
        return reservationRepository.findById(id);
    }

    public Reservation save(Reservation reservation) {
        return reservationRepository.save(reservation);
    }

    public void deleteById(Integer id) {
        reservationRepository.deleteById(id);
    }

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private SeanceService seanceService;

    @Autowired
    private PlaceService placeService;

    @Autowired
    private CategoriePersonneService categoriePersonneService;

    @Autowired
    private TarifService tarifService;

    @Autowired
    private StatutTicketService statutTicketService;

    @Autowired
    private StatutReservationService statutReservationService;
    
    @Autowired
    private PersonneService personneService;

    @Transactional
    public Reservation createReservation(Integer seanceId, List<Map<String, Object>> selections, Long personneId) {
        Optional<Seance> seanceOpt = seanceService.findById(seanceId);
        if (seanceOpt.isEmpty()) {
            throw new IllegalArgumentException("Séance introuvable");
        }
        Seance seance = seanceOpt.get();

        // Vérifier disponibilité et calculer total
        BigDecimal total = BigDecimal.ZERO;
        List<Ticket> ticketsToSave = new ArrayList<>();

        List<String> busyCodes = List.of("RESERVE", "PAYE");

        for (Map<String, Object> sel : selections) {
            Number placeNum = (Number) sel.get("placeId");
            Number catNum = (Number) sel.get("categorieId");
            if (placeNum == null || catNum == null) continue;
            Integer placeId = placeNum.intValue();
            Integer categorieId = catNum.intValue();

            if (ticketRepository.existsBySeance_IdAndPlace_IdAndStatut_CodeIn(seanceId, placeId, busyCodes)) {
                throw new IllegalStateException("Place déjà réservée: " + placeId);
            }

            Optional<Place> placeOpt = placeService.findById(placeId);
            Optional<CategoriePersonne> catOpt = categoriePersonneService.findById(categorieId);
            if (placeOpt.isEmpty() || catOpt.isEmpty()) {
                throw new IllegalArgumentException("Place ou catégorie invalide");
            }

            Place place = placeOpt.get();
            CategoriePersonne cat = catOpt.get();

            // Calcul prix: tarif seance sinon tarif defaut
            BigDecimal prix = BigDecimal.ZERO;
            List<?> seanceTarifs = tarifService.findBySeance(seanceId);
            if (seanceTarifs != null && !seanceTarifs.isEmpty() && place.getTypePlace() != null) {
                for (Object o : seanceTarifs) {
                    try {
                        entity.TarifSeance ts = (entity.TarifSeance) o;
                        if (ts.getTypePlace() != null && ts.getCategoriePersonne() != null
                                && ts.getTypePlace().getId().equals(place.getTypePlace().getId())
                                && ts.getCategoriePersonne().getId().equals(cat.getId())) {
                            prix = ts.getPrix();
                            break;
                        }
                    } catch (ClassCastException ignore) {
                    }
                }
            }
            if (BigDecimal.ZERO.equals(prix)) {
                List<?> defauts = tarifService.findDefautsByTypeAndCategorie(
                        place.getTypePlace() != null ? place.getTypePlace().getId() : null,
                        cat.getId());
                if (defauts != null && !defauts.isEmpty()) {
                    try {
                        entity.TarifDefaut td = (entity.TarifDefaut) defauts.get(0);
                        prix = td.getPrix();
                    } catch (ClassCastException ignore) {
                    }
                }
            }

            total = total.add(prix != null ? prix : BigDecimal.ZERO);

            Ticket t = new Ticket();
            t.setSeance(seance);
            t.setPlace(place);
            t.setCategoriePersonne(cat);
            t.setPrix(prix);
            // statut will be set after saving reservation
            ticketsToSave.add(t);
        }

        // Create reservation
        Reservation reservation = new Reservation();
        reservation.setSeance(seance);
        reservation.setMontantTotal(total);
        reservation.setDateReservation(ZonedDateTime.now());
        
        // Set personne if provided
        if (personneId != null) {
            personneService.findById(personneId).ifPresent(reservation::setPersonne);
        }

        // statut PAYE since payment is integrated
        try {
            Optional<entity.StatutReservation> statOpt = statutReservationService.findAll().stream()
                    .filter(s -> "PAYE".equals(s.getCode()))
                    .findFirst();
            statOpt.ifPresent(reservation::setStatut);
        } catch (Exception ignored) {
        }

        Reservation saved = reservationRepository.save(reservation);

        // persist tickets linked to reservation
        Optional<StatutTicket> defaultStat = statutTicketService.findByCode("PAYE");
        StatutTicket reservStat = defaultStat.orElse(null);

        for (Ticket t : ticketsToSave) {
            t.setReservation(saved);
            if (reservStat != null) t.setStatut(reservStat);
            ticketRepository.save(t);
        }

        return saved;
    }
}
