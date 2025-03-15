-- Table des rôles (Administrateur, Enseignant, Apprenant)
CREATE TABLE Roles (
    id_role INT PRIMARY KEY AUTO_INCREMENT,
    intitule VARCHAR(30) UNIQUE NOT NULL
);

-- Table des utilisateurs (apprenants, enseignants, administrateurs)
CREATE TABLE Utilisateurs (
    id_utilisateur INT PRIMARY KEY AUTO_INCREMENT,
    prenom VARCHAR(20) NOT NULL,
    nom VARCHAR(20) NOT NULL,
    email VARCHAR(25) UNIQUE NOT NULL,
    genre ENUM('H', 'F') NOT NULL,
    id_role INT NOT NULL,
    id_cohorte INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_role) REFERENCES Roles(id_role),
    FOREIGN KEY (id_cohorte) REFERENCES Cohorte(id_cohorte)
);

-- Table des cohortes (groupes d'apprenants)
CREATE TABLE Cohorte (
    id_cohorte INT PRIMARY KEY AUTO_INCREMENT,
    nom_cohorte VARCHAR(50) NOT NULL,
    formation_id INT NOT NULL,
    FOREIGN KEY (formation_id) REFERENCES Formation(id_formation)
);

-- Table des formations
CREATE TABLE Formation (
    id_formation INT PRIMARY KEY AUTO_INCREMENT,
    nom_formation VARCHAR(100) NOT NULL
);

-- Table des salles (localisation des sessions)
CREATE TABLE Salle (
    id_salle INT PRIMARY KEY AUTO_INCREMENT,
    nom_salle VARCHAR(50) NOT NULL,
    ville VARCHAR(50) NOT NULL
);

-- Table des sessions (cours organisés)
CREATE TABLE Session (
    id_session INT PRIMARY KEY AUTO_INCREMENT,
    formation_id INT NOT NULL,
    salle_id INT NOT NULL,
    date_session DATE NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    FOREIGN KEY (formation_id) REFERENCES Formation(id_formation),
    FOREIGN KEY (salle_id) REFERENCES Salle(id_salle)
);

-- Table des présences (table intermédiaire pour suivre les présences)
CREATE TABLE Présence (
    id_presence INT PRIMARY KEY AUTO_INCREMENT,
    utilisateur_id INT NOT NULL,
    session_id INT NOT NULL,
    statut_presence ENUM('Présent', 'Retard', 'Absent', 'Justifié') NOT NULL,
    heure_check_in TIME NULL,
    heure_check_out TIME NULL,
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY (session_id) REFERENCES Session(id_session),
    UNIQUE (utilisateur_id, session_id) -- Un utilisateur ne peut avoir qu'une présence par session
);

-- Table des justifications (fichiers justificatifs des absences)
CREATE TABLE Justification (
    id_justification INT PRIMARY KEY AUTO_INCREMENT,
    utilisateur_id INT NOT NULL,
    session_id INT NOT NULL,
    motif TEXT NOT NULL,
    fichier VARCHAR(255) NULL,
    statut_validation ENUM('Validé', 'Rejeté', 'En attente') DEFAULT 'En attente',
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id_utilisateur),
    FOREIGN KEY (session_id) REFERENCES Session(id_session)
);
