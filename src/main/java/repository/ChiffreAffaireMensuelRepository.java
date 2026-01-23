// ChiffreAffaireMensuelRepository.java
package repository;

import java.time.LocalDate;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import entity.ChiffreAffaireMensuel;

public interface ChiffreAffaireMensuelRepository extends JpaRepository<ChiffreAffaireMensuel, LocalDate> {

    List<ChiffreAffaireMensuel> findByMois(LocalDate mois); // Filtrer par mois
}
