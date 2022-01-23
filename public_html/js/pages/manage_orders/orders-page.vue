<template>
  <main class="orders-page">
    <h1 class="orders-page__header">Заказы</h1>

    <ul class="orders-list">
      <Order></Order>
    </ul>
  </main>
</template>

<script>
import Order from "./components/order";

export default {
  components: { Order },
};
</script>

<style lang="scss" scoped>
.orders-page {
  --main-background-color: #e5e5e5;
  --sub-background-color: #ffffff;
  --obtused-background-color: rgba(231, 231, 231, 0.2);

  --main-text-color: #000000;
  --light-text-color: #ffffff;

  --main-btn-background: #689fd9;
  --sub-btn-background: #009900;

  --active-background-color: #d9f0d9;
  --active-color: #009900;
  --passive-background-color: #f0f0f0;
  --passive-color: #4f4f4f;
  --warning-background-color: #fdf7e4;
  --warning-color: #cc933d;
  --error-background-color: #fdeeee;
  --error-color: #eb5757;

  --header-height: 50px;

  background-color: var(--main-background-color);
  color: var(--main-text-color);
  font-family: "Open Sans", sanf-serif;
  min-height: calc(100vh - var(--header-height));
}

.orders-page__header {
  align-items: flex-end;
  display: flex;
  height: calc(90px - 14px);
  font-style: normal;
  font-weight: bold;
  font-size: 2rem;
  line-height: 2.75rem;
  margin: 0;
  padding: 0 0 14px 16px;
  width: 100%;
}

.orders-list {
  list-style: none;
  padding: 0;
  margin: 0;
}
</style>