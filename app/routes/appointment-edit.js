import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class AppointmentEditRoute extends Route {
  @service appointmentService;

  model(params) {
    const appointment = this.appointmentService.getById(
      params.appointment_id,
    );

    if (!appointment) {
      throw new Error(
        `Appointment ${params.appointment_id} was not found`,
      );
    }

    return appointment;
  }
}
