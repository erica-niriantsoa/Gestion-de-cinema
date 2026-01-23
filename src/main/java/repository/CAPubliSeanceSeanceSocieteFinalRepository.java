package repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import entity.CAPubliSeanceSeanceSocieteFinal;
import entity.CAPubliSeanceSeanceSocieteFinalId;

/**
 * Repository pour CAPubliSeanceSeanceSocieteFinal
 * Gère les requêtes sur la vue v_ca_pub_seance_societe_final
 */
@Repository
public interface CAPubliSeanceSeanceSocieteFinalRepository 
    extends JpaRepository<CAPubliSeanceSeanceSocieteFinal, CAPubliSeanceSeanceSocieteFinalId> {

    /**
     * Récupère tous les enregistrements pour une société donnée
     */
    List<CAPubliSeanceSeanceSocieteFinal> findBySociete(String societe);

    /**
     * Récupère tous les enregistrements pour une date donnée
     */
    List<CAPubliSeanceSeanceSocieteFinal> findByDateDiffusion(LocalDate dateDiffusion);

    /**
     * Récupère tous les enregistrements pour une société et une date donnée
     */
    List<CAPubliSeanceSeanceSocieteFinal> findBySocieteAndDateDiffusion(String societe, LocalDate dateDiffusion);

    /**
     * Récupère tous les enregistrements pour une société et un mois donné (entre deux dates)
     */
    @Query("SELECT c FROM CAPubliSeanceSeanceSocieteFinal c " +
           "WHERE c.societe = :societe " +
           "AND FUNCTION('DATE_TRUNC', 'month', c.dateDiffusion) = FUNCTION('DATE_TRUNC', 'month', :mois) " +
           "ORDER BY c.dateDiffusion, c.heureDiffusion")
    List<CAPubliSeanceSeanceSocieteFinal> findBySocieteAndMois(@Param("societe") String societe, @Param("mois") LocalDate mois);

    /**
     * Récupère tous les enregistrements pour un mois donné
     */
    @Query("SELECT c FROM CAPubliSeanceSeanceSocieteFinal c " +
           "WHERE FUNCTION('DATE_TRUNC', 'month', c.dateDiffusion) = FUNCTION('DATE_TRUNC', 'month', :mois) " +
           "ORDER BY c.dateDiffusion, c.heureDiffusion")
    List<CAPubliSeanceSeanceSocieteFinal> findByMois(@Param("mois") LocalDate mois);

    /**
     * Récupère tous les enregistrements pour une plage de dates
     */
    List<CAPubliSeanceSeanceSocieteFinal> findByDateDiffusionBetween(LocalDate dateDebut, LocalDate dateFin);

    /**
     * Récupère tous les enregistrements pour une société et une plage de dates
     */
    @Query("SELECT c FROM CAPubliSeanceSeanceSocieteFinal c " +
           "WHERE c.societe = :societe " +
           "AND c.dateDiffusion BETWEEN :dateDebut AND :dateFin " +
           "ORDER BY c.dateDiffusion, c.heureDiffusion")
    List<CAPubliSeanceSeanceSocieteFinal> findBySocieteAndDateRange(
        @Param("societe") String societe,
        @Param("dateDebut") LocalDate dateDebut,
        @Param("dateFin") LocalDate dateFin);
}
