<template>
  <div class="recapitulatif-page">
    <!-- HERO SECTION -->
    <section class="hero-section">
      <div class="hero-bg-grid"></div>
      <div class="hero-blob blob-1"></div>
      <div class="hero-blob blob-2"></div>

      <div class="hero-content">
        <div class="hero-badge">
          <span class="badge-pulse"></span>
          Récapitulatif
        </div>
        <h1 class="hero-title">
          <span class="ht-line">Vérifiez vos</span>
          <span class="ht-line blue">informations</span>
        </h1>
        <p class="hero-tagline">
          "Confirmez votre demande avant validation finale"
        </p>
        <p class="hero-desc">
          🇨🇲 AXE CAPITAL · Service client premium<br>
          <span>Votre sécurité est notre priorité</span>
        </p>
        <div class="hero-btns">
          <button @click="scrollToContent" class="hbtn hbtn-outline">
            Voir les détails
            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 5v14M5 12l7 7 7-7"/></svg>
          </button>
        </div>
      </div>
      
      <div class="hero-scroll">
        <span>Défiler</span>
        <div class="scroll-bar"></div>
      </div>
    </section>

    <!-- CONTENT SECTION -->
    <section id="content" class="content-section">
      <div class="content-header">
        <span class="eyebrow">RÉCAPITULATIF DE COMPTE</span>
        <h2 class="content-title">Résumé de votre demande</h2>
        <p class="content-sub">Vérifiez attentivement toutes les informations avant de valider</p>
      </div>

      <!-- Status Card -->
      <div class="status-card">
        <div class="status-header">
          <div class="status-icon">
            <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10"/>
              <polyline points="12 6 12 12 16 14"/>
            </svg>
          </div>
          <div class="status-info">
            <h3 class="status-title">Statut de votre demande</h3>
            <p class="status-sub">En attente de validation</p>
          </div>
        </div>
        <div class="status-badge">
          <span class="badge-text">EN ATTENTE</span>
        </div>
      </div>

      <!-- Information Cards -->
      <div class="info-cards-grid">
        <!-- Personal Information -->
        <div class="info-card">
          <div class="info-card-header">
            <div class="info-card-icon">
              <span>👤</span>
            </div>
            <h3 class="info-card-title">Informations Personnelles</h3>
          </div>
          <div class="info-card-content">
            <div class="info-row">
              <span class="info-label">Nom complet</span>
              <span class="info-value">{{ clientData.nom }} {{ clientData.prenom }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Date de naissance</span>
              <span class="info-value">{{ formatDate(clientData.date_naissance) }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Lieu de naissance</span>
              <span class="info-value">{{ clientData.lieu_naissance }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Sexe</span>
              <span class="info-value">{{ clientData.sexe === 'M' ? 'Masculin' : 'Féminin' }}</span>
            </div>
          </div>
        </div>

        <!-- Contact Information -->
        <div class="info-card">
          <div class="info-card-header">
            <div class="info-card-icon">
              <span>📞</span>
            </div>
            <h3 class="info-card-title">Coordonnées</h3>
          </div>
          <div class="info-card-content">
            <div class="info-row">
              <span class="info-label">Téléphone</span>
              <span class="info-value">{{ clientData.telephone }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Pays</span>
              <span class="info-value">{{ clientData.pays }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Ville</span>
              <span class="info-value">{{ clientData.ville }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Quartier</span>
              <span class="info-value">{{ clientData.quartier }}</span>
            </div>
            <div v-if="clientData.lieu_dit" class="info-row">
              <span class="info-label">Lieu dit</span>
              <span class="info-value">{{ clientData.lieu_dit }}</span>
            </div>
          </div>
        </div>

        <!-- Document Information -->
        <div class="info-card">
          <div class="info-card-header">
            <div class="info-card-icon">
              <span>📄</span>
            </div>
            <h3 class="info-card-title">Carte d'Identité</h3>
          </div>
          <div class="info-card-content">
            <div class="info-row">
              <span class="info-label">Numéro CNI</span>
              <span class="info-value">{{ clientData.numero_cni }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Photos CNI</span>
              <span class="info-value">{{ clientData.photos_cni?.length || 0 }} photo(s) téléchargée(s)</span>
            </div>
          </div>
        </div>

        <!-- Emergency Contact -->
        <div class="info-card">
          <div class="info-card-header">
            <div class="info-card-icon">
              <span>🆘</span>
            </div>
            <h3 class="info-card-title">Contact d'Urgence</h3>
          </div>
          <div class="info-card-content">
            <div class="info-row">
              <span class="info-label">Nom du contact</span>
              <span class="info-value">{{ clientData.contact_urgence_nom }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Téléphone d'urgence</span>
              <span class="info-value">{{ clientData.telephone_urgence }}</span>
            </div>
          </div>
        </div>

        <!-- Signature Information -->
        <div class="info-card">
          <div class="info-card-header">
            <div class="info-card-icon">
              <span>✍️</span>
            </div>
            <h3 class="info-card-title">Signature</h3>
          </div>
          <div class="info-card-content">
            <div class="info-row">
              <span class="info-label">Fait le</span>
              <span class="info-value">{{ formatDate(clientData.fait_le) }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Fait à</span>
              <span class="info-value">{{ clientData.fait_a }}</span>
            </div>
            <div class="info-row">
              <span class="info-label">Confirmation</span>
              <span class="info-value confirmation-status">
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M20 6L9 17l-5-5"/>
                </svg>
                Confirmé
              </span>
            </div>
          </div>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons">
        <button @click="goBack" class="btn btn-secondary">
          ← Retour à la création
        </button>
        <button @click="goToHome" class="btn btn-outline">
          ← Retour à l'accueil
        </button>
        <button @click="validateAccount" :disabled="loading" class="btn btn-primary">
          <span v-if="loading" class="btn-loading">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 12a9 9 0 1 1-6.219-8.56"/>
            </svg>
            Validation en cours...
          </span>
          <span v-else>
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M9 12l2 2 4-4"/>
              <path d="M21 12c-1 0-3-1-3-3s2-3 3-3 3 1 3 3-2 3-3 3"/>
              <path d="M3 12c1 0 3-1 3-3s-2-3-3-3-3 1-3 3 2 3 3 3"/>
            </svg>
            Valider mon compte
          </span>
        </button>
      </div>
    </section>

    <!-- FOOTER -->
    <footer class="recapitulatif-footer">
      <div class="footer-content">
        <div class="footer-brand">
          <h3 class="footer-title">AXE CAPITAL</h3>
          <p class="footer-sub">Votre partenaire financier de confiance</p>
        </div>
        <div class="footer-links">
          <router-link to="/" class="footer-link">← Retour à l'accueil</router-link>
          <router-link to="/compte" class="footer-link">← Retour à la gestion</router-link>
          <router-link to="/compte/creation" class="footer-link">← Retour à la création</router-link>
        </div>
      </div>
    </footer>
  </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabase'

const router = useRouter()
const loading = ref(false)
const clientData = ref({})

// Navigation
const scrollToContent = () => {
  const contentSection = document.querySelector('#content')
  if (contentSection) {
    contentSection.scrollIntoView({ behavior: 'smooth' })
  }
}

const goBack = () => {
  router.push('/compte/creation')
}

const goToHome = () => {
  router.push('/')
}

const validateAccount = async () => {
  loading.value = true
  
  try {
    // Mettre à jour le statut du client
    const { error } = await supabase
      .from('clients')
      .update({ statut: 'approuve' })
      .eq('id', clientData.value.id)
    
    if (error) {
      throw new Error('Erreur lors de la validation du compte')
    }
    
    // Rediriger vers la page de confirmation
    setTimeout(() => {
      router.push('/compte/confirmation')
    }, 1500)
    
  } catch (error) {
    console.error('Erreur complète:', error)
    alert(error.message || 'Une erreur est survenue')
  } finally {
    loading.value = false
  }
}

// Formater la date
const formatDate = (dateString) => {
  if (!dateString) return 'Non spécifié'
  const date = new Date(dateString)
  return date.toLocaleDateString('fr-FR', {
    day: 'numeric',
    month: 'long',
    year: 'numeric'
  })
}

// Charger les données du client
onMounted(async () => {
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
        throw new Error('Erreur lors du chargement des données')
      }
      
      console.log('Données fraîches récupérées depuis Supabase (local):', data)
      clientData.value = data
    } else {
      // Fallback : récupérer le dernier client enregistré (ancien comportement)
      console.warn('Aucun client connecté trouvé dans sessionStorage, utilisation du fallback')
      const { data, error } = await supabase
        .from('clients')
        .select('*')
        .order('created_at', { ascending: false })
        .limit(1)
        .single()
      
      if (error) {
        throw new Error('Erreur lors du chargement des données')
      }
      
      clientData.value = data
    }
    
  } catch (error) {
    console.error('Erreur:', error)
    // Rediriger vers la création si aucune donnée trouvée
    router.push('/compte/creation')
  }
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
  --green: #059669;
  --green-lt: #10b981;
  --red: #dc2626;
  --orange: #f97316;
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
  background: var(--orange);
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
  background: var(--orange);
  border-radius: 50%;
  animation: pulse 2s infinite;
}

@keyframes pulse {
  0% { box-shadow: 0 0 0 0 rgba(249, 115, 22, 0.7); }
  70% { box-shadow: 0 0 0 10px rgba(249, 115, 22, 0); }
  100% { box-shadow: 0 0 0 0 rgba(249, 115, 22, 0); }
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

/* Content Section */
.content-section {
  padding: 6rem 2rem 4rem;
  max-width: 1200px;
  margin: 0 auto;
}

.content-header {
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

.content-title {
  font-family: 'Syne', sans-serif;
  font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 700;
  color: white;
  margin-bottom: 1rem;
  line-height: 1.2;
}

.content-sub {
  font-size: 1.1rem;
  color: var(--muted);
  max-width: 600px;
  margin: 0 auto;
}

/* Status Card */
.status-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 2rem;
  margin-bottom: 3rem;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 2rem;
}

.status-header {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.status-icon {
  width: 60px;
  height: 60px;
  background: rgba(249, 115, 22, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: var(--orange);
}

.status-info h3 {
  font-family: 'Syne', sans-serif;
  font-size: 1.3rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.25rem;
}

.status-sub {
  color: var(--muted);
  font-size: 0.9rem;
}

.status-badge {
  background: rgba(249, 115, 22, 0.2);
  border: 1px solid rgba(249, 115, 22, 0.3);
  border-radius: 50px;
  padding: 0.75rem 1.5rem;
}

.badge-text {
  color: var(--orange);
  font-weight: 700;
  font-size: 0.85rem;
  letter-spacing: 0.05em;
}

/* Info Cards Grid */
.info-cards-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
  gap: 2rem;
  margin-bottom: 3rem;
}

.info-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 2rem;
  transition: all 0.3s ease;
}

.info-card:hover {
  background: rgba(255, 255, 255, 0.08);
  transform: translateY(-2px);
}

.info-card-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.info-card-icon {
  width: 48px;
  height: 48px;
  background: rgba(59, 130, 246, 0.2);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.5rem;
}

.info-card-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.2rem;
  font-weight: 700;
  color: white;
}

.info-card-content {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.info-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0.75rem 0;
  border-bottom: 1px solid rgba(255, 255, 255, 0.05);
}

.info-row:last-child {
  border-bottom: none;
}

.info-label {
  color: var(--muted);
  font-size: 0.9rem;
  font-weight: 500;
}

.info-value {
  color: white;
  font-weight: 600;
  font-size: 0.95rem;
  text-align: right;
  max-width: 60%;
}

.confirmation-status {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  color: var(--green);
}

/* Action Buttons */
.action-buttons {
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
  background: linear-gradient(135deg, var(--green), var(--green-lt));
  color: white;
  box-shadow: 0 8px 24px rgba(5, 150, 105, 0.3);
}

.btn-primary:hover:not(:disabled) {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(5, 150, 105, 0.4);
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
.recapitulatif-footer {
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
  color: white;
  margin-bottom: 0.5rem;
}

.footer-sub {
  color: var(--muted);
  font-size: 0.9rem;
}

.footer-links {
  display: flex;
  gap: 2rem;
  flex-wrap: wrap;
}

.footer-link {
  color: var(--muted);
  text-decoration: none;
  font-weight: 500;
  transition: color 0.3s ease;
}

.footer-link:hover {
  color: var(--blue-lt);
}

/* Responsive */
@media (max-width: 768px) {
  .hero-section {
    padding: 1rem;
  }
  
  .hero-title {
    font-size: clamp(2rem, 10vw, 3rem);
  }
  
  .content-section {
    padding: 4rem 1rem 2rem;
  }
  
  .status-card {
    flex-direction: column;
    text-align: center;
  }
  
  .info-cards-grid {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .info-row {
    flex-direction: column;
    align-items: flex-start;
    gap: 0.5rem;
  }
  
  .info-value {
    text-align: left;
    max-width: 100%;
  }
  
  .action-buttons {
    flex-direction: column;
  }
  
  .btn {
    width: 100%;
  }
  
  .footer-content {
    flex-direction: column;
    text-align: center;
  }
  
  .footer-brand {
    text-align: center;
  }
  
  .footer-links {
    flex-direction: column;
    gap: 1rem;
  }
}
</style>
