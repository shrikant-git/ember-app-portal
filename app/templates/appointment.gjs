import Component from '@glimmer/component';
import { service } from '@ember/service';
import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';
import AppointmentActions from '../components/appointment-actions';

export default class AppointmentDetailsComponent extends Component {
  @service session;

  <template>
    {{pageTitle "Appointment Details"}}

    <main>
      <h1>Appointment Details</h1>

      <dl>
        <dt>Appointment ID</dt>
        <dd>{{@model.id}}</dd>

        <dt>Patient</dt>
        <dd>{{@model.patient}}</dd>

        <dt>Service</dt>
        <dd>{{@model.service}}</dd>

        <dt>Date</dt>
        <dd>{{@model.date}}</dd>

        <dt>Status</dt>
        <dd>{{@model.status}}</dd>
      </dl>

      {{#if this.session.canManageAppointments}}
        <LinkTo @route="appointment-edit" @model={{@model.id}}>
          Edit appointment
        </LinkTo>

        <AppointmentActions @appointment={{@model}} />
      {{else}}
        <p>You have read-only access to appointments.</p>
      {{/if}}

      <p>
        <LinkTo @route="appointments">
          Back to appointments
        </LinkTo>
      </p>
    </main>
  </template>
}
