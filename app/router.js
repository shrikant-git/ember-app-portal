import EmberRouter from '@embroider/router';
import config from 'appointment-operations-portal/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

// Router.map() connects a URL pattern to a route definition.
// Ember's conventional route structure associates that route with its route class and template.
// appointments is the route name not the URL itself. Ember resolves it to /appointments.
// Router.map(function () {
//   this.route('appointments');
// });

Router.map(function () {
  this.route('appointments');

  this.route('new-appointment', {
    path: '/appointments/new',
  });

  this.route('appointment-edit', {
    path: '/appointments/:appointment_id/edit',
  });

  this.route('appointment', {
    path: '/appointments/:appointment_id',
  });

  this.route('login');
});
