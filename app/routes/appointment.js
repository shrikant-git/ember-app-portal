// import Route from '@ember/routing/route';

// import { appointments } from '../data/appointments';

// export default class AppointmentRoute extends Route {
//   async model(params) {
//     const appointment = appointments.find(
//       (item) => String(item.id) === params.appointment_id,
//     );

//     // Simulate an asynchronous data source for learning.
//     await Promise.resolve();

//     return appointment;
//   }
// }

// import Route from '@ember/routing/route';
import { service } from '@ember/service';

import AuthenticatedRoute from './authenticated';

export default class AppointmentsRoute extends AuthenticatedRoute {
  @service appointmentService;

  model(params) {
    const appointment = this.appointmentService.getById(params.appointment_id);

    if (!appointment) {
      throw new Error(`Appointment ${params.appointment_id} was not found`);
    }

    return appointment;
  }
}

// import Route from '@ember/routing/route';
// import { fetchPost } from '../data/api';
// export default class AppointmentRoute extends Route {
//   beforeModel() {
//     console.log('1. beforeModel: starting transition');
//   }

//   async model(params) {
//     console.log('2. model: fetching record', params.appointment_id);

//     const record = await fetchPost(params.appointment_id);

//     console.log('3. model: record fetched', record.id);
//     return record;
//   }

//   afterModel(model) {
//     console.log('4. afterModel: resolved record', model.id);
//   }
// }

// import Route from '@ember/routing/route';
// import { appointments } from '../data/appointments';

// // In Ember, the normal sequence for a route whose model is being resolved is:
// // 1. beforeModel() — runs before the route's model is resolved.
// // 2. model(params) — obtains the route's data, often asynchronously.
// // 3. afterModel(resolvedModel) — runs after the model resolves. afterModel() does not run for the failed transition.

// export default class AppointmentRoute extends Route {
//   // Route lifecycle: beforeModel(), model(), afterModel() demonstration
//   beforeModel() {
//     console.log('1. beforeModel');
//   }

//   model(params) {
//     console.log('2. model:', params.appointment_id);

//     return appointments.find(
//       (appointment) =>
//         String(appointment.id) === params.appointment_id,
//     );
//   }

//   afterModel(appointment) {
//     console.log('3. afterModel:', appointment?.patient);
//   }
// }
