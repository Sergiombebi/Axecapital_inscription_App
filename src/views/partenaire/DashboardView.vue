<template>
  <div class="dashboard">
    <div class="dashboard-header">
      <div class="header-content">
        <div class="logo">
          <h1 class="logo-text">AXE<span class="logo-blue">CAPITAL</span></h1>
        </div>
        <div class="header-actions">
          <span class="welcome-text">Bienvenue, {{ user?.email }}</span>
          <button @click="handleLogout" class="logout-btn">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
              <polyline points="16 17 21 12 16 7"/>
              <line x1="21" y1="12" x2="9" y2="12"/>
            </svg>
            Déconnexion
          </button>
        </div>
      </div>
    </div>

    <div class="dashboard-content">
      <div class="content-header">
        <h2 class="page-title">Tableau de bord</h2>
        <p class="page-subtitle">Gérez vos clients et suivez vos activités</p>
      </div>

      <!-- Export Buttons -->
      <div class="export-section">
        <div class="export-buttons">
          <button @click="exportToCSV" class="export-btn csv">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/>
              <polyline points="7 10 12 15 17 10"/>
              <line x1="12" y1="15" x2="12" y2="3"/>
            </svg>
            Exporter en CSV
          </button>
          <button @click="exportToPDF" class="export-btn pdf">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M6 9V2h12v7"/>
              <path d="M6 18H4a2 2 0 0 1-2-2v-5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2v5a2 2 0 0 1-2 2h-2"/>
              <rect x="6" y="14" width="12" height="8"/>
            </svg>
            Exporter en PDF
          </button>
        </div>
      </div>

      <div class="stats-grid">
        <div class="stat-card">
          <div class="stat-icon">👥</div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.clients }}</div>
            <div class="stat-label">Clients actifs</div>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon">📁</div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.dossiers }}</div>
            <div class="stat-label">Dossiers en cours</div>
          </div>
        </div>

        <div class="stat-card">
          <div class="stat-icon">📈</div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.taux }}%</div>
            <div class="stat-label">Taux de conversion</div>
          </div>
        </div>
      </div>

      <div class="dashboard-grid">
        <div class="dashboard-section">
          <h3 class="section-title">Derniers clients</h3>
          <div class="clients-list">
            <div v-for="client in recentClients" :key="client.id" class="client-item">
              <div class="client-info">
                <div class="client-avatar">
                  {{ client.name.charAt(0).toUpperCase() }}
                </div>
                <div class="client-details">
                  <div class="client-name">{{ client.name }}</div>
                  <div class="client-email">{{ client.email }}</div>
                </div>
              </div>
              <div class="client-status">
                <span :class="['status-badge', client.status]">
                  {{ getStatusText(client.status) }}
                </span>
              </div>
              <div class="client-actions">
                <button @click="viewClientProfile(client.fullData)" class="view-profile-btn">
                  👁️ Voir profil
                </button>
                <button @click="deleteClient(client.id, client.name)" class="delete-btn">
                  🗑️ Supprimer
                </button>
              </div>
            </div>
          </div>
        </div>

        <!-- Graphes Section -->
        <div class="dashboard-section">
          <h3 class="section-title">Statistiques visuelles</h3>
          <div class="charts-grid">
            <div class="chart-card">
              <h4 class="chart-title">Répartition des statuts</h4>
              <div class="simple-chart">
                <div class="donut-chart">
                  <svg viewBox="0 0 42 42" class="donut-svg">
                    <circle cx="21" cy="21" r="15.915" fill="transparent" stroke="#e5e7eb" stroke-width="3"></circle>
                    <circle v-for="(item, index) in statusChartData" :key="index"
                      cx="21" cy="21" r="15.915"
                      fill="transparent"
                      :stroke="item.color"
                      stroke-width="3"
                      :stroke-dasharray="getDonutPercentage(statusChartData, index)"
                      :stroke-dashoffset="getDonutOffset(statusChartData, index)"
                      class="donut-segment"
                    ></circle>
                  </svg>
                  <div class="donut-center">
                    <div class="donut-value">{{ stats.clients }}</div>
                    <div class="donut-label">Total</div>
                  </div>
                </div>
                <div class="chart-legend">
                  <div v-for="(item, index) in statusChartData" :key="index" class="legend-item">
                    <span class="legend-color" :style="{ backgroundColor: item.color }"></span>
                    <span class="legend-text">{{ item.label }}</span>
                    <span class="legend-value">{{ item.value }}</span>
                  </div>
                </div>
              </div>
            </div>
            <div class="chart-card">
              <h4 class="chart-title">Évolution mensuelle</h4>
              <div class="simple-chart">
                <div class="bar-chart">
                  <div v-for="(item, index) in evolutionChartData" :key="index" class="bar-item">
                    <span class="bar-label">{{ item.month }}</span>
                    <div class="bar-container">
                      <div class="bar-fill" :style="{ width: getBarWidth(item, evolutionChartData) }"></div>
                    </div>
                    <span class="bar-value">{{ item.count }}</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal Profil Client -->
    <div v-if="showClientModal && selectedClient" class="modal-overlay" @click="closeModal">
      <div class="modal-content" @click.stop>
        <div class="modal-header">
          <h3 class="modal-title">Profil du client</h3>
          <button @click="closeModal" class="modal-close">✕</button>
        </div>
        
        <div class="modal-body">
          <!-- Photo du client -->
          <div class="profile-photo-section">
            <div class="photo-container">
              <img 
                v-if="getClientPhoto(selectedClient)" 
                :src="getClientPhoto(selectedClient)" 
                alt="Photo CNI"
                class="profile-photo"
              />
              <div v-else class="photo-placeholder">
                <span class="photo-icon">👤</span>
                <span class="photo-text">Aucune photo</span>
              </div>
            </div>
          </div>

          <!-- Informations du client -->
          <div class="profile-info">
            <div class="info-grid">
              <div class="info-item">
                <label>Nom complet</label>
                <span>{{ selectedClient.nom }} {{ selectedClient.prenom }}</span>
              </div>
              <div class="info-item">
                <label>Date de naissance</label>
                <span>{{ selectedClient.date_naissance || 'N/A' }}</span>
              </div>
              <div class="info-item">
                <label>Lieu de naissance</label>
                <span>{{ selectedClient.lieu_naissance || 'N/A' }}</span>
              </div>
              <div class="info-item">
                <label>Sexe</label>
                <span>{{ selectedClient.sexe === 'M' ? 'Masculin' : 'Féminin' }}</span>
              </div>
              <div class="info-item">
                <label>Téléphone</label>
                <span>{{ selectedClient.telephone }}</span>
              </div>
              <div class="info-item">
                <label>Pays</label>
                <span>{{ selectedClient.pays }}</span>
              </div>
              <div class="info-item">
                <label>Ville</label>
                <span>{{ selectedClient.ville }}</span>
              </div>
              <div class="info-item">
                <label>Quartier</label>
                <span>{{ selectedClient.quartier }}</span>
              </div>
              <div class="info-item">
                <label>Numéro CNI</label>
                <span>{{ selectedClient.numero_cni }}</span>
              </div>
              <div class="info-item">
                <label>Contact d'urgence</label>
                <span>{{ selectedClient.contact_urgence_nom }} ({{ selectedClient.telephone_urgence }})</span>
              </div>
              <div class="info-item">
                <label>Date de création</label>
                <span>{{ formatDate(selectedClient.created_at) }}</span>
              </div>
              <div class="info-item">
                <label>Statut</label>
                <span :class="['status-badge', selectedClient.statut === 'approuve' ? 'active' : selectedClient.statut === 'en_attente' ? 'pending' : 'inactive']">
                  {{ selectedClient.statut === 'approuve' ? 'Approuvé' : selectedClient.statut === 'en_attente' ? 'En attente' : 'Inactif' }}
                </span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- Modal de confirmation de suppression -->
    <div v-if="showDeleteModal && clientToDelete" class="modal-overlay" @click="cancelDelete">
      <div class="modal-content delete-modal" @click.stop>
        <div class="modal-header">
          <h3 class="modal-title">⚠️ Confirmation de suppression</h3>
          <button @click="cancelDelete" class="modal-close">✕</button>
        </div>
        
        <div class="modal-body">
          <div class="delete-warning">
            <div class="warning-icon">⚠️</div>
            <p class="warning-text">
              Êtes-vous sûr de vouloir supprimer le compte de <strong>{{ clientToDelete.name }}</strong> ?
            </p>
            <p class="warning-subtext">
              Cette action est <strong>irréversible</strong> et toutes les données associées à ce compte seront définitivement perdues.
            </p>
          </div>
          
          <div class="modal-actions">
            <button @click="cancelDelete" class="cancel-btn">
              Annuler
            </button>
            <button @click="confirmDelete" class="confirm-delete-btn">
              🗑️ Supprimer le compte
            </button>
          </div>
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
const user = ref(null)
const stats = ref({
  clients: 0,
  dossiers: 0,
  taux: 0
})

