<template>
  <div class="compte-page">
    <!-- HERO SECTION -->
    <section class="hero-section">
      <div class="hero-bg-grid"></div>
      <div class="hero-blob blob-1"></div>
      <div class="hero-blob blob-2"></div>

      <div class="hero-content">
        <div class="hero-badge">
          <span class="badge-pulse"></span>
          Création de Compte
        </div>
        <h1 class="hero-title">
          <span class="ht-line">Créez votre</span>
          <span class="ht-line blue">compte</span>
        </h1>
        <p class="hero-tagline">
          "Rejoignez AXE CAPITAL en quelques étapes simples"
        </p>
        <p class="hero-desc">
          🇨🇲 Votre partenaire financier de confiance au Cameroun<br>
          <span>Épargne · Crédit · Projets · Import/Export</span>
        </p>
        <div class="hero-btns">
          <button @click="scrollToForm" class="hbtn hbtn-outline">
            Commencer maintenant
            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 5v14M5 12l7 7 7-7"/></svg>
          </button>
        </div>
      </div>
      
      <div class="hero-scroll">
        <span>Défiler</span>
        <div class="scroll-bar"></div>
      </div>
    </section>

    <!-- FORM SECTION -->
    <section id="form" class="form-section">
      <div class="form-header">
        <span class="eyebrow">OUVERTURE DE COMPTE</span>
        <h2 class="form-title">Formulaire de Création</h2>
        <p class="form-sub">Remplissez les informations ci-dessous pour créer votre compte</p>
      </div>

      <!-- Barre de progression -->
      <div class="progress-bar">
        <div class="progress-steps">
          <div 
            v-for="step in totalSteps" 
            :key="step"
            :class="['progress-step', { 
              'active': currentStep === step, 
              'completed': currentStep > step 
            }]"
          >
            <div class="step-number">{{ step }}</div>
            <div class="step-label">
              <span v-if="step === 1">Informations</span>
              <span v-if="step === 2">Documents</span>
              <span v-if="step === 3">Validation</span>
            </div>
          </div>
        </div>
        <div class="progress-line">
          <div class="progress-fill" :style="{ width: progressPercentage + '%' }"></div>
        </div>
      </div>

      <!-- Étape 1: Informations personnelles -->
      <div v-if="currentStep === 1" class="step-content">
        <div class="form-card">
          <div class="form-card-header">
            <h3 class="form-card-title">
              <span class="step-icon">👤</span>
              Informations Personnelles
            </h3>
            <p class="form-card-subtitle">Vos informations de base</p>
          </div>
          
          <div class="form-grid">
            <div class="form-group">
              <label>Nom *</label>
              <input 
                v-model="formData.nom" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.nom }"
                placeholder="Votre nom"
              />
              <span v-if="errors.nom" class="error-message">{{ errors.nom }}</span>
            </div>
            
            <div class="form-group">
              <label>Prénom *</label>
              <input 
                v-model="formData.prenom" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.prenom }"
                placeholder="Votre prénom"
              />
              <span v-if="errors.prenom" class="error-message">{{ errors.prenom }}</span>
            </div>
            
            <div class="form-group">
              <label>Date de naissance *</label>
              <input 
                v-model="formData.dateNaissance" 
                type="date" 
                class="form-input"
                :class="{ 'error': errors.dateNaissance }"
              />
              <span v-if="errors.dateNaissance" class="error-message">{{ errors.dateNaissance }}</span>
            </div>
            
            <div class="form-group">
              <label>Lieu de naissance *</label>
              <input 
                v-model="formData.lieuNaissance" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.lieuNaissance }"
                placeholder="Ville de naissance"
              />
              <span v-if="errors.lieuNaissance" class="error-message">{{ errors.lieuNaissance }}</span>
            </div>
            
            <div class="form-group">
              <label>Sexe *</label>
              <select 
                v-model="formData.sexe" 
                class="form-input"
                :class="{ 'error': errors.sexe }"
              >
                <option value="">Sélectionner</option>
                <option value="M">Masculin</option>
                <option value="F">Féminin</option>
              </select>
              <span v-if="errors.sexe" class="error-message">{{ errors.sexe }}</span>
            </div>
          </div>
        </div>
      </div>

      <!-- Étape 2: Documents et contact -->
      <div v-if="currentStep === 2" class="step-content">
        <div class="form-card">
          <div class="form-card-header">
            <h3 class="form-card-title">
              <span class="step-icon">📄</span>
              Carte d'Identité et Contact
            </h3>
            <p class="form-card-subtitle">Vos documents et coordonnées</p>
          </div>
          
          <div class="form-grid">
            <div class="form-group full-width">
              <label>Numéro CNI *</label>
              <input 
                v-model="formData.numeroCni" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.numeroCni }"
                placeholder="Numéro de votre carte d'identité"
              />
              <span v-if="errors.numeroCni" class="error-message">{{ errors.numeroCni }}</span>
            </div>
            
            <div class="form-group full-width">
              <label>Photos CNI * (Maximum 5)</label>
              <div class="file-upload-area" :class="{ 'error': errors.photosCni }">
                <input 
                  ref="fileInput"
                  type="file" 
                  multiple
                  accept="image/*"
                  @change="handleFileUpload"
                  class="file-input"
                />
                <div class="file-upload-content">
                  <div class="file-upload-icon">
                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
                      <polyline points="17 8 12 3 7 8"/>
                      <line x1="12" y1="3" x2="12" y2="15"/>
                    </svg>
                  </div>
                  <p class="file-upload-text">Cliquez pour ajouter ou glissez les photos</p>
                  <p class="file-upload-sub">PNG, JPG jusqu'à 5MB</p>
                </div>
              </div>
              <span v-if="errors.photosCni" class="error-message">{{ errors.photosCni }}</span>
              
              <!-- Photos uploadées -->
              <div v-if="formData.photosCniUrls.length > 0" class="uploaded-files">
                <div v-for="(photo, index) in formData.photosCniUrls" :key="index" class="uploaded-file">
                  <img :src="photo.url" :alt="`Photo CNI ${index + 1}`" class="uploaded-preview" />
                  <div class="uploaded-info">
                    <span class="uploaded-name">{{ photo.name }}</span>
                    <span class="uploaded-size">{{ formatFileSize(photo.size) }}</span>
                  </div>
                  <button @click="removePhoto(index)" class="uploaded-remove">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                      <line x1="18" y1="6" x2="6" y2="18"/>
                      <line x1="6" y1="6" x2="18" y2="18"/>
                    </svg>
                  </button>
                </div>
              </div>
            </div>
            
            <div class="form-group">
              <label>Téléphone *</label>
              <input 
                v-model="formData.telephone" 
                type="tel" 
                class="form-input"
                :class="{ 'error': errors.telephone }"
                placeholder="+237 XXX XXX XXX"
              />
              <span v-if="errors.telephone" class="error-message">{{ errors.telephone }}</span>
            </div>
            
            <div class="form-group">
              <label>Pays *</label>
              <select 
                v-model="formData.pays" 
                class="form-input"
                :class="{ 'error': errors.pays }"
              >
                <option value="">Sélectionner</option>
                <option value="Cameroun">Cameroun</option>
                <option value="France">France</option>
                <option value="Belgique">Belgique</option>
                <option value="Suisse">Suisse</option>
                <option value="Canada">Canada</option>
              </select>
              <span v-if="errors.pays" class="error-message">{{ errors.pays }}</span>
            </div>
            
            <div class="form-group">
              <label>Ville *</label>
              <input 
                v-model="formData.ville" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.ville }"
                placeholder="Votre ville"
              />
              <span v-if="errors.ville" class="error-message">{{ errors.ville }}</span>
            </div>
            
            <div class="form-group">
              <label>Quartier *</label>
              <input 
                v-model="formData.quartier" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.quartier }"
                placeholder="Votre quartier"
              />
              <span v-if="errors.quartier" class="error-message">{{ errors.quartier }}</span>
            </div>
            
            <div class="form-group">
              <label>Lieu dit</label>
              <input 
                v-model="formData.lieuDit" 
                type="text" 
                class="form-input"
                placeholder="Optionnel"
              />
            </div>
          </div>
        </div>
      </div>

      <!-- Étape 3: Contact d'urgence et validation -->
      <div v-if="currentStep === 3" class="step-content">
        <div class="form-card">
          <div class="form-card-header">
            <h3 class="form-card-title">
              <span class="step-icon">🆘</span>
              Contact d'Urgence
            </h3>
            <p class="form-card-subtitle">Personne à contacter en cas d'urgence</p>
          </div>
          
          <div class="form-grid">
            <div class="form-group">
              <label>Téléphone d'urgence *</label>
              <input 
                v-model="formData.telephoneUrgence" 
                type="tel" 
                class="form-input"
                :class="{ 'error': errors.telephoneUrgence }"
                placeholder="+237 XXX XXX XXX"
              />
              <span v-if="errors.telephoneUrgence" class="error-message">{{ errors.telephoneUrgence }}</span>
            </div>
            
            <div class="form-group">
              <label>Nom du contact *</label>
              <input 
                v-model="formData.contactUrgenceNom" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.contactUrgenceNom }"
                placeholder="Nom complet"
              />
              <span v-if="errors.contactUrgenceNom" class="error-message">{{ errors.contactUrgenceNom }}</span>
            </div>
          </div>
        </div>
        
        <div class="form-card">
          <div class="form-card-header">
            <h3 class="form-card-title">
              <span class="step-icon">✍️</span>
              Signature et Confirmation
            </h3>
            <p class="form-card-subtitle">Validez votre demande</p>
          </div>
          
          <div class="form-grid">
            <div class="form-group">
              <label>Fait le *</label>
              <input 
                v-model="formData.faitLe" 
                type="date" 
                class="form-input"
                :class="{ 'error': errors.faitLe }"
              />
              <span v-if="errors.faitLe" class="error-message">{{ errors.faitLe }}</span>
            </div>
            
            <div class="form-group">
              <label>Fait à *</label>
              <input 
                v-model="formData.faitA" 
                type="text" 
                class="form-input"
                :class="{ 'error': errors.faitA }"
                placeholder="Lieu de signature"
              />
              <span v-if="errors.faitA" class="error-message">{{ errors.faitA }}</span>
            </div>
            
            <div class="form-group full-width">
              <div class="checkbox-group">
                <label class="checkbox-label">
                  <input 
                    v-model="formData.confirmation" 
                    type="checkbox" 
                    class="checkbox-input"
                    :class="{ 'error': errors.confirmation }"
                  />
                  <span class="checkbox-text">
                    Les fonds sont bloquer pendant toutes la periode du jeu
                  </span>
                </label>
                <span v-if="errors.confirmation" class="error-message">{{ errors.confirmation }}</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <!-- Actions -->
      <div class="form-actions">
        <button v-if="currentStep > 1" @click="previousStep" class="btn btn-secondary">
          ← Précédent
        </button>
        <button @click="goToHome" class="btn btn-outline">
          Annuler
        </button>
        <button v-if="currentStep < totalSteps" @click="nextStep" class="btn btn-primary">
          Suivant →
        </button>
        <button v-if="currentStep === totalSteps" @click="handleSubmit" :disabled="loading" class="btn btn-primary">
          <span v-if="loading" class="btn-loading">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 12a9 9 0 1 1-6.219-8.56"/>
            </svg>
            Création en cours...
          </span>
          <span v-else>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M9 12l2 2 4-4"/>
              <path d="M21 12c-1 0-3-1-3-3s2-3 3-3 3 1 3 3-2 3-3 3"/>
              <path d="M3 12c1 0 3-1 3-3s-2-3-3-3-3 1-3 3 2 3 3 3"/>
            </svg>
            Créer mon compte
          </span>
        </button>
      </div>
    </section>

    <!-- FOOTER -->
    <footer class="compte-footer">
      <div class="footer-content">
        <div class="footer-brand">
          <h3 class="footer-title">AXE CAPITAL</h3>
          <p class="footer-sub">Votre partenaire financier de confiance</p>
        </div>
        <div class="footer-links">
          <router-link to="/" class="footer-link">← Retour à l'accueil</router-link>
          <router-link to="/compte" class="footer-link">← Retour à la gestion</router-link>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabase'

