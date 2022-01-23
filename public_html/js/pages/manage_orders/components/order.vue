<template>
  <li class="order">
    <div class="order__order-status order__order-status_not-started">
      Не начат
    </div>

    <div class="order__avatar-container">
      <img class="order__seller-avatar" />

      <span class="order__seller-initials">И.А.</span>
    </div>

    <div class="order__content">
      <h2 class="order__sub-header">Баннер для сайта</h2>

      <p class="order__seller-status">Покупатель онлайн</p>

      <button class="order__send-button">Отправить сообщение</button>
    </div>

    <button class="order__expand-button">
      <img src="/images/curved-arrow.svg" alt="Изогнутая стрелка" />
    </button>
  </li>
</template>

<script>
export default {};
</script>

<style lang="scss" scoped>
.order {
  background-color: var(--sub-background-color);
  height: 112px;
  position: relative;
  margin-bottom: 20px;
  width: 100%;
}

.order__order-status {
  border: 1px solid var(--sub-background-color);
  border-radius: 5px;
  font-weight: 600;
  font-size: 0.625rem;
  line-height: 0.875rem;
  position: absolute;
  right: 0;
  top: -8px;
  padding: 5px 16px 5px 12px;
  z-index: 10;
}

.order__order-status_in-work {
  background-color: var(--active-background-color);
  color: var(--active-color);
}

.order__order-status_not-started {
  background-color: var(--passive-background-color);
  color: var(--passive-color);
}

.order__order-status_checking {
  background-color: var(--warning-background-color);
  color: var(--warning-color);
}

.order__order-status_canceling {
  background-color: var(--error-background-color);
  color: var(--error-color);
}

.order__avatar-container {
  display: inline-block;
  position: relative;
}

.order__seller-avatar {
  border-radius: 50%;
  height: 72px;
  margin: 12px 16px 0 8px;
  width: 72px;
}

.order__seller-initials {
  position: absolute;
  margin: auto;
  left: 50%;
  top: 50%;
  transform: translate(-50%, -50%);
}

.order__content {
  display: inline-block;
  height: 100%;
}

.order__sub-header {
  color: var(--main-text-color);
  margin-top: 15px;
  font-style: normal;
  font-weight: bold;
  font-size: 1.25rem;
  line-height: 1.6875rem;
  vertical-align: top;
  overflow: hidden;
  text-overflow: ellipsis;
}

.order__seller-status {
  color: var(--main-text-color);
  display: inline-block;
  font-size: 0.6875rem;
  line-height: 0.9375rem;
  position: relative;

  &::after {
    content: "";
    display: block;
    background-color: var(--active-color);
    border-radius: 50%;
    position: absolute;
    right: -10px;
    height: 6px;
    width: 6px;
    top: 0;
    bottom: 0;
    margin: auto 0;
  }
}

.order__send-button {
  background: var(--main-btn-background);
  border: none;
  border-radius: 24px;
  color: var(--sub-background-color);
  display: block;
  margin: 5px 0;
  font-style: normal;
  font-weight: 600;
  font-size: 0.625rem;
  line-height: 0.875rem;
  padding: 4px 16px 6px 16px;
}

.order__expand-button {
  background-color: var(--obtused-background-color);
  border: none;
  border-radius: 50%;
  box-shadow: 0px 1px 4px rgba(0, 0, 0, 0.45);
  height: 32px;
  width: 32px;
  position: absolute;
  bottom: 16px;
  right: 16px;
}

.order__expand-button_active {
  transform: rotate(180deg);
}
</style>