const recentClients = ref([])
const selectedClient = ref(null)
const showClientModal = ref(false)
const showDeleteModal = ref(false)
const clientToDelete = ref(null)
const statusChartData = ref([])
const evolutionChartData = ref([])

const formatCurrency = (amount) => {
  return new Intl.NumberFormat('fr-FR', {
    style: 'currency',
    currency: 'XAF',
    minimumFractionDigits: 0
  }).format(amount)
}

const getStatusText = (status) => {
  const statusMap = {
    'active': 'Actif',
    'pending': 'En attente',
    'inactive': 'Inactif'
  }
  return statusMap[status] || status
}

const viewClientProfile = (client) => {
  selectedClient.value = client
  showClientModal.value = true
}

const closeModal = () => {
  showClientModal.value = false
  selectedClient.value = null
}

const getClientPhoto = (client) => {
  // Récupérer la photo CNI depuis les données du client
  if (client.photos_cni && client.photos_cni.length > 0) {
    // Si c'est une URL ou une base64, la retourner directement
    return client.photos_cni[0]
  }
  return null
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

// Fonctions pour les graphes simples sans Chart.js
const getStatusChartData = (clients) => {
  const approuves = clients.filter(c => c.statut === 'approuve').length
  const enAttente = clients.filter(c => c.statut === 'en_attente').length
  const autres = clients.filter(c => c.statut !== 'approuve' && c.statut !== 'en_attente').length
  
  return [
    { label: 'Approuvés', value: approuves, color: '#10b981' },
    { label: 'En attente', value: enAttente, color: '#f59e0b' },
    { label: 'Autres', value: autres, color: '#6b7280' }
  ]
}

const getEvolutionChartData = (clients) => {
  // Grouper par mois
  const monthlyData = {}
  clients.forEach(client => {
    const date = new Date(client.created_at)
    const monthKey = `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, '0')}`
    monthlyData[monthKey] = (monthlyData[monthKey] || 0) + 1
  })

  // Trier les mois et formater
  return Object.keys(monthlyData).sort().map(month => {
    const [year, monthNum] = month.split('-')
    const date = new Date(year, monthNum - 1)
    return {
      month: date.toLocaleDateString('fr-FR', { month: 'short', year: 'numeric' }),
      count: monthlyData[month]
    }
  })
}

const getBarWidth = (item, allData) => {
  if (allData.length === 0) return '10%'
  const maxValue = Math.max(...allData.map(d => d.count))
  const percentage = (item.count / maxValue) * 100
  return `${Math.max(percentage, 10)}%`
}

const getDonutPercentage = (data, index) => {
  if (data.length === 0) return '0 100'
  const total = data.reduce((sum, item) => sum + item.value, 0)
  if (total === 0) return '0 100'
  const percentage = (data[index].value / total) * 100
  const circumference = 2 * Math.PI * 15.915
  const dashArray = (percentage / 100) * circumference
  return `${dashArray} ${circumference}`
}

const getDonutOffset = (data, index) => {
  if (index === 0) return '0'
  const total = data.reduce((sum, item) => sum + item.value, 0)
  if (total === 0) return '0'
  const circumference = 2 * Math.PI * 15.915
  
  let offset = 0
  for (let i = 0; i < index; i++) {
    const percentage = (data[i].value / total) * 100
    const dashArray = (percentage / 100) * circumference
    offset += dashArray
  }
  
  return -offset
}

const loadDashboardData = async () => {
  try {
    // Charger les statistiques depuis la table clients
    const { data: clientsData, error: clientsError } = await supabase
      .from('clients')
      .select('*')

    if (clientsError) {
      console.error('Erreur lors du chargement des clients:', clientsError)
      return
    }

    const clients = clientsData || []
    
    // Calculer les statistiques
    stats.value = {
      clients: clients.length,
      dossiers: clients.filter(c => c.statut === 'en_attente').length,
      taux: clients.length > 0 ? Math.round((clients.filter(c => c.statut === 'approuve').length / clients.length) * 100) : 0
    }

    // Préparer les clients récents avec données complètes
    recentClients.value = clients.slice(0, 200).map(client => ({
      id: client.id,
      name: `${client.nom} ${client.prenom}`,
      email: client.telephone,
      status: client.statut === 'approuve' ? 'active' : client.statut === 'en_attente' ? 'pending' : 'inactive',
      // Données complètes pour le profil
      fullData: client
    }))

    // Calculer les données des graphes une seule fois
    statusChartData.value = getStatusChartData(clients)
    evolutionChartData.value = getEvolutionChartData(clients)

  } catch (error) {
    console.error('Erreur lors du chargement des données du dashboard:', error)
  }
}

const handleLogout = async () => {
  await supabase.auth.signOut()
  router.push('/')
}

const exportToCSV = async () => {
  try {
    // Charger tous les clients (pas seulement les 4 récents)
    const { data: allClients, error } = await supabase
      .from('clients')
      .select('*')
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Erreur lors du chargement des clients pour export:', error)
      alert('Erreur lors de l\'exportation des données')
      return
    }

    // Préparer les données CSV (sans ID et date de création)
    const headers = [
      'Nom',
      'Prénom',
      'Date de naissance',
      'Lieu de naissance',
      'Sexe',
      'Téléphone',
      'Pays',
      'Ville',
      'Quartier',
      'Numéro CNI',
      'Contact d\'urgence',
      'Téléphone d\'urgence',
      'Statut'
    ]

    const csvData = allClients.map(client => [
      client.nom || '',
      client.prenom || '',
      client.date_naissance || '',
      client.lieu_naissance || '',
      client.sexe === 'M' ? 'Masculin' : 'Féminin',
      client.telephone || '',
      client.pays || '',
      client.ville || '',
      client.quartier || '',
      client.numero_cni || '',
      client.contact_urgence_nom || '',
      client.telephone_urgence || '',
      client.statut === 'approuve' ? 'Approuvé' : client.statut === 'en_attente' ? 'En attente' : 'Inactif'
    ])

    // Créer le contenu CSV
    const csvContent = [
      headers.join(','),
      ...csvData.map(row => row.map(cell => `"${cell}"`).join(','))
    ].join('\n')

    // Créer le blob et télécharger
    const blob = new Blob(['\ufeff' + csvContent], { type: 'text/csv;charset=utf-8;' })
    const link = document.createElement('a')
    const url = URL.createObjectURL(blob)
    
    const date = new Date().toISOString().split('T')[0]
    link.setAttribute('href', url)
    link.setAttribute('download', `clients_axe_capital_${date}.csv`)
    link.style.visibility = 'hidden'
    
    document.body.appendChild(link)
    link.click()
    document.body.removeChild(link)

    console.log('Export CSV réussi')
  } catch (error) {
    console.error('Erreur lors de l\'export CSV:', error)
    alert('Erreur lors de l\'exportation des données')
  }
}

