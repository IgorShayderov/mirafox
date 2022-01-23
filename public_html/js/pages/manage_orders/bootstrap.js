import OrdersPage from './orders-page';

require('appJs/bootstrap.js');
require('appJs/live-tabs.js');
console.log('before doc ready')

window.addEventListener('load', () => {
  new Vue({
    el: '#orders-vue',
    render: h => h(OrdersPage, {})
  });
});
