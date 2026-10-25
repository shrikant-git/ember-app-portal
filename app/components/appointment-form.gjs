import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { service } from '@ember/service';
import { on } from '@ember/modifier';

export default class AppointmentFormComponent extends Component {
  @service appointmentService;
  @service router;

  @tracked patient = '';
  @tracked serviceName = '';
  @tracked date = '';
  @tracked errors = {};
  @tracked submissionError = '';
  @tracked isSubmitting = false;
  @tracked submissionSuccess = '';

  constructor(owner, args) {
    super(owner, args);

    const appointment = args.appointment;

    if (appointment) {
      this.patient = appointment.patient;
      this.serviceName = appointment.service;
      this.date = appointment.date;
    }
  }

  @action
  updatePatient(event) {
    this.patient = event.target.value;
  }

  @action
  updateService(event) {
    this.serviceName = event.target.value;
  }

  @action
  updateDate(event) {
    this.date = event.target.value;
  }

  @action
  async handleSubmit(event) {
    event.preventDefault();

    if (this.isSubmitting) {
      return;
    }

    const errors = {};

    if (!this.patient.trim()) {
      errors.patient = 'Patient name is required.';
    }

    if (!this.serviceName.trim()) {
      errors.service = 'Service is required.';
    }

    if (!this.date) {
      errors.date = 'Appointment date is required.';
    }

    this.errors = errors;
    this.submissionError = '';
    this.submissionSuccess = '';

    if (Object.keys(errors).length > 0) {
      return;
    }

    this.isSubmitting = true;

    try {
      const attributes = {
        patient: this.patient.trim(),
        service: this.serviceName.trim(),
        date: this.date,
      };

      let appointment;

      if (this.args.appointment) {
        appointment = await this.appointmentService.update(
          this.args.appointment.id,
          attributes,
        );
      } else {
        appointment = await this.appointmentService.create({
          ...attributes,
          status: 'Upcoming',
        });
      }

      if (!appointment) {
        this.submissionError = 'Appointment could not be found.';
        return;
      }

      this.submissionSuccess = 'Appointment saved successfully.';
      this.router.transitionTo('appointment', appointment.id);
    } catch (error) {
      this.submissionError =
        'Unable to save the appointment. Please try again.';
      console.error('Appointment save failed:', error);
    } finally {
      this.isSubmitting = false;
    }
  }

  <template>
    <main>
      <h1>Create Appointment</h1>

      <form {{on "submit" this.handleSubmit}} novalidate>
        <div>
          <label for="patient">Patient name</label>
          <input
            id="patient"
            type="text"
            value={{this.patient}}
            {{on "input" this.updatePatient}}
            aria-invalid={{if this.errors.patient "true" "false"}}
            aria-describedby="patient-error"
          />
          {{#if this.errors.patient}}
            <p id="patient-error" role="alert">{{this.errors.patient}}</p>
          {{/if}}
        </div>

        <div>
          <label for="service">Service</label>
          <input
            id="service"
            type="text"
            value={{this.serviceName}}
            {{on "input" this.updateService}}
            aria-invalid={{if this.errors.service "true" "false"}}
            aria-describedby="service-error"
          />
          {{#if this.errors.service}}
            <p id="service-error" role="alert">{{this.errors.service}}</p>
          {{/if}}
        </div>

        <div>
          <label for="date">Appointment date</label>
          <input
            id="date"
            type="date"
            value={{this.date}}
            {{on "input" this.updateDate}}
            aria-describedby="date-error"
          />
          {{#if this.errors.date}}
            <p id="date-error" role="alert">{{this.errors.date}}</p>
          {{/if}}
        </div>

        {{#if this.submissionError}}
          <p role="alert">{{this.submissionError}}</p>
        {{/if}}

        {{#if this.submissionSuccess}}
          <p role="status">{{this.submissionSuccess}}</p>
        {{/if}}

        <button type="submit" disabled={{this.isSubmitting}}>
          {{if this.isSubmitting "Saving..." "Save appointment"}}
        </button>
      </form>
    </main>
  </template>
}
