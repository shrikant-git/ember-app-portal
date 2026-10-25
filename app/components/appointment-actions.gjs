import Component from '@glimmer/component';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { on } from '@ember/modifier';

export default class AppointmentActionsComponent extends Component {
  @service appointmentService;
  @service router;

  @action
  cancelAppointment() {
    const appointment = this.args.appointment;

    if (!appointment || appointment.status === 'Cancelled') {
      return;
    }

    const updated = this.appointmentService.cancel(appointment.id);

    if (!updated) {
      return;
    }

    this.router.transitionTo('appointments', {
      queryParams: { status: 'All' },
    });
  }

  get isCancelled() {
    return this.args.appointment?.status === 'Cancelled';
  }

  <template>
    <section aria-label="Appointment actions">
      {{#if this.isCancelled}}
        <p role="status">This appointment has been cancelled.</p>
      {{else}}
        <button type="button" {{on "click" this.cancelAppointment}}>
          Cancel appointment
        </button>
      {{/if}}
    </section>
  </template>
}
