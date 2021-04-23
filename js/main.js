document.addEventListener('DOMContentLoaded', () => {

    var destination = new Date('Oct 05, 2021 00:00:00').getTime() / 1000;
    // var destination = new Date().getTime() / 1000

    new FlipDown(destination, 'wedding', {theme: 'light'}).start();
      
  });