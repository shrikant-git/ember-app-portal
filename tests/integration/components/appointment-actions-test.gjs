import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { render, click } from '@ember/test-helpers';
import AppointmentActions from 'appointment-operations-portal/components/appointment-actions';

module('Integration | Component | appointment-actions', function (hooks) {
  setupRenderingTest(hooks);

  test('shows read-only access message when the user cannot manage appointments', async function (assert) {
    this.appointment = {
      id: 'appointment-1',
      status: 'Upcoming',
    };

    await render(
      <template>
        <AppointmentActions @appointment={{this.appointment}} />
      </template>,
    );

    assert
      .dom('section[aria-label="Appointment actions"]')
      .includesText('You have read-only access to appointments.');

    assert.dom('button').doesNotExist();
  });

  test('shows cancellation status for a cancelled appointment', async function (assert) {
    this.appointment = {
      id: 'appointment-2',
      status: 'Cancelled',
    };

    await render(
      <template>
        <AppointmentActions @appointment={{this.appointment}} />
      </template>,
    );

    assert
      .dom('[role="status"]')
      .hasText('This appointment has been cancelled.');

    assert.dom('button').doesNotExist();
  });

  test('shows an error and restores the button when cancellation fails', async function (assert) {
    const appointmentService = this.owner.lookup('service:appointment-service');

    this.owner.lookup('service:session').login('admin@example.com', 'admin');

    const originalCancel = appointmentService.cancel;

    appointmentService.cancel = async () => {
      throw new Error('Simulated network failure');
    };

    this.appointment = {
      id: 'appointment-1',
      status: 'Upcoming',
    };

    try {
      await render(
        <template>
          <AppointmentActions @appointment={{this.appointment}} />
        </template>,
      );

      await click('button');

      assert
        .dom('[role="alert"]')
        .hasText('Unable to cancel the appointment. Please try again.');

      assert.dom('button').isEnabled();
      assert.dom('button').hasText('Cancel appointment');
    } finally {
      appointmentService.cancel = originalCancel;
    }
  });
});
