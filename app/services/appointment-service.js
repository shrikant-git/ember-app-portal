
import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

import { appointments as initialAppointments } from '../data/appointments';

export default class AppointmentService extends Service {
  @tracked appointments = initialAppointments.map((appointment) => ({
    ...appointment,
  }));

  // Read all appointments
  getAll() {
    return this.appointments;
  }

  // Read one appointment by ID
  getById(id) {
    return (
      this.appointments.find(
        (appointment) => String(appointment.id) === String(id),
      ) ?? null
    );
  }

  // Create an appointment
  create(attributes) {
    const nextId =
      this.appointments.reduce(
        (maxId, appointment) => Math.max(maxId, appointment.id),
        0,
      ) + 1;

    const appointment = {
      id: nextId,
      ...attributes,
    };

    this.appointments = [...this.appointments, appointment];

    return appointment;
  }

  // Update an existing appointment
  update(id, changes) {
    const existing = this.getById(id);

    if (!existing) {
      return null;
    }

    const updated = {
      ...existing,
      ...changes,
      id: existing.id,
    };

    this.appointments = this.appointments.map((appointment) =>
      appointment.id === existing.id ? updated : appointment,
    );

    return updated;
  }

  // Cancel an appointment
  cancel(id) {
    return this.update(id, { status: 'Cancelled' });
  }
}