const deleteClient = (clientId, clientName) => {
  console.log('Tentative de suppression du client:', clientId, clientName)
  
  clientToDelete.value = { id: clientId, name: clientName }
  showDeleteModal.value = true
}

const confirmDelete = async () => {
  if (!clientToDelete.value) return
  
  console.log('Début de la suppression dans la base de données...')
  
  try {
    const { error } = await supabase
      .from('clients')
      .delete()
      .eq('id', clientToDelete.value.id)

    console.log('Résultat de la suppression:', { error })

    if (error) {
      console.error('Erreur lors de la suppression du client:', error)
      alert('Erreur lors de la suppression du compte: ' + error.message)
      return
    }

    console.log('Client supprimé avec succès, rechargement des données...')
    
    // Recharger les données du dashboard
    await loadDashboardData()
    alert('Compte utilisateur supprimé avec succès')
    
    // Fermer la modal
    showDeleteModal.value = false
    clientToDelete.value = null
  } catch (error) {
    console.error('Erreur lors de la suppression du client:', error)
    alert('Erreur lors de la suppression du compte: ' + error.message)
  }
}

const cancelDelete = () => {
  console.log('Suppression annulée par l\'utilisateur')
  showDeleteModal.value = false
  clientToDelete.value = null
}

const exportToPDF = async () => {
  try {
    // Charger tous les clients
    const { data: allClients, error } = await supabase
      .from('clients')
      .select('*')
      .order('created_at', { ascending: false })

    if (error) {
      console.error('Erreur lors du chargement des clients pour export:', error)
      alert('Erreur lors de l\'exportation des données')
      return
    }

    // Créer le contenu HTML pour le PDF
    const htmlContent = `
      <!DOCTYPE html>
      <html>
      <head>
        <meta charset="utf-8">
        <title>Liste des Clients - AXE CAPITAL</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 20px; }
          h1 { color: #1a56db; text-align: center; }
          table { width: 100%; border-collapse: collapse; margin-top: 20px; }
          th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
          th { background-color: #f2f2f2; font-weight: bold; }
          tr:nth-child(even) { background-color: #f9f9f9; }
          .header-info { text-align: center; margin-bottom: 30px; }
          .footer { margin-top: 30px; text-align: center; font-size: 12px; color: #666; }
        </style>
      </head>
      <body>
        <div class="header-info">
          <h1>AXE CAPITAL</h1>
          <h2>Liste des Clients</h2>
          <p>Généré le ${new Date().toLocaleDateString('fr-FR')}</p>
        </div>
        
        <table>
          <thead>
            <tr>
              <th>Nom</th>
              <th>Prénom</th>
              <th>Date de naissance</th>
              <th>Lieu de naissance</th>
              <th>Sexe</th>
              <th>Téléphone</th>
              <th>Pays</th>
              <th>Ville</th>
              <th>Quartier</th>
              <th>Numéro CNI</th>
              <th>Contact d'urgence</th>
              <th>Téléphone d'urgence</th>
              <th>Statut</th>
            </tr>
          </thead>
          <tbody>
            ${allClients.map(client => `
              <tr>
                <td>${client.nom || ''}</td>
                <td>${client.prenom || ''}</td>
                <td>${client.date_naissance || ''}</td>
                <td>${client.lieu_naissance || ''}</td>
                <td>${client.sexe === 'M' ? 'Masculin' : 'Féminin'}</td>
                <td>${client.telephone || ''}</td>
                <td>${client.pays || ''}</td>
                <td>${client.ville || ''}</td>
                <td>${client.quartier || ''}</td>
                <td>${client.numero_cni || ''}</td>
                <td>${client.contact_urgence_nom || ''}</td>
                <td>${client.telephone_urgence || ''}</td>
                <td>${client.statut === 'approuve' ? 'Approuvé' : client.statut === 'en_attente' ? 'En attente' : 'Inactif'}</td>
              </tr>
            `).join('')}
          </tbody>
        </table>
        
        <div class="footer">
          <p>AXE CAPITAL - Service Financier Camerounais</p>
          <p>Total: ${allClients.length} client(s)</p>
        </div>
      </body>
      </html>
    `

    // Créer une nouvelle fenêtre pour imprimer
    const printWindow = window.open('', '_blank')
    printWindow.document.write(htmlContent)
    printWindow.document.close()
    
    // Attendre que le contenu soit chargé puis imprimer
    printWindow.onload = () => {
      setTimeout(() => {
        printWindow.print()
        printWindow.close()
      }, 500)
    }

    console.log('Export PDF initié')
  } catch (error) {
    console.error('Erreur lors de l\'export PDF:', error)
    alert('Erreur lors de l\'exportation des données')
  }
}

