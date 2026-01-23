// ChiffreAffaireTotalMensuelRepository.java
package repository;

import java.time.LocalDate;

import org.springframework.data.jpa.repository.JpaRepository;

import entity.ChiffreAffaireTotalMensuel;

public interface ChiffreAffaireTotalMensuelRepository extends JpaRepository<ChiffreAffaireTotalMensuel, LocalDate> {

}
