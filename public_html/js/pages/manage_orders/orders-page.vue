<template>
  <main class="orders-page">
    <section class="orders-page__container">
      <h1 class="orders-page__header">Заказы</h1>

      <ul class="orders-list">
        <Order v-for="order in adaptedOrders" :key="order.OID" :order="order" />
      </ul>
    </section>
  </main>
</template>

<script>
import Order from "./components/order";

export default {
  components: { Order },
  props: {
    orders: {
      type: Array,
      default: () => [],
    },
  },
  computed: {
    adaptedOrders() {
      return this.orders.map((order) => {
        const adaptedOrder = { ...order };

        if (order.status === "1" && order.in_work === "1") {
          adaptedOrder.status = "2";
        }

        return adaptedOrder;
      });
    },
  },
};
</script>

<style>
.content-expand-enter-active,
.content-expand-leave-active {
  transition: all 0.6s ease-in-out;
}

.content-expand-enter-to,
.content-expand-leave {
  overflow: hidden;
  max-height: 1000px;
  opacity: 1;
}

.content-expand-enter,
.content-expand-leave-to {
  overflow: hidden;
  max-height: 0;
  opacity: 0;
}
</style>

<style lang="scss" scoped>
.orders-page {
  --main-background-color: #e5e5e5;
  --sub-background-color: #ffffff;
  --obtused-background-color: rgba(231, 231, 231, 0.2);

  --main-text-color: #000000;
  --light-text-color: #ffffff;
  --inactive-text-color: #c0c0c0;
  --info-bold-text-color: #111111;
  --info-text-color: #333333;

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

@media screen and (min-width: 1024px) {
  .orders-page {
    display: flex;
    justify-content: center;
  }

  .orders-page__header {
    padding: 6px 0 5px 0;
  }

  .orders-page__container {
    width: 56.85vw;
  }
}
</style>