package repository;

import org.springframework.data.jpa.repository.JpaRepository;

import entity.SoldePubliciteMensuel;

public interface SoldePubliciteMensuelRepository extends JpaRepository<SoldePubliciteMensuel, Integer> {
    // On peut rajouter des méthodes custom si besoin
}
