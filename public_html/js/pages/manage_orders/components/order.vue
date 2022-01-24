<template>
  <li class="order">
    <div class="order__content">
      <div class="order__order-status" :class="[orderStatusClass]">
        <FailIcon v-if="status === statuses.rejected" class="order__fail" />

        <SuccessIcon
          v-if="status === statuses.accepted"
          class="order__success"
        />

        {{ orderStatusTitle }}
      </div>

      <Avatar
        class="order__avatar-container"
        :photo-src="order.profilepicture"
        photo-class="order__seller-avatar"
      />

      <div class="order__text">
        <h2 class="order__sub-header" :title="order.kwork_title">
          {{ order.kwork_title }}
        </h2>

        <p class="order__seller-status">Покупатель онлайн</p>

        <button
          class="order__send-button"
          @click="notify('Сообщение отправлено')"
        >
          Отправить сообщение
        </button>
      </div>
    </div>

    <button
      v-if="!emptyTrackHistory"
      class="order__expand-button"
      :class="[isExpanded && 'order__expand-button_active']"
      @click="isExpanded = !isExpanded"
    >
      <img
        class="order__expand-image"
        src="/images/curved-arrow.svg"
        alt="Изогнутая стрелка"
      />
    </button>

    <transition name="content-expand" mode="out-in">
      <OrderInfo v-show="isExpanded" :order="order" />
    </transition>
  </li>
</template>

<script>
import OrderInfo from "./order-info";
import Avatar from "./avatar";
import FailIcon from "../icons/fail";
import SuccessIcon from "../icons/success";

export default {
  components: { OrderInfo, Avatar, FailIcon, SuccessIcon },
  provide() {
    return {
      notify: this.notify,
      status: this.status,
      statuses: this.statuses,
    };
  },
  props: {
    order: {
      type: Object,
      required: true,
    },
  },
  data() {
    return {
      isExpanded: false,
      imageIsLoaded: false,
    };
  },
  computed: {
    status() {
      if (this.order.status) {
        const status = parseInt(this.order.status, 10);

        return status;
      }

      return 0;
    },
    statuses() {
      return {
        notStarted: 1,
        inWork: 2,
        rejected: 3,
        checking: 4,
        accepted: 5,
      };
    },
    emptyTrackHistory() {
      const { trackHistory } = this.order;

      return trackHistory && trackHistory.length === 0;
    },
    orderStatusClass() {
      const statusClasses = {
        1: "order__order-status_not-started",
        2: "order__order-status_in-work",
        3: "order__order-status_canceling",
        4: "order__order-status_checking",
        5: "order__order-status_finished",
      };
      const { status } = this.order;

      if (status) {
        return statusClasses[status];
      }

      return "";
    },
    orderStatusTitle() {
      const { status } = this.order;

      switch (status) {
        case "1":
          return "Не начат";
        case "2":
          return "Взят в работу";
        case "3":
          return "Отменён";
        case "4":
          return "Сдан на проверку";
        case "5":
          return "Выполнен";
        default:
          return "";
      }
    },
  },
  mounted() {
    const { inWork, checking } = this.statuses;

    this.isExpanded = [inWork, checking].includes(this.status);
  },
  methods: {
    notify(message) {
      alert(message);
    },
  },
};
</script>

<style lang="scss" scoped>
.order {
  --avatar-height: 72px;
  --avatar-width: 72px;

  background-color: var(--sub-background-color);
  position: relative;
  margin-bottom: 20px;
  width: 100%;
}

.order__content {
  height: 112px;
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

::v-deep {
  .order__success,
  .order__fail {
    bottom: 0;
    position: absolute;
    top: 0;
    margin: auto 0;
  }

  .order__success {
    left: 6px;
    stroke: var(--active-color);
    width: 12px;
  }
}

.order__fail {
  left: 8px;
  stroke: var(--error-color);
  width: 6px;
}

.order__order-status_not-started {
  background-color: var(--passive-background-color);
  color: var(--passive-color);
}

.order__order-status_in-work {
  background-color: var(--active-background-color);
  color: var(--active-color);
}

.order__order-status_checking {
  background-color: var(--warning-background-color);
  color: var(--warning-color);
}

.order__order-status_canceling {
  background-color: var(--error-background-color);
  color: var(--error-color);
  padding-left: 19px;
}

.order__order-status_finished {
  background-color: var(--active-background-color);
  color: var(--active-color);
  padding-left: 22px;
}

.order__avatar-container,
::v-deep .order__seller-avatar,
.order__seller-initials {
  border-radius: 50%;
  height: var(--avatar-height);
  width: var(--avatar-width);
  max-height: var(--avatar-height);
  max-width: var(--avatar-width);
}

.order__avatar-container {
  display: inline-block;
  padding: 0 13px 0 8px;
  position: relative;
}

::v-deep .order__seller-avatar {
  margin: 12px 0 8px;
}

.order__seller-initials {
  background-color: var(--main-background-color);
  position: absolute;
  margin: auto;
  left: 50%;
  line-height: var(--avatar-height);
  top: 50%;
  transform: translate(-50%, -50%);
  text-align: center;
  vertical-align: middle;
}

.order__text {
  display: inline-block;
  height: 100%;
  max-width: calc(100% - (var(--avatar-width) + 40px));
  vertical-align: top;
  white-space: nowrap;
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
  .order__expand-image {
    transform: rotate(180deg);
    transition: all 0.6s ease-in-out;
  }
}

@media screen and (min-width: 1024px) {
  .order {
    border-radius: 8px;
  }

  .order__order-status {
    border-radius: 20px 0 0 20px;
    border: none;
    top: 16px;
  }

  .order__content {
    height: 128px;
  }

  .order__expand-button {
    right: 32px;
    bottom: 24px;
  }
}
</style>
