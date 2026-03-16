<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

// Données des statistiques
const stats = ref({
  clients: 0,
  projets: 0,
  satisfaction: 0
})

// Valeurs cibles
const targetStats = {
  clients: 50000,
  projets: 10000,
  satisfaction: 98
}

// Animation du compteur
const animateCounter = (target, duration, key) => {
  const start = 0
  const increment = target / (duration / 16) // 60fps
  let current = start
  
  const timer = setInterval(() => {
    current += increment
    if (current >= target) {
      current = target
      clearInterval(timer)
    }
    
    if (key === 'satisfaction') {
      stats.value[key] = Math.floor(current)
    } else {
      stats.value[key] = Math.floor(current)
    }
  }, 16)
}

// Démarrer les animations quand le composant est monté
onMounted(() => {
  // Démarrer l'animation après un petit délai pour l'effet visuel
  setTimeout(() => {
    animateCounter(targetStats.clients, 2000, 'clients')
    animateCounter(targetStats.projets, 1800, 'projets')
    animateCounter(targetStats.satisfaction, 1500, 'satisfaction')
  }, 500)
})

const scrollToServices = () => {
  const servicesSection = document.querySelector('.services-section')
  if (servicesSection) {
    servicesSection.scrollIntoView({ behavior: 'smooth' })
  }
}

const openAdminLogin = () => {
  router.push('/partenaire')
}

const navigateToCompte = () => {
  router.push('/compte')
}

const navigateToGestionnaire = () => {
  router.push('/gestionnaire')
}

// Formater les grands nombres (ex: 50000 -> 50K)
const formatNumber = (num) => {
  if (num >= 1000) {
    return (num / 1000).toFixed(0) + 'K'
  }
  return num.toString()
}
</script>