const router = useRouter()
const loading = ref(false)
const currentStep = ref(1)
const totalSteps = 3
const fileInput = ref(null)

const formData = ref({
  nom: '',
  prenom: '',
  dateNaissance: '',
  lieuNaissance: '',
  sexe: '',
  numeroCni: '',
  photosCni: [],
  photosCniUrls: [],
  telephone: '',
  pays: '',
  ville: '',
  quartier: '',
  lieuDit: '',
  telephoneUrgence: '',
  contactUrgenceNom: '',
  faitLe: '',
  faitA: '',
  confirmation: false
})

const errors = ref({})

// Calculer le pourcentage de progression
const progressPercentage = computed(() => {
  return ((currentStep.value - 1) / (totalSteps - 1)) * 100
})

// Navigation
const scrollToForm = () => {
  const formSection = document.querySelector('#form')
  if (formSection) {
    formSection.scrollIntoView({ behavior: 'smooth' })
  }
}

const goToHome = () => {
  router.push('/')
}

const nextStep = () => {
  if (validateCurrentStep()) {
    if (currentStep.value < totalSteps) {
      currentStep.value++
      // Scroll vers le haut de la section formulaire
      document.querySelector('#form').scrollIntoView({ behavior: 'smooth' })
    }
  }
}

const previousStep = () => {
  if (currentStep.value > 1) {
    currentStep.value--
    document.querySelector('#form').scrollIntoView({ behavior: 'smooth' })
  }
}

