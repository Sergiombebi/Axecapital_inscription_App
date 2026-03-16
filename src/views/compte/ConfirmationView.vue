<template>
  <div class="confirmation-page">
    <!-- HERO SECTION -->
    <section class="hero-section">
      <div class="hero-bg-grid"></div>
      <div class="hero-blob blob-1"></div>
      <div class="hero-blob blob-2"></div>

      <div class="hero-content">
        <div class="hero-badge">
          <span class="badge-pulse"></span>
          Confirmation
        </div>
        <h1 class="hero-title">
          <span class="ht-line">Compte</span>
          <span class="ht-line blue">validé</span>
        </h1>
        <p class="hero-tagline">
          "Félicitations ! Votre compte AXE CAPITAL est maintenant actif"
        </p>
        <p class="hero-desc">
          🇨🇲 Bienvenue dans la famille AXE CAPITAL<br>
          <span>Prêt à commencer votre voyage financier</span>
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
        <span class="eyebrow">COMPTE ACTIVÉ</span>
        <h2 class="content-title">Votre compte est prêt</h2>
        <p class="content-sub">Toutes nos félicitations pour votre nouvelle aventure financière</p>
      </div>

      <!-- Success Card -->
      <div class="success-card">
        <div class="success-animation">
          <div class="success-circle">
            <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"/>
              <polyline points="22 4 12 14.01 9 11.01"/>
            </svg>
          </div>
        </div>
        <div class="success-content">
          <h3 class="success-title">Compte créé avec succès !</h3>
          <p class="success-sub">
            Votre demande a été approuvée et votre compte est maintenant entièrement fonctionnel.
            Vous pouvez accéder à tous nos services financiers.
          </p>
        </div>
      </div>

      <!-- Account Information -->
      <div class="account-info">
        <h3 class="section-title">Informations de votre compte</h3>
        <div class="info-grid">
          <div class="info-item">
            <div class="info-icon">
              <span>👤</span>
            </div>
            <div class="info-details">
              <h4 class="info-title">Client</h4>
              <p class="info-value">{{ clientData.nom }} {{ clientData.prenom }}</p>
            </div>
          </div>
          
          <div class="info-item">
            <div class="info-icon">
              <span>📞</span>
            </div>
            <div class="info-details">
              <h4 class="info-title">Téléphone</h4>
              <p class="info-value">{{ clientData.telephone }}</p>
            </div>
          </div>
          
          <div class="info-item">
            <div class="info-icon">
              <span>📍</span>
            </div>
            <div class="info-details">
              <h4 class="info-title">Localisation</h4>
              <p class="info-value">{{ clientData.ville }}, {{ clientData.pays }}</p>
            </div>
          </div>
          
          <div class="info-item">
            <div class="info-icon">
              <span>📅</span>
            </div>
            <div class="info-details">
              <h4 class="info-title">Date de création</h4>
              <p class="info-value">{{ formatDate(clientData.created_at) }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Next Steps -->
      <div class="next-steps">
        <h3 class="section-title">Prochaines étapes</h3>
        <div class="steps-grid">
          <div class="step-item">
            <div class="step-number">1</div>
            <div class="step-content">
              <h4 class="step-title">Connectez-vous</h4>
              <p class="step-desc">Utilisez votre numéro de téléphone pour accéder à votre espace client</p>
            </div>
          </div>
          
          <div class="step-item">
            <div class="step-number">2</div>
            <div class="step-content">
              <h4 class="step-title">Explorez nos services</h4>
              <p class="step-desc">Découvrez nos solutions d'épargne, de crédit et d'investissement</p>
            </div>
          </div>
          
          <div class="step-item">
            <div class="step-number">3</div>
            <div class="step-content">
              <h4 class="step-title">Contactez-nous</h4>
              <p class="step-desc">Notre équipe est disponible pour vous accompagner dans vos projets</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Services Preview -->
      <div class="services-preview">
        <h3 class="section-title">Nos services disponibles</h3>
        <div class="services-grid">
          <div class="service-card">
            <div class="service-icon">💰</div>
            <h4 class="service-title">Épargne</h4>
            <p class="service-desc">Des solutions d'épargne adaptées à vos objectifs</p>
          </div>
          
          <div class="service-card">
            <div class="service-icon">💳</div>
            <h4 class="service-title">Crédit</h4>
            <p class="service-desc">Des prêts personnalisés pour vos projets</p>
          </div>
          
          <div class="service-card">
            <div class="service-icon">🏗️</div>
            <h4 class="service-title">Projets</h4>
            <p class="service-desc">Accompagnement dans vos investissements</p>
          </div>
          
          
        </div>
      </div>

      <!-- Contact Support -->
      <div class="contact-support">
        <div class="support-content">
          <div class="support-icon">
            <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"/>
            </svg>
          </div>
          <div class="support-info">
            <h3 class="support-title">Besoin d'aide ?</h3>
            <p class="support-desc">
              Notre service client est à votre disposition pour répondre à toutes vos questions.
              N'hésitez pas à nous contacter !
            </p>
            <div class="support-actions">
              <button class="support-btn">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
                +237 XXX XXX XXX
              </button>
              <button class="support-btn">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                  <polyline points="22,6 12,13 2,6"/>
                </svg>
                contact@axecapital.cm
              </button>
            </div>
          </div>
        </div>
      </div>

      <!-- Action Buttons -->
      <div class="action-buttons">
        
        <button @click="goToHome" class="btn btn-outline">
          ← Retour à l'accueil
        </button>
      </div>
    </section>

    <!-- FOOTER -->
    <footer class="confirmation-footer">
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
const clientData = ref({})

// Navigation
const scrollToContent = () => {
  const contentSection = document.querySelector('#content')
  if (contentSection) {
    contentSection.scrollIntoView({ behavior: 'smooth' })
  }
}

const goToAccount = () => {
  router.push('/compte')
}

const goToHome = () => {
  router.push('/')
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
    // Récupérer le dernier client approuvé (pour la démo)
    const { data, error } = await supabase
      .from('clients')
      .select('*')
      .eq('statut', 'approuve')
      .order('created_at', { ascending: false })
      .limit(1)
      .single()
    
    if (error) {
      throw new Error('Erreur lors du chargement des données')
    }
    
    clientData.value = data
    
  } catch (error) {
    console.error('Erreur:', error)
    // Rediriger vers la création si aucune donnée trouvée
    router.push('/compte/creation')
  }
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&display=swap');

.confirmation-page {
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
  --purple: #8b5cf6;
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
    linear-gradient(rgba(139, 92, 246, 0.03) 1px, transparent 1px),
    linear-gradient(90deg, rgba(139, 92, 246, 0.03) 1px, transparent 1px);
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
  background: var(--green);
  top: 10%;
  left: 10%;
  animation-delay: 0s;
}

.blob-2 {
  width: 300px;
  height: 300px;
  background: var(--purple);
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
  background: rgba(139, 92, 246, 0.1);
  border: 1px solid rgba(139, 92, 246, 0.2);
  border-radius: 50px;
  padding: 0.5rem 1rem;
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--purple);
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
  background: linear-gradient(135deg, #10b981 0%, #34d399 50%, #10b981 100%);
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
  color: var(--purple);
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

/* Success Card */
.success-card {
  background: rgba(16, 185, 129, 0.1);
  border: 1px solid rgba(16, 185, 129, 0.2);
  border-radius: 24px;
  padding: 3rem;
  margin-bottom: 4rem;
  display: flex;
  align-items: center;
  gap: 3rem;
  flex-wrap: wrap;
}

.success-animation {
  flex-shrink: 0;
}

.success-circle {
  width: 100px;
  height: 100px;
  background: var(--green);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  animation: successPulse 2s ease-in-out;
}

@keyframes successPulse {
  0% { transform: scale(0); opacity: 0; }
  50% { transform: scale(1.1); }
  100% { transform: scale(1); opacity: 1; }
}

.success-content {
  flex: 1;
}

.success-title {
  font-family: 'Syne', sans-serif;
  font-size: 2rem;
  font-weight: 700;
  color: var(--green);
  margin-bottom: 1rem;
}

.success-sub {
  color: var(--muted);
  font-size: 1.1rem;
  line-height: 1.6;
}

/* Account Information */
.account-info {
  margin-bottom: 4rem;
}

.section-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.8rem;
  font-weight: 700;
  color: white;
  margin-bottom: 2rem;
  text-align: center;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.info-item {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 2rem;
  display: flex;
  align-items: center;
  gap: 1.5rem;
  transition: all 0.3s ease;
}

.info-item:hover {
  background: rgba(255, 255, 255, 0.08);
  transform: translateY(-2px);
}

.info-icon {
  width: 60px;
  height: 60px;
  background: rgba(139, 92, 246, 0.2);
  border-radius: 12px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.8rem;
  flex-shrink: 0;
}

.info-details {
  flex: 1;
}

.info-title {
  font-size: 0.9rem;
  color: var(--muted);
  margin-bottom: 0.25rem;
  font-weight: 500;
}

.info-value {
  color: white;
  font-weight: 600;
  font-size: 1.1rem;
}

/* Next Steps */
.next-steps {
  margin-bottom: 4rem;
}

.steps-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

.step-item {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 2rem;
  display: flex;
  gap: 1.5rem;
  transition: all 0.3s ease;
}

.step-item:hover {
  background: rgba(255, 255, 255, 0.08);
  transform: translateY(-2px);
}

.step-number {
  width: 40px;
  height: 40px;
  background: var(--purple);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  font-weight: 700;
  font-size: 1.2rem;
  flex-shrink: 0;
}

.step-content {
  flex: 1;
}

.step-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.2rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.5rem;
}

.step-desc {
  color: var(--muted);
  font-size: 0.95rem;
  line-height: 1.5;
}

/* Services Preview */
.services-preview {
  margin-bottom: 4rem;
}

.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 2rem;
}

