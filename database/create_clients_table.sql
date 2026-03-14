-- Création de la table clients pour AXE CAPITAL
-- Structure complète pour les comptes clients

CREATE TABLE clients (
  -- Identifiant unique
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  
  -- Informations personnelles
  nom VARCHAR(100) NOT NULL,
  prenom VARCHAR(100) NOT NULL,
  date_naissance DATE NOT NULL,
  lieu_naissance VARCHAR(200) NOT NULL,
  sexe VARCHAR(1) NOT NULL CHECK (sexe IN ('M', 'F')),
  
  -- Carte Nationale d'Identité
  numero_cni VARCHAR(50) UNIQUE NOT NULL,
  photos_cni TEXT[], -- Array de URLs des photos CNI stockées dans Supabase Storage
  
  -- Coordonnées
  telephone VARCHAR(20) NOT NULL,
  pays VARCHAR(100) NOT NULL,
  ville VARCHAR(100) NOT NULL,
  quartier VARCHAR(100) NOT NULL,
  lieu_dit VARCHAR(200), -- Optionnel
  
  -- Contact d'urgence
  telephone_urgence VARCHAR(20) NOT NULL,
  contact_urgence_nom VARCHAR(200) NOT NULL,
  
  -- Signature et validation
  fait_le DATE NOT NULL,
  fait_a VARCHAR(100) NOT NULL,
  confirmation BOOLEAN NOT NULL DEFAULT false,
  
  -- Statut du compte
  statut VARCHAR(20) DEFAULT 'en_attente' CHECK (statut IN ('en_attente', 'approuve', 'rejete', 'en_revision')),
  
  -- Timestamps
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Créer un index pour accélérer les recherches par numéro CNI
CREATE INDEX idx_clients_numero_cni ON clients(numero_cni);

-- Créer un index pour accélérer les recherches par téléphone
CREATE INDEX idx_clients_telephone ON clients(telephone);

-- Créer un index pour le statut
CREATE INDEX idx_clients_statut ON clients(statut);

-- Trigger pour mettre à jour updated_at automatiquement
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

CREATE TRIGGER update_clients_updated_at 
    BEFORE UPDATE ON clients 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();

-- Commentaires pour la documentation
COMMENT ON TABLE clients IS 'Table principale pour les comptes clients d''AXE CAPITAL';
COMMENT ON COLUMN clients.id IS 'Identifiant unique UUID généré automatiquement';
COMMENT ON COLUMN clients.photos_cni IS 'Array contenant les URLs des photos CNI stockées dans Supabase Storage';
COMMENT ON COLUMN clients.statut IS 'Statut du compte: en_attente, approuve, rejete, en_revision';
COMMENT ON COLUMN clients.confirmation IS 'Confirmation que le client accepte les conditions générales';
