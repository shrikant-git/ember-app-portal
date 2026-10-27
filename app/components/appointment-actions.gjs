import Component from '@glimmer/component';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { on } from '@ember/modifier';

export default class AppointmentActionsComponent extends Component {
  @service appointmentService;
  @service router;
  @service session;

  @tracked isCancelling = false;
  @tracked cancelError = '';

  get isCancelled() {
    return this.args.appointment?.status === 'Cancelled';
  }

  @action
  async cancelAppointment() {
    const appointment = this.args.appointment;

    if (!appointment || this.isCancelled || this.isCancelling) {
      return;
    }

    this.isCancelling = true;
    this.cancelError = '';

    try {
      const updated = await this.appointmentService.cancel(appointment.id);

      if (!updated) {
        this.cancelError = 'Appointment could not be found.';
        return;
      }

      await this.router.transitionTo('appointments', {
        queryParams: { status: 'All' },
      });
    } catch (error) {
      this.cancelError = 'Unable to cancel the appointment. Please try again.';
      console.error('Appointment cancellation failed:', error);
    } finally {
      this.isCancelling = false;
    }
  }

  <template>
    <section aria-label="Appointment actions">

      {{#if this.isCancelled}}
        <p role="status">This appointment has been cancelled.</p>
      {{else if this.session.canManageAppointments}}
        <button
          type="button"
          disabled={{this.isCancelling}}
          {{on "click" this.cancelAppointment}}
        >
          {{if this.isCancelling "Cancelling..." "Cancel appointment"}}
        </button>
      {{else}}
        <p>You have read-only access to appointments.</p>
      {{/if}}

      {{#if this.cancelError}}
        <p role="alert">{{this.cancelError}}</p>
      {{/if}}

    </section>
  </template>
}
