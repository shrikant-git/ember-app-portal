import { service } from '@ember/service';

import AuthenticatedRoute from './authenticated';

export default class AppointmentEditRoute extends AuthenticatedRoute {
  @service appointmentService;

  model(params) {
    const appointment = this.appointmentService.getById(params.appointment_id);

    if (!appointment) {
      throw new Error(`Appointment ${params.appointment_id} was not found`);
    }

    return appointment;
  }
}
