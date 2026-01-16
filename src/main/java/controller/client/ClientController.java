package controller.client;

import entity.Seance;
import service.SeanceService;
import java.time.format.DateTimeFormatter;
import java.time.ZoneOffset;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import java.util.List;
import service.SalleService;
@Controller
@RequestMapping("/client")
public class ClientController {
    
    @Autowired
    private SeanceService seanceService;
    @Autowired
    private SalleService salleService;

    @GetMapping("/accueil")
    public String getAllSeance(Model model) {
        List<Seance> seances = seanceService.findAll();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm").withZone(ZoneOffset.ofHours(3));
        List<Map<String,Object>> rows = new ArrayList<>();
        for (Seance s : seances) {
            Map<String,Object> row = new HashMap<>();
            row.put("seance", s);
            if (s.getDebut() != null) row.put("debutFormatted", s.getDebut().format(fmt));
            else row.put("debutFormatted", null);
            if (s.getFin() != null) row.put("finFormatted", s.getFin().format(fmt));
            else row.put("finFormatted", null);
            row.put("revenue", seanceService.getRevenueForSeance(s.getId()));
            rows.add(row);
        }
        Map<String, Double> revenuParSalle = salleService.getRevenueParSalle();
        model.addAttribute("seances", rows);
        model.addAttribute("revenueParSalle", revenuParSalle);
        return "client/accueil";
    }
    
    // Liste complète des séances
    @GetMapping("/seances")
    public String listeSeances(Model model) {
        List<Seance> seances = seanceService.findAll();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm").withZone(ZoneOffset.ofHours(3));
        List<Map<String,Object>> rows = new ArrayList<>();
        for (Seance s : seances) {
            Map<String,Object> row = new HashMap<>();
            row.put("seance", s);
            row.put("debutFormatted", s.getDebut() != null ? s.getDebut().format(fmt) : null);
            row.put("finFormatted", s.getFin() != null ? s.getFin().format(fmt) : null);
            row.put("revenue", seanceService.getRevenueForSeance(s.getId()));
            rows.add(row);
        }
        model.addAttribute("seances", rows);
        model.addAttribute("pageTitle", "Toutes les seances");
        return "client/seances";
    }
}