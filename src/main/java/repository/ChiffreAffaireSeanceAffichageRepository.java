package repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import entity.ChiffreAffaireSeanceAffichage;
import entity.ChiffreAffaireSeanceAffichageId;

/**
 * Repository pour ChiffreAffaireSeanceAffichage
 * Gère les requêtes sur la vue v_chiffre_affaire_seance_affichage
 */
@Repository
public interface ChiffreAffaireSeanceAffichageRepository 
    extends JpaRepository<ChiffreAffaireSeanceAffichage, ChiffreAffaireSeanceAffichageId> {

    /**
     * Récupère tous les enregistrements pour une date donnée
     */
    List<ChiffreAffaireSeanceAffichage> findByDateDiffusion(LocalDate dateDiffusion);

    /**
     * Récupère tous les enregistrements pour un film donné
     */
    List<ChiffreAffaireSeanceAffichage> findByFilm(String film);

    /**
     * Récupère tous les enregistrements pour une plage de dates
     */
    List<ChiffreAffaireSeanceAffichage> findByDateDiffusionBetween(LocalDate dateDebut, LocalDate dateFin);

    /**
     * Récupère tous les enregistrements pour un mois donné
     */
    @Query("SELECT c FROM ChiffreAffaireSeanceAffichage c " +
           "WHERE FUNCTION('DATE_TRUNC', 'month', c.dateDiffusion) = FUNCTION('DATE_TRUNC', 'month', :mois) " +
           "ORDER BY c.dateDiffusion, c.heureDiffusion")
    List<ChiffreAffaireSeanceAffichage> findByMois(@Param("mois") LocalDate mois);

    /**
     * Récupère tous les enregistrements pour un film et une date donnée
     */
    List<ChiffreAffaireSeanceAffichage> findByFilmAndDateDiffusion(String film, LocalDate dateDiffusion);

    /**
     * Récupère tous les enregistrements pour un film et une plage de dates
     */
    @Query("SELECT c FROM ChiffreAffaireSeanceAffichage c " +
           "WHERE c.film = :film " +
           "AND c.dateDiffusion BETWEEN :dateDebut AND :dateFin " +
           "ORDER BY c.dateDiffusion, c.heureDiffusion")
    List<ChiffreAffaireSeanceAffichage> findByFilmAndDateRange(
        @Param("film") String film,
        @Param("dateDebut") LocalDate dateDebut,
        @Param("dateFin") LocalDate dateFin);
}
