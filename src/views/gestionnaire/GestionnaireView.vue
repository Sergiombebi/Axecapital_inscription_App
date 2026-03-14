<script setup>
import { ref, onMounted } from 'vue'
import { useRouter } from 'vue-router'
import { supabase } from '../../lib/supabase'
import BaseCard from '../../components/BaseCard.vue'
import BaseButton from '../../components/BaseButton.vue'
import FlashNotification from '../../components/FlashNotification.vue'

const router = useRouter()

const clients = ref([])
const loading = ref(false)
const notification = ref({
  show: false,
  message: '',
  type: 'info'
})

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

const fetchClients = async () => {
  loading.value = true
  try {
    const { data, error } = await supabase
      .from('clients')
      .select('*')
      .order('created_at', { ascending: false })

    if (error) {
      showNotification('Erreur lors de la récupération des clients: ' + error.message, 'error')
      return
    }

    clients.value = data || []
  } catch (error) {
    showNotification('Une erreur est survenue', 'error')
  } finally {
    loading.value = false
  }
}

const formatDate = (dateString) => {
  if (!dateString) return 'N/A'
  return new Date(dateString).toLocaleDateString('fr-FR', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit'
  })
}

const getStatusColor = (statut) => {
  switch (statut) {
    case 'approuve':
      return 'bg-green-100 text-green-800'
    case 'en_attente':
      return 'bg-yellow-100 text-yellow-800'
    case 'rejete':
      return 'bg-red-100 text-red-800'
    default:
      return 'bg-gray-100 text-gray-800'
  }
}

const getStatusText = (statut) => {
  switch (statut) {
    case 'approuve':
      return 'Approuvé'
    case 'en_attente':
      return 'En attente'
    case 'rejete':
      return 'Rejeté'
    default:
      return 'Inconnu'
  }
}

const goToHome = () => {
  router.push('/')
}

onMounted(() => {
  fetchClients()
})
</script>

<template>
  <div class="min-h-screen bg-gray-50">
    <FlashNotification
      :show="notification.show"
      :message="notification.message"
      :type="notification.type"
      @close="handleNotificationClose"
    />

    <div class="container mx-auto px-4 py-8">
      <div class="mb-8">
        <div class="flex items-center justify-between">
          <div>
            <h1 class="text-3xl font-bold text-gray-900 mb-2">
              Espace Gestionnaire
            </h1>
            <p class="text-gray-600">
              Gestion des comptes clients Axe Capital
            </p>
          </div>
          <BaseButton
            type="secondary"
            @click="goToHome"
          >
            Retour à l'accueil
          </BaseButton>
        </div>
      </div>

      <BaseCard>
        <div class="mb-6">
          <h2 class="text-xl font-semibold text-gray-900 mb-4">
            Liste des clients inscrits
          </h2>
          
          <div class="flex items-center justify-between mb-4">
            <p class="text-gray-600">
              {{ clients.length }} client(s) trouvé(s)
            </p>
            <BaseButton
              type="primary"
              @click="fetchClients"
              :loading="loading"
              size="small"
            >
              Actualiser
            </BaseButton>
          </div>
        </div>

        <div v-if="loading" class="text-center py-8">
          <div class="inline-block animate-spin rounded-full h-8 w-8 border-b-2 border-blue-600"></div>
          <p class="mt-2 text-gray-600">Chargement des clients...</p>
        </div>

        <div v-else-if="clients.length === 0" class="text-center py-12">
          <div class="w-16 h-16 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <svg class="w-8 h-8 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0zm6 3a2 2 0 11-4 0 2 2 0 014 0zM7 10a2 2 0 11-4 0 2 2 0 014 0z"></path>
            </svg>
          </div>
          <h3 class="text-lg font-medium text-gray-900 mb-2">
            Aucun client trouvé
          </h3>
          <p class="text-gray-600">
            Aucun compte client n'a été créé pour le moment.
          </p>
        </div>

        <div v-else class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Nom complet
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Téléphone
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Ville
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Date d'inscription
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                  Statut
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr v-for="client in clients" :key="client.id" class="hover:bg-gray-50">
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm font-medium text-gray-900">
                    {{ client.nom }} {{ client.prenom }}
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm text-gray-900">
                    {{ client.telephone }}
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm text-gray-900">
                    {{ client.ville }}
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="text-sm text-gray-500">
                    {{ formatDate(client.created_at) }}
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <span :class="['px-2 inline-flex text-xs leading-5 font-semibold rounded-full', getStatusColor(client.statut)]">
                    {{ getStatusText(client.statut) }}
                  </span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </BaseCard>
    </div>
  </div>
</template>
