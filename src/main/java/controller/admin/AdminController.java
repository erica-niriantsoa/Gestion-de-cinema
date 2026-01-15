package controller.admin;

import entity.*;
import repository.TicketRepository;
import service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.time.ZoneId;
import java.util.List;

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
    private RevenuMaximalSeanceService revenuMaximalSeanceService;
    
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
            if (s1.getDebut() == null) return 1;
            if (s2.getDebut() == null) return -1;
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
            if (seance == null) seance = new Seance();
            
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
                    if (nbTickets > 0) message.append(" et ");
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
    
    // ========== GESTION RESERVATIONS ==========
    @GetMapping("/reservations")
    public String listReservations(Model model) {
        List<ReservationComplete> reservations = reservationCompleteService.findAll();
        model.addAttribute("reservations", reservations);
        return "client/reservationDetail";
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
}