onMounted(() => {
  // Récupérer l'utilisateur connecté
  supabase.auth.getUser().then(({ data: { user: currentUser } }) => {
    user.value = currentUser
    if (!currentUser) {
      router.push('/partenaire')
      return
    }
    loadDashboardData()
  })
})
</script>

<style scoped>
@import url('https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=Plus+Jakarta+Sans:ital,wght@0,300;0,400;0,500;0,600;1,300&display=swap');

*, *::before, *::after {
  box-sizing: border-box;
  margin: 0;
  padding: 0;
}

.dashboard {
  min-height: 100vh;
  font-family: 'Plus Jakarta Sans', sans-serif;
  background: #dbeafe;
  color: #1e40af;
}

.logo-img {
  height: 40px;
  width: auto;
  max-width: 200px;
}

.dashboard-header {
  background: white;
  border-bottom: 1px solid #e2e8f0;
  position: sticky;
  top: 0;
  z-index: 100;
}

.header-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 1rem 2rem;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.logo-text {
  font-family: 'Syne', sans-serif;
  font-size: 1.5rem;
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

.header-actions {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.welcome-text {
  color: #6b7280;
  font-size: 0.9rem;
}

.logout-btn {
  padding: 0.5rem 1rem;
  background: #ef4444;
  color: white;
  border: none;
  border-radius: 8px;
  font-size: 0.85rem;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.logout-btn:hover {
  background: #dc2626;
  transform: translateY(-1px);
}

.dashboard-content {
  max-width: 1200px;
  margin: 0 auto;
  padding: 2rem;
}

.content-header {
  margin-bottom: 2rem;
}

.export-section {
  margin-bottom: 2rem;
  text-align: right;
}

.export-buttons {
  display: flex;
  gap: 1rem;
  justify-content: flex-end;
}

.export-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.75rem 1.5rem;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  font-size: 0.9rem;
  cursor: pointer;
  transition: all 0.3s ease;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.export-btn.csv {
  background: #059669;
  color: white;
  box-shadow: 0 4px 12px rgba(5, 150, 105, 0.3);
}

.export-btn.csv:hover {
  background: #047857;
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(5, 150, 105, 0.4);
}

.export-btn.pdf {
  background: #dc2626;
  color: white;
  box-shadow: 0 4px 12px rgba(220, 38, 38, 0.3);
}

.export-btn.pdf:hover {
  background: #b91c1c;
  transform: translateY(-1px);
  box-shadow: 0 6px 16px rgba(220, 38, 38, 0.4);
}

.export-btn:active {
  transform: translateY(0);
}

.page-title {
  font-family: 'Syne', sans-serif;
  font-size: 2rem;
  font-weight: 700;
  color: #0f172a;
  margin-bottom: 0.5rem;
  letter-spacing: -0.02em;
}

.page-subtitle {
  color: #6b7280;
  font-size: 1rem;
  font-weight: 300;
}

.stats-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 1.5rem;
  margin-bottom: 2rem;
}

.stat-card {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
  display: flex;
  align-items: center;
  gap: 1rem;
  transition: all 0.3s ease;
}

.stat-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
}

.stat-icon {
  font-size: 2rem;
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #eff6ff;
  border-radius: 12px;
}

.stat-content {
  flex: 1;
}

.stat-number {
  font-family: 'Syne', sans-serif;
  font-size: 1.8rem;
  font-weight: 800;
  color: #0f172a;
  margin-bottom: 0.25rem;
}

.stat-label {
  color: #6b7280;
  font-size: 0.85rem;
  font-weight: 500;
}

.dashboard-grid {
  display: grid;
  grid-template-columns: 2fr 1fr;
  gap: 2rem;
}

.dashboard-section {
  background: white;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
}

.section-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.2rem;
  font-weight: 700;
  color: #0f172a;
  margin-bottom: 1.5rem;
  letter-spacing: -0.02em;
}

