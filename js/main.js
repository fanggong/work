document.addEventListener('DOMContentLoaded', () => {

    var destination = new Date('2021-10-05 00:00:00').getTime() / 1000;
    // var destination = new Date().getTime() / 1000

    new FlipDown(destination, 'wedding', {theme: 'light'}).start();
      
  });