.service-card {
  background: rgba(255, 255, 255, 0.05);
  border: 1px solid rgba(255, 255, 255, 0.1);
  border-radius: 16px;
  padding: 2rem;
  text-align: center;
  transition: all 0.3s ease;
}

.service-card:hover {
  background: rgba(255, 255, 255, 0.08);
  transform: translateY(-2px);
}

.service-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.service-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.2rem;
  font-weight: 700;
  color: white;
  margin-bottom: 0.5rem;
}

.service-desc {
  color: var(--muted);
  font-size: 0.95rem;
  line-height: 1.5;
}

/* Contact Support */
.contact-support {
  background: rgba(139, 92, 246, 0.1);
  border: 1px solid rgba(139, 92, 246, 0.2);
  border-radius: 20px;
  padding: 3rem;
  margin-bottom: 4rem;
}

.support-content {
  display: flex;
  align-items: center;
  gap: 3rem;
  flex-wrap: wrap;
}

.support-icon {
  width: 80px;
  height: 80px;
  background: var(--purple);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  color: white;
  flex-shrink: 0;
}

.support-info {
  flex: 1;
}

.support-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.5rem;
  font-weight: 700;
  color: white;
  margin-bottom: 1rem;
}

.support-desc {
  color: var(--muted);
  font-size: 1rem;
  line-height: 1.6;
  margin-bottom: 2rem;
}

.support-actions {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.support-btn {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  padding: 1rem 1.5rem;
  background: rgba(255, 255, 255, 0.1);
  border: 1px solid rgba(255, 255, 255, 0.2);
  border-radius: 12px;
  color: white;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.support-btn:hover {
  background: rgba(255, 255, 255, 0.15);
  transform: translateY(-2px);
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

.btn-primary:hover {
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(5, 150, 105, 0.4);
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

/* Footer */
.confirmation-footer {
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
  color: var(--purple);
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
