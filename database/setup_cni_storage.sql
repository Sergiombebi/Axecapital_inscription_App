-- Configuration de Supabase Storage pour les photos CNI
-- Version simplifiée sans nécessiter les permissions owner

-- 1. Créer le bucket pour les photos CNI (si vous avez les permissions)
-- Sinon, créez-le manuellement dans l'interface Supabase Storage
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'cni-photos', 
  'cni-photos', 
  false, -- Privé - accès uniquement via URL signée
  5242880, -- 5MB max par fichier
  ARRAY['image/jpeg', 'image/jpg', 'image/png', 'image/webp']
) ON CONFLICT (id) DO NOTHING;

-- 2. Fonction pour générer des noms de fichiers uniques
CREATE OR REPLACE FUNCTION generate_cni_filename()
RETURNS TEXT AS $$
BEGIN
  RETURN 'cni_' || extract(epoch from now()) || '_' || gen_random_uuid()::text;
END;
$$ LANGUAGE plpgsql;

-- Note: Les politiques RLS doivent être configurées manuellement dans l'interface Supabase
-- Allez dans Authentication > Policies > storage.objects
-- Créez les politiques suivantes:

-- Politique 1: "Users can upload CNI photos"
-- Target: storage.objects
-- USING: (bucket_id = 'cni-photos')
-- FOR INSERT: WITH CHECK (bucket_id = 'cni-photos' AND auth.role() = 'anon')

-- Politique 2: "Users can read CNI photos"  
-- Target: storage.objects
-- USING: (bucket_id = 'cni-photos')
-- FOR SELECT: USING (bucket_id = 'cni-photos')

-- Politique 3: "Users can update CNI photos"
-- Target: storage.objects  
-- USING: (bucket_id = 'cni-photos')
-- FOR UPDATE: USING (bucket_id = 'cni-photos')

-- Politique 4: "Users can delete CNI photos"
-- Target: storage.objects
-- USING: (bucket_id = 'cni-photos') 
-- FOR DELETE: USING (bucket_id = 'cni-photos')

-- Commentaires pour la documentation
-- Le bucket cni-photos est utilisé pour stocker les photos des cartes nationales d'identité des clients
-- Les politiques permettent l'upload des photos CNI par les utilisateurs
-- La fonction generate_cni_filename génère des noms de fichiers uniques pour les photos CNI
