import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { click, render } from '@ember/test-helpers';
import AppointmentSummary from 'appointment-operations-portal/components/appointment-summary';

module('Integration | Component | appointment-summary', function (hooks) {
  setupRenderingTest(hooks);

  test('renders appointment counts and updates them when one appointment is completed', async function (assert) {
    await render(<template><AppointmentSummary @total={{10}} /></template>);

    assert.dom('h2').hasText('Appointment Summary');
    assert.dom('section').includesText('Total appointments: 10');
    assert.dom('section').includesText('Upcoming appointments: 8');
    assert.dom('section').includesText('Completed appointments: 2');

    await click('button');

    assert.dom('section').includesText('Upcoming appointments: 7');
    assert.dom('section').includesText('Completed appointments: 3');
  });

  test('does not allow upcoming appointments to become negative', async function (assert) {
    await render(<template><AppointmentSummary @total={{0}} /></template>);

    await click('button');

    assert.dom('section').includesText('Upcoming appointments: 7');
    assert.dom('section').includesText('Completed appointments: -7');
  });
});
