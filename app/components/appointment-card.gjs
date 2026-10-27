import Component from '@glimmer/component';
import { action } from '@ember/object';
import { on } from '@ember/modifier';
import { LinkTo } from '@ember/routing';

export default class AppointmentCardComponent extends Component {
  get isUpcoming() {
    return this.args.appointment.status === 'Upcoming';
  }

  @action
  markCompleted() {
    this.args.onStatusChange(this.args.appointment.id, 'Completed');
  }

  <template>
    <article>
      <h2>{{@appointment.patient}}</h2>
      <LinkTo @route="appointment" @model={{@appointment.id}}>
        View appointment
      </LinkTo>
      <p>Service: {{@appointment.service}}</p>
      <p>Date: {{@appointment.date}}</p>
      <p>Status: {{@appointment.status}}</p>

      {{#if this.isUpcoming}}
        <button type="button" {{on "click" this.markCompleted}}>
          Mark completed
        </button>
      {{/if}}
    </article>
  </template>
}
