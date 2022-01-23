<template>
  <main class="orders-list">
    <Order></Order>
  </main>
</template>

<script>
import Order from "./components/order";

export default {
  components: { Order },
  created() {
    console.log("ORDERS-PAGE IS CREATED!");
  },
};
</script>

<style>
.orders-list {
  --background-color: #ffffff;
}
</style>