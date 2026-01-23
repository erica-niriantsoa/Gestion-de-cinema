// SocieteRepository.java
package repository;

import org.springframework.data.jpa.repository.JpaRepository;

import entity.Societe;

public interface SocieteRepository extends JpaRepository<Societe, Integer> {}
