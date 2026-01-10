package repository;

import entity.CategoriePersonne;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface CategoriePersonneRepository extends JpaRepository<CategoriePersonne, Integer> {
}
