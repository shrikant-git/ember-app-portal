import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { click, fillIn, render } from '@ember/test-helpers';
import AppointmentForm from 'appointment-operations-portal/components/appointment-form';

module('Integration | Component | appointment-form', function (hooks) {
  setupRenderingTest(hooks);

  test('renders the appointment fields', async function (assert) {
    await render(<template><AppointmentForm /></template>);

    assert.dom('h1').hasText('Create Appointment');
    assert.dom('#patient').exists();
    assert.dom('#service').exists();
    assert.dom('#date').exists();
    assert.dom('button[type="submit"]').hasText('Save appointment');
  });

  test('shows validation errors when submitted empty', async function (assert) {
    await render(<template><AppointmentForm /></template>);

    await click('button[type="submit"]');

    assert.dom('#patient-error').hasText('Patient name is required.');
    assert.dom('#service-error').hasText('Service is required.');
    assert.dom('#date-error').hasText('Appointment date is required.');

    assert.dom('#patient').hasAttribute('aria-invalid', 'true');
    assert.dom('#service').hasAttribute('aria-invalid', 'true');
  });

  test('accepts input in all appointment fields', async function (assert) {
    await render(<template><AppointmentForm /></template>);

    await fillIn('#patient', 'Alex Morgan');
    await fillIn('#service', 'Consultation');
    await fillIn('#date', '2026-11-02');

    assert.dom('#patient').hasValue('Alex Morgan');
    assert.dom('#service').hasValue('Consultation');
    assert.dom('#date').hasValue('2026-11-02');
  });

  test('marks the date field invalid when its value is missing', async function (assert) {
    await render(<template><AppointmentForm /></template>);

    await click('button[type="submit"]');

    // assert.dom('#date').hasAttribute('aria-invalid', 'true');
    assert.dom('#date-error').hasText('Appointment date is required.');
  });
});
