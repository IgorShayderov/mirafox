<template>
  <section class="order-info">
    <p
      class="order-info__status order-info__status_active"
      :class="{
        'order-info__status_active-border': isInWork || isRejected,
      }"
    >
      Заказ создан
    </p>

    <div class="order-info__description">
      <h3 class="order-info__description-title">
        Получена информация от покупателя
      </h3>

      <p class="order-info__description-text">
        Покупатель следовал вашим инструкциям. Если отправленной информации
        недостаточно, уточните ее, отправив сообщение покупателю. Если
        информации достаточно, приступайте
      </p>
    </div>

    <template v-if="isRejected">
      <p class="order-info__status order-info__status_error">Заказ отменен</p>

      <div class="order-info__description">
        <h3 class="order-info__description-title">Заказ отменен</h3>

        <p class="order-info__description-text">Произошла отмена заказа</p>
      </div>
    </template>

    <template v-else>
      <p
        class="order-info__status"
        :class="{
          'order-info__status_active': isInWork,
          'order-info__status_active-border': isChecking,
        }"
      >
        Взят в <br />
        работу
      </p>

      <div class="order-info__description">
        <template v-if="isInWork">
          <h3 class="order-info__description-title">
            Вы приступили к работе над заказом
          </h3>

          <p class="order-info__description-text">
            Приложите результат, когда будете готовы
          </p>

          <button
            class="order-info__confirm-button mt10"
            @click="notify('Отправить заказ')"
          >
            Отправить заказ
          </button>
        </template>

        <button
          v-else
          class="order-info__confirm-button"
          @click="notify('Взят в работу')"
        >
          Взять в работу
        </button>
      </div>
    </template>

    <p
      class="order-info__status"
      :class="{
        'order-info__status_active': isChecking,
        'order-info__status_active-border': isAccepted,
      }"
    >
      Сдан на проверку
    </p>

    <div class="order-info__description">
      <h3 v-if="isChecking" class="order-info__description-title">
        Заказ отправлен на проверку
      </h3>
    </div>

    <p
      class="order-info__status"
      :class="{
        'order-info__status_active': isAccepted,
      }"
    >
      Принят
    </p>

    <div class="order-info__description">
      <template v-if="isAccepted">
        <h3 class="order-info__description-title">
          Поздравляем! Работа принята заказчиком!
        </h3>

        <p class="order-info__description-text">
          На выполнение у вас ушло 2 часа 23 минуты, вознаграждение уже
          переведено вам на расчётный счёт
        </p>
      </template>
    </div>

    <p class="order-info__status">Опубликован в портфолио</p>

    <div class="order-info__description">
      <template v-if="isAccepted">
        <h3 class="order-info__description-title">
          Отличная работа, теперь можно опубликовать работу в портфолио
        </h3>

        <button
          class="order-info__confirm-button mt20"
          @click="notify('Опубликовать')"
        >
          Опубликовать
        </button>

        <button
          class="order-info__reject-button"
          @click="notify('Оставить без публикации')"
        >
          Оставить без публикации
        </button>
      </template>
    </div>
  </section>
</template>

<script>
export default {
  inject: ["notify"],
  props: {
    order: {
      type: Object,
      default: () => ({}),
    },
  },
  data() {
    return {
      rejectedStatuses: [3],
    };
  },
  methods: {
    checkMessageExitance(description, messageIndex) {
      const message = this.order.trackHistory[messageIndex];

      if (message === undefined) {
        return false;
      }

      return message.description === description;
    },
  },
  computed: {
    status() {
      if (this.order.status === undefined) {
        return 0;
      }

      const status = parseInt(this.order.status, 10);

      return status;
    },
    isAccepted() {
      return this.status === 5;
    },
    isInWork() {
      const { in_work } = this.order;

      return this.status === 1 && parseInt(in_work, 10) === 1;
    },
    isChecking() {
      return this.status >= 4 && !this.rejectedStatuses.includes(this.status);
    },
    isRejected() {
      return this.rejectedStatuses.includes(this.status);
    },
  },
};
</script>

<style lang="scss" scoped>
.order-info {
  display: grid;
  grid-template-columns: 26% 74%;
  padding-bottom: 42px;
}

.order-info__status {
  border-left: 2px solid var(--inactive-text-color);
  color: var(--inactive-text-color);
  font-weight: 600;
  font-size: 0.625rem;
  line-height: 0.875rem;
  padding: 0 20px 20px 8px;
  position: relative;
  margin-left: 1px;

  &::before,
  &::after {
    background-color: transparent;
    content: "";
    position: absolute;
    left: -2px;
  }

  &::before {
    height: 1px;
    top: calc(0.875rem / 2);
    width: 5px;
    z-index: 10;
  }

  &::after {
    height: calc(0.875rem / 2);
    top: 0;
    width: 2px;
  }

  &:first-of-type,
  &:last-of-type {
    &::after {
      background-color: var(--sub-background-color);
    }
  }

  &:last-of-type {
    &::after {
      top: 0.5rem;
      height: 100%;
    }
  }
}

.order-info__status_active {
  color: var(--active-color);

  &::before {
    background-color: var(--active-color);
  }

  &:first-of-type,
  &:last-of-type {
    &::after {
      color: var(--sub-background-color);
    }
  }

  & ~ &::after {
    background-color: var(--active-color);
    height: calc((0.875rem / 2) + 1px);
  }
}

.order-info__status_active-border {
  border-color: var(--active-color);
}

.order-info__status_error {
  @extend .order-info__status_active;
  color: var(--error-color);

  &::before {
    border-color: var(--error-color);
  }
}

.order-info__description {
  color: var(--info-text-color);
  font-style: normal;
  font-weight: normal;
  font-size: 0.75rem;
  line-height: 1rem;
  padding: 0 0 20px;
}

.order-info__description-title {
  color: var(--info-bold-text-color);
  font-weight: 600;
  font-size: 0.875rem;
  line-height: 1.25rem;
}

.order-info__description-text {
  color: var(--info-text-color);
  font-size: 0.75rem;
  line-height: 1rem;
}

.order-info__confirm-button {
  background-color: var(--sub-btn-background);
  border: none;
  border-radius: 28.75px;
  color: var(--light-text-color);
  display: block;
  font-style: normal;
  font-weight: 600;
  font-size: 0.703125rem;
  line-height: 1.25rem;
  padding: 8px 0;
  width: 190px;
  margin-bottom: 10px;
}

.order-info__reject-button {
  @extend .order-info__confirm-button;
  background-color: var(--sub-background-color);
  color: var(--active-color);
  border: 1px solid var(--active-color);
}
</style>