// Validation par étape
const validateCurrentStep = () => {
  const newErrors = {}
  
  if (currentStep.value === 1) {
    if (!formData.value.nom.trim()) newErrors.nom = 'Le nom est requis'
    if (!formData.value.prenom.trim()) newErrors.prenom = 'Le prénom est requis'
    if (!formData.value.dateNaissance) newErrors.dateNaissance = 'La date de naissance est requise'
    if (!formData.value.lieuNaissance.trim()) newErrors.lieuNaissance = 'Le lieu de naissance est requis'
    if (!formData.value.sexe) newErrors.sexe = 'Le sexe est requis'
  }
  
  if (currentStep.value === 2) {
    if (!formData.value.numeroCni.trim()) newErrors.numeroCni = 'Le numéro CNI est requis'
    if (formData.value.photosCni.length === 0) newErrors.photosCni = 'Au moins une photo CNI est requise'
    if (!formData.value.telephone.trim()) newErrors.telephone = 'Le téléphone est requis'
    if (!formData.value.pays) newErrors.pays = 'Le pays est requis'
    if (!formData.value.ville.trim()) newErrors.ville = 'La ville est requise'
    if (!formData.value.quartier.trim()) newErrors.quartier = 'Le quartier est requis'
  }
  
  if (currentStep.value === 3) {
    if (!formData.value.telephoneUrgence.trim()) newErrors.telephoneUrgence = 'Le téléphone d\'urgence est requis'
    if (!formData.value.contactUrgenceNom.trim()) newErrors.contactUrgenceNom = 'Le nom du contact est requis'
    if (!formData.value.faitLe) newErrors.faitLe = 'La date est requise'
    if (!formData.value.faitA.trim()) newErrors.faitA = 'Le lieu est requis'
    if (!formData.value.confirmation) newErrors.confirmation = 'Vous devez accepter les conditions'
  }
  
  errors.value = newErrors
  return Object.keys(newErrors).length === 0
}

