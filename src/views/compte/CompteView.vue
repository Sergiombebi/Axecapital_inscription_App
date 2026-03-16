<script setup>
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabase'

const router = useRouter()

const currentStep = ref(1)
const totalSteps = 3
const isAnimating = ref(false)
const loading = ref(false)
const isMobile = ref(false)
const clientId = ref(null) // Pour stocker l'ID du client créé

const formData = ref({
  nom: '',
  prenom: '',
  dateNaissance: '',
  lieuNaissance: '',
  sexe: '',
  numeroCni: '',
  photosCni: [],
  photosCniUrls: [], // URLs après upload
  telephone: '',
  pays: '',
  ville: '',
  quartier: '',
  lieuDit: '',
  telephoneUrgence: '',
  contactUrgenceNom: '',
  faitLe: new Date().toISOString().split('T')[0],
  faitA: '',
  confirmation: false
})

const errors = ref({})
const notification = ref({
  show: false,
  message: '',
  type: 'info'
})

const pays = [
  'Cameroun', 'Nigeria', 'Gabon', 'Congo', 'Côte d\'Ivoire', 
  'Sénégal', 'Mali', 'Burkina Faso', 'Togo', 'Bénin',
  'Guinée', 'Sierra Leone', 'Libéria', 'Gambie', 'Guinée-Bissau',
  'Cap-Vert', 'Mauritanie', 'Niger', 'Tchad', 'République Centrafricaine',
  'République Démocratique du Congo', 'Rwanda', 'Burundi', 'Éthiopie',
  'Kenya', 'Ouganda', 'Tanzanie', 'Autre'
]

// Détecter si on est sur mobile
const checkMobile = () => {
  isMobile.value = window.innerWidth < 768
}

onMounted(() => {
  checkMobile()
  window.addEventListener('resize', checkMobile)
})

onUnmounted(() => {
  window.removeEventListener('resize', checkMobile)
})

// Computed properties pour les étapes
const stepTitle = computed(() => {
  const titles = {
    1: 'Informations Personnelles',
    2: 'Coordonnées & Documents',
    3: 'Validation & Soumission'
  }
  return titles[currentStep.value]
})

const stepDescription = computed(() => {
  const descriptions = {
    1: 'Renseignez vos informations personnelles de base',
    2: 'Ajoutez vos coordonnées et téléchargez vos documents',
    3: 'Vérifiez et soumettez votre demande d\'ouverture de compte'
  }
  return descriptions[currentStep.value]
})

const progressPercentage = computed(() => {
  return (currentStep.value / totalSteps) * 100
})

const stepIcon = computed(() => {
  const icons = {
    1: '👤',
    2: '📍',
    3: '✅'
  }
  return icons[currentStep.value]
})

// Animation de transition
const animateStepTransition = async (direction) => {
  isAnimating.value = true
  
  // Attendre la fin de l'animation
  await new Promise(resolve => setTimeout(resolve, 600))
  
  isAnimating.value = false
}

// Validation par étape
const validateCurrentStep = () => {
  const newErrors = {}
  
  if (currentStep.value === 1) {
    if (!formData.value.nom.trim()) {
      newErrors.nom = 'Le nom est requis'
    }
    
    if (!formData.value.prenom.trim()) {
      newErrors.prenom = 'Le prénom est requis'
    }
    
    if (!formData.value.dateNaissance) {
      newErrors.dateNaissance = 'La date de naissance est requise'
    }
    
    if (!formData.value.lieuNaissance.trim()) {
      newErrors.lieuNaissance = 'Le lieu de naissance est requis'
    }
    
    if (!formData.value.sexe) {
      newErrors.sexe = 'Le sexe est requis'
    }
  }
  
  if (currentStep.value === 2) {
    if (!formData.value.numeroCni.trim()) {
      newErrors.numeroCni = 'Le numéro CNI est requis'
    }
    
    if (formData.value.photosCni.length === 0) {
      newErrors.photosCni = 'Au moins une photo CNI est requise'
    }
    
    if (!formData.value.telephone.trim()) {
      newErrors.telephone = 'Le téléphone est requis'
    } else if (!/^[+]?[0-9]{9,15}$/.test(formData.value.telephone.replace(/\s/g, ''))) {
      newErrors.telephone = 'Le numéro de téléphone n\'est pas valide'
    }
    
    if (!formData.value.pays) {
      newErrors.pays = 'Le pays est requis'
    }
    
    if (!formData.value.ville.trim()) {
      newErrors.ville = 'La ville est requise'
    }
    
    if (!formData.value.quartier.trim()) {
      newErrors.quartier = 'Le quartier est requis'
    }
  }
  
  if (currentStep.value === 3) {
    if (!formData.value.telephoneUrgence.trim()) {
      newErrors.telephoneUrgence = 'Le téléphone d\'urgence est requis'
    } else if (!/^[+]?[0-9]{9,15}$/.test(formData.value.telephoneUrgence.replace(/\s/g, ''))) {
      newErrors.telephoneUrgence = 'Le numéro de téléphone d\'urgence n\'est pas valide'
    }
    
    if (!formData.value.contactUrgenceNom.trim()) {
      newErrors.contactUrgenceNom = 'Le nom du contact d\'urgence est requis'
    }
    
    if (!formData.value.faitA.trim()) {
      newErrors.faitA = 'Le lieu de signature est requis'
    }
    
    if (!formData.value.confirmation) {
      newErrors.confirmation = 'Vous devez accepter les conditions pour continuer'
    }
  }
  
  errors.value = newErrors
  return Object.keys(newErrors).length === 0
}

const nextStep = async () => {
  if (!validateCurrentStep()) {
    showNotification('Veuillez corriger les erreurs avant de continuer', 'error')
    return
  }
  
  if (currentStep.value < totalSteps) {
    await animateStepTransition('forward')
    currentStep.value++
    if (isMobile.value) {
      window.scrollTo({ top: 0, behavior: 'smooth' })
    }
  }
}

