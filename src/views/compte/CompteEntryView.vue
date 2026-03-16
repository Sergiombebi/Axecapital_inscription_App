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
          Gestion de Compte
        </div>
        <h1 class="hero-title">
          <span class="ht-line">Bienvenue</span>
          <span class="ht-line blue">sur AXE CAPITAL</span>
        </h1>
        <p class="hero-tagline">
          "Accédez à votre espace ou créez votre compte en quelques clics"
        </p>
        <p class="hero-desc">
          🇨🇲 Votre partenaire financier de confiance au Cameroun<br>
          <span>Épargne · Crédit · Projets · Import/Export</span>
        </p>
        <div class="hero-btns">
          <button @click="scrollToChoice" class="hbtn hbtn-outline">
            Gérer mon compte
            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 5v14M5 12l7 7 7-7"/></svg>
          </button>
        </div>
      </div>
      
      <div class="hero-scroll">
        <span>Défiler</span>
        <div class="scroll-bar"></div>
      </div>
    </section>

    <!-- CHOICE SECTION -->
    <section id="choice" class="choice-section">
      <div class="choice-header">
        <span class="eyebrow">QUE SOUHAITEZ-VOUS FAIRE ?</span>
        <h2 class="choice-title">Choisissez une option</h2>
        <p class="choice-sub">Sélectionnez l'action qui correspond à votre besoin</p>
      </div>

      <div class="choice-cards">
        <div class="choice-card" @click="goToLogin">
          <div class="choice-icon">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/>
              <circle cx="12" cy="7" r="4"/>
            </svg>
          </div>
          <div class="choice-content">
            <h3 class="choice-name">J'ai déjà un compte</h3>
            <p class="choice-desc">Accéder à mon espace avec mon numéro de téléphone</p>
            <div class="choice-features">
              <span class="feature-tag">Accès rapide</span>
              <span class="feature-tag">Sécurisé</span>
            </div>
          </div>
          <div class="choice-arrow">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M9 18l6-6-6-6"/>
            </svg>
          </div>
        </div>
        
        <div class="choice-card" @click="goToRegister">
          <div class="choice-icon">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
              <circle cx="8.5" cy="7" r="4"/>
              <line x1="20" y1="8" x2="20" y2="14"/>
              <line x1="23" y1="11" x2="17" y2="11"/>
            </svg>
          </div>
          <div class="choice-content">
            <h3 class="choice-name">Pas encore de compte</h3>
            <p class="choice-desc">Créer un nouveau compte dès maintenant</p>
            <div class="choice-features">
              <span class="feature-tag">GRATUIT</span>
              <span class="feature-tag">Rapide</span>
            </div>
          </div>
          <div class="choice-arrow">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M9 18l6-6-6-6"/>
            </svg>
          </div>
        </div>
      </div>

      <!-- LOGIN FORM -->
      <div v-if="showLogin" class="login-form-section">
        <div class="login-header">
          <h3 class="login-title">Connexion à mon espace</h3>
          <p class="login-subtitle">Entrez votre numéro de téléphone pour accéder à votre compte</p>
        </div>
        
        <div class="login-form">
          <div class="form-group">
            <label>Numéro de téléphone</label>
            <div class="input-wrapper">
              <input 
                v-model="loginPhone" 
                type="tel" 
                class="form-input"
                placeholder="+237 XXX XXX XXX"
                @keyup.enter="handleLogin"
              />
              <div class="input-icon">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 1 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 1 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
              </div>
            </div>
          </div>
          
          <div class="login-actions">
            <button @click="goBack" class="btn btn-secondary">
              ← Retour
            </button>
            <button @click="handleLogin" :disabled="loading" class="btn btn-primary">
              <span v-if="loading" class="btn-loading">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M21 12a9 9 0 1 1-6.219-8.56"/>
                </svg>
                Connexion...
              </span>
              <span v-else>
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M15 3h4a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2h-4"/>
                  <polyline points="10 17 15 12 10 7"/>
                </svg>
                Accéder à mon espace
              </span>
            </button>
          </div>
          
          <!-- Message d'erreur -->
          <div v-if="loginError" class="error-message">
            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <circle cx="12" cy="12" r="10"/>
              <line x1="12" y1="8" x2="12" y2="12"/>
              <line x1="12" y1="16" x2="12.01" y2="16"/>
            </svg>
            {{ loginError }}
          </div>
        </div>
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
const showLogin = ref(false)
const loginPhone = ref('')
const loginError = ref('')

// Navigation
const scrollToChoice = () => {
  const choiceSection = document.querySelector('#choice')
  if (choiceSection) {
    choiceSection.scrollIntoView({ behavior: 'smooth' })
  }
}

const goToLogin = () => {
  showLogin.value = true
  loginError.value = ''
  loginPhone.value = ''
  // Scroll vers le formulaire
  setTimeout(() => {
    const loginSection = document.querySelector('.login-form-section')
    if (loginSection) {
      loginSection.scrollIntoView({ behavior: 'smooth' })
    }
  }, 100)
}

const goToRegister = () => {
  router.push('/compte/creation')
}

const goBack = () => {
  showLogin.value = false
  loginError.value = ''
  loginPhone.value = ''
}