<template>
  <div class="accueil">
    <!-- HERO SECTION -->
    <section class="hero-section">
      <div class="hero-bg-grid"></div>
      <div class="hero-blob blob-1"></div>
      <div class="hero-blob blob-2"></div>

      <div class="hero-content">
        <div class="hero-badge">
          <span class="badge-pulse"></span>
          N°1 au Cameroun
        </div>
        <h1 class="hero-title">
          <span class="ht-line">AXE</span>
          <span class="ht-line blue">CAPITAL</span>
        </h1>
        <p class="hero-tagline">
          "Les petites tontines pour de grandes ambitions"
        </p>
        <div class="hero-stats">
          <div class="stat-box">
            <span class="stat-num">{{ formatNumber(stats.clients) }}<sup>+</sup></span>
            <span class="stat-lbl">Clients actifs</span>
          </div>
          <div class="stat-sep"></div>
          <div class="stat-box">
            <span class="stat-num">{{ formatNumber(stats.projets) }}<sup>+</sup></span>
            <span class="stat-lbl">Projets financés</span>
          </div>
          <div class="stat-sep"></div>
          <div class="stat-box">
            <span class="stat-num">{{ stats.satisfaction }}<sup>%</sup></span>
            <span class="stat-lbl">Satisfaction client</span>
          </div>
        </div>
        <p class="hero-desc">
          🇨🇲 Votre partenaire financier de confiance au Cameroun<br>
          <span>Épargne · Crédit · Projets</span>
        </p>
        <div class="hero-btns">
          <button @click="openAdminLogin" class="hbtn hbtn-outline">
            Espace Administrateur
            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"/></svg>
          </button>
          <router-link to="/compte" class="hbtn hbtn-solid">
            Créer un compte
            <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M16 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/><circle cx="8.5" cy="7" r="4"/><line x1="20" y1="8" x2="20" y2="14"/><line x1="23" y1="11" x2="17" y2="11"/></svg>
          </router-link>
        </div>
      </div>
      
      <div class="hero-scroll">
        <span>Défiler</span>
        <div class="scroll-bar"></div>
      </div>
    </section>

    <!-- SERVICES SECTION -->
    <section id="services" class="services-section">
      <div class="srv-header">
        <span class="eyebrow">CE QUE NOUS OFFRONS</span>
        <h2 class="srv-title">Nos Services</h2>
        <p class="srv-sub">Des solutions financières innovantes, accessibles et adaptées à chaque camerounais</p>
      </div>

      <!-- Ouverture de Compte -->
      <div class="srv-block">
        <div class="srv-inner">
          <div class="srv-left">
            <span class="srv-num">01</span>
            <span class="srv-badge free">GRATUIT</span>
            <h3 class="srv-name">Ouverture de Compte</h3>
            <p class="srv-desc">Rejoignez la famille AXE CAPITAL en quelques minutes. Notre compte moderne vous donne accès à tous nos services financiers directement depuis votre téléphone.</p>
            <ul class="srv-feat">
              <li><span class="fd"></span>Ouverture 100% en ligne</li>
              <li><span class="fd"></span>Aucun frais de tenue de compte</li>
              <li><span class="fd"></span>Accès immédiat à tous les services</li>
            </ul>
            <router-link to="/compte" class="srv-cta">
              Ouvrir mon compte gratuitement
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </router-link>
          </div>
          <div class="srv-right">
            <div class="vis-account">
              <div class="bank-card">
                <div class="bc-top">
                  <span class="bc-logo">AX</span>
                  <span class="bc-chip">💳</span>
                </div>
                <div class="bc-num">•••• •••• •••• 4821</div>
                <div class="bc-bot">
                  <span>Jean-Pierre K.</span>
                  <span>12/28</span>
                </div>
              </div>
              <div class="vis-bubble bub-a">✅ Compte activé</div>
              <div class="vis-bubble bub-b">⚡ En 5 min</div>
            </div>
          </div>
        </div>
      </div>

      <!-- Épargne -->
      <div class="srv-block alt">
        <div class="srv-inner rev">
          <div class="srv-left">
            <span class="srv-num">02</span>
            <span class="srv-badge popular">POPULAIRE</span>
            <h3 class="srv-name">Épargne Intelligente</h3>
            <p class="srv-desc">Construisez votre avenir financier grâce à notre système d'épargne flexible via Orange Money. Définissez votre objectif, versez à votre rythme.</p>
            <ul class="srv-feat">
              <li><span class="fd green"></span>Versements via Orange Money</li>
              <li><span class="fd green"></span>Suivi en temps réel sur WhatsApp</li>
              <li><span class="fd green"></span>Objectifs d'épargne personnalisés</li>
            </ul>
            <button class="srv-cta green">
              Commencer à épargner
              <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
            </button>
          </div>
          <div class="srv-right">
            <div class="vis-savings">
              <div class="prog-card">
                <div class="pc-lbl">Objectif Épargne</div>
                <div class="pc-goal">500 000 FCFA</div>
                <div class="pc-bar-bg"><div class="pc-bar"></div></div>
                <div class="pc-pct">68% atteint · 340 000 FCFA</div>
              </div>
            </div>
          </div>
        </div>
      </div>

     
    </section>

    <!-- CONTACT SECTION -->
    <section class="contact-section">
      <div class="ct-wrap">
        <span class="eyebrow light">PRÊT À COMMENCER ?</span>
        <h2 class="ct-title">Contactez-nous</h2>
        <p class="ct-sub">Notre équipe est disponible pour vous accompagner dans chaque démarche.</p>
        <div class="ct-methods">
          <a href="https://wa.me/237688822232" target="_blank" class="ct-item">
            <span>📱</span>
            <div><h4>WhatsApp</h4><p>+237 688 822 232</p></div>
          </a>
          <div class="ct-item">
            <span>📍</span>
            <div><h4>Localisation</h4><p>Cameroun</p></div>
          </div>
          <div class="ct-item">
            <span>🕐</span>
            <div><h4>Horaires</h4><p>Lun – Sam : 8h – 17h</p></div>
          </div>
        </div>
        <router-link to="/compte" class="ct-cta">
          Ouvrir un compte gratuitement
          <svg width="17" height="17" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
        </router-link>
      </div>
    </section>
  </div>
</template>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&display=swap');


.accueil {
  font-family: 'Plus Jakarta Sans', sans-serif;
  color: #1e40af;
  background: #dbeafe;
  --blue: #60a5fa;
  --blue-dk: #3b82f6;
  --blue-lt: #93c5fd;
  --blue-pale: #eff6ff;
  --blue-mid: #dbeafe;
  --dark: #1e40af;
  --text: #374151;
  --muted: #6b7280;
  --green: #059669;
  --orange: #d97706;
  --purple: #7c3aed;
}

.eyebrow {
  font-size: 0.68rem;
  font-weight: 600;
  letter-spacing: 0.22em;
  text-transform: uppercase;
  color: var(--blue);
  display: block;
  margin-bottom: 12px;
}
.eyebrow.light { color: rgba(96,165,250,0.8); }

