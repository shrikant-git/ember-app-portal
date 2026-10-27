import Component from '@glimmer/component';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';

import AppointmentCard from './appointment-card';
import { service } from '@ember/service';

export default class AppointmentsPageComponent extends Component {
  @service appointmentService;
  @service session;

  get filteredAppointments() {
    const query = (this.args.searchQuery ?? '').trim().toLowerCase();
    const status = this.args.selectedStatus ?? 'All';

    return this.appointmentService.getAll().filter((appointment) => {
      const matchesSearch =
        appointment.patient.toLowerCase().includes(query) ||
        appointment.service.toLowerCase().includes(query);

      const matchesStatus = status === 'All' || appointment.status === status;

      return matchesSearch && matchesStatus;
    });
  }

  @action
  updateSearch(event) {
    this.args.onSearchChange(event.target.value);
  }

  @action
  updateStatus(event) {
    this.args.onStatusChange(event.target.value);
  }

  @action
  updateAppointmentStatus(id, newStatus) {
    this.appointmentService.update(id, { status: newStatus });
  }

  <template>
    <main>
      <h1>Appointments</h1>
      {{#if this.session.canManageAppointments}}
        <LinkTo @route="new-appointment">New appointment</LinkTo>
      {{/if}}
      <p>Search and filter patient appointments.</p>

      <p>Search query: {{@searchQuery}}</p>
      <p>Selected status: {{@selectedStatus}}</p>

      <section aria-label="Appointment filters">
        <label for="appointment-search">Search by patient or service</label>
        <input
          id="appointment-search"
          type="search"
          value={{@searchQuery}}
          {{on "input" this.updateSearch}}
        />

        <label for="appointment-status">Filter by status</label>
        <select
          id="appointment-status"
          value={{@selectedStatus}}
          {{on "change" this.updateStatus}}
        >
          <option value="All">All statuses</option>
          <option value="Upcoming">Upcoming</option>
          <option value="Completed">Completed</option>
        </select>
      </section>

      <section aria-label="Appointment list">
        <p>Showing {{this.filteredAppointments.length}} appointments</p>

        {{#each this.filteredAppointments key="id" as |appointment|}}
          <AppointmentCard
            @appointment={{appointment}}
            @onStatusChange={{this.updateAppointmentStatus}}
          />
        {{else}}
          <p>No matching appointments found.</p>
        {{/each}}
      </section>
    </main>
  </template>
}