// Gestion des fichiers
const handleFileUpload = async (event) => {
  const files = Array.from(event.target.files)
  
  if (formData.value.photosCni.length + files.length > 5) {
    alert('Maximum 5 photos autorisées')
    return
  }
  
  for (const file of files) {
    if (file.size > 5 * 1024 * 1024) {
      alert(`Le fichier ${file.name} dépasse 5MB`)
      return
    }
  }
  
  // Stocker les fichiers localement et générer les chemins
  for (const file of files) {
    const fileName = `cni_${Date.now()}_${Math.random().toString(36).substring(2, 15)}_${file.name}`
    const filePath = `/public/cni-photos/${fileName}`
    
    formData.value.photosCni.push(file)
    formData.value.photosCniUrls.push({
      name: file.name,
      path: filePath,
      url: filePath,
      size: file.size
    })
  }
  
  event.target.value = ''
}

const removePhoto = (index) => {
  formData.value.photosCni.splice(index, 1)
  formData.value.photosCniUrls.splice(index, 1)
}

const formatFileSize = (bytes) => {
  if (bytes === 0) return '0 Bytes'
  const k = 1024
  const sizes = ['Bytes', 'KB', 'MB', 'GB']
  const i = Math.floor(Math.log(bytes) / Math.log(k))
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i]
}

// Soumission du formulaire
const handleSubmit = async () => {
  if (!validateCurrentStep()) {
    return
  }
  
  loading.value = true
  
  try {
    // Extraire seulement les chemins des photos
    const photoPaths = formData.value.photosCniUrls.map(photo => photo.path)
    
    // Enregistrement du client sans upload de fichiers
    const { data, error } = await supabase
      .from('clients')
      .insert({
        nom: formData.value.nom.trim(),
        prenom: formData.value.prenom.trim(),
        date_naissance: formData.value.dateNaissance,
        lieu_naissance: formData.value.lieuNaissance.trim(),
        sexe: formData.value.sexe,
        numero_cni: formData.value.numeroCni.trim(),
        photos_cni: photoPaths,
        telephone: formData.value.telephone.trim(),
        pays: formData.value.pays,
        ville: formData.value.ville.trim(),
        quartier: formData.value.quartier.trim(),
        lieu_dit: formData.value.lieuDit.trim() || null,
        telephone_urgence: formData.value.telephoneUrgence.trim(),
        contact_urgence_nom: formData.value.contactUrgenceNom.trim(),
        fait_le: formData.value.faitLe,
        fait_a: formData.value.faitA.trim(),
        confirmation: formData.value.confirmation,
        statut: 'en_attente'
      })
      .select()
      .single()
    
    if (error) {
      throw new Error('Erreur lors de l\'enregistrement du compte')
    }
    
    // Rediriger vers la page de récapitulatif
    setTimeout(() => {
      router.push('/compte/recapitulatif')
    }, 1500)
    
  } catch (error) {
    console.error('Erreur complète:', error)
    alert(error.message || 'Une erreur est survenue')
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&display=swap');

.compte-page {
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
  --green: #059669;
  --green-lt: #10b981;
  --red: #dc2626;
}

/* Hero Section */
.hero-section {
  position: relative;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  padding: 2rem;
}

.hero-bg-grid {
  position: absolute;
  inset: 0;
  background-image: 
    linear-gradient(rgba(59, 130, 246, 0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(59, 130, 246, 0.03) 1px, transparent 1px);
  background-size: 50px 50px;
  animation: gridMove 20s linear infinite;
}

@keyframes gridMove {
  0% { transform: translate(0, 0); }
  100% { transform: translate(50px, 50px); }
}

.hero-blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(80px);
  opacity: 0.15;
  animation: float 6s ease-in-out infinite;
}

.blob-1 {
  width: 400px;
  height: 400px;
  background: var(--blue);
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.blob-2 {
  width: 300px;
  height: 300px;
  background: var(--green);
  bottom: 20%;
  right: 10%;
  animation-delay: 3s;
}

@keyframes float {
  0%, 100% { transform: translate(0, 0) scale(1); }
  50% { transform: translate(30px, -30px) scale(1.05); }
}

.hero-content {
  position: relative;
  z-index: 10;
  text-align: center;
  max-width: 800px;
  margin: 0 auto;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  background: rgba(59, 130, 246, 0.1);
  border: 1px solid rgba(59, 130, 246, 0.2);
  border-radius: 50px;
  padding: 0.5rem 1rem;
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--blue);
  margin-bottom: 2rem;
}

.badge-pulse {
  width: 8px;
  height: 8px;
  background: var(--green);
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(5, 150, 105, 0.7); }
  70% { box-shadow: 0 0 0 10px rgba(5, 150, 105, 0); }
  100% { box-shadow: 0 0 0 0 rgba(5, 150, 105, 0); }
}

.hero-title {
  font-family: 'Syne', sans-serif;
  font-size: clamp(2.5rem, 8vw, 5rem);
  font-weight: 800;
  line-height: 1;
  margin-bottom: 1.5rem;
}

.ht-line {
  display: block;
}

.blue {
  background: linear-gradient(135deg, #3b82f6 0%, #60a5fa 50%, #3b82f6 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.hero-tagline {
  font-size: 1.25rem;
  color: var(--muted);
  margin-bottom: 1rem;
  font-style: italic;
}

.hero-desc {
  font-size: 1.1rem;
  color: var(--muted);
  margin-bottom: 3rem;
  line-height: 1.6;
}

.hero-btns {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
}

.hbtn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 2rem;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  text-decoration: none;
  transition: all 0.3s ease;
  cursor: pointer;
  border: none;
}

.hbtn-outline {
  background: transparent;
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.hbtn-outline:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-2px);
}

