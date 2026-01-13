package service;

import entity.Film;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import repository.FilmRepository;
import repository.SeanceRepository;

import java.util.List;
import java.util.Optional;

@Service
public class FilmService {

    @Autowired
    private FilmRepository filmRepository;
    
    @Autowired
    private SeanceRepository seanceRepository;

    public List<Film> getAllFilms() {
        return filmRepository.findAll();
    }

    public Optional<Film> getFilmById(Long id) {
        return filmRepository.findById(id);
    }

    public Film saveFilm(Film film) {
        return filmRepository.save(film);
    }

    public void deleteFilm(Long id) {
        filmRepository.deleteById(id);
    }
    
    public long countSeancesByFilm(Long filmId) {
        Optional<Film> film = getFilmById(filmId);
        if (film.isPresent()) {
            return seanceRepository.countByFilm(film.get());
        }
        return 0;
    }
}