const prevStep = async () => {
  if (currentStep.value > 1) {
    await animateStepTransition('backward')
    currentStep.value--
    if (isMobile.value) {
      window.scrollTo({ top: 0, behavior: 'smooth' })
    }
  }
}

const showNotification = (message, type = 'info') => {
  notification.value = {
    show: true,
    message,
    type
  }
}

const handleNotificationClose = () => {
  notification.value.show = false
}

// Gestion des fichiers
const handleFileUpload = async (event) => {
  const files = Array.from(event.target.files)
  
  // Limiter à 5 photos maximum
  if (formData.value.photosCni.length + files.length > 5) {
    showNotification('Maximum 5 photos autorisées', 'error')
    return
  }
  
  // Vérifier la taille des fichiers (max 5MB)
  for (const file of files) {
    if (file.size > 5 * 1024 * 1024) {
      showNotification(`Le fichier ${file.name} dépasse 5MB`, 'error')
      return
    }
  }
  
  formData.value.photosCni = [...formData.value.photosCni, ...files]
  
  // Réinitialiser l'input pour permettre de sélectionner le même fichier
  event.target.value = ''
}

// Supprimer une photo
const removePhoto = (index) => {
  formData.value.photosCni.splice(index, 1)
  showNotification('Photo supprimée', 'success')
}

// Upload des photos dans Supabase Storage
const uploadPhotos = async () => {
  const uploadedUrls = []
  
  console.log('Début upload photos, nombre de fichiers:', formData.value.photosCni.length)
  
  for (const file of formData.value.photosCni) {
    console.log('Upload du fichier:', file.name, 'Taille:', file.size, 'Type:', file.type)
    
    const fileName = `cni_${Date.now()}_${Math.random().toString(36).substring(2, 15)}`
    console.log('Nom du fichier généré:', fileName)
    
    try {
      const { data, error } = await supabase.storage
        .from('cni-photos')
        .upload(fileName, file)
      
      console.log('Résultat upload:', { data, error })
      
      if (error) {
        console.error('Erreur upload détaillée:', error)
        throw new Error(`Erreur lors de l'upload de ${file.name}: ${error.message}`)
      }
      
      // Obtenir l'URL publique
      const { data: { publicUrl } } = supabase.storage
        .from('cni-photos')
        .getPublicUrl(fileName)
      
      console.log('URL publique générée:', publicUrl)
      uploadedUrls.push(fileName) // Stocker le nom du fichier, pas l'URL
      
    } catch (uploadError) {
      console.error('Erreur upload complète:', uploadError)
      throw uploadError
    }
  }
  
  console.log('Tous les fichiers uploadés:', uploadedUrls)
  return uploadedUrls
}

// Enregistrement du client dans Supabase
const registerClient = async () => {
  try {
    console.log('Début registerClient...')
    loading.value = true
    
    console.log('FormData:', formData.value)
    
    // 1. Upload des photos
    console.log('Upload des photos...')
    const photoNames = await uploadPhotos()
    console.log('Photos uploadées:', photoNames)
    
    // 2. Enregistrement du client
    console.log('Insertion dans la base de données...')
    const { data, error } = await supabase
      .from('clients')
      .insert({
        nom: formData.value.nom.trim(),
        prenom: formData.value.prenom.trim(),
        date_naissance: formData.value.dateNaissance,
        lieu_naissance: formData.value.lieuNaissance.trim(),
        sexe: formData.value.sexe,
        numero_cni: formData.value.numeroCni.trim(),
        photos_cni: photoNames,
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
    
    console.log('Résultat insertion:', { data, error })
    
    if (error) {
      console.error('Erreur insertion:', error)
      throw new Error('Erreur lors de l\'enregistrement du compte')
    }
    
    // Stocker l'ID du client pour la page de récapitulatif
    clientId.value = data.id
    console.log('Client ID:', clientId.value)
    
    // Rediriger vers la page de récapitulatif
    console.log('Redirection vers /compte/recapitulatif')
    router.push('/compte/recapitulatif')
    
  } catch (error) {
    console.error('Erreur complète:', error)
    showNotification(error.message || 'Une erreur est survenue', 'error')
  } finally {
    loading.value = false
    console.log('Fin registerClient')
  }
}

const goToHome = () => {
  router.push('/')
}

const handleSubmit = async () => {
  console.log('handleSubmit appelé - currentStep:', currentStep.value, 'totalSteps:', totalSteps)
  
  if (!validateCurrentStep()) {
    console.log('Validation échouée')
    return
  }
  
  if (currentStep.value < totalSteps) {
    console.log('Passage à l\'étape suivante')
    await nextStep()
  } else {
    console.log('Enregistrement du client...')
    await registerClient()
  }
}

const getStepTitle = (step) => {
  const titles = {
    1: 'Infos',
    2: 'Coord.',
    3: 'Valid.'
  }
  return titles[step] || ''
}

// Fermer sur mobile avec la touche Escape
const handleEscape = (event) => {
  if (event.key === 'Escape' && isMobile.value) {
    goToHome()
  }
}

onMounted(() => {
  document.addEventListener('keydown', handleEscape)
})

onUnmounted(() => {
  document.removeEventListener('keydown', handleEscape)
})
</script>

<template>
  <div class="compte-page">
    <!-- Notification -->
    <div v-if="notification.show" :class="['notification', notification.type]">
      <div class="notification-content">
        <span class="notification-icon">
          {{ notification.type === 'success' ? '✅' : notification.type === 'error' ? '❌' : 'ℹ️' }}
        </span>
        <span class="notification-message">{{ notification.message }}</span>
        <button @click="handleNotificationClose" class="notification-close">×</button>
      </div>
    </div>

    <!-- Mode Desktop -->
    <div v-if="!isMobile" class="desktop-container">
      <div class="form-wrapper">
        <div class="form-header">
          <div class="logo">
            <h1 class="logo-text">AXE<span class="logo-blue">CAPITAL</span></h1>
          </div>
          <h2 class="form-title">Ouverture de Compte</h2>
          <button @click="goToHome" class="cancel-btn">
            <span class="cancel-icon">✕</span>
            Annuler
          </button>
        </div>

        <!-- Progress Bar Desktop -->
        <div class="progress-container">
          <div class="progress-bar">
            <div class="progress-fill" :style="{ width: progressPercentage + '%' }"></div>
          </div>
          <div class="progress-steps">
            <div 
              v-for="step in totalSteps" 
              :key="step"
              :class="['progress-step', { active: currentStep >= step, current: currentStep === step }]"
            >
              <div class="step-number">{{ step }}</div>
              <div class="step-label">
                <span class="step-title">{{ getStepTitle(step) }}</span>
              </div>
            </div>
          </div>
        </div>

        <!-- Step Info -->
        <div class="step-info">
          <div class="step-icon-large">{{ stepIcon }}</div>
          <div>
            <h3 class="step-title-main">{{ stepTitle }}</h3>
            <p class="step-description">{{ stepDescription }}</p>
          </div>
        </div>

        <!-- Form Content -->
        <div class="form-content" :class="{ animating: isAnimating }">
          <form @submit.prevent="handleSubmit" class="account-form">
            <!-- Étape 1 -->
            <div v-if="currentStep === 1" class="step-content">
              <div class="form-grid">
                <div class="form-group">
                  <label for="nom">Nom *</label>
                  <input
                    type="text"
                    id="nom"
                    v-model="formData.nom"
                    placeholder="Entrez votre nom"
                    class="form-input"
                    :class="{ error: errors.nom }"
                  />
                  <span v-if="errors.nom" class="error-text">{{ errors.nom }}</span>
                </div>

                <div class="form-group">
                  <label for="prenom">Prénom *</label>
                  <input
                    type="text"
                    id="prenom"
                    v-model="formData.prenom"
                    placeholder="Entrez votre prénom"
                    class="form-input"
                    :class="{ error: errors.prenom }"
                  />
                  <span v-if="errors.prenom" class="error-text">{{ errors.prenom }}</span>
                </div>

                <div class="form-group">
                  <label for="dateNaissance">Date de naissance *</label>
                  <input
                    type="date"
                    id="dateNaissance"
                    v-model="formData.dateNaissance"
                    class="form-input"
                    :class="{ error: errors.dateNaissance }"
                  />
                  <span v-if="errors.dateNaissance" class="error-text">{{ errors.dateNaissance }}</span>
                </div>

                <div class="form-group">
                  <label for="lieuNaissance">Lieu de naissance *</label>
                  <input
                    type="text"
                    id="lieuNaissance"
                    v-model="formData.lieuNaissance"
                    placeholder="Entrez le lieu de naissance"
                    class="form-input"
                    :class="{ error: errors.lieuNaissance }"
                  />
                  <span v-if="errors.lieuNaissance" class="error-text">{{ errors.lieuNaissance }}</span>
                </div>

                <div class="form-group">
                  <label for="sexe">Sexe *</label>
                  <select
                    id="sexe"
                    v-model="formData.sexe"
                    class="form-input"
                    :class="{ error: errors.sexe }"
                  >
                    <option value="">Sélectionnez</option>
                    <option value="M">Masculin</option>
                    <option value="F">Féminin</option>
                  </select>
                  <span v-if="errors.sexe" class="error-text">{{ errors.sexe }}</span>
                </div>
              </div>
            </div>

            <!-- Étape 2 -->
            <div v-if="currentStep === 2" class="step-content">
              <div class="sub-section">
                <h4 class="sub-section-title">📄 Carte Nationale d'Identité</h4>
                <div class="form-grid">
                  <div class="form-group">
                    <label for="numeroCni">Numéro CNI *</label>
                    <input
                      type="text"
                      id="numeroCni"
                      v-model="formData.numeroCni"
                      placeholder="Entrez votre numéro CNI"
                      class="form-input"
                      :class="{ error: errors.numeroCni }"
                    />
                    <span v-if="errors.numeroCni" class="error-text">{{ errors.numeroCni }}</span>
                  </div>

                  <div class="form-group full-width">
                    <label>Photos CNI *</label>
                    <div class="file-upload">
                      <input
                        type="file"
                        id="photosCni"
                        multiple
                        accept="image/*"
                        @change="handleFileUpload"
                        class="file-input"
                      />
                      <label for="photosCni" class="file-label">
                        <span class="file-icon">📷</span>
                        <span>Cliquez pour ajouter des photos</span>
                        <span class="file-hint">Plusieurs photos autorisées</span>
                      </label>
                    </div>
                    <span v-if="errors.photosCni" class="error-text">{{ errors.photosCni }}</span>
                    
                    <div v-if="formData.photosCni.length > 0" class="uploaded-files">
                      <div v-for="(file, index) in formData.photosCni" :key="index" class="file-item">
                        <span class="file-name">{{ file.name }}</span>
                        <button type="button" @click="removePhoto(index)" class="remove-btn">×</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>

              <div class="sub-section">
                <h4 class="sub-section-title">📍 Coordonnées</h4>
                <div class="form-grid">
                  <div class="form-group">
                    <label for="telephone">Téléphone *</label>
                    <input
                      type="tel"
                      id="telephone"
                      v-model="formData.telephone"
                      placeholder="+237 XXX XXX XXX"
                      class="form-input"
                      :class="{ error: errors.telephone }"
                    />
                    <span v-if="errors.telephone" class="error-text">{{ errors.telephone }}</span>
                  </div>

                  <div class="form-group">
                    <label for="pays">Pays *</label>
                    <select
                      id="pays"
                      v-model="formData.pays"
                      class="form-input"
                      :class="{ error: errors.pays }"
                    >
                      <option value="">Sélectionnez un pays</option>
                      <option v-for="country in pays" :key="country" :value="country">
                        {{ country }}
                      </option>
                    </select>
                    <span v-if="errors.pays" class="error-text">{{ errors.pays }}</span>
                  </div>

                  <div class="form-group">
                    <label for="ville">Ville *</label>
                    <input
                      type="text"
                      id="ville"
                      v-model="formData.ville"
                      placeholder="Entrez votre ville"
                      class="form-input"
                      :class="{ error: errors.ville }"
                    />
                    <span v-if="errors.ville" class="error-text">{{ errors.ville }}</span>
                  </div>

                  <div class="form-group">
                    <label for="quartier">Quartier *</label>
                    <input
                      type="text"
                      id="quartier"
                      v-model="formData.quartier"
                      placeholder="Entrez votre quartier"
                      class="form-input"
                      :class="{ error: errors.quartier }"
                    />
                    <span v-if="errors.quartier" class="error-text">{{ errors.quartier }}</span>
                  </div>

                  <div class="form-group">
                    <label for="lieuDit">Lieu dit (optionnel)</label>
                    <input
                      type="text"
                      id="lieuDit"
                      v-model="formData.lieuDit"
                      placeholder="Entrez le lieu dit"
                      class="form-input"
                    />
                  </div>
                </div>
              </div>
            </div>

            <!-- Étape 3 -->
            <div v-if="currentStep === 3" class="step-content">
              <div class="sub-section">
                <h4 class="sub-section-title">🆘 Contact d'urgence</h4>
                <div class="form-grid">
                  <div class="form-group">
                    <label for="telephoneUrgence">Téléphone d'urgence *</label>
                    <input
                      type="tel"
                      id="telephoneUrgence"
                      v-model="formData.telephoneUrgence"
                      placeholder="+237 XXX XXX XXX"
                      class="form-input"
                      :class="{ error: errors.telephoneUrgence }"
                    />
                    <span v-if="errors.telephoneUrgence" class="error-text">{{ errors.telephoneUrgence }}</span>
                  </div>

                  <div class="form-group">
                    <label for="contactUrgenceNom">Nom du contact d'urgence *</label>
                    <input
                      type="text"
                      id="contactUrgenceNom"
                      v-model="formData.contactUrgenceNom"
                      placeholder="Entrez le nom complet"
                      class="form-input"
                      :class="{ error: errors.contactUrgenceNom }"
                    />
                    <span v-if="errors.contactUrgenceNom" class="error-text">{{ errors.contactUrgenceNom }}</span>
                  </div>
                </div>
              </div>

              <div class="sub-section">
                <h4 class="sub-section-title">✍️ Signature</h4>
                <div class="form-grid">
                  <div class="form-group">
                    <label for="faitLe">Fait le *</label>
                    <input
                      type="date"
                      id="faitLe"
                      v-model="formData.faitLe"
                      class="form-input"
                      readonly
                    />
                  </div>

                  <div class="form-group">
                    <label for="faitA">Fait à *</label>
                    <input
                      type="text"
                      id="faitA"
                      v-model="formData.faitA"
                      placeholder="Entrez le lieu de signature"
                      class="form-input"
                      :class="{ error: errors.faitA }"
                    />
                    <span v-if="errors.faitA" class="error-text">{{ errors.faitA }}</span>
                  </div>
                </div>
              </div>

              <div class="sub-section">
                <h4 class="sub-section-title">✅ Validation</h4>
                <div class="checkbox-group">
                  <label class="checkbox-label">
                    <input
                      type="checkbox"
                      v-model="formData.confirmation"
                      class="checkbox-input"
                    />
                    <span class="checkbox-text">
                    Les fonds sont bloquer pendant toutes la periode du jeu. *
                    </span>
                  </label>
                  <span v-if="errors.confirmation" class="error-text">{{ errors.confirmation }}</span>
                </div>
              </div>
            </div>

            <!-- Actions -->
            <div class="form-actions">
              <button 
                type="button" 
                @click="prevStep" 
                class="btn btn-secondary"
                v-if="currentStep > 1"
              >
                ← Étape précédente
              </button>
              
              <button 
                type="button" 
                @click="nextStep" 
                class="btn btn-primary"
                v-if="currentStep < totalSteps"
              >
                Étape suivante →
              </button>
              
              <button 
                type="submit" 
                :disabled="loading" 
                class="btn btn-primary"
                v-if="currentStep === totalSteps"
              >
                <span v-if="loading">⏳ Création en cours...</span>
                <span v-else>🚀 Créer mon compte</span>
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>

    <!-- Mode Mobile (Modal) -->
    <div v-if="isMobile" class="mobile-modal">
      <div class="mobile-header">
        <div class="mobile-nav">
          <button @click="goToHome" class="mobile-close">
            <span>✕</span>
          </button>
          <h3 class="mobile-title">Ouverture de Compte</h3>
          <div class="mobile-step-indicator">
            {{ currentStep }}/{{ totalSteps }}
          </div>
        </div>
        
        <!-- Progress Mobile -->
        <div class="mobile-progress">
          <div class="mobile-progress-bar">
            <div class="mobile-progress-fill" :style="{ width: progressPercentage + '%' }"></div>
          </div>
          <div class="mobile-step-info">
            <span class="mobile-step-icon">{{ stepIcon }}</span>
            <div>
              <div class="mobile-step-title">{{ stepTitle }}</div>
              <div class="mobile-step-desc">{{ stepDescription }}</div>
            </div>
          </div>
        </div>
      </div>

      <div class="mobile-content" :class="{ animating: isAnimating }">
        <form @submit.prevent="handleSubmit" class="mobile-form">
          <!-- Contenu des étapes (même structure que desktop mais adaptée mobile) -->
          <div v-if="currentStep === 1" class="mobile-step-content">
            <div class="mobile-form-group">
              <label for="nom">Nom *</label>
              <input
                type="text"
                id="nom"
                v-model="formData.nom"
                placeholder="Entrez votre nom"
                class="mobile-form-input"
                :class="{ error: errors.nom }"
              />
              <span v-if="errors.nom" class="mobile-error-text">{{ errors.nom }}</span>
            </div>

            <div class="mobile-form-group">
              <label for="prenom">Prénom *</label>
              <input
                type="text"
                id="prenom"
                v-model="formData.prenom"
                placeholder="Entrez votre prénom"
                class="mobile-form-input"
                :class="{ error: errors.prenom }"
              />
              <span v-if="errors.prenom" class="mobile-error-text">{{ errors.prenom }}</span>
            </div>

            <div class="mobile-form-group">
              <label for="dateNaissance">Date de naissance *</label>
              <input
                type="date"
                id="dateNaissance"
                v-model="formData.dateNaissance"
                class="mobile-form-input"
                :class="{ error: errors.dateNaissance }"
              />
              <span v-if="errors.dateNaissance" class="mobile-error-text">{{ errors.dateNaissance }}</span>
            </div>

            <div class="mobile-form-group">
              <label for="lieuNaissance">Lieu de naissance *</label>
              <input
                type="text"
                id="lieuNaissance"
                v-model="formData.lieuNaissance"
                placeholder="Entrez le lieu de naissance"
                class="mobile-form-input"
                :class="{ error: errors.lieuNaissance }"
              />
              <span v-if="errors.lieuNaissance" class="mobile-error-text">{{ errors.lieuNaissance }}</span>
            </div>

            <div class="mobile-form-group">
              <label for="sexe">Sexe *</label>
              <select
                id="sexe"
                v-model="formData.sexe"
                class="mobile-form-input"
                :class="{ error: errors.sexe }"
              >
                <option value="">Sélectionnez</option>
                <option value="M">Masculin</option>
                <option value="F">Féminin</option>
              </select>
              <span v-if="errors.sexe" class="mobile-error-text">{{ errors.sexe }}</span>
            </div>
          </div>

          <!-- Étape 2 Mobile -->
          <div v-if="currentStep === 2" class="mobile-step-content">
            <div class="mobile-sub-section">
              <h4 class="mobile-sub-title">📄 Carte Nationale d'Identité</h4>
              <div class="mobile-form-group">
                <label for="numeroCni">Numéro CNI *</label>
                <input
                  type="text"
                  id="numeroCni"
                  v-model="formData.numeroCni"
                  placeholder="Entrez votre numéro CNI"
                  class="mobile-form-input"
                  :class="{ error: errors.numeroCni }"
                />
                <span v-if="errors.numeroCni" class="mobile-error-text">{{ errors.numeroCni }}</span>
              </div>

              <div class="mobile-form-group">
                <label>Photos CNI *</label>
                <div class="mobile-file-upload">
                  <input
                    type="file"
                    id="photosCni"
                    multiple
                    accept="image/*"
                    @change="handleFileUpload"
                    class="mobile-file-input"
                  />
                  <label for="photosCni" class="mobile-file-label">
                    <span class="mobile-file-icon">📷</span>
                    <span>Ajouter des photos</span>
                  </label>
                </div>
                <span v-if="errors.photosCni" class="mobile-error-text">{{ errors.photosCni }}</span>
                
                <div v-if="formData.photosCni.length > 0" class="mobile-uploaded-files">
                  <div v-for="(file, index) in formData.photosCni" :key="index" class="mobile-file-item">
                    <span class="mobile-file-name">{{ file.name }}</span>
                    <button type="button" @click="removePhoto(index)" class="mobile-remove-btn">×</button>
                  </div>
                </div>
              </div>
            </div>

            <div class="mobile-sub-section">
              <h4 class="mobile-sub-title">📍 Coordonnées</h4>
              <div class="mobile-form-group">
                <label for="telephone">Téléphone *</label>
                <input
                  type="tel"
                  id="telephone"
                  v-model="formData.telephone"
                  placeholder="+237 XXX XXX XXX"
                  class="mobile-form-input"
                  :class="{ error: errors.telephone }"
                />
                <span v-if="errors.telephone" class="mobile-error-text">{{ errors.telephone }}</span>
              </div>

              <div class="mobile-form-group">
                <label for="pays">Pays *</label>
                <select
                  id="pays"
                  v-model="formData.pays"
                  class="mobile-form-input"
                  :class="{ error: errors.pays }"
                >
                  <option value="">Sélectionnez un pays</option>
                  <option v-for="country in pays" :key="country" :value="country">
                    {{ country }}
                  </option>
                </select>
                <span v-if="errors.pays" class="mobile-error-text">{{ errors.pays }}</span>
              </div>

              <div class="mobile-form-group">
                <label for="ville">Ville *</label>
                <input
                  type="text"
                  id="ville"
                  v-model="formData.ville"
                  placeholder="Entrez votre ville"
                  class="mobile-form-input"
                  :class="{ error: errors.ville }"
                />
                <span v-if="errors.ville" class="mobile-error-text">{{ errors.ville }}</span>
              </div>

              <div class="mobile-form-group">
                <label for="quartier">Quartier *</label>
                <input
                  type="text"
                  id="quartier"
                  v-model="formData.quartier"
                  placeholder="Entrez votre quartier"
                  class="mobile-form-input"
                  :class="{ error: errors.quartier }"
                />
                <span v-if="errors.quartier" class="mobile-error-text">{{ errors.quartier }}</span>
              </div>

              <div class="mobile-form-group">
                <label for="lieuDit">Lieu dit (optionnel)</label>
                <input
                  type="text"
                  id="lieuDit"
                  v-model="formData.lieuDit"
                  placeholder="Entrez le lieu dit"
                  class="mobile-form-input"
                />
              </div>
            </div>
          </div>

          <!-- Étape 3 Mobile -->
          <div v-if="currentStep === 3" class="mobile-step-content">
            <div class="mobile-sub-section">
              <h4 class="mobile-sub-title">🆘 Contact d'urgence</h4>
              <div class="mobile-form-group">
                <label for="telephoneUrgence">Téléphone d'urgence *</label>
                <input
                  type="tel"
                  id="telephoneUrgence"
                  v-model="formData.telephoneUrgence"
                  placeholder="+237 XXX XXX XXX"
                  class="mobile-form-input"
                  :class="{ error: errors.telephoneUrgence }"
                />
                <span v-if="errors.telephoneUrgence" class="mobile-error-text">{{ errors.telephoneUrgence }}</span>
              </div>

              <div class="mobile-form-group">
                <label for="contactUrgenceNom">Nom du contact d'urgence *</label>
                <input
                  type="text"
                  id="contactUrgenceNom"
                  v-model="formData.contactUrgenceNom"
                  placeholder="Entrez le nom complet"
                  class="mobile-form-input"
                  :class="{ error: errors.contactUrgenceNom }"
                />
                <span v-if="errors.contactUrgenceNom" class="mobile-error-text">{{ errors.contactUrgenceNom }}</span>
              </div>
            </div>

            <div class="mobile-sub-section">
              <h4 class="mobile-sub-title">✍️ Signature</h4>
              <div class="mobile-form-group">
                <label for="faitLe">Fait le *</label>
                <input
                  type="date"
                  id="faitLe"
                  v-model="formData.faitLe"
                  class="mobile-form-input"
                  readonly
                />
              </div>

              <div class="mobile-form-group">
                <label for="faitA">Fait à *</label>
                <input
                  type="text"
                  id="faitA"
                  v-model="formData.faitA"
                  placeholder="Entrez le lieu de signature"
                  class="mobile-form-input"
                  :class="{ error: errors.faitA }"
                />
                <span v-if="errors.faitA" class="mobile-error-text">{{ errors.faitA }}</span>
              </div>
            </div>

            <div class="mobile-sub-section">
              <h4 class="mobile-sub-title">✅ Validation</h4>
              <div class="mobile-checkbox-group">
                <label class="mobile-checkbox-label">
                  <input
                    type="checkbox"
                    v-model="formData.confirmation"
                    class="mobile-checkbox-input"
                  />
                  <span class="mobile-checkbox-text">
                    Je certifie que toutes les informations fournies sont exactes et j'accepte les conditions générales d'utilisation d'AXE CAPITAL. *
                  </span>
                </label>
                <span v-if="errors.confirmation" class="mobile-error-text">{{ errors.confirmation }}</span>
              </div>
            </div>
          </div>

          <!-- Actions Mobile -->
          <div class="mobile-actions">
            <button 
              type="button" 
              @click="prevStep" 
              class="mobile-btn mobile-btn-secondary"
              v-if="currentStep > 1"
            >
              ← Précédent
            </button>
            
            <button 
              type="button" 
              @click="nextStep" 
              class="mobile-btn mobile-btn-primary"
              v-if="currentStep < totalSteps"
            >
              Suivant →
            </button>
            
            <button 
              type="submit" 
              :disabled="loading" 
              class="mobile-btn mobile-btn-primary"
              v-if="currentStep === totalSteps"
            >
              <span v-if="loading">⏳ En cours...</span>
              <span v-else>🚀 Créer</span>
            </button>
          </div>
        </form>
      </div>
    </div>
  </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&display=swap');

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

.compte-page {
  min-height: 100vh;
  font-family: 'Plus Jakarta Sans', sans-serif;
  background: #dbeafe;
  color: #1e40af;
  --blue: #60a5fa;
  --blue-dk: #3b82f6;
  --blue-lt: #93c5fd;
  --blue-pale: #eff6ff;
  --blue-mid: #dbeafe;
  --dark: #1e40af;
  --text: #374151;
  --muted: #6b7280;
  --green: #059669;
  --red: #dc2626;
}

/* Notification */
.notification {
  position: fixed;
  top: 20px;
  right: 20px;
  padding: 1rem 1.5rem;
  border-radius: 12px;
  z-index: 10000;
  max-width: 400px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  backdrop-filter: blur(10px);
  animation: slideInRight 0.3s ease;
}

.notification.success {
  background: linear-gradient(135deg, var(--green), #10b981);
  color: white;
}

.notification.error {
  background: linear-gradient(135deg, var(--red), #ef4444);
  color: white;
}

.notification.info {
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  color: white;
}

.notification-content {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.notification-icon {
  font-size: 1.2rem;
}

.notification-message {
  flex: 1;
  font-weight: 500;
}

.notification-close {
  background: rgba(255, 255, 255, 0.2);
  border: none;
  color: white;
  font-size: 1.2rem;
  cursor: pointer;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.3s ease;
}

.notification-close:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: scale(1.1);
}

/* Desktop Container */
.desktop-container {
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
}

.form-wrapper {
  background: white;
  border-radius: 24px;
  padding: 3rem;
  width: 100%;
  max-width: 900px;
  box-shadow: 0 30px 80px rgba(0, 0, 0, 0.2);
  position: relative;
  overflow: hidden;
}

.form-wrapper::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  height: 4px;
  background: linear-gradient(90deg, var(--blue), var(--blue-lt), var(--blue));
}

.form-header {
  text-align: center;
  margin-bottom: 3rem;
  position: relative;
}

.cancel-btn {
  position: absolute;
  top: 0;
  right: 0;
  background: rgba(220, 38, 38, 0.1);
  border: 2px solid rgba(220, 38, 38, 0.2);
  color: var(--red);
  padding: 0.5rem 1rem;
  border-radius: 8px;
  font-size: 0.9rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  gap: 0.5rem;
}

.cancel-btn:hover {
  background: var(--red);
  color: white;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
}

.cancel-icon {
  font-size: 1rem;
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

.form-title {
  font-family: 'Syne', sans-serif;
  font-size: 2rem;
  font-weight: 700;
  color: var(--dark);
  margin: 1rem 0 0.5rem;
  letter-spacing: -0.02em;
}

.form-subtitle {
  color: var(--muted);
  font-size: 1rem;
  font-weight: 300;
}

/* Progress */
.progress-container {
  margin-bottom: 2.5rem;
}

.progress-bar {
  height: 6px;
  background: #e2e8f0;
  border-radius: 3px;
  margin-bottom: 2rem;
  overflow: hidden;
  position: relative;
}

.progress-fill {
  height: 100%;
  background: linear-gradient(90deg, var(--blue), var(--blue-lt));
  border-radius: 3px;
  transition: width 0.6s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
}

.progress-fill::after {
  content: '';
  position: absolute;
  top: 0;
  right: 0;
  width: 20px;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3));
  animation: shimmer 2s infinite;
}

@keyframes shimmer {
  0% { transform: translateX(-100%); }
  100% { transform: translateX(100%); }
}

.progress-steps {
  display: flex;
  justify-content: space-between;
  position: relative;
}

.progress-step {
  display: flex;
  flex-direction: column;
  align-items: center;
  flex: 1;
  position: relative;
}

.step-number {
  width: 48px;
  height: 48px;
  border-radius: 50%;
  background: #e2e8f0;
  color: var(--muted);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 700;
  font-size: 1rem;
  margin-bottom: 0.75rem;
  transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
  position: relative;
}

.progress-step.active .step-number {
  background: var(--blue);
  color: white;
  box-shadow: 0 8px 24px rgba(26, 86, 219, 0.3);
  transform: scale(1.05);
}

.progress-step.current .step-number {
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  color: white;
  box-shadow: 0 12px 32px rgba(26, 86, 219, 0.4);
  transform: scale(1.15);
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0%, 100% { transform: scale(1.15); }
  50% { transform: scale(1.25); }
}

.step-label {
  text-align: center;
}

.step-title {
  font-size: 0.8rem;
  color: var(--muted);
  font-weight: 600;
  transition: all 0.3s ease;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.progress-step.active .step-title {
  color: var(--blue);
  font-weight: 700;
}

.progress-step.current .step-title {
  color: var(--dark);
  font-weight: 800;
}

/* Step Info */
.step-info {
  text-align: center;
  margin-bottom: 2.5rem;
  padding: 2rem;
  background: linear-gradient(135deg, var(--blue-pale), #f0f9ff);
  border-radius: 16px;
  border: 1px solid var(--blue-mid);
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1.5rem;
}

.step-icon-large {
  font-size: 3rem;
  animation: float 3s ease-in-out infinite;
}

@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

.step-title-main {
  font-family: 'Syne', sans-serif;
  font-size: 1.8rem;
  font-weight: 700;
  color: var(--dark);
  margin-bottom: 0.5rem;
  letter-spacing: -0.02em;
}

.step-description {
  color: var(--muted);
  font-size: 1rem;
  font-weight: 300;
}

/* Form Content */
.form-content {
  position: relative;
  min-height: 400px;
}

.form-content.animating {
  animation: fadeOut 0.3s ease;
}

@keyframes fadeOut {
  0% { opacity: 1; transform: translateX(0); }
  100% { opacity: 0; transform: translateX(-20px); }
}

.step-content {
  animation: fadeIn 0.6s ease;
}

@keyframes fadeIn {
  0% { opacity: 0; transform: translateX(20px); }
  100% { opacity: 1; transform: translateX(0); }
}

/* Form Styles */
.sub-section {
  margin-bottom: 2.5rem;
}

.sub-section-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.2rem;
  font-weight: 700;
  color: var(--dark);
  margin-bottom: 1.5rem;
  padding-bottom: 0.75rem;
  border-bottom: 2px solid var(--blue-pale);
  letter-spacing: -0.02em;
}

.form-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-group.full-width {
  grid-column: 1 / -1;
}

/* FORCER TOUS LES LABELS EN BLEU FONCE */
.form-group label {
  font-weight: 600;
  color: #1e40af !important;
  font-size: 0.9rem;
}

.mobile-form-group label {
  font-weight: 600;
  color: #1e40af !important;
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
  display: block;
}

.file-label {
  color: #1e40af !important;
}

.checkbox-label {
  color: #1e40af !important;
}

.checkbox-text {
  color: #1e40af !important;
}

.mobile-form-input {
  padding: 1rem;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  font-size: 0.95rem;
  background: linear-gradient(135deg, #1e40af, #3b82f6, #60a5fa);
  color: white;
  transition: all 0.3s ease;
}

.form-input:focus {
  outline: none;
  border-color: var(--blue);
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
  background: white;
  transform: translateY(-2px);
}

.form-input::placeholder {
  color: #94a3b8;
}

.form-input.error {
  border-color: var(--red);
  background: #fef2f2;
}

.error-text {
  color: var(--red);
  font-size: 0.85rem;
  font-weight: 500;
  margin-top: 0.25rem;
}
.file-upload {
  position: relative;
}

.file-input {
  display: none;
}

.file-label {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.75rem;
  padding: 2.5rem;
  border: 2px dashed #cbd5e1;
  border-radius: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  background: #f8fafc;
  color: #1e40af;
}

.file-label:hover {
  border-color: var(--blue);
  background: var(--blue-pale);
  transform: translateY(-2px);
}

.file-icon {
  font-size: 2.5rem;
}

.file-hint {
  font-size: 0.85rem;
  color: var(--muted);
}

.uploaded-files {
  margin-top: 1rem;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.file-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem 1.25rem;
  background: var(--blue-pale);
  border-radius: 12px;
  border: 1px solid var(--blue-mid);
  transition: all 0.3s ease;
}

.file-item:hover {
  background: #dbeafe;
  transform: translateX(4px);
}

.file-name {
  font-size: 0.9rem;
  color: var(--dark);
  font-weight: 500;
}

.remove-btn {
  background: var(--red);
  color: white;
  border: none;
  border-radius: 50%;
  width: 28px;
  height: 28px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1rem;
  transition: all 0.3s ease;
}

.remove-btn:hover {
  background: #b91c1c;
  transform: scale(1.1) rotate(90deg);
}

/* Checkbox */
.checkbox-group {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.checkbox-label {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
  cursor: pointer;
  font-size: 0.95rem;
  line-height: 1.6;
  color: #1e40af;
}

.checkbox-input {
  width: auto;
  margin: 0;
  margin-top: 0.25rem;
}

.checkbox-text {
  color: #1e40af;
  flex: 1;
}

/* Actions */
.form-actions {
  display: flex;
  gap: 1rem;
  justify-content: space-between;
  margin-top: 3rem;
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
  transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
  text-decoration: none;
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 160px;
  position: relative;
  overflow: hidden;
}

.btn::before {
  content: '';
  position: absolute;
  top: 0;
  left: -100%;
  width: 100%;
  height: 100%;
  background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
  transition: left 0.5s;
}

.btn:hover::before {
  left: 100%;
}

.btn-primary {
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  color: white;
  box-shadow: 0 12px 32px rgba(26, 86, 219, 0.3);
}

.btn-primary:hover:not(:disabled) {
  background: linear-gradient(135deg, var(--blue-lt), var(--blue));
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

.btn:disabled {
  opacity: 0.6;
  cursor: not-allowed;
  transform: none;
}

/* Mobile Modal */
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
  animation: slideUp 0.4s ease;
}

@keyframes slideUp {
  0% { transform: translateY(100%); }
  100% { transform: translateY(0); }
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
  margin-bottom: 1rem;
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
  transition: all 0.3s ease;
}

.mobile-close:hover {
  background: rgba(255, 255, 255, 0.3);
  transform: scale(1.1);
}

.mobile-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.3rem;
  font-weight: 700;
  margin: 0;
}

.mobile-step-indicator {
  background: rgba(255, 255, 255, 0.2);
  padding: 0.5rem 1rem;
  border-radius: 20px;
  font-size: 0.85rem;
  font-weight: 600;
}

.mobile-progress {
  margin-bottom: 1.5rem;
}

.mobile-progress-bar {
  height: 4px;
  background: rgba(255, 255, 255, 0.3);
  border-radius: 2px;
  margin-bottom: 1rem;
  overflow: hidden;
}

.mobile-progress-fill {
  height: 100%;
  background: white;
  border-radius: 2px;
  transition: width 0.6s ease;
}

.mobile-step-info {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.mobile-step-icon {
  font-size: 2rem;
  animation: float 3s ease-in-out infinite;
}

.mobile-step-title {
  font-weight: 700;
  font-size: 1rem;
  margin-bottom: 0.25rem;
}

.mobile-step-desc {
  font-size: 0.85rem;
  opacity: 0.8;
}

.mobile-content {
  flex: 1;
  overflow-y: auto;
  padding: 1.5rem;
}

.mobile-form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.mobile-step-content {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.mobile-sub-section {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.mobile-sub-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--dark);
  margin-bottom: 0.5rem;
}

.mobile-form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.mobile-form-group label {
  font-weight: 600;
  color: #1e40af;
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
  display: block;
}

.mobile-form-input {
  padding: 1rem;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  font-size: 1rem;
  transition: all 0.3s ease;
  background: #f8fafc;
}

.mobile-form-input:focus {
  outline: none;
  border-color: #60a5fa;
  box-shadow: 0 0 0 3px rgba(96, 165, 250, 0.3);
  background: linear-gradient(135deg, #2563eb, #3b82f6, #60a5fa);
}

.mobile-form-input::placeholder {
  color: rgba(255, 255, 255, 0.7);
}

.mobile-form-input.error {
  border-color: var(--red);
  background: #fef2f2;
}

.mobile-error-text {
  color: var(--red);
  font-size: 0.8rem;
  font-weight: 500;
}

.mobile-file-input {
  display: none;
}

.mobile-file-label {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 1.5rem;
  border: 2px dashed #cbd5e1;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  background: #f8fafc;
}

.mobile-file-label:hover {
  border-color: var(--blue);
  background: var(--blue-pale);
}

.mobile-file-icon {
  font-size: 1.5rem;
}

.mobile-uploaded-files {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.mobile-file-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 1rem;
  background: var(--blue-pale);
  border-radius: 8px;
  border: 1px solid var(--blue-mid);
}

.mobile-file-name {
  font-size: 0.85rem;
  color: var(--dark);
  font-weight: 500;
  flex: 1;
  overflow: hidden;
  text-overflow: ellipsis;
  white-space: nowrap;
}

.mobile-remove-btn {
  background: var(--red);
  color: white;
  border: none;
  border-radius: 50%;
  width: 24px;
  height: 24px;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 0.9rem;
  flex-shrink: 0;
}

.mobile-checkbox-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.mobile-checkbox-label {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  cursor: pointer;
  font-size: 0.85rem;
  line-height: 1.4;
}

.mobile-checkbox-input {
  width: auto;
  margin: 0;
  margin-top: 0.1rem;
}

.mobile-checkbox-text {
  color: var(--text);
  flex: 1;
}

.mobile-actions {
  display: flex;
  gap: 1.25rem;
  margin-top: auto;
  padding: 2rem;
  border-top: 3px solid #e2e8f0;
  background: linear-gradient(135deg, #f8fafc, #e2e8f0);
  border-radius: 16px;
  position: sticky;
  bottom: 0;
  box-shadow: 0 -8px 32px rgba(0, 0, 0, 0.15);
  backdrop-filter: blur(10px);
}

.mobile-btn {
  flex: 1;
  padding: 1.75rem;
  border: none;
  border-radius: 16px;
  font-weight: 800;
  font-size: 1.3rem;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
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

/* Animations */
@keyframes slideInRight {
  0% { transform: translateX(100%); opacity: 0; }
  100% { transform: translateX(0); opacity: 1; }
}

/* Responsive */
@media (max-width: 768px) {
  .desktop-container {
    display: none;
  }
  
  .mobile-modal {
    display: block;
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
