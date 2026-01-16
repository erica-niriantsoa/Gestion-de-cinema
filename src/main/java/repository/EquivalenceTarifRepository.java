package repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import entity.EquivalenceTarif;

@Repository
public interface EquivalenceTarifRepository extends JpaRepository<EquivalenceTarif, Long> {
}
