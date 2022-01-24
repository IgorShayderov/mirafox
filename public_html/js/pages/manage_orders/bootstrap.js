import OrdersPage from './orders-page';

require('appJs/bootstrap.js');
require('appJs/live-tabs.js');

window.addEventListener('load', () => {
  const { dataStorage } = window;
  let orders = [];

  if (dataStorage) {
    orders = dataStorage.orders;
  }

  new Vue({
    el: '#orders-vue',
    render: h => h(OrdersPage, {
      props: {
        orders
      }
    })
  });

  window.dataStorage = undefined;
});
