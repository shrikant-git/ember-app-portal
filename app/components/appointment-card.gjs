import Component from '@glimmer/component';

export default class AppointmentCardComponent extends Component {
  <template>
    <article>
      <h2>{{@appointment.patient}}</h2>
      <p>Service: {{@appointment.service}}</p>
      <p>Date: {{@appointment.date}}</p>
      <p>Status: {{@appointment.status}}</p>
    </article>
  </template>
}