.clients-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.client-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
  background: #f8fafc;
  border-radius: 8px;
  transition: all 0.3s ease;
}

.client-item:hover {
  background: #f1f5f9;
}

.client-info {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.client-avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: #3b82f6;
  color: white;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 600;
  font-size: 0.9rem;
}

.client-details {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.client-name {
  font-weight: 600;
  color: #0f172a;
  font-size: 0.95rem;
}

.client-email {
  color: #6b7280;
  font-size: 0.85rem;
}

.client-actions {
  display: flex;
  gap: 0.5rem;
  align-items: center;
}

.view-profile-btn {
  background: #3b82f6;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 6px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.view-profile-btn:hover {
  background: #2563eb;
  transform: translateY(-1px);
}

.delete-btn {
  background: #ef4444;
  color: white;
  border: none;
  padding: 0.5rem 1rem;
  border-radius: 6px;
  font-size: 0.8rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.delete-btn:hover {
  background: #dc2626;
  transform: translateY(-1px);
}

/* Charts Section */
.charts-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 1.5rem;
  margin-top: 1.5rem;
}

.chart-card {
  background: white;
  border: 1px solid #e2e8f0;
  border-radius: 12px;
  padding: 1.5rem;
  box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
}

.chart-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.1rem;
  font-weight: 600;
  color: #0f172a;
  margin-bottom: 1rem;
}

