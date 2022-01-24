<template>
  <div class="order__avatar-container">
    <img
      v-show="photoSrc && imageIsLoaded"
      :src="photoSrc"
      :class="photoClass"
      alt="Фото продавца"
      @load="imageIsLoaded = true"
    />

    <img
      v-show="!photoSrc || !imageIsLoaded"
      src="/images/default_avatar.png"
      :class="photoClass"
      alt="Фото продавца"
    />
  </div>
</template>

<script>
export default {
  props: {
    photoSrc: {
      type: String,
      default: "",
    },
    photoClass: {
      type: String,
      default: "",
    },
  },
  data() {
    return {
      imageIsLoaded: false,
    };
  },
};
</script>

<style>
</style>