/* HERO */
.hero-section {
  position: relative;
  min-height: 100vh;
  background: var(--dark);
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 80px 24px 120px;
  overflow: hidden;
}
.hero-bg-grid {
  position: absolute; inset: 0;
  background-image:
    linear-gradient(rgba(26,86,219,0.07) 1px, transparent 1px),
    linear-gradient(90deg, rgba(26,86,219,0.07) 1px, transparent 1px);
  background-size: 60px 60px;
}
.hero-blob { position: absolute; border-radius: 50%; filter: blur(140px); pointer-events: none; }
.blob-1 { width: 600px; height: 600px; background: rgba(26,86,219,0.2); top: -150px; left: -120px; }
.blob-2 { width: 400px; height: 400px; background: rgba(59,130,246,0.12); bottom: -80px; right: -60px; }

.hero-content { position: relative; z-index: 2; text-align: center; max-width: 840px; }

.hero-badge {
  display: inline-flex; align-items: center; gap: 8px;
  background: rgba(26,86,219,0.15);
  border: 1px solid rgba(26,86,219,0.3);
  color: #93c5fd;
  font-size: 0.78rem; font-weight: 500; letter-spacing: 0.08em;
  padding: 7px 18px; border-radius: 100px; margin-bottom: 36px;
}
.badge-pulse {
  width: 7px; height: 7px; background: var(--blue-lt);
  border-radius: 50%; animation: bp 2s infinite;
}
@keyframes bp { 0%,100%{opacity:1} 50%{opacity:0.3} }

