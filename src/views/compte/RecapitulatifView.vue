<template>
  <div class="recapitulatif-page">
    <!-- Mode Desktop -->
    <div v-if="!isMobile" class="desktop-container">
      <div class="recap-wrapper">
        <div class="recap-header">
          <div class="logo">
            <h1 class="logo-text">AXE<span class="logo-blue">CAPITAL</span></h1>
          </div>
          <h2 class="recap-title">Récapitulatif de votre compte</h2>
          <p class="recap-subtitle">Vérifiez et modifiez vos informations avant validation</p>
        </div>

        <div class="recap-content">
          <div class="info-section">
            <h3 class="section-title">
              <span class="section-icon">👤</span>
              Informations Personnelles
            </h3>
            <div class="info-grid">
              <div class="info-item">
                <label>Nom</label>
                <input v-model="clientData.nom" class="info-input" />
              </div>
              <div class="info-item">
                <label>Prénom</label>
                <input v-model="clientData.prenom" class="info-input" />
              </div>
              <div class="info-item">
                <label>Date de naissance</label>
                <input v-model="clientData.dateNaissance" type="date" class="info-input" />
              </div>
              <div class="info-item">
                <label>Lieu de naissance</label>
                <input v-model="clientData.lieuNaissance" class="info-input" />
              </div>
              <div class="info-item">
                <label>Sexe</label>
                <select v-model="clientData.sexe" class="info-input">
                  <option value="M">Masculin</option>
                  <option value="F">Féminin</option>
                </select>
              </div>
            </div>
          </div>

          <div class="info-section">
            <h3 class="section-title">
              <span class="section-icon">📄</span>
              Carte Nationale d'Identité
            </h3>
            <div class="info-grid">
              <div class="info-item full-width">
                <label>Numéro CNI</label>
                <input v-model="clientData.numeroCni" class="info-input" />
              </div>
              <div class="info-item full-width">
                <label>Photos CNI</label>
                <div class="photos-preview">
                  <div v-for="(photo, index) in clientData.photos" :key="index" class="photo-item">
                    <img :src="photo.url" :alt="`Photo CNI ${index + 1}`" />
                    <span class="photo-name">{{ photo.name }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>

          <div class="info-section">
            <h3 class="section-title">
              <span class="section-icon">📍</span>
              Coordonnées
            </h3>
            <div class="info-grid">
              <div class="info-item">
                <label>Téléphone</label>
                <input v-model="clientData.telephone" class="info-input" />
              </div>
              <div class="info-item">
                <label>Pays</label>
                <input v-model="clientData.pays" class="info-input" />
              </div>
              <div class="info-item">
                <label>Ville</label>
                <input v-model="clientData.ville" class="info-input" />
              </div>
              <div class="info-item">
                <label>Quartier</label>
                <input v-model="clientData.quartier" class="info-input" />
              </div>
              <div class="info-item">
                <label>Lieu dit</label>
                <input v-model="clientData.lieuDit" class="info-input" placeholder="Optionnel" />
              </div>
            </div>
          </div>

          <div class="info-section">
            <h3 class="section-title">
              <span class="section-icon">🆘</span>
              Contact d'urgence
            </h3>
            <div class="info-grid">
              <div class="info-item">
                <label>Téléphone d'urgence</label>
                <input v-model="clientData.telephoneUrgence" class="info-input" />
              </div>
              <div class="info-item">
                <label>Nom du contact</label>
                <input v-model="clientData.contactUrgenceNom" class="info-input" />
              </div>
            </div>
          </div>

          <div class="info-section">
            <h3 class="section-title">
              <span class="section-icon">✍️</span>
              Signature
            </h3>
            <div class="info-grid">
              <div class="info-item">
                <label>Fait le</label>
                <input v-model="clientData.faitLe" type="date" class="info-input" readonly />
              </div>
              <div class="info-item">
                <label>Fait à</label>
                <input v-model="clientData.faitA" class="info-input" />
              </div>
            </div>
          </div>
        </div>

        <div class="recap-actions">
          <button @click="goBack" class="btn btn-secondary">
            ← Retour au formulaire
          </button>
          <button @click="validateAccount" :disabled="loading" class="btn btn-primary">
            <span v-if="loading">⏳ Validation...</span>
            <span v-else>✅ Valider mon compte</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Mode Mobile -->
    <div v-if="isMobile" class="mobile-modal">
      <div class="mobile-header">
        <div class="mobile-nav">
          <button @click="goBack" class="mobile-close">
            <span>←</span>
          </button>
          <h3 class="mobile-title">Récapitulatif</h3>
          <div class="mobile-step-indicator">
            ✅
          </div>
        </div>
      </div>

      <div class="mobile-content">
        <div class="mobile-recap-intro">
          <h2 class="mobile-recap-title">Vérifiez vos informations</h2>
          <p class="mobile-recap-subtitle">Modifiez si nécessaire avant validation</p>
        </div>

        <div class="mobile-info-sections">
          <!-- Sections mobile similaires à desktop mais adaptées -->
          <div class="mobile-info-section">
            <h4 class="mobile-section-title">👤 Informations</h4>
            <div class="mobile-info-grid">
              <div class="mobile-info-item">
                <label>Nom</label>
                <input v-model="clientData.nom" class="mobile-info-input" />
              </div>
              <div class="mobile-info-item">
                <label>Prénom</label>
                <input v-model="clientData.prenom" class="mobile-info-input" />
              </div>
              <!-- ... autres champs mobiles ... -->
            </div>
          </div>
        </div>

        <div class="mobile-actions">
          <button @click="goBack" class="mobile-btn mobile-btn-secondary">
            ← Retour
          </button>
          <button @click="validateAccount" :disabled="loading" class="mobile-btn mobile-btn-primary">
            <span v-if="loading">⏳...</span>
            <span v-else>✅ Valider</span>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabase'

const router = useRouter()
const isMobile = ref(window.innerWidth < 768)
const loading = ref(false)

// Données du client (seront chargées depuis Supabase)
const clientData = ref({
  nom: '',
  prenom: '',
  dateNaissance: '',
  lieuNaissance: '',
  sexe: '',
  numeroCni: '',
  photos: [],
  telephone: '',
  pays: '',
  ville: '',
  quartier: '',
  lieuDit: '',
  telephoneUrgence: '',
  contactUrgenceNom: '',
  faitLe: '',
  faitA: '',
  id: null
})

// Charger les données du client depuis Supabase
const loadClientData = async () => {
  try {
    // Récupérer l'ID du client connecté depuis sessionStorage
    const storedClient = sessionStorage.getItem('loggedInClient')
    
    if (storedClient) {
      // Parser les données pour récupérer l'ID
      const parsedClient = JSON.parse(storedClient)
      const clientId = parsedClient.id
      
      console.log('Récupération des données fraîches depuis Supabase pour le client ID:', clientId)
      
      // Récupérer les données fraîches depuis la base de données
      const { data, error } = await supabase
        .from('clients')
        .select('*')
        .eq('id', clientId)
        .single()
      
      if (error) {
        throw error
      }
      
      console.log('Données fraîches récupérées depuis Supabase:', data)
      
      // Transformer les données pour le formulaire
      clientData.value = {
        nom: data.nom,
        prenom: data.prenom,
        dateNaissance: data.date_naissance,
        lieuNaissance: data.lieu_naissance,
        sexe: data.sexe,
        numeroCni: data.numero_cni,
        photos: data.photos_cni.map(photoName => ({
          name: photoName,
          url: supabase.storage.from('cni-photos').getPublicUrl(photoName).data.publicUrl
        })),
        telephone: data.telephone,
        pays: data.pays,
        ville: data.ville,
        quartier: data.quartier,
        lieuDit: data.lieu_dit || '',
        telephoneUrgence: data.telephone_urgence,
        contactUrgenceNom: data.contact_urgence_nom,
        faitLe: data.fait_le,
        faitA: data.fait_a,
        id: data.id
      }
    } else {
      // Fallback : récupérer le dernier client enregistré (ancien comportement)
      console.warn('Aucun client connecté trouvé dans sessionStorage, utilisation du fallback')
      const { data, error } = await supabase
        .from('clients')
        .select('*')
        .order('created_at', { ascending: false })
        .limit(1)
        .single()
      
      if (error) throw error
      
      // Transformer les données pour le formulaire
      clientData.value = {
        nom: data.nom,
        prenom: data.prenom,
        dateNaissance: data.date_naissance,
        lieuNaissance: data.lieu_naissance,
        sexe: data.sexe,
        numeroCni: data.numero_cni,
        photos: data.photos_cni.map(photoName => ({
          name: photoName,
          url: supabase.storage.from('cni-photos').getPublicUrl(photoName).data.publicUrl
        })),
        telephone: data.telephone,
        pays: data.pays,
        ville: data.ville,
        quartier: data.quartier,
        lieuDit: data.lieu_dit || '',
        telephoneUrgence: data.telephone_urgence,
        contactUrgenceNom: data.contact_urgence_nom,
        faitLe: data.fait_le,
        faitA: data.fait_a,
        id: data.id
      }
    }
  } catch (error) {
    console.error('Erreur chargement données:', error)
    router.push('/compte')
  }
}

// Mettre à jour le client dans Supabase
const updateClient = async () => {
  try {
    const { error } = await supabase
      .from('clients')
      .update({
        nom: clientData.value.nom.trim(),
        prenom: clientData.value.prenom.trim(),
        date_naissance: clientData.value.dateNaissance,
        lieu_naissance: clientData.value.lieuNaissance.trim(),
        sexe: clientData.value.sexe,
        numero_cni: clientData.value.numeroCni.trim(),
        telephone: clientData.value.telephone.trim(),
        pays: clientData.value.pays,
        ville: clientData.value.ville.trim(),
        quartier: clientData.value.quartier.trim(),
        lieu_dit: clientData.value.lieuDit.trim() || null,
        telephone_urgence: clientData.value.telephoneUrgence.trim(),
        contact_urgence_nom: clientData.value.contactUrgenceNom.trim(),
        fait_a: clientData.value.faitA.trim(),
        updated_at: new Date().toISOString()
      })
      .eq('id', clientData.value.id)
    
    if (error) throw error
  } catch (error) {
    console.error('Erreur mise à jour:', error)
    throw error
  }
}

// Valider le compte
const validateAccount = async () => {
  try {
    loading.value = true
    
    // Mettre à jour les données
    await updateClient()
    
    // Changer le statut à "approuve"
    const { error } = await supabase
      .from('clients')
      .update({ statut: 'approuve' })
      .eq('id', clientData.value.id)
    
    if (error) throw error
    
    // Rediriger vers la page de confirmation
    router.push('/compte/confirmation')
  } catch (error) {
    console.error('Erreur validation:', error)
    alert('Erreur lors de la validation du compte')
  } finally {
    loading.value = false
  }
}

// Retour au formulaire
const goBack = () => {
  router.push('/compte')
}

onMounted(() => {
  loadClientData()
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&display=swap');

.recapitulatif-page {
  min-height: 100vh;
  font-family: 'Plus Jakarta Sans', sans-serif;
  background: #1e40af;
  color: white;
  --blue: #60a5fa;
  --blue-dk: #3b82f6;
  --blue-lt: #93c5fd;
  --blue-pale: #eff6ff;
  --blue-mid: #dbeafe;
  --dark: #60a5fa;
  --text: #374151;
  --muted: #6b7280;
}

/* Desktop */
.desktop-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.recap-wrapper {
  background: white;
  border-radius: 24px;
  padding: 3rem;
  width: 100%;
  max-width: 1000px;
  box-shadow: 0 30px 80px rgba(0, 0, 0, 0.2);
  max-height: 90vh;
  overflow-y: auto;
}

.recap-header {
  text-align: center;
  margin-bottom: 3rem;
}

.logo-text {
  font-family: 'Syne', sans-serif;
  font-size: 2.5rem;
  font-weight: 800;
  color: var(--dark);
  letter-spacing: -0.02em;
}

.logo-blue {
  background: linear-gradient(90deg, #3b82f6 0%, #60a5fa 50%, #3b82f6 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.recap-title {
  font-family: 'Syne', sans-serif;
  font-size: 2rem;
  font-weight: 700;
  color: var(--dark);
  margin: 1rem 0 0.5rem;
}

.recap-subtitle {
  color: var(--muted);
  font-size: 1rem;
  font-weight: 300;
}

.info-section {
  margin-bottom: 2.5rem;
  padding: 2rem;
  background: var(--blue-pale);
  border-radius: 16px;
  border: 1px solid #dbeafe;
}

.section-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.3rem;
  font-weight: 700;
  color: var(--dark);
  margin-bottom: 1.5rem;
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.section-icon {
  font-size: 1.5rem;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.info-item.full-width {
  grid-column: 1 / -1;
}

.info-item label {
  font-weight: 600;
  color: var(--dark);
  font-size: 0.9rem;
}

.info-input {
  padding: 1rem 1.25rem;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: white;
}

.info-input:focus {
  outline: none;
  border-color: var(--blue);
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
  transform: translateY(-2px);
}

.photos-preview {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.photo-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem;
  background: white;
  border-radius: 12px;
  border: 2px solid #e2e8f0;
}

.photo-item img {
  width: 100px;
  height: 100px;
  object-fit: cover;
  border-radius: 8px;
}

.photo-name {
  font-size: 0.8rem;
  color: var(--muted);
  text-align: center;
  max-width: 100px;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.recap-actions {
  display: flex;
  gap: 1rem;
  justify-content: space-between;
  margin-top: 2rem;
  padding-top: 2rem;
  border-top: 2px solid var(--blue-pale);
}

.btn {
  padding: 1rem 2rem;
  border: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  min-width: 160px;
}

.btn-primary {
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  color: white;
  box-shadow: 0 12px 32px rgba(26, 86, 219, 0.3);
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-3px);
  box-shadow: 0 16px 40px rgba(26, 86, 219, 0.4);
}

.btn-secondary {
  background: #f1f5f9;
  color: var(--text);
  border: 2px solid #e2e8f0;
}

.btn-secondary:hover {
  background: #e2e8f0;
  transform: translateY(-2px);
}

/* Mobile */
.mobile-modal {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: white;
  z-index: 10000;
  display: flex;
  flex-direction: column;
}

.mobile-header {
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  color: white;
  padding: 1.5rem;
  box-shadow: 0 4px 20px rgba(0, 0, 0, 0.1);
}

.mobile-nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.mobile-close {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2rem;
  cursor: pointer;
}

.mobile-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.3rem;
  font-weight: 700;
}

.mobile-step-indicator {
  background: rgba(255, 255, 255, 0.2);
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
}

.mobile-content {
  flex: 1;
  overflow-y: auto;
  padding: 1.5rem;
}

.mobile-recap-intro {
  text-align: center;
  margin-bottom: 2rem;
}

.mobile-recap-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.5rem;
  font-weight: 700;
  color: var(--dark);
  margin-bottom: 0.5rem;
}

.mobile-recap-subtitle {
  color: var(--muted);
  font-size: 0.9rem;
}

.mobile-info-section {
  margin-bottom: 2rem;
  padding: 1.5rem;
  background: var(--blue-pale);
  border-radius: 12px;
}

.mobile-section-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--dark);
  margin-bottom: 1rem;
}

.mobile-info-grid {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.mobile-info-item {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.mobile-info-item label {
  font-weight: 600;
  color: var(--dark);
  font-size: 0.9rem;
}

.mobile-info-input {
  padding: 1rem;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: white;
}

.mobile-info-input:focus {
  outline: none;
  border-color: var(--blue);
  box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
}

.mobile-actions {
  display: flex;
  gap: 1rem;
  margin-top: auto;
  padding-top: 2rem;
  border-top: 1px solid #e2e8f0;
}

.mobile-btn {
  flex: 1;
  padding: 1.25rem;
  border: none;
  border-radius: 12px;
  font-weight: 700;
  font-size: 1.1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
  min-height: 60px;
}

.mobile-btn-primary {
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  color: white;
  box-shadow: 0 8px 24px rgba(26, 86, 219, 0.4);
}

.mobile-btn-primary:hover:not(:disabled) {
  transform: translateY(-3px);
  box-shadow: 0 12px 32px rgba(26, 86, 219, 0.5);
}

.mobile-btn-secondary {
  background: white;
  color: var(--blue);
  border: 3px solid var(--blue);
  box-shadow: 0 4px 12px rgba(26, 86, 219, 0.2);
}

.mobile-btn-secondary:hover {
  background: var(--blue);
  color: white;
  transform: translateY(-2px);
}

/* Responsive */
@media (max-width: 768px) {
  .desktop-container {
    display: none;
  }
  
  .mobile-modal {
    display: flex;
  }
}

@media (min-width: 769px) {
  .mobile-modal {
    display: none;
  }
  
  .desktop-container {
    display: flex;
  }
}
</style>