// Gestion de la connexion
const handleLogin = async () => {
  if (!loginPhone.value.trim()) {
    loginError.value = 'Veuillez entrer votre numéro de téléphone'
    return
  }
  
  loading.value = true
  loginError.value = ''
  
  try {
    // Chercher le compte par numéro de téléphone
    const { data, error } = await supabase
      .from('clients')
      .select('*')
      .eq('telephone', loginPhone.value.trim())
      .single()
    
    if (error && error.code !== 'PGRST116') {
      throw error
    }
    
    if (data) {
      // Compte trouvé
      console.log('Compte trouvé:', data)
      
      if (data.statut === 'approuve') {
        // Compte approuvé, rediriger vers confirmation
        showSuccess('Connexion réussie ! Redirection...')
        setTimeout(() => {
          router.push('/compte/confirmation')
        }, 1500)
      } else {
        // Compte en attente, rediriger vers récapitulatif
        showInfo('Compte en attente de validation')
        setTimeout(() => {
          router.push('/compte/recapitulatif')
        }, 1500)
      }
    } else {
      // Aucun compte trouvé
      loginError.value = 'Ce numéro n\'est associé à aucun compte'
    }
  } catch (error) {
    console.error('Erreur connexion:', error)
    loginError.value = 'Erreur lors de la connexion. Veuillez réessayer.'
  } finally {
    loading.value = false
  }
}

// Notifications
const showSuccess = (message) => {
  // Implémentation simple de notification
  console.log(`[SUCCESS] ${message}`)
}

const showInfo = (message) => {
  // Implémentation simple de notification
  console.log(`[INFO] ${message}`)
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
  --dark: #1e40af;
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

/* Choice Section */
.choice-section {
  padding: 6rem 2rem 4rem;
  max-width: 1200px;
  margin: 0 auto;
}

.choice-header {
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

.choice-title {
  font-family: 'Syne', sans-serif;
  font-size: clamp(2rem, 5vw, 3rem);
  font-weight: 700;
  color: white;
  margin-bottom: 1rem;
  line-height: 1.2;
}

.choice-sub {
  font-size: 1.1rem;
  color: var(--muted);
  max-width: 600px;
  margin: 0 auto;
}

.choice-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(400px, 1fr));
  gap: 2rem;
  margin-bottom: 4rem;
}

.choice-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 2.5rem;
  cursor: pointer;
  transition: all 0.4s ease;
  position: relative;
  overflow: hidden;
}

.choice-card::before {
  content: '';
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: linear-gradient(135deg, rgba(59, 130, 246, 0.1), rgba(5, 150, 105, 0.1));
  opacity: 0;
  transition: opacity 0.4s ease;
  border-radius: 20px;
}

.choice-card:hover {
  transform: translateY(-8px);
  border-color: rgba(59, 130, 246, 0.3);
  background: rgba(255, 255, 255, 0.08);
}

.choice-card:hover::before {
  opacity: 1;
}

.choice-icon {
  width: 60px;
  height: 60px;
  background: linear-gradient(135deg, var(--blue), var(--blue-lt));
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1.5rem;
  color: white;
}

.choice-content {
  margin-bottom: 1.5rem;
}

.choice-name {
  font-family: 'Syne', sans-serif;
  font-size: 1.5rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.75rem;
}

.choice-desc {
  color: var(--muted);
  font-size: 1rem;
  line-height: 1.6;
  margin-bottom: 1.5rem;
}

.choice-features {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.feature-tag {
  background: rgba(59, 130, 246, 0.2);
  color: var(--blue-lt);
  padding: 0.25rem 0.75rem;
  border-radius: 20px;
  font-size: 0.8rem;
  font-weight: 600;
}

.choice-arrow {
  position: absolute;
  right: 2rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--blue);
  transition: transform 0.3s ease;
}

.choice-card:hover .choice-arrow {
  transform: translateY(-50%) translateX(4px);
}

/* Login Form Section */
.login-form-section {
  background: rgba(255, 255, 255, 0.03);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 20px;
  padding: 3rem;
  max-width: 600px;
  margin: 0 auto 4rem;
}

.login-header {
  text-align: center;
  margin-bottom: 2rem;
}

.login-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.8rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.5rem;
}

.login-subtitle {
  color: var(--muted);
  font-size: 1rem;
}

.login-form {
  max-width: 400px;
  margin: 0 auto;
}

.form-group {
  margin-bottom: 2rem;
}

.form-group label {
  display: block;
  font-weight: 600;
  color: white;
  font-size: 0.9rem;
  margin-bottom: 0.75rem;
}

.input-wrapper {
  position: relative;
}

.form-input {
  width: 100%;
  padding: 1rem 1rem 1rem 3rem;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  font-size: 1rem;
  background: white;
  color: #1e40af;
  transition: all 0.3s ease;
}

.form-input::placeholder {
  color: #94a3b8;
}

.form-input:focus {
  outline: none;
  border-color: var(--blue);
  box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.1);
  background: white;
}

.input-icon {
  position: absolute;
  left: 1rem;
  top: 50%;
  transform: translateY(-50%);
  color: var(--muted);
}

.login-actions {
  display: flex;
  gap: 1rem;
  margin-bottom: 1.5rem;
}

.btn {
  flex: 1;
  padding: 1rem 1.5rem;
  border: none;
  border-radius: 12px;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  display: flex;
  align-items: center;
  justify-content: center;
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

.error-message {
  background: rgba(220, 38, 38, 0.1);
  border: 1px solid rgba(220, 38, 38, 0.3);
  border-radius: 12px;
  padding: 1rem;
  color: #fca5a5;
  font-size: 0.9rem;
  display: flex;
  align-items: center;
  gap: 0.75rem;
  margin-top: 1rem;
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
  
  .choice-section {
    padding: 4rem 1rem 2rem;
  }
  
  .choice-cards {
    grid-template-columns: 1fr;
    gap: 1.5rem;
  }
  
  .choice-card {
    padding: 2rem;
  }
  
  .login-form-section {
    padding: 2rem 1.5rem;
    margin: 0 auto 2rem;
  }
  
  .footer-content {
    flex-direction: column;
    text-align: center;
  }
  
  .footer-brand {
    text-align: center;
  }
}
</style>
