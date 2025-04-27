CREATE TABLE Personnel (
    id_personnel INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    DATE_embauche DATE,
    salaire FLOAT,
    affectation_specialite VARCHAR(50),
    service_affectation VARCHAR(50),
    statut VARCHAR(50),
    langue VARCHAR(50),
    responsable VARCHAR(50)
);

CREATE TABLE Patient (
    id_patient INT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    DATE_naissance DATE,
    sexe CHAR,
    adresse VARCHAR(50),
    téléphone VARCHAR(50),
    num_assurance VARCHAR(50),
    langue VARCHAR(50),
    hospitalise CHAR,
    DATE_création DATETIME,
    id_chambre INT,
    id_dossier_médical INT
);

CREATE TABLE Dossier_médical (
    id_dossier_médical INT PRIMARY KEY,
    id_patient INT,
    antécédents TEXT,
    traitements TEXT
);

CREATE TABLE Service (
    id_service INT PRIMARY KEY,
    nom VARCHAR(50),
    id_personnel INT
);

CREATE TABLE Locaux (
    id_locaux INT PRIMARY KEY,
    id_service INT,
    localisation VARCHAR(50),
    fonctions VARCHAR(50)
);

CREATE TABLE Chambre (
    id_locaux INT PRIMARY KEY,
    id_patient INT
);

CREATE TABLE Stockage (
    id_locaux INT PRIMARY KEY,
    description TEXT
);

CREATE TABLE Équipement (
    id_équipement INT PRIMARY KEY,
    nom VARCHAR(50),
    type VARCHAR(50),
    id_service_ref INT,
    id_service_actif INT
);

CREATE TABLE Médecin (
    id_personnel INT PRIMARY KEY,
    num_licence VARCHAR(50)
);

CREATE TABLE Infirmier (
    id_personnel INT PRIMARY KEY,
    niveau_certification VARCHAR(50)
);

CREATE TABLE Intendance (
    id_personnel INT PRIMARY KEY,
    zone_attribuee VARCHAR(50),
    fonction VARCHAR(50)
);

CREATE TABLE Pharmacie (
    id_pharmacie INT PRIMARY KEY,
    nom VARCHAR(50),
    adresse VARCHAR(50)
);

CREATE TABLE Médicament (
    id_médicament INT PRIMARY KEY,
    nom VARCHAR(50),
    description TEXT,
    id_pharmacie INT
);

CREATE TABLE Hospitalisation (
    id_hospitalisation INT PRIMARY KEY,
    id_médecin INT,
    id_patient INT,
    motif TEXT,
    id_chambre INT,
    id_service INT,
    id_infirmier INT
);

CREATE TABLE Prescription (
    id_prescription INT PRIMARY KEY,
    id_médecin INT,
    id_médicament INT,
    date DATETIME,
    description TEXT
);

CREATE TABLE Consultation (
    id_consultation INT PRIMARY KEY,
    id_patient INT,
    id_médecin INT,
    date DATETIME,
    id_consultation_ref INT,
    id_prescription INT,
    motif TEXT
);

CREATE TABLE Urgence (
    id_urgence INT PRIMARY KEY,
    id_patient INT,
    date DATETIME,
    description TEXT
);

CREATE TABLE Facture (
    id_facture INT PRIMARY KEY,
    id_patient INT,
    montant FLOAT,
    date DATETIME
);

CREATE TABLE Commande (
    id_commande INT PRIMARY KEY,
    id_médicament INT,
    id_prescription INT
);

CREATE TABLE Suivi (
    id_hospitalisation INT,
    id_infirmier INT,
    PRIMARY KEY (id_hospitalisation, id_infirmier)
);



ALTER TABLE Médicament 
    ADD CONSTRAINT FK_MEDICAMENT_PHARMACIE
    FOREIGN KEY (id_pharmacie) 
    REFERENCES Pharmacie (id_pharmacie);

-- Patient constraints
ALTER TABLE Patient 
    ADD CONSTRAINT FK_PATIENT_CHAMBRE
    FOREIGN KEY (id_chambre) 
    REFERENCES Chambre (id_locaux);
    
ALTER TABLE Patient 
    ADD CONSTRAINT FK_PATIENT_DOSSIER
    FOREIGN KEY (id_dossier_médical) 
    REFERENCES Dossier_médical (id_dossier_médical);

-- Dossier_médical constraint
ALTER TABLE Dossier_médical 
    ADD CONSTRAINT FK_DOSSIER_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

-- Service constraint
ALTER TABLE Service 
    ADD CONSTRAINT FK_SERVICE_PERSONNEL
    FOREIGN KEY (id_personnel) 
    REFERENCES Personnel (id_personnel);

-- Locaux constraint
ALTER TABLE Locaux 
    ADD CONSTRAINT FK_LOCAUX_SERVICE
    FOREIGN KEY (id_service) 
    REFERENCES Service (id_service);

