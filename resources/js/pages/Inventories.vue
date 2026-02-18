<template>
  <div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">Inventaires</h1>
    <div v-if="canEdit" class="mb-6">
      <button
        @click="showModal = true"
        class="bg-indigo-600 hover:bg-indigo-700 text-white font-bold py-2 px-4 rounded"
      >
        Nouvel inventaire
      </button>
    </div>

    <div class="bg-white rounded-lg shadow p-6">
      <div v-for="inventory in inventories.data" :key="inventory.id" class="mb-4 p-4 border rounded">
        <div class="flex justify-between items-center">
          <div>
            <h3 class="font-bold">{{ inventory.reference }}</h3>
            <p class="text-sm text-gray-600">Date: {{ formatDate(inventory.inventory_date) }}</p>
            <p class="text-sm text-gray-600">Statut: {{ inventory.status }}</p>
          </div>
          <div>
            <router-link :to="`/inventories/${inventory.id}`" class="text-indigo-600 hover:text-indigo-900">
              Voir détails
            </router-link>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { ref, onMounted, computed } from 'vue';
import axios from 'axios';

export default {
  name: 'Inventories',
  setup() {
    const inventories = ref({ data: [] });
    const showModal = ref(false);

    const user = computed(() => {
      const userData = localStorage.getItem('user');
      return userData ? JSON.parse(userData) : null;
    });

    const canEdit = computed(() => {
      return user.value && ['admin', 'gestionnaire'].includes(user.value.role);
    });

    const loadInventories = async () => {
      try {
        const response = await axios.get('/inventories');
        inventories.value = response.data;
      } catch (error) {
        console.error('Erreur lors du chargement des inventaires:', error);
      }
    };

    const formatDate = (date) => {
      return new Date(date).toLocaleDateString('fr-FR');
    };

    onMounted(() => {
      loadInventories();
    });

    return {
      inventories,
      showModal,
      canEdit,
      loadInventories,
      formatDate
    };
  }
}
</script>
