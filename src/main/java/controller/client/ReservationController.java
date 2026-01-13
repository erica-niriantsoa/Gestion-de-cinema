package controller.client;

import entity.*;
import service.*;
import repository.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.*;
import java.util.Map;
import java.util.HashMap;
import java.util.stream.Collectors;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
@RequestMapping("/client")
public class ReservationController {
    
    @Autowired
    private SeanceService seanceService;
    
    @Autowired
    private PlaceService placeService;
    
    @Autowired
    private CategoriePersonneService categoriePersonneService;
    
    @Autowired
    private ReservationService reservationService;
    
    @Autowired
    private PersonneService personneService;
    
    @Autowired
    private TicketRepository ticketRepository;
    
    @Autowired
    private ReservationCompleteService reservationCompleteService;
    
    
    @GetMapping("/seances/{seanceId}/reserver")
    public String showReservationPage(@PathVariable("seanceId") Integer seanceId, Model model) {
        try {
            Optional<Seance> seanceOpt = seanceService.findById(seanceId);
            if (seanceOpt.isEmpty()) {
                return "redirect:/client/seances?error=seanceNotFound";
            }
            Seance seance = seanceOpt.get();
            
            List<Place> allPlaces = placeService.findAll();
            List<Place> places = allPlaces.stream()
                .filter(p -> p.getSalle().getId().equals(seance.getSalle().getId()))
                .collect(Collectors.toList());
            
            
            List<Ticket> tickets = ticketRepository.findAll().stream()
                .filter(t -> t.getSeance().getId().equals(seanceId))
                .collect(Collectors.toList());
            Set<Integer> reservedPlaceIds = tickets.stream()
                .map(t -> t.getPlace().getId())
                .collect(Collectors.toSet());
            
            List<CategoriePersonne> categories = categoriePersonneService.findAll();
            
            // Convertir en JSON pour le JS
            ObjectMapper mapper = new ObjectMapper();
            String categoriesJson = mapper.writeValueAsString(categories);
            
            model.addAttribute("seance", seance);
            model.addAttribute("places", places);
            model.addAttribute("reservedPlaceIds", reservedPlaceIds);
            model.addAttribute("categories", categories);
            model.addAttribute("categoriesJson", categoriesJson);
            model.addAttribute("pageTitle", "Réservation - " + (seance.getFilm() != null ? seance.getFilm().getTitre() : ""));
            
            return "client/reservation";
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/client/seances?error=system";
        }
    }

    @PostMapping("/reservation/confirmer")
    @ResponseBody
    public Map<String, Object> confirmerReservation(@RequestBody Map<String, Object> payload) {
        Map<String, Object> resp = new HashMap<>();
        try {
            Object seanceIdObj = payload.get("seanceId");
            Integer seanceId = seanceIdObj instanceof Number ? ((Number) seanceIdObj).intValue() : null;
            List<Map<String, Object>> selections = (List<Map<String, Object>>) payload.get("selections");
            
            String nomComplet = (String) payload.get("nomComplet");
            String email = (String) payload.get("email");
            String telephone = (String) payload.get("telephone");
            
            Personne personne = personneService.findByEmail(email).orElse(null);
            if (personne == null) {
                personne = new Personne();
                personne.setNomComplet(nomComplet);
                personne.setEmail(email);
                personne.setTelephone(telephone);
                personne.setRole("CLIENT");
                personne.setMotDePasse(""); // TODO: Gérer le mot de passe pour les clients
                try {
                    personne = personneService.savePersonne(personne);
                } catch (Exception e) {
                    // En cas d'erreur (ex: séquence), essayer de retrouver
                    personne = personneService.findByEmail(email).orElseThrow(() -> new RuntimeException("Erreur lors de la création de la personne"));
                }
            }
            Long personneId = personne.getId();

            if (seanceId == null || selections == null || selections.isEmpty()) {
                resp.put("success", false);
                resp.put("error", "Veuillez sélectionner au moins une place");
                return resp;
            }
            
            if (nomComplet == null || nomComplet.trim().isEmpty()) {
                resp.put("success", false);
                resp.put("error", "Le nom complet est requis");
                return resp;
            }
            
            if (email == null || email.trim().isEmpty()) {
                resp.put("success", false);
                resp.put("error", "L'email est requis");
                return resp;
            }

            Reservation created = reservationService.createReservation(seanceId, selections, personneId);
            
            resp.put("success", true);
            resp.put("reservationId", created.getId());
            resp.put("total", created.getMontantTotal());
            resp.put("message", "Réservation confirmée pour " + nomComplet);
            resp.put("email", email);
            
        } catch (Exception e) {
            e.printStackTrace();
            resp.put("success", false);
            resp.put("error", e.getMessage() != null ? e.getMessage() : "Erreur lors de la confirmation");
        }

        return resp;
    }

    @GetMapping("/reservationDetail")
    public String listReservations(Model model) {
        List<ReservationComplete> reservations = reservationCompleteService.findAll();

        // Charger les tickets avec leurs relations (seance.film, place, categoriePersonne, statut)
        List<Ticket> tickets = ticketRepository.findAll();
        tickets.forEach(ticket -> {
            if (ticket.getSeance() != null) {
                ticket.getSeance().getFilm(); // Charger le film
                ticket.getSeance().getSalle(); // Charger la salle

                // Ajouter les dates converties pour l'affichage
                model.addAttribute("seanceDebutDate", java.util.Date.from(ticket.getSeance().getDebut().toInstant()));
                model.addAttribute("seanceFinDate", java.util.Date.from(ticket.getSeance().getFin().toInstant()));
            }
            ticket.getPlace(); // Charger la place
            ticket.getCategoriePersonne(); // Charger la catégorie
            ticket.getStatut(); // Charger le statut
        });

        model.addAttribute("reservations", reservations);
        model.addAttribute("tickets", tickets);
        return "client/reservationDetail";
    }

    /**
     * API JSON pour récupérer tous les tickets (facile pour UI JS)
     */
    @GetMapping("/tickets/json")
    @ResponseBody
    public List<Map<String, Object>> getTicketsJson() {
        List<Ticket> tickets = ticketRepository.findAll();
        List<Map<String, Object>> out = new ArrayList<>();
        for (Ticket t : tickets) {
            Map<String, Object> m = new HashMap<>();
            m.put("id", t.getId());
            if (t.getSeance() != null) {
                if (t.getSeance().getFilm() != null) m.put("film", t.getSeance().getFilm().getTitre());
                m.put("seanceDebut", t.getSeance().getDebutFormatted());
                m.put("seanceFin", t.getSeance().getFinFormatted());
            }
            if (t.getPlace() != null) m.put("place", t.getPlace().getCodePlace());
            if (t.getCategoriePersonne() != null) m.put("categorie", t.getCategoriePersonne().getLibelle());
            m.put("prix", t.getPrix());
            if (t.getStatut() != null) m.put("statut", t.getStatut().getLibelle());
            out.add(m);
        }
        return out;
    }

    @GetMapping("/tickets-ui")
    public String ticketsUi() {
        return "client/ticketsUI";
    }

}