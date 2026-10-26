import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { click, render } from '@ember/test-helpers';
import AppointmentCard from 'appointment-operations-portal/components/appointment-card';

module('Integration | Component | appointment-card', function (hooks) {
  setupRenderingTest(hooks);

  test('renders appointment details and allows marking an upcoming appointment completed', async function (assert) {
    const appointment = {
      id: 'appointment-1',
      patient: 'Alex Morgan',
      service: 'Consultation',
      date: '2026-11-02',
      status: 'Upcoming',
    };

    let statusChangeArgs;

    this.onStatusChange = (id, status) => {
      statusChangeArgs = { id, status };
    };

    this.appointment = appointment;

    await render(
      <template>
        <AppointmentCard
          @appointment={{this.appointment}}
          @onStatusChange={{this.onStatusChange}}
        />
      </template>,
    );

    assert.dom('article h2').hasText('Alex Morgan');
    assert.dom('article').includesText('Service: Consultation');
    assert.dom('article').includesText('Date: 2026-11-02');
    assert.dom('article').includesText('Status: Upcoming');
    assert.dom('a').hasText('View appointment');
    assert.dom('button').hasText('Mark completed');

    await click('button');

    assert.deepEqual(statusChangeArgs, {
      id: 'appointment-1',
      status: 'Completed',
    });
  });

  test('does not show the mark-completed button for a completed appointment', async function (assert) {
    this.appointment = {
      id: 'appointment-2',
      patient: 'Jamie Lee',
      service: 'Follow-up',
      date: '2026-11-03',
      status: 'Completed',
    };

    this.onStatusChange = () => {
      assert.step('status-change-called');
    };

    await render(
      <template>
        <AppointmentCard
          @appointment={{this.appointment}}
          @onStatusChange={{this.onStatusChange}}
        />
      </template>,
    );

    assert.dom('article h2').hasText('Jamie Lee');
    assert.dom('button').doesNotExist();
    assert.verifySteps([]);
  });
});
