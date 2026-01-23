// PubliciteService.java
package service;

import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import repository.ChiffreAffaireTotalMensuelRepository;
import repository.SoldePubliciteMensuelRepository;

@Service
public class PubliciteService {

    @Autowired
    private ChiffreAffaireTotalMensuelRepository chiffreRepo;

    private static final DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");

    /**
     * Récupère tous les chiffres d'affaire mensuel et les formate pour la JSP
     */
   
    /**
     * DTO pour la JSP
     */
    public static class ChiffreAffaireDTO {
        private String mois; // déjà formaté
        private Integer nombreDiffusions;
        private java.math.BigDecimal chiffreAffaireTotal;

        public ChiffreAffaireDTO(String mois, Integer nombreDiffusions, java.math.BigDecimal chiffreAffaireTotal) {
            this.mois = mois;
            this.nombreDiffusions = nombreDiffusions;
            this.chiffreAffaireTotal = chiffreAffaireTotal;
        }

        // Getters
        public String getMois() { return mois; }
        public Integer getNombreDiffusions() { return nombreDiffusions; }
        public java.math.BigDecimal getChiffreAffaireTotal() { return chiffreAffaireTotal; }
    }

    @Autowired
    private SoldePubliciteMensuelRepository soldeRepo;

    // DTO pour envoyer à la page JSP avec la date formatée
    public static class SoldeDTO {
        private String mois;
        private String societe;
        private String chiffreAffaire;
        private String totalPaye;
        private String resteAPayer;

        public SoldeDTO(String mois, String societe, String chiffreAffaire, String totalPaye, String resteAPayer) {
            this.mois = mois;
            this.societe = societe;
            this.chiffreAffaire = chiffreAffaire;
            this.totalPaye = totalPaye;
            this.resteAPayer = resteAPayer;
        }

        // Getters
        public String getMois() { return mois; }
        public String getSociete() { return societe; }
        public String getChiffreAffaire() { return chiffreAffaire; }
        public String getTotalPaye() { return totalPaye; }
        public String getResteAPayer() { return resteAPayer; }
    }

    public List<SoldeDTO> getChiffreAffaireMensuel() {
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM");
        return soldeRepo.findAll().stream()
                .map(s -> new SoldeDTO(
                        s.getMois().format(formatter),
                        s.getSociete(),
                        s.getChiffreAffaire().toPlainString(),
                        s.getTotalPaye().toPlainString(),
                        s.getResteAPayer().toPlainString()
                ))
                .collect(Collectors.toList());
    }
}
