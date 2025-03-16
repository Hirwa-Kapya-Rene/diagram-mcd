-- Table role
CREATE TABLE Roles (
    id_role INT PRIMARY KEY AUTO_INCREMENT,
    intitule VARCHAR(30) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table utilisateur
CREATE TABLE Utilisateurs (
    id_utilisateur INT PRIMARY KEY,
    prenom VARCHAR(20) NOT NULL,
    nom VARCHAR(20) NOT NULL,
    email VARCHAR(25) UNIQUE NOT NULL,
    genre VARCHAR NOT NULL,
    id_role INT NOT NULL,
    id_cohorte INT NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (id_role) REFERENCES Roles(id_role),
    FOREIGN KEY (id_cohorte) REFERENCES Cohortes(id_cohorte)
);

-- Table cohorte
CREATE TABLE Cohortes (
    id_cohorte INT PRIMARY KEY AUTO_INCREMENT,
    nom_cohorte VARCHAR(20) NOT NULL,
    date_debut DATE NOT NULL,
    date_fin DATE NOT NULL,
    id_sponsor INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_sponsor) REFERENCES id_sponsors(id_sponsor)
);

-- table sponsors
CREATE TABLE Sponsors (
    id_sponsor INT PRIMARY KEY,
    nom_sponsor VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table formation
CREATE TABLE Formation (
    id_formation INT PRIMARY KEY AUTO_INCREMENT,
    intitule VARCHAR(100) NOT NULL,
    description_formation TEXT NOT NULL,
    id_cohorte INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cohorte) REFERENCES Cohortes(id_cohorte)
);

-- Table salles
CREATE TABLE Salles (
    id_salle INT PRIMARY KEY AUTO_INCREMENT,
    nom_salle VARCHAR(20) NOT NULL,
    id_ville INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_ville) REFERENCES Villes(id_ville)
);
-- Table villes
CREATE TABLE Villes (
    id_ville INT PRIMARY KEY AUTO_INCREMENT,
    nom_ville VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Table session
CREATE TABLE Sessions (
    id_session INT PRIMARY KEY AUTO_INCREMENT,
    id_salle INT NOT NULL,
    date_session DATE NOT NULL,
    heure_debut TIME NOT NULL,
    heure_fin TIME NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_salle) REFERENCES Salles(id_salle)
);

-- Table presence
CREATE TABLE Presence (
    id_presence INT PRIMARY KEY AUTO_INCREMENT,
    id_utilisateur INT NOT NULL,
    id_session INT NOT NULL,
    statut ENUM('Présent', 'Retard', 'Absent', 'Justifié') NOT NULL,
    heure_check_in TIME NULL,
    heure_check_out TIME NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_utilisateur) REFERENCES Utilisateurs(id_utilisateur),
    FOREIGN KEY (id_session) REFERENCES Sessions(id_session),
    UNIQUE (utilisateur_id, session_id) 
);


CREATE TABLE Justifications (
    id_justification INT PRIMARY KEY AUTO_INCREMENT,
    id_presence INT NOT NULL,
    motif TEXT NOT NULL,
    fichier VARCHAR(255) NULL,
    statut_validation ENUM('Validé', 'Rejeté', 'En attente') DEFAULT 'En attente',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_presence) REFERENCES Presence(id_presence)
);