-- Chambre constraints
ALTER TABLE Chambre 
    ADD CONSTRAINT FK_CHAMBRE_LOCAUX
    FOREIGN KEY (id_locaux) 
    REFERENCES Locaux (id_locaux);
    
ALTER TABLE Chambre 
    ADD CONSTRAINT FK_CHAMBRE_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

-- Stockage constraint
ALTER TABLE Stockage 
    ADD CONSTRAINT FK_STOCKAGE_LOCAUX
    FOREIGN KEY (id_locaux) 
    REFERENCES Locaux (id_locaux);

-- Équipement constraints
ALTER TABLE Équipement 
    ADD CONSTRAINT FK_EQUIPEMENT_SERVICE_REF
    FOREIGN KEY (id_service_ref) 
    REFERENCES Service (id_service);
    
ALTER TABLE Équipement 
    ADD CONSTRAINT FK_EQUIPEMENT_SERVICE_ACTIF
    FOREIGN KEY (id_service_actif) 
    REFERENCES Service (id_service);

-- Médecin constraint
ALTER TABLE Médecin 
    ADD CONSTRAINT FK_MEDECIN_PERSONNEL
    FOREIGN KEY (id_personnel) 
    REFERENCES Personnel (id_personnel);

-- Infirmier constraint
ALTER TABLE Infirmier 
    ADD CONSTRAINT FK_INFIRMIER_PERSONNEL
    FOREIGN KEY (id_personnel) 
    REFERENCES Personnel (id_personnel);

-- Intendance constraint
ALTER TABLE Intendance 
    ADD CONSTRAINT FK_INTENDANCE_PERSONNEL
    FOREIGN KEY (id_personnel) 
    REFERENCES Personnel (id_personnel);

-- Médicament constraint
ALTER TABLE Médicament 
    ADD CONSTRAINT FK_MEDICAMENT_PHARMACIE
    FOREIGN KEY (id_pharmacie) 
    REFERENCES Pharmacie (id_pharmacie);

-- Hospitalisation constraints
ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_MEDECIN
    FOREIGN KEY (id_médecin) 
    REFERENCES Médecin (id_personnel);
    
ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);
    
ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_CHAMBRE
    FOREIGN KEY (id_chambre) 
    REFERENCES Chambre (id_locaux);
    
ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_SERVICE
    FOREIGN KEY (id_service) 
    REFERENCES Service (id_service);
    
ALTER TABLE Hospitalisation 
    ADD CONSTRAINT FK_HOSPITALISATION_INFIRMIER
    FOREIGN KEY (id_infirmier) 
    REFERENCES Infirmier (id_personnel);

-- Prescription constraints
ALTER TABLE Prescription 
    ADD CONSTRAINT FK_PRESCRIPTION_MEDECIN
    FOREIGN KEY (id_médecin) 
    REFERENCES Médecin (id_personnel);
    
ALTER TABLE Prescription 
    ADD CONSTRAINT FK_PRESCRIPTION_MEDICAMENT
    FOREIGN KEY (id_médicament) 
    REFERENCES Médicament (id_médicament);

-- Consultation constraints
ALTER TABLE Consultation 
    ADD CONSTRAINT FK_CONSULTATION_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);
    
ALTER TABLE Consultation 
    ADD CONSTRAINT FK_CONSULTATION_MEDECIN
    FOREIGN KEY (id_médecin) 
    REFERENCES Médecin (id_personnel);
    
ALTER TABLE Consultation 
    ADD CONSTRAINT FK_CONSULTATION_REF
    FOREIGN KEY (id_consultation_ref) 
    REFERENCES Consultation (id_consultation);
    
ALTER TABLE Consultation 
    ADD CONSTRAINT FK_CONSULTATION_PRESCRIPTION
    FOREIGN KEY (id_prescription) 
    REFERENCES Prescription (id_prescription);

-- Urgence constraint
ALTER TABLE Urgence 
    ADD CONSTRAINT FK_URGENCE_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

-- Facture constraint
ALTER TABLE Facture 
    ADD CONSTRAINT FK_FACTURE_PATIENT
    FOREIGN KEY (id_patient) 
    REFERENCES Patient (id_patient);

-- Commande constraints
ALTER TABLE Commande 
    ADD CONSTRAINT FK_COMMANDE_MEDICAMENT
    FOREIGN KEY (id_médicament) 
    REFERENCES Médicament (id_médicament);
    
ALTER TABLE Commande 
    ADD CONSTRAINT FK_COMMANDE_PRESCRIPTION
    FOREIGN KEY (id_prescription) 
    REFERENCES Prescription (id_prescription);

-- Suivi constraints
ALTER TABLE Suivi 
    ADD CONSTRAINT FK_SUIVI_HOSPITALISATION
    FOREIGN KEY (id_hospitalisation) 
    REFERENCES Hospitalisation (id_hospitalisation);
    
ALTER TABLE Suivi 
    ADD CONSTRAINT FK_SUIVI_INFIRMIER
    FOREIGN KEY (id_infirmier) 
    REFERENCES Infirmier (id_personnel);