import Component from '@glimmer/component';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { on } from '@ember/modifier';

export default class AppointmentSummaryComponent extends Component {
  @tracked upcoming = 8;

  // Notice two things:
  // 1. get completed() defines a getter, so we access it as this.completed, not this.completed().
  // 2. completed is calculated from existing values. We don't maintain a separate completed variable.
  // In React terms, this is similar to calculating a derived value during rendering rather than adding unnecessary state.

  // Imp:
  // a getter does not automatically make its dependencies reactive. The properties it reads must participate in Ember's reactivity system.
  // i.e. this.args.total and this.upcoming
  get completed() {
    return this.args.total - this.upcoming;
  }

  @action
  markOneCompleted() {
    if (this.upcoming > 0) {
      this.upcoming--;
    }
  }

  <template>
    <section>
      <h2>Appointment Summary</h2>

      <p>Total appointments: {{@total}}</p>
      <p>Upcoming appointments: {{this.upcoming}}</p>
      <p>Completed appointments: {{this.completed}}</p>

      <button type="button" {{on "click" this.markOneCompleted}}>
        Mark one completed
      </button>
    </section>
  </template>
}