.hero-scroll {
  position: absolute;
  bottom: 2rem;
  left: 50%;
  transform: translateX(-50%);
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  color: var(--muted);
  font-size: 0.85rem;
  animation: bounce 2s infinite;
}

@keyframes bounce {
  0%, 20%, 50%, 80%, 100% { transform: translateX(-50%) translateY(0); }
  40% { transform: translateX(-50%) translateY(-10px); }
  60% { transform: translateX(-50%) translateY(-5px); }
}

.scroll-bar {
  width: 2px;
  height: 30px;
  background: linear-gradient(to bottom, transparent, var(--muted), transparent);
  border-radius: 1px;
}

/* Form Section */
.form-section {
  padding: 6rem 2rem 4rem;
  max-width: 1200px;
  margin: 0 auto;
}

.form-header {
  text-align: center;
  margin-bottom: 4rem;
}

.eyebrow {
  display: inline-block;
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--blue);
  text-transform: uppercase;
  letter-spacing: 0.1em;
  margin-bottom: 1rem;
}

.form-title {
  font-family: 'Syne', sans-serif;
  font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 700;
  color: white;
  margin-bottom: 1rem;
  line-height: 1.2;
}

.form-sub {
  font-size: 1.1rem;
  color: var(--muted);
  max-width: 600px;
  margin: 0 auto;
}

/* Progress Bar */
.progress-bar {
  margin-bottom: 4rem;
  position: relative;
}

.progress-steps {
  display: flex;
  justify-content: space-between;
  margin-bottom: 1rem;
  position: relative;
  z-index: 2;
}

.progress-step {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
}

.step-number {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 0.9rem;
  transition: all 0.3s ease;
}

.progress-step:not(.completed) .step-number {
  background: rgba(255, 255, 255, 0.1);
  color: var(--muted);
  border: 2px solid rgba(255, 255, 255, 0.2);
}

