package controller.admin;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import entity.DiffusionPublicitaire;
import entity.Film;
import entity.Reservation;
import entity.ReservationComplete;
import entity.RevenuMaximalSeance;
import entity.Salle;
import entity.Seance;
import entity.Ticket;
import repository.ChiffreAffaireTotalMensuelRepository;
import repository.DiffusionPublicitaireRepository;
import repository.PersonneRepository;
import repository.PlaceRepository;
import repository.ReservationRepository;
import repository.SocieteRepository;
import repository.StatutReservationRepository;
import repository.StatutTicketRepository;
import repository.TarifDiffusionPublicitaireRepository;
import repository.TicketRepository;
import repository.TypePubliciteRepository;
import service.CAPubliSeanceSeanceSocieteFinalService;
import service.CategoriePersonneService;
import service.ChiffreAffaireSeanceAffichageService;
import service.FilmService;
import service.PubliciteService;
import service.ReservationCompleteService;
import service.RevenuMaximalSeanceService;
import service.SalleService;
import service.SeanceService;
import service.TarifDefautService;
import service.TypePlaceService;

@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    private FilmService filmService;

    @Autowired
    private SalleService salleService;

    @Autowired
    private SeanceService seanceService;

    @Autowired
    private TarifDefautService tarifDefautService;

    @Autowired
    private TypePlaceService typePlaceService;

    @Autowired
    private CategoriePersonneService categoriePersonneService;

    @Autowired
    private ReservationCompleteService reservationCompleteService;

    @Autowired
    private TicketRepository ticketRepository;

    @Autowired
    private ReservationRepository reservationRepository;

    @Autowired
    private PersonneRepository personneRepository;

    @Autowired
    private PlaceRepository placeRepository;

    @Autowired
    private StatutTicketRepository statutTicketRepository;

    @Autowired
    private StatutReservationRepository statutReservationRepository;

    @Autowired
    private DiffusionPublicitaireRepository diffusionPublicitaireRepository;

    @Autowired
    private SocieteRepository societeRepository;

    @Autowired
    private TypePubliciteRepository typePubliciteRepository;

    @Autowired
    private TarifDiffusionPublicitaireRepository tarifDiffusionPublicitaireRepository;

    @Autowired
    private RevenuMaximalSeanceService revenuMaximalSeanceService;

    @Autowired
    private PubliciteService publiciteService;

    @Autowired
    private CAPubliSeanceSeanceSocieteFinalService caPubliSeanceSeanceSocieteFinalService;

    @Autowired
    private ChiffreAffaireSeanceAffichageService chiffreAffaireSeanceAffichageService;

        @Autowired
    private ChiffreAffaireTotalMensuelRepository chiffreRepo;
    // ========== PAGE D'ACCUEIL ADMIN ==========
    @GetMapping("/accueil")
    public String accueil(Model model) {
        model.addAttribute("nbFilms", filmService.getAllFilms().size());
        model.addAttribute("nbSalles", salleService.findAll().size());
        model.addAttribute("nbSeances", seanceService.findAll().size());
        return "admin/accueil";
    }

    // ========== CRUD FILMS ==========
    @GetMapping("/films")
    public String listFilms(Model model) {
        model.addAttribute("films", filmService.getAllFilms());
        return "admin/films/liste";
    }

    @GetMapping("/films/nouveau")
    public String nouveauFilm(Model model) {
        model.addAttribute("film", new Film());
        return "admin/films/formulaire";
    }

    @GetMapping("/films/{id}/editer")
    public String editerFilm(@PathVariable("id") Long id, Model model) {
        Film film = filmService.getFilmById(id).orElse(null);
        if (film == null) {
            return "redirect:/admin/films?error=notFound";
        }
        model.addAttribute("film", film);
        return "admin/films/formulaire";
    }

    @PostMapping("/films/sauvegarder")
    public String sauvegarderFilm(@ModelAttribute Film film, RedirectAttributes redirectAttributes) {
        try {
            filmService.saveFilm(film);
            redirectAttributes.addFlashAttribute("success", "Film enregistré avec succès");
            return "redirect:/admin/films";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur: " + e.getMessage());
            return "redirect:/admin/films/nouveau";
        }
    }

    @GetMapping("/films/{id}/supprimer")
    public String supprimerFilm(@PathVariable("id") Long id, RedirectAttributes redirectAttributes) {
        try {
            // Vérifier si le film a des séances associées
            long nbSeances = filmService.countSeancesByFilm(id);
            if (nbSeances > 0) {
                redirectAttributes.addFlashAttribute("error",
                        "Impossible de supprimer ce film : il est utilisé dans " + nbSeances + " séance(s). Veuillez d'abord supprimer les séances associées.");
                return "redirect:/admin/films";
            }

            filmService.deleteFilm(id);
            redirectAttributes.addFlashAttribute("success", "Film supprimé avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Impossible de supprimer: " + e.getMessage());
        }
        return "redirect:/admin/films";
    }

    // ========== CRUD SALLES ==========
    @GetMapping("/salles")
    public String listSalles(Model model) {
        model.addAttribute("salles", salleService.findAll());
        return "admin/salles/liste";
    }

    @GetMapping("/salles/nouveau")
    public String nouvelleSalle(Model model) {
        model.addAttribute("salle", new Salle());
        return "admin/salles/formulaire";
    }

    @GetMapping("/salles/{id}/editer")
    public String editerSalle(@PathVariable("id") Integer id, Model model) {
        Salle salle = salleService.findById(id).orElse(null);
        if (salle == null) {
            return "redirect:/admin/salles?error=notFound";
        }
        model.addAttribute("salle", salle);
        return "admin/salles/formulaire";
    }

    @PostMapping("/salles/sauvegarder")
    public String sauvegarderSalle(@ModelAttribute Salle salle, RedirectAttributes redirectAttributes) {
        try {
            salleService.save(salle);
            redirectAttributes.addFlashAttribute("success", "Salle enregistrée avec succès");
            return "redirect:/admin/salles";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur: " + e.getMessage());
            return "redirect:/admin/salles/nouveau";
        }
    }

    @GetMapping("/salles/{id}/supprimer")
    public String supprimerSalle(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            // Vérifier si la salle a des séances associées
            long nbSeances = salleService.countSeancesBySalle(id);
            if (nbSeances > 0) {
                redirectAttributes.addFlashAttribute("error",
                        "Impossible de supprimer cette salle : elle est utilisée dans " + nbSeances + " séance(s). Veuillez d'abord supprimer les séances associées.");
                return "redirect:/admin/salles";
            }

            salleService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Salle supprimée avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Impossible de supprimer: " + e.getMessage());
        }
        return "redirect:/admin/salles";
    }

    @GetMapping("/sallesDetail")
    public String sallesDetail(Model model) {
        List<RevenuMaximalSeance> revenusMaximaux = revenuMaximalSeanceService.findAll();
        model.addAttribute("revenusMaximaux", revenusMaximaux);
        return "admin/salles/sallesDetail";
    }

    // ========== CRUD SEANCES ==========
    @GetMapping("/seances")
    public String listSeances(Model model) {
        List<Seance> seances = seanceService.findAll();
        seances.sort((s1, s2) -> {
            if (s1.getDebut() == null) {
                return 1;
            }
            if (s2.getDebut() == null) {
                return -1;
            }
            return s2.getDebut().compareTo(s1.getDebut());
        });
        model.addAttribute("seances", seances);
        return "admin/seances/liste";
    }

    @GetMapping("/seances/nouveau")
    public String nouvelleSeance(Model model) {
        model.addAttribute("seance", new Seance());
        model.addAttribute("films", filmService.getAllFilms());
        model.addAttribute("salles", salleService.findAll());
        return "admin/seances/formulaire";
    }

    @GetMapping("/seances/{id}/editer")
    public String editerSeance(@PathVariable("id") Integer id, Model model) {
        Seance seance = seanceService.findById(id).orElse(null);
        if (seance == null) {
            return "redirect:/admin/seances?error=notFound";
        }
        model.addAttribute("seance", seance);
        model.addAttribute("films", filmService.getAllFilms());
        model.addAttribute("salles", salleService.findAll());
        return "admin/seances/formulaire";
    }

    @PostMapping("/seances/sauvegarder")
    public String sauvegarderSeance(
            @RequestParam("filmId") Long filmId,
            @RequestParam("salleId") Integer salleId,
            @RequestParam("dateDebut") String dateDebut,
            @RequestParam("heureDebut") String heureDebut,
            @RequestParam(value = "langue", required = false) String langue,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {
        try {
            Seance seance = (id != null) ? seanceService.findById(id).orElse(null) : new Seance();
            if (seance == null) {
                seance = new Seance();
            }

            Film film = filmService.getFilmById(filmId).orElse(null);
            Salle salle = salleService.findById(salleId).orElse(null);

            if (film == null || salle == null) {
                redirectAttributes.addFlashAttribute("error", "Film ou salle introuvable");
                return "redirect:/admin/seances/nouveau";
            }

            ZonedDateTime debut = ZonedDateTime.of(
                    LocalDate.parse(dateDebut).atTime(Integer.parseInt(heureDebut.split(":")[0]),
                            Integer.parseInt(heureDebut.split(":")[1])),
                    ZoneId.of("Europe/Paris")
            );

            ZonedDateTime fin = debut.plusMinutes(film.getDureeMinutes() != null ? film.getDureeMinutes() : 120);

            seance.setFilm(film);
            seance.setSalle(salle);
            seance.setDebut(debut);
            seance.setFin(fin);
            seance.setLangue(langue);

            seanceService.save(seance);
            redirectAttributes.addFlashAttribute("success", "Séance enregistrée avec succès");
            return "redirect:/admin/seances";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Erreur: " + e.getMessage());
            return "redirect:/admin/seances/nouveau";
        }
    }

    @GetMapping("/seances/{id}/supprimer")
    public String supprimerSeance(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            // Vérifier si la séance a des tickets associés
            long nbTickets = seanceService.countTicketsBySeance(id);
            long nbReservations = seanceService.countReservationsBySeance(id);

            if (nbTickets > 0 || nbReservations > 0) {
                StringBuilder message = new StringBuilder("Impossible de supprimer cette séance : ");
                if (nbTickets > 0) {
                    message.append(nbTickets).append(" ticket(s) vendu(s)");
                }
                if (nbReservations > 0) {
                    if (nbTickets > 0) {
                        message.append(" et ");
                    }
                    message.append(nbReservations).append(" réservation(s)");
                }
                message.append(". Veuillez d'abord les supprimer.");
                redirectAttributes.addFlashAttribute("error", message.toString());
                return "redirect:/admin/seances";
            }

            seanceService.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Séance supprimée avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Impossible de supprimer: " + e.getMessage());
        }
        return "redirect:/admin/seances";
    }

    // ========== GESTION TICKETS ==========
    @GetMapping("/tickets")
    public String listTickets(Model model) {
        List<Ticket> tickets = ticketRepository.findAll();
        // Charger les relations nécessaires
        tickets.forEach(ticket -> {
            if (ticket.getSeance() != null) {
                ticket.getSeance().getFilm(); // Charger le film
                ticket.getSeance().getSalle(); // Charger la salle
            }
            ticket.getPlace(); // Charger la place
            ticket.getCategoriePersonne(); // Charger la catégorie
            ticket.getStatut(); // Charger le statut
            if (ticket.getReservation() != null) {
                ticket.getReservation().getPersonne(); // Charger la personne
            }
        });
        model.addAttribute("tickets", tickets);
        return "admin/tickets/liste";
    }

    @GetMapping("/tickets/nouveau")
    public String nouveauTicket(Model model) {
        model.addAttribute("ticket", new Ticket());
        model.addAttribute("seances", seanceService.findAll());
        model.addAttribute("places", placeRepository.findAll());
        model.addAttribute("categories", categoriePersonneService.findAll());
        model.addAttribute("statuts", statutTicketRepository.findAll());
        model.addAttribute("reservations", reservationRepository.findAll());
        return "admin/tickets/formulaire";
    }

    @GetMapping("/tickets/{id}/editer")
    public String editerTicket(@PathVariable("id") Integer id, Model model) {
        Ticket ticket = ticketRepository.findById(id).orElse(null);
        if (ticket == null) {
            return "redirect:/admin/tickets?error=notFound";
        }
        model.addAttribute("ticket", ticket);
        model.addAttribute("seances", seanceService.findAll());
        model.addAttribute("places", placeRepository.findAll());
        model.addAttribute("categories", categoriePersonneService.findAll());
        model.addAttribute("statuts", statutTicketRepository.findAll());
        model.addAttribute("reservations", reservationRepository.findAll());
        return "admin/tickets/formulaire";
    }

    @PostMapping("/tickets/sauvegarder")
    public String sauvegarderTicket(
            @RequestParam("seanceId") Integer seanceId,
            @RequestParam("placeId") Integer placeId,
            @RequestParam("categorieId") Integer categorieId,
            @RequestParam("statutId") Integer statutId,
            @RequestParam(value = "reservationId", required = false) Integer reservationId,
            @RequestParam("prix") java.math.BigDecimal prix,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {
        try {
            Ticket ticket = (id != null) ? ticketRepository.findById(id).orElse(new Ticket()) : new Ticket();
            
            ticket.setSeance(seanceService.findById(seanceId).orElse(null));
            ticket.setPlace(placeRepository.findById(placeId).orElse(null));
            ticket.setCategoriePersonne(categoriePersonneService.findById(categorieId).orElse(null));
            ticket.setStatut(statutTicketRepository.findById(statutId).orElse(null));
            if (reservationId != null) {
                ticket.setReservation(reservationRepository.findById(reservationId).orElse(null));
            }
            ticket.setPrix(prix);
            
            ticketRepository.save(ticket);
            redirectAttributes.addFlashAttribute("success", "Ticket enregistré avec succès");
            return "redirect:/admin/tickets";
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Erreur: " + e.getMessage());
            return "redirect:/admin/tickets/nouveau";
        }
    }

    @GetMapping("/tickets/{id}/supprimer")
    public String supprimerTicket(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            ticketRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Ticket supprimé avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Impossible de supprimer: " + e.getMessage());
        }
        return "redirect:/admin/tickets";
    }

    // ========== GESTION RESERVATIONS (CRUD) ==========
    @GetMapping("/reservations")
    public String listReservations(Model model) {
        List<ReservationComplete> reservations = reservationCompleteService.findAll();
        model.addAttribute("reservations", reservations);
        return "client/reservationDetail";
    }

    @GetMapping("/reservations/liste")
    public String listeReservationsAdmin(Model model) {
        List<Reservation> reservations = reservationRepository.findAll();
        model.addAttribute("reservations", reservations);
        return "admin/reservations/liste";
    }

    @GetMapping("/reservations/nouveau")
    public String nouvelleReservation(Model model) {
        model.addAttribute("reservation", new Reservation());
        model.addAttribute("personnes", personneRepository.findAll());
        model.addAttribute("seances", seanceService.findAll());
        model.addAttribute("statuts", statutReservationRepository.findAll());
        return "admin/reservations/formulaire";
    }

    @GetMapping("/reservations/{id}/editer")
    public String editerReservation(@PathVariable("id") Integer id, Model model) {
        Reservation reservation = reservationRepository.findById(id).orElse(null);
        if (reservation == null) {
            return "redirect:/admin/reservations/liste?error=notFound";
        }
        model.addAttribute("reservation", reservation);
        model.addAttribute("personnes", personneRepository.findAll());
        model.addAttribute("seances", seanceService.findAll());
        model.addAttribute("statuts", statutReservationRepository.findAll());
        return "admin/reservations/formulaire";
    }

    @PostMapping("/reservations/sauvegarder")
    public String sauvegarderReservation(
            @RequestParam("personneId") Long personneId,
            @RequestParam("seanceId") Integer seanceId,
            @RequestParam("statutId") Integer statutId,
            @RequestParam("montantTotal") java.math.BigDecimal montantTotal,
            @RequestParam(value = "dateReservation", required = false) String dateReservation,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {
        try {
            Reservation reservation = (id != null) ? reservationRepository.findById(id).orElse(new Reservation()) : new Reservation();
            
            reservation.setPersonne(personneRepository.findById(personneId).orElse(null));
            reservation.setSeance(seanceService.findById(seanceId).orElse(null));
            reservation.setStatut(statutReservationRepository.findById(statutId).orElse(null));
            reservation.setMontantTotal(montantTotal);
            
            if (dateReservation != null && !dateReservation.isEmpty()) {
                reservation.setDateReservation(ZonedDateTime.parse(dateReservation + ":00+01:00[Europe/Paris]"));
            } else if (reservation.getDateReservation() == null) {
                reservation.setDateReservation(ZonedDateTime.now(ZoneId.of("Europe/Paris")));
            }
            
            reservationRepository.save(reservation);
            redirectAttributes.addFlashAttribute("success", "Réservation enregistrée avec succès");
            return "redirect:/admin/reservations/liste";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Erreur: " + e.getMessage());
            return "redirect:/admin/reservations/nouveau";
        }
    }

    @GetMapping("/reservations/{id}/supprimer")
    public String supprimerReservation(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            // Vérifier les tickets associés
            long nbTickets = ticketRepository.countByReservationId(id);
            if (nbTickets > 0) {
                redirectAttributes.addFlashAttribute("error", 
                    "Impossible de supprimer: " + nbTickets + " ticket(s) associé(s)");
                return "redirect:/admin/reservations/liste";
            }
            reservationRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Réservation supprimée avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Impossible de supprimer: " + e.getMessage());
        }
        return "redirect:/admin/reservations/liste";
    }

    // ========== GESTION PUBLICITES ==========