.chart-container {
  height: 200px;
  position: relative;
}

/* Simple Charts Styles */
.simple-chart {
  padding: 1rem 0;
}

.donut-chart {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-bottom: 1.5rem;
  position: relative;
}

.donut-svg {
  width: 120px;
  height: 120px;
  transform: rotate(-90deg);
}

.donut-segment {
  transition: stroke-dasharray 0.5s ease, stroke-dashoffset 0.5s ease;
}

.donut-center {
  position: absolute;
  top: 60px;
  left: 50%;
  transform: translateX(-50%);
  text-align: center;
  pointer-events: none;
}

.donut-value {
  font-size: 1.5rem;
  font-weight: 700;
  color: #0f172a;
  line-height: 1;
}

.donut-label {
  font-size: 0.8rem;
  color: #6b7280;
  margin-top: 0.25rem;
}

.chart-legend {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.legend-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.5rem;
  background: #f8fafc;
  border-radius: 8px;
}

.legend-color {
  width: 16px;
  height: 16px;
  border-radius: 4px;
  flex-shrink: 0;
}

.legend-text {
  flex: 1;
  font-weight: 600;
  color: #374151;
  font-size: 0.9rem;
}

.legend-value {
  font-weight: 700;
  color: #0f172a;
  font-size: 0.9rem;
  background: #e2e8f0;
  padding: 0.25rem 0.5rem;
  border-radius: 4px;
}

