<template>
  <div class="partenaire-login">
    <div class="login-container">
      <div class="login-card">
        <div class="login-header">
          <div class="logo">
            <img src="/logo.svg" alt="AXE CAPITAL" class="logo-img" />
          </div>
          <h2 class="login-title">Espace Administrateur</h2>
          <p class="login-subtitle">Connectez-vous pour accéder à votre espace de gestion</p>
        </div>

        <form @submit.prevent="handleLogin" class="login-form">
          <div v-if="error" class="message error">
            {{ error }}
          </div>

          <div class="form-group">
            <label for="email">Adresse email</label>
            <input
              type="email"
              id="email"
              v-model="email"
              required
              placeholder="partenaire@axecapital.cm"
              class="form-input"
            />
          </div>

          <div class="form-group">
            <label for="password">Mot de passe</label>
            <input
              type="password"
              id="password"
              v-model="password"
              required
              placeholder="••••••••"
              class="form-input"
            />
          </div>

          <button type="submit" :disabled="loading" class="login-btn">
            <span v-if="loading">Connexion en cours...</span>
            <span v-else>Se connecter</span>
          </button>
        </form>

        <div class="login-footer">
          <p>
            Vous n'avez pas de compte ? 
            <a href="#" class="link">Contactez-nous</a>
          </p>
          <p class="help-text">
            <a href="https://wa.me/237688822232" target="_blank" class="link">
              Besoin d'aide ? Contactez le support
            </a>
          </p>
        </div>
      </div>

      <div class="login-bg">
        <div class="bg-pattern"></div>
        <div class="bg-blob blob-1"></div>
        <div class="bg-blob blob-2"></div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabase'

const router = useRouter()
const email = ref('')
const password = ref('')
const loading = ref(false)
const error = ref('')

const handleLogin = async () => {
  loading.value = true
  error.value = ''

  try {
    const { data, error: authError } = await supabase.auth.signInWithPassword({
      email: email.value,
      password: password.value
    })

    if (authError) {
      error.value = 'Email ou mot de passe incorrect'
      return
    }

    if (data.user) {
      // Redirection vers le dashboard partenaire
      router.push('/partenaire/dashboard')
    }
  } catch (err) {
    error.value = 'Une erreur est survenue lors de la connexion'
  } finally {
    loading.value = false
  }
}
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&display=swap');

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

.partenaire-login {
  min-height: 100vh;
  background: #dbeafe;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: 'Plus Jakarta Sans', sans-serif;
  color: #1e40af;
}

.login-container {
  position: relative;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 2rem;
  z-index: 2;
}

.login-card {
  background: white;
  border-radius: 20px;
  padding: 3rem;
  width: 100%;
  max-width: 420px;
  box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
  position: relative;
  z-index: 10;
}

.login-header {
  text-align: center;
  margin-bottom: 2.5rem;
}

.logo {
  margin-bottom: 1.5rem;
}

.logo-text {
  font-family: 'Syne', sans-serif;
  font-size: 2rem;
  font-weight: 800;
  color: #0f172a;
  letter-spacing: -0.02em;
}

.logo-blue {
  background: linear-gradient(90deg, #3b82f6 0%, #60a5fa 50%, #3b82f6 100%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.login-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.8rem;
  font-weight: 700;
  color: #0f172a;
  margin-bottom: 0.5rem;
  letter-spacing: -0.02em;
}

.login-subtitle {
  color: #6b7280;
  font-size: 0.95rem;
  font-weight: 300;
  line-height: 1.5;
}

.login-form {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.form-group label {
  font-weight: 600;
  color: #0f172a;
  font-size: 0.9rem;
}

.form-input {
  padding: 0.875rem 1rem;
  border: 2px solid #e2e8f0;
  border-radius: 10px;
  font-size: 0.95rem;
  transition: all 0.3s ease;
  background: #f8fafc;
}

.form-input:focus {
  --blue: #60a5fa;
  --blue-dk: #3b82f6;
  --blue-lt: #93c5fd;
  box-shadow: 0 0 0 3px rgba(60, 165, 250, 0.1);
  background: white;
}

.login-btn {
  padding: 1rem;
  background: linear-gradient(135deg, #60a5fa, #93c5fd);
  color: white;
  border: none;
  border-radius: 10px;
  font-weight: 600;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 8px 24px rgba(60, 165, 250, 0.3);
  margin-top: 1rem;
}

.login-btn:hover:not(:disabled) {
  background: linear-gradient(135deg, #93c5fd, #60a5fa);
  transform: translateY(-2px);
  box-shadow: 0 12px 32px rgba(60, 165, 250, 0.4);
}

.login-btn:disabled {
  opacity: 0.7;
  cursor: not-allowed;
  transform: none;
}

.login-footer {
  text-align: center;
  border-top: 1px solid #e2e8f0;
  padding-top: 1.5rem;
}

.login-footer p {
  color: #6b7280;
  font-size: 0.85rem;
  margin-bottom: 0.5rem;
}

.link {
  color: #3b82f6;
  text-decoration: none;
  font-weight: 600;
  transition: color 0.3s ease;
}

.link:hover {
  color: #2563eb;
  text-decoration: underline;
}

.help-text {
  font-size: 0.8rem !important;
  opacity: 0.8;
}

.message {
  padding: 1rem;
  border-radius: 8px;
  font-size: 0.9rem;
  font-weight: 500;
  text-align: center;
}

.message.error {
  background: #fef2f2;
  color: #dc2626;
  border: 1px solid #fecaca;
}

/* Background */
.login-bg {
  position: absolute;
  inset: 0;
  z-index: 1;
}

.bg-pattern {
  position: absolute;
  inset: 0;
  background-image: 
    linear-gradient(rgba(59, 130, 246, 0.07) 1px, transparent 1px),
    linear-gradient(90deg, rgba(59, 130, 246, 0.07) 1px, transparent 1px);
  background-size: 60px 60px;
}

.bg-blob {
  position: absolute;
  border-radius: 50%;
  filter: blur(120px);
}

.blob-1 {
  width: 500px;
  height: 500px;
  background: rgba(59, 130, 246, 0.15);
  top: -100px;
  left: -100px;
}

.blob-2 {
  width: 350px;
  height: 350px;
  background: rgba(37, 99, 235, 0.1);
  bottom: -80px;
  right: -80px;
}

.logo-img {
  height: 40px;
  width: auto;
  max-width: 200px;
}

/* Responsive */
@media (max-width: 640px) {
  .login-container {
    padding: 1rem;
  }
  
  .login-card {
    padding: 2rem;
    border-radius: 16px;
  }
  
  .logo-img {
    height: 35px;
  }
  
  .logo-text {
    font-size: 1.5rem;
  }
  
  .login-title {
    font-size: 1.4rem;
  }
  
  .form-input {
    padding: 0.75rem 0.875rem;
    font-size: 0.9rem;
  }
  
  .login-btn {
    padding: 0.875rem;
    font-size: 0.9rem;
  }
}
</style>
