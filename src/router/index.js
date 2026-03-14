import { createRouter, createWebHistory } from 'vue-router'
import HomeView from '../views/home/HomeView.vue'
import CompteView from '../views/compte/CompteEntryView.vue'
import CompteFormView from '../views/compte/CompteViewLocal.vue'
import RecapitulatifView from '../views/compte/RecapitulatifViewLocal.vue'
import ConfirmationView from '../views/compte/ConfirmationView.vue'
import GestionnaireView from '../views/gestionnaire/GestionnaireView.vue'
import PartenaireView from '../views/partenaire/PartenaireView.vue'
import DashboardView from '../views/partenaire/DashboardView.vue'
import { supabase } from '../lib/supabase'

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomeView,
    meta: {
      title: 'Accueil - Axe Capital'
    }
  },
  {
    path: '/compte',
    name: 'Compte',
    component: CompteView,
    meta: {
      title: 'Gestion de Compte - Axe Capital'
    }
  },
  {
    path: '/compte/creation',
    name: 'CompteCreation',
    component: CompteFormView,
    meta: {
      title: 'Créer un compte - Axe Capital'
    }
  },
  {
    path: '/compte/recapitulatif',
    name: 'Recapitulatif',
    component: RecapitulatifView,
    meta: {
      title: 'Récapitulatif - Axe Capital'
    }
  },
  {
    path: '/compte/confirmation',
    name: 'Confirmation',
    component: ConfirmationView,
    meta: {
      title: 'Compte actif - Axe Capital'
    }
  },
  {
    path: '/gestionnaire',
    name: 'Gestionnaire',
    component: GestionnaireView,
    meta: {
      title: 'Gestionnaire - Axe Capital'
    }
  },
  {
    path: '/partenaire',
    name: 'Partenaire',
    component: PartenaireView,
    meta: {
      title: 'Espace Partenaire - Axe Capital'
    }
  },
  {
    path: '/partenaire/dashboard',
    name: 'PartenaireDashboard',
    component: DashboardView,
    meta: {
      title: 'Tableau de bord - Axe Capital',
      requiresAuth: true
    }
  }
]

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes
})

router.beforeEach(async (to, from, next) => {
  document.title = to.meta.title || 'Axe Capital'
  
  // Vérifier l'authentification pour les routes protégées
  if (to.meta.requiresAuth) {
    const { data: { user } } = await supabase.auth.getUser()
    if (!user) {
      next('/partenaire')
      return
    }
  }
  
  next()
})

export default router