.progress-step.active .step-number {
  background: var(--blue);
  color: white;
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
}

.progress-step.completed .step-number {
  background: var(--green);
  color: white;
}

.step-label {
  font-size: 0.8rem;
  color: var(--muted);
  font-weight: 500;
  text-align: center;
}

.progress-step.active .step-label {
  color: white;
}

.progress-line {
  position: absolute;
  top: 20px;
  left: 0;
  right: 0;
  height: 2px;
  background: rgba(255, 255, 255, 0.1);
  z-index: 1;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--green), var(--blue));
  transition: width 0.3s ease;
}

/* Form Cards */
.step-content {
  margin-bottom: 3rem;
}

.form-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 3rem;
  margin-bottom: 2rem;
}

.form-card-header {
  text-align: center;
  margin-bottom: 2rem;
}

.form-card-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.5rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.5rem;
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
}

.step-icon {
  font-size: 1.8rem;
}

.form-card-subtitle {
  color: var(--muted);
  font-size: 0.9rem;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.form-group.full-width {
  grid-column: 1 / -1;
}

.form-group label {
  font-weight: 600;
  color: white;
  font-size: 0.9rem;
}

.form-input {
  padding: 1rem 1.25rem;
  border: 2px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: rgba(255, 255, 255, 0.05);
  color: white;
}

.form-input::placeholder {
  color: rgba(255, 255, 255, 0.5);
}

.form-input:focus {
  outline: none;
  border-color: var(--blue);
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
  background: rgba(255, 255, 255, 0.08);
}

.form-input.error {
  border-color: var(--red);
  box-shadow: 0 0 0 4px rgba(220, 38, 38, 0.1);
}

.error-message {
  color: #fca5a5;
  font-size: 0.8rem;
  font-weight: 500;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

/* File Upload */
.file-upload-area {
  border: 2px dashed rgba(255, 255, 255, 0.3);
  border-radius: 12px;
  padding: 2rem;
  text-align: center;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  background: rgba(255, 255, 255, 0.02);
}

.file-upload-area:hover {
  border-color: var(--blue);
  background: rgba(255, 255, 255, 0.05);
}

.file-upload-area.error {
  border-color: var(--red);
  background: rgba(220, 38, 38, 0.05);
}

.file-input {
  position: absolute;
  inset: 0;
  opacity: 0;
  cursor: pointer;
}

.file-upload-content {
  pointer-events: none;
}

.file-upload-icon {
  color: var(--muted);
  margin-bottom: 1rem;
}

.file-upload-text {
  color: white;
  font-weight: 600;
  margin-bottom: 0.5rem;
}

.file-upload-sub {
  color: var(--muted);
  font-size: 0.8rem;
}

.uploaded-files {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  margin-top: 1.5rem;
}

.uploaded-file {
  display: flex;
  align-items: center;
  gap: 1rem;
  padding: 1rem;
  background: rgba(255, 255, 255, 0.05);
  border-radius: 12px;
  border: 1px solid rgba(255, 255, 255, 0.1);
}

.uploaded-preview {
  width: 60px;
  height: 60px;
  object-fit: cover;
  border-radius: 8px;
}

.uploaded-info {
  flex: 1;
}

.uploaded-name {
  display: block;
  color: white;
  font-weight: 500;
  margin-bottom: 0.25rem;
}

.uploaded-size {
  color: var(--muted);
  font-size: 0.8rem;
}

.uploaded-remove {
  background: rgba(220, 38, 38, 0.2);
  border: none;
  color: #fca5a5;
  padding: 0.5rem;
  border-radius: 8px;
  cursor: pointer;
  transition: all 0.3s ease;
}

.uploaded-remove:hover {
  background: rgba(220, 38, 38, 0.3);
}

/* Checkbox */
.checkbox-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.checkbox-label {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  cursor: pointer;
  color: white;
  font-size: 0.9rem;
  line-height: 1.4;
}

.checkbox-input {
  margin-top: 0.25rem;
  width: 18px;
  height: 18px;
  accent-color: var(--blue);
}

.checkbox-input.error {
  accent-color: var(--red);
}

/* Actions */
.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
  flex-wrap: wrap;
  margin-top: 3rem;
}

.btn {
  padding: 1rem 2rem;
  border: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
  min-height: 50px;
}

.btn-primary {
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  color: white;
  box-shadow: 0 8px 24px rgba(26, 86, 219, 0.3);
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(26, 86, 219, 0.4);
}

.btn-secondary {
  background: rgba(255, 255, 255, 0.1);
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.2);
}