.hero-title {
  font-family: 'Syne', sans-serif;
  font-size: clamp(4rem, 11vw, 8rem);
  font-weight: 800; line-height: 0.92;
  letter-spacing: -0.025em; color: #fff; margin-bottom: 22px;
}
.ht-line { display: block; }
.ht-line.blue {
  background: linear-gradient(90deg, #60a5fa 0%, #93c5fd 45%, #60a5fa 100%);
  -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
}

.hero-tagline {
  font-size: 1.1rem; font-style: italic; font-weight: 300;
  color: rgba(255,255,255,0.4); margin-bottom: 48px;
}

.hero-stats {
  display: inline-flex; align-items: center;
  background: rgba(255,255,255,0.05);
  border: 1px solid rgba(255,255,255,0.1);
  border-radius: 16px; padding: 20px 32px; margin-bottom: 36px;
}
.stat-box { text-align: center; padding: 0 28px; }
.stat-num {
  display: block; font-family: 'Syne', sans-serif;
  font-size: 1.9rem; font-weight: 800; color: #fff; line-height: 1; margin-bottom: 4px;
}
.stat-num sup { font-size: 0.95rem; }
.stat-lbl { font-size: 0.7rem; color: rgba(255,255,255,0.38); text-transform: uppercase; letter-spacing: 0.1em; }
.stat-sep { width: 1px; height: 40px; background: rgba(255,255,255,0.1); }

.hero-desc { font-size: 0.97rem; color: rgba(255,255,255,0.42); line-height: 1.9; margin-bottom: 48px; }
.hero-desc span { color: rgba(96,165,250,0.75); }

.hero-btns { display: flex; gap: 14px; justify-content: center; flex-wrap: wrap; }
.hbtn {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 13px 26px; border-radius: 8px;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.93rem; font-weight: 600; cursor: pointer; border: none;
  text-decoration: none; transition: all 0.22s ease;
}
.hbtn-outline {
  background: transparent; color: rgba(255,255,255,0.68);
  border: 1px solid rgba(255,255,255,0.15);
}
.hbtn-outline:hover { background: rgba(255,255,255,0.08); color: #fff; }
.hbtn-solid {
  background: var(--blue); color: #fff;
  box-shadow: 0 8px 24px rgba(26,86,219,0.4);
}
.hbtn-solid:hover { background: var(--blue-lt); transform: translateY(-2px); }

.hero-scroll {
  position: absolute; bottom: 28px; left: 50%; transform: translateX(-50%);
  display: flex; flex-direction: column; align-items: center; gap: 10px;
  color: rgba(255,255,255,0.22); font-size: 0.62rem; letter-spacing: 0.18em; text-transform: uppercase;
}
.scroll-bar {
  width: 1px; height: 44px;
  background: linear-gradient(to bottom, rgba(255,255,255,0.3), transparent);
  animation: sa 1.8s ease-in-out infinite;
}
@keyframes sa { 0%,100%{opacity:1} 50%{opacity:0.3} }

/* SERVICES */
.services-section { background: #fff; }

.srv-header {
  text-align: center;
  padding: 90px 5% 70px;
  background: var(--blue-pale);
  border-bottom: 1px solid var(--blue-mid);
}
.srv-title {
  font-family: 'Syne', sans-serif;
  font-size: clamp(2.2rem, 5vw, 3.4rem);
  font-weight: 800; color: var(--dark);
  letter-spacing: -0.025em; margin-bottom: 16px;
}
.srv-sub {
  font-size: 1.05rem; color: var(--muted); font-weight: 300;
  max-width: 520px; margin: 0 auto; line-height: 1.7;
}

.srv-block { padding: 88px 5%; border-bottom: 1px solid #f1f5f9; }
.srv-block.alt { background: #f8faff; }

.srv-inner {
  max-width: 1180px; margin: 0 auto;
  display: grid; grid-template-columns: 1fr 1fr;
  gap: 80px; align-items: center;
}
.srv-inner.rev { direction: rtl; }
.srv-inner.rev > * { direction: ltr; }

.srv-num {
  font-family: 'Syne', sans-serif;
  font-size: 0.68rem; font-weight: 700; letter-spacing: 0.14em;
  color: #cbd5e1; display: block; margin-bottom: 10px;
}

.srv-badge {
  display: inline-block; font-size: 0.6rem; font-weight: 700;
  letter-spacing: 0.14em; text-transform: uppercase;
  padding: 4px 12px; border-radius: 100px; margin-bottom: 16px;
}
.srv-badge.free       { background: #dcfce7; color: #15803d; }
.srv-badge.popular    { background: #fff7ed; color: #c2410c; }
.srv-badge.fast       { background: var(--blue-pale); color: var(--blue-dk); }

.srv-name {
  font-family: 'Syne', sans-serif;
  font-size: clamp(1.7rem, 3vw, 2.3rem);
  font-weight: 800; color: var(--dark);
  letter-spacing: -0.02em; line-height: 1.1; margin-bottom: 18px;
}

.srv-desc {
  font-size: 0.97rem; color: var(--muted);
  line-height: 1.78; font-weight: 300; margin-bottom: 26px;
}

.srv-feat { list-style: none; display: flex; flex-direction: column; gap: 10px; margin-bottom: 34px; }
.srv-feat li { display: flex; align-items: center; gap: 10px; font-size: 0.9rem; color: var(--text); }
.fd { width: 7px; height: 7px; border-radius: 50%; background: var(--blue); flex-shrink: 0; }
.fd.green  { background: var(--green); }
.fd.blue   { background: var(--blue); }

.srv-cta {
  display: inline-flex; align-items: center; gap: 8px;
  padding: 13px 24px; background: var(--blue); color: #fff;
  border: none; border-radius: 8px;
  font-family: 'Plus Jakarta Sans', sans-serif;
  font-size: 0.9rem; font-weight: 600; text-decoration: none; cursor: pointer;
  transition: all 0.22s ease;
  box-shadow: 0 4px 16px rgba(26,86,219,0.25);
}
.srv-cta:hover { background: var(--blue-dk); transform: translateY(-2px); }
.srv-cta.green  { background: var(--green); }
.srv-cta.green:hover { background: #047857; }
.srv-cta.blue   { background: var(--blue); }

/* Visuels */
.vis-account, .vis-savings, .vis-credit {
  position: relative;
}

.bank-card {
  background: linear-gradient(135deg, var(--blue-dk), var(--blue));
  border-radius: 20px; padding: 26px 28px 22px; color: white;
  box-shadow: 0 20px 60px rgba(26,86,219,0.3);
}
.bc-top { display: flex; justify-content: space-between; align-items: center; margin-bottom: 32px; }
.bc-logo { font-family: 'Syne', sans-serif; font-size: 1.4rem; font-weight: 800; }
.bc-chip { font-size: 1.6rem; }
.bc-num { font-size: 1.05rem; letter-spacing: 0.18em; margin-bottom: 18px; opacity: 0.82; }
.bc-bot { display: flex; justify-content: space-between; font-size: 0.82rem; opacity: 0.65; }

.vis-bubble {
  position: absolute;
  display: flex; align-items: center; gap: 8px;
  background: white; border-radius: 100px; padding: 8px 16px;
  font-size: 0.78rem; font-weight: 600; color: var(--dark);
  box-shadow: 0 8px 24px rgba(0,0,0,0.12);
  white-space: nowrap;
}
.bub-a { bottom: -14px; right: 20px; }
.bub-b { top: -14px; left: 20px; }

.prog-card {
  background: white; border-radius: 16px; padding: 26px;
  box-shadow: 0 12px 40px rgba(0,0,0,0.09); border: 1px solid #e2e8f0;
}
.pc-lbl { font-size: 0.7rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 6px; }
.pc-goal { font-family: 'Syne', sans-serif; font-size: 1.7rem; font-weight: 800; color: var(--dark); margin-bottom: 14px; }
.pc-bar-bg { height: 8px; background: #e2e8f0; border-radius: 10px; margin-bottom: 8px; overflow: hidden; }
.pc-bar { height: 100%; width: 68%; background: linear-gradient(90deg, var(--green), #34d399); border-radius: 10px; }
.pc-pct { font-size: 0.78rem; color: var(--green); font-weight: 600; }

.credit-card {
  background: white; border-radius: 16px; padding: 26px;
  box-shadow: 0 12px 40px rgba(0,0,0,0.09); border: 1px solid #e2e8f0;
}
.cc-row { margin-bottom: 18px; }
.cc-lbl { display: block; font-size: 0.68rem; color: var(--muted); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px; }
.cc-val { font-family: 'Syne', sans-serif; font-size: 1rem; font-weight: 700; color: var(--dark); }
.cc-val.big { font-size: 1.8rem; color: var(--blue); }
.cc-div { height: 1px; background: #f1f5f9; margin: 14px 0; }
.cc-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 16px; }
.cc-grid > div { display: flex; flex-direction: column; gap: 4px; }

/* CONTACT */
.contact-section { padding: 100px 5%; background: var(--dark); }
.ct-wrap { max-width: 800px; margin: 0 auto; text-align: center; }
.ct-title {
  font-family: 'Syne', sans-serif;
  font-size: clamp(2rem, 4vw, 3rem);
  font-weight: 800; color: #fff; letter-spacing: -0.02em; margin-bottom: 12px;
}
.ct-sub { font-size: 0.98rem; color: rgba(255,255,255,0.38); margin-bottom: 50px; font-weight: 300; }
.ct-methods { display: grid; grid-template-columns: repeat(3, 1fr); gap: 18px; margin-bottom: 44px; }
.ct-item {
  display: flex; align-items: center; gap: 14px; padding: 20px 16px;
  background: rgba(255,255,255,0.05); border: 1px solid rgba(255,255,255,0.08);
  border-radius: 10px; text-decoration: none; color: white; text-align: left;
  transition: all 0.22s ease;
}
.ct-item:hover { background: rgba(255,255,255,0.09); border-color: rgba(26,86,219,0.4); transform: translateY(-3px); }
.ct-item > span { font-size: 1.5rem; flex-shrink: 0; }
.ct-item h4 { font-size: 0.68rem; font-weight: 600; color: rgba(255,255,255,0.38); text-transform: uppercase; letter-spacing: 0.1em; margin-bottom: 4px; }
.ct-item p { font-size: 0.92rem; color: #fff; }
.ct-cta {
  display: inline-flex; align-items: center; gap: 10px;
  background: var(--blue); color: white; padding: 15px 34px;
  border-radius: 8px; font-weight: 700; font-size: 0.97rem;
  text-decoration: none; transition: all 0.22s ease;
  box-shadow: 0 8px 28px rgba(26,86,219,0.4);
  border: none;
  cursor: pointer;
}
.ct-cta:hover { background: var(--blue-lt); transform: translateY(-2px); }

/* RESPONSIVE */
@media (max-width: 900px) {
  .srv-inner { grid-template-columns: 1fr; gap: 40px; }
  .srv-inner.rev { direction: ltr; }
  .srv-block { padding: 60px 5%; }
  .ct-methods { grid-template-columns: 1fr; }
}
@media (max-width: 600px) {
  .hero-stats { flex-direction: column; padding: 18px; }
  .stat-sep { width: 48px; height: 1px; }
  .cc-grid { grid-template-columns: 1fr; }
  .bub-a, .bub-b { display: none; }
}
</style>
