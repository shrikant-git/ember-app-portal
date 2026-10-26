import { module, test } from 'qunit';
import { setupTest } from 'appointment-operations-portal/tests/helpers';

module('Unit | Service | appointment-service', function (hooks) {
  setupTest(hooks);

  hooks.beforeEach(function () {
    this.service = this.owner.lookup('service:appointment-service');

    // Isolate each test from the initial fixture data.
    this.originalAppointments = this.service.appointments;
  });

  hooks.afterEach(function () {
    this.service.appointments = this.originalAppointments;
  });

  test('getAll returns the appointment collection', function (assert) {
    const appointments = this.service.getAll();

    assert.strictEqual(appointments, this.service.appointments);
    assert.ok(appointments.length > 0, 'Initial appointment data is available');
  });

  test('getById finds an appointment by ID', function (assert) {
    const firstAppointment = this.service.getAll()[0];

    assert.strictEqual(
      this.service.getById(firstAppointment.id),
      firstAppointment,
    );
  });

  test('getById returns null for an unknown ID', function (assert) {
    assert.strictEqual(this.service.getById('missing-id'), null);
  });

  test('update returns null for an unknown appointment', async function (assert) {
    const result = await this.service.update(-999, {
      status: 'Completed',
    });

    assert.strictEqual(result, null);
  });

  test('create rejects with field-level validation errors', async function (assert) {
    try {
      await this.service.create({
        patient: 'server reject',
        service: 'Consultation',
        date: '2026-11-02',
        status: 'Upcoming',
      });

      assert.ok(false, 'Expected server validation to reject the request');
    } catch (error) {
      assert.strictEqual(error.status, 400);
      assert.deepEqual(error.errors, {
        patient: ['The server rejected this patient name.'],
      });
    }
  });
});