.btn-secondary:hover {
  background: rgba(255, 255, 255, 0.15);
  border-color: rgba(255, 255, 255, 0.3);
  transform: translateY(-2px);
}

.btn-outline {
  background: transparent;
  color: white;
  border: 2px solid rgba(255, 255, 255, 0.3);
}

.btn-outline:hover {
  background: rgba(255, 255, 255, 0.1);
  border-color: rgba(255, 255, 255, 0.5);
  transform: translateY(-2px);
}

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none !important;
}

.btn-loading {
  animation: spin 1s linear infinite;
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}

/* Footer */
.compte-footer {
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  padding: 3rem 2rem;
  background: rgba(0, 0, 0, 0.2);
}

.footer-content {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  flex-wrap: wrap;
  gap: 2rem;
}

.footer-brand {
  text-align: left;
}

.footer-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.3rem;
  font-weight: 700;
  min-height: 80px;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  position: relative;
  overflow: hidden;
}

.mobile-btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
  transition: left 0.5s;
}

.mobile-btn:hover::before {
  left: 100%;
}

.mobile-btn-primary {
  background: linear-gradient(135deg, #1e40af, #3b82f6, #60a5fa);
  color: white;
  box-shadow: 0 12px 32px rgba(30, 64, 175, 0.5);
  border: 3px solid #1e40af;
}

.mobile-btn-primary:hover:not(:disabled) {
  transform: translateY(-4px) scale(1.02);
  box-shadow: 0 20px 48px rgba(30, 64, 175, 0.6);
  background: linear-gradient(135deg, #3b82f6, #60a5fa, #93c5fd);
}

.mobile-btn-secondary {
  background: linear-gradient(135deg, white, #f8fafc);
  color: #1e40af;
  border: 4px solid #1e40af;
  box-shadow: 0 8px 24px rgba(30, 64, 175, 0.3);
}

.mobile-btn-secondary:hover {
  background: linear-gradient(135deg, #1e40af, #3b82f6);
  color: white;
  transform: translateY(-3px) scale(1.02);
  box-shadow: 0 16px 40px rgba(30, 64, 175, 0.4);
}

/* Notification */
.notification {
  position: fixed;
  top: 2rem;
  right: 2rem;
  padding: 1rem 1.5rem;
  border-radius: 12px;
  box-shadow: 0 12px 32px rgba(0, 0, 0, 0.15);
  z-index: 10001;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1rem;
  min-width: 300px;
  animation: slideIn 0.3s ease;
}

.notification.success {
  background: linear-gradient(135deg, #059669, #10b981);
  color: white;
}

.notification.error {
  background: linear-gradient(135deg, #dc2626, #ef4444);
  color: white;
}

.notification.info {
  background: linear-gradient(135deg, #1e40af, #3b82f6);
  color: white;
}

.notification-content {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  flex: 1;
}

.notification-icon {
  font-size: 1.2rem;
  font-weight: bold;
}

.notification-message {
  font-size: 0.9rem;
  line-height: 1.4;
}

.notification-close {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
}

@keyframes slideIn {
  from {
    transform: translateX(100%);
    opacity: 0;
  }
  to {
    transform: translateX(0);
    opacity: 1;
  }
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