/* Bar Chart Styles */
.bar-chart {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.bar-item {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.bar-label {
  font-size: 0.8rem;
  color: #6b7280;
  min-width: 80px;
  flex-shrink: 0;
}

.bar-container {
  flex: 1;
  height: 20px;
  background: #f1f5f9;
  border-radius: 10px;
  overflow: hidden;
  position: relative;
}

.bar-fill {
  height: 100%;
  background: linear-gradient(90deg, #3b82f6, #60a5fa);
  border-radius: 10px;
  transition: width 0.5s ease;
  min-width: 4px;
}

.bar-value {
  font-weight: 600;
  color: #0f172a;
  font-size: 0.8rem;
  min-width: 20px;
  text-align: right;
}

.chart-placeholder {
  height: 200px;
  background: #f8fafc;
  border: 2px dashed #cbd5e1;
  border-radius: 8px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 1.2rem;
  color: #64748b;
}

/* Modal Styles */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  align-items: center;
  justify-content: center;
  z-index: 1000;
}

.modal-content {
  background: white;
  border-radius: 16px;
  width: 90%;
  max-width: 800px;
  max-height: 90vh;
  overflow-y: auto;
  box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
}

.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem;
  border-bottom: 1px solid #e2e8f0;
}

.modal-title {
  font-family: 'Syne', sans-serif;
  font-size: 1.5rem;
  font-weight: 700;
  color: #0f172a;
}

.modal-close {
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
  color: #93c5fd;
  padding: 0.5rem;
  border-radius: 50%;
  transition: all 0.3s ease;
}

.modal-close:hover {
  background: #f3f4f6;
  color: #0f172a;
}

/* Modal de suppression */
.delete-modal {
  max-width: 500px;
}

.delete-warning {
  text-align: center;
  padding: 2rem 0;
}

.warning-icon {
  font-size: 3rem;
  margin-bottom: 1rem;
}

.warning-text {
  font-size: 1.1rem;
  color: #0f172a;
  margin-bottom: 0.5rem;
  line-height: 1.5;
}

.warning-subtext {
  color: #6b7280;
  font-size: 0.9rem;
  line-height: 1.4;
}

.modal-actions {
  display: flex;
  gap: 1rem;
  justify-content: center;
  margin-top: 2rem;
}

.cancel-btn {
  padding: 0.75rem 2rem;
  background: #f3f4f6;
  color: #374151;
  border: 1px solid #d1d5db;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.cancel-btn:hover {
  background: #e5e7eb;
  transform: translateY(-1px);
}

.confirm-delete-btn {
  padding: 0.75rem 2rem;
  background: #dc2626;
  color: white;
  border: none;
  border-radius: 8px;
  font-weight: 600;
  cursor: pointer;
  transition: all 0.3s ease;
}

.confirm-delete-btn:hover {
  background: #b91c1c;
  transform: translateY(-1px);
}

.modal-body {
  padding: 1.5rem;
}

.profile-photo-section {
  text-align: center;
  margin-bottom: 2rem;
}

.photo-container {
  display: inline-block;
}

.profile-photo {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  object-fit: cover;
  border: 4px solid #e2e8f0;
}

.photo-placeholder {
  width: 150px;
  height: 150px;
  border-radius: 50%;
  background: #f8fafc;
  border: 4px solid #e2e8f0;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: 0.5rem;
}

.photo-icon {
  font-size: 3rem;
  color: #cbd5e1;
}

.photo-text {
  color: #64748b;
  font-size: 0.9rem;
}

.profile-info {
  margin-top: 1rem;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 1rem;
}

.info-item {
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.info-item label {
  font-weight: 600;
  color: #374151;
  font-size: 0.9rem;
}

.info-item span {
  color: #0f172a;
  font-size: 0.95rem;
}

.status-badge {
  padding: 0.25rem 0.75rem;
  border-radius: 100px;
  font-size: 0.75rem;
  font-weight: 600;
  text-transform: uppercase;
}

.status-badge.active {
  background: #dcfce7;
  color: #15803d;
}

.status-badge.pending {
  background: #fef3c7;
  color: #b45309;
}

.status-badge.inactive {
  background: #f1f5f9;
  color: #64748b;
}

.actions-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1rem;
}

.action-btn {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.5rem;
  padding: 1.5rem;
  background: #f8fafc;
  border: 2px solid #e2e8f0;
  border-radius: 12px;
  cursor: pointer;
  transition: all 0.3s ease;
  text-decoration: none;
  color: inherit;
}

.action-btn:hover {
  background: #eff6ff;
  border-color: #3b82f6;
  transform: translateY(-2px);
}

.action-icon {
  font-size: 1.5rem;
}

.action-text {
  font-weight: 600;
  color: #0f172a;
  font-size: 0.85rem;
}

/* Responsive */
@media (max-width: 1024px) {
  .dashboard-grid {
    grid-template-columns: 1fr;
  }
  
  .stats-grid {
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
  }
}

@media (max-width: 768px) {
  .dashboard-content {
    padding: 1rem;
  }
  
  .header-content {
    padding: 1rem;
  }
  
  .header-actions {
    gap: 1rem;
  }
  
  .welcome-text {
    display: none;
  }
  
  .stats-grid {
    grid-template-columns: 1fr;
  }
  
  .actions-grid {
    grid-template-columns: 1fr;
  }
}
</style>