@GetMapping("/publicite")
public String gestionPublicite(Model model) {
    // Récupérer toutes les données de chiffre d'affaire mensuel formatées
    List<PubliciteService.SoldeDTO> chiffres = publiciteService.getChiffreAffaireMensuel();
    model.addAttribute("chiffres", chiffres);
    return "admin/publicite/liste";
}

    @GetMapping("/publicite/nouveau")
    public String nouvellePublicite(Model model) {
        model.addAttribute("publicite", new DiffusionPublicitaire());
        model.addAttribute("seances", seanceService.findAll());
        model.addAttribute("societes", societeRepository.findAll());
        model.addAttribute("typesPublicite", typePubliciteRepository.findAll());
        model.addAttribute("tarifs", tarifDiffusionPublicitaireRepository.findAll());
        return "admin/publicite/formulaire";
    }

    @GetMapping("/publicite/{id}/editer")
    public String editerPublicite(@PathVariable("id") Integer id, Model model) {
        DiffusionPublicitaire publicite = diffusionPublicitaireRepository.findById(id).orElse(null);
        if (publicite == null) {
            return "redirect:/admin/publicite?error=notFound";
        }
        model.addAttribute("publicite", publicite);
        model.addAttribute("seances", seanceService.findAll());
        model.addAttribute("societes", societeRepository.findAll());
        model.addAttribute("typesPublicite", typePubliciteRepository.findAll());
        model.addAttribute("tarifs", tarifDiffusionPublicitaireRepository.findAll());
        return "admin/publicite/formulaire";
    }

    @PostMapping("/publicite/sauvegarder")
    public String sauvegarderPublicite(
            @RequestParam("seanceId") Integer seanceId,
            @RequestParam("societeId") Integer societeId,
            @RequestParam("typePubliciteId") Integer typePubliciteId,
            @RequestParam("tarifId") Integer tarifId,
            @RequestParam("dateDiffusion") String dateDiffusion,
            @RequestParam(value = "id", required = false) Integer id,
            RedirectAttributes redirectAttributes) {
        try {
            DiffusionPublicitaire publicite = (id != null) ? diffusionPublicitaireRepository.findById(id).orElse(new DiffusionPublicitaire()) : new DiffusionPublicitaire();
            
            publicite.setIdSeance(seanceId);
            publicite.setSociete(societeRepository.findById(societeId).orElse(null));
            publicite.setTypePublicite(typePubliciteRepository.findById(typePubliciteId).orElse(null));
            publicite.setTarif(tarifDiffusionPublicitaireRepository.findById(tarifId).orElse(null));
            publicite.setDateDiffusion(LocalDate.parse(dateDiffusion));
            
            diffusionPublicitaireRepository.save(publicite);
            redirectAttributes.addFlashAttribute("success", "Publicité enregistrée avec succès");
            return "redirect:/admin/publicite";
        } catch (Exception e) {
            e.printStackTrace();
            redirectAttributes.addFlashAttribute("error", "Erreur: " + e.getMessage());
            return "redirect:/admin/publicite/nouveau";
        }
    }

    @GetMapping("/publicite/{id}/supprimer")
    public String supprimerPublicite(@PathVariable("id") Integer id, RedirectAttributes redirectAttributes) {
        try {
            diffusionPublicitaireRepository.deleteById(id);
            redirectAttributes.addFlashAttribute("success", "Publicité supprimée avec succès");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Impossible de supprimer: " + e.getMessage());
        }
        return "redirect:/admin/publicite";
    }

    // ========== CHIFFRE D'AFFAIRE PUBLICITE PAR SEANCE ET SOCIETE ==========
    /**
     * Affiche le chiffre d'affaire des publicités par séance et par société
     * Filtrable par société et par mois
     */
    @GetMapping("/publicite/seance-societe")
    public String chiffreAffairePubliciteSeanceSociete(
            @RequestParam(value = "societe", required = false) String societe,
            @RequestParam(value = "mois", required = false) String mois,
            Model model) {
        
        try {
            java.util.List<CAPubliSeanceSeanceSocieteFinalService.CAPubliSeanceDTO> donnees;

            if (societe != null && !societe.isEmpty() && mois != null && !mois.isEmpty()) {
                // Filtrer par société et mois
                YearMonth yearMonth = YearMonth.parse(mois);
                donnees = caPubliSeanceSeanceSocieteFinalService.findBySocieteAndMoisFormatted(societe, yearMonth);
                model.addAttribute("filtreApplique", true);
                model.addAttribute("societeFiltree", societe);
                model.addAttribute("moisFiltre", mois);
            } else if (mois != null && !mois.isEmpty()) {
                // Filtrer par mois uniquement
                YearMonth yearMonth = YearMonth.parse(mois);
                donnees = caPubliSeanceSeanceSocieteFinalService.findByMoisFormatted(yearMonth);
                model.addAttribute("filtreApplique", true);
                model.addAttribute("moisFiltre", mois);
            } else {
                // Afficher tous les enregistrements
                donnees = caPubliSeanceSeanceSocieteFinalService.findAll()
                    .stream()
                    .map(c -> new CAPubliSeanceSeanceSocieteFinalService.CAPubliSeanceDTO(
                        c.getFilm(),
                        c.getDateDiffusion(),
                        c.getHeureDiffusion(),
                        c.getSociete(),
                        c.getCaDiffusion(),
                        c.getPourcentagePaye(),
                        c.getMontantPayeDiffusion(),
                        c.getResteAPayerDiffusion()
                    ))
                    .collect(java.util.stream.Collectors.toList());
            }

            model.addAttribute("caPubliSeances", donnees);
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la récupération des données: " + e.getMessage());
        }

        return "admin/publicite/seance-societe";
    }

    // ========== CHIFFRE D'AFFAIRE TOTAL PAR SEANCE ==========
    /**
     * Affiche le chiffre d'affaire total (tickets + publicités + extras) par séance
     * Filtrable par mois
     */
    @GetMapping("/publicite/seance-affichage")
    public String chiffreAffaireSeanceAffichage(
            @RequestParam(value = "mois", required = false) String mois,
            Model model) {
        
        try {
            java.util.List<ChiffreAffaireSeanceAffichageService.ChiffreAffaireSeanceDTO> donnees;

            if (mois != null && !mois.isEmpty()) {
                // Filtrer par mois
                YearMonth yearMonth = YearMonth.parse(mois);
                donnees = chiffreAffaireSeanceAffichageService.findByMoisFormatted(yearMonth);
                model.addAttribute("filtreApplique", true);
                model.addAttribute("moisFiltre", mois);
            } else {
                // Afficher tous les enregistrements
                donnees = chiffreAffaireSeanceAffichageService.findAll()
                    .stream()
                    .map(c -> new ChiffreAffaireSeanceAffichageService.ChiffreAffaireSeanceDTO(
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
                    .collect(java.util.stream.Collectors.toList());
            }

            model.addAttribute("caSeances", donnees);
        } catch (Exception e) {
            model.addAttribute("error", "Erreur lors de la récupération des données: " + e.getMessage());
        }

        return "admin/publicite/seance-affichage";
    }

}

