import { module, test } from 'qunit';
import { tracked } from '@glimmer/tracking';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { fillIn, render, select } from '@ember/test-helpers';
import AppointmentsPage from 'appointment-operations-portal/components/appointments-page';

class AppointmentFilters {
  @tracked searchQuery = '';
  @tracked selectedStatus = 'All';

  onSearchChange = (value) => {
    this.searchQuery = value;
  };

  onStatusChange = (value) => {
    this.selectedStatus = value;
  };
}

module('Integration | Component | appointments-page', function (hooks) {
  setupRenderingTest(hooks);

  hooks.beforeEach(function () {
    this.appointmentService = this.owner.lookup('service:appointment-service');
    this.session = this.owner.lookup('service:session');

    this.originalAppointments = this.appointmentService.appointments;

    this.appointmentService.appointments = [
      {
        id: 101,
        patient: 'Aarav Sharma',
        service: 'General Consultation',
        date: '2026-11-02',
        status: 'Upcoming',
      },
      {
        id: 102,
        patient: 'Priya Patel',
        service: 'Dental Checkup',
        date: '2026-11-03',
        status: 'Upcoming',
      },
      {
        id: 103,
        patient: 'Rohan Deshmukh',
        service: 'Follow-up',
        date: '2026-11-04',
        status: 'Completed',
      },
    ];

    this.filters = new AppointmentFilters();
  });

  hooks.afterEach(function () {
    this.appointmentService.appointments = this.originalAppointments;
    this.session.logout();
  });

  async function renderPage(context) {
    await render(
      <template>
        <AppointmentsPage
          @searchQuery={{context.filters.searchQuery}}
          @selectedStatus={{context.filters.selectedStatus}}
          @onSearchChange={{context.filters.onSearchChange}}
          @onStatusChange={{context.filters.onStatusChange}}
        />
      </template>,
    );
  }

  test('renders the page, filters, and all appointments', async function (assert) {
    await renderPage(this);

    assert.dom('h1').hasText('Appointments');
    assert.dom('#appointment-search').exists();
    assert.dom('#appointment-status').exists();
    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('Showing 3 appointments');

    assert.dom('[aria-label="Appointment list"]').includesText('Aarav Sharma');
    assert.dom('[aria-label="Appointment list"]').includesText('Priya Patel');
    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('Rohan Deshmukh');
  });

  test('filters appointments when the search input changes', async function (assert) {
    await renderPage(this);
    await fillIn('#appointment-search', 'Aarav');

    assert.strictEqual(this.filters.searchQuery, 'Aarav');
    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('Showing 1 appointments');
    assert.dom('[aria-label="Appointment list"]').includesText('Aarav Sharma');
    assert
      .dom('[aria-label="Appointment list"]')
      .doesNotIncludeText('Priya Patel');
  });

  test('filters appointments by status', async function (assert) {
    await renderPage(this);
    await select('#appointment-status', 'Completed');

    assert.strictEqual(this.filters.selectedStatus, 'Completed');
    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('Showing 1 appointments');
    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('Rohan Deshmukh');
    assert
      .dom('[aria-label="Appointment list"]')
      .doesNotIncludeText('Aarav Sharma');
  });

  test('shows an empty state when no appointments match', async function (assert) {
    await renderPage(this);
    await fillIn('#appointment-search', 'No matching patient');

    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('Showing 0 appointments');
    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('No matching appointments found.');
  });

  test('searches by service as well as patient name', async function (assert) {
    await renderPage(this);
    await fillIn('#appointment-search', 'dental');

    assert
      .dom('[aria-label="Appointment list"]')
      .includesText('Showing 1 appointments');
    assert.dom('[aria-label="Appointment list"]').includesText('Priya Patel');
  });

  test('shows the new appointment link to users who can manage appointments', async function (assert) {
    this.session.login('admin@example.com', 'admin');

    await renderPage(this);

    assert.dom('a[href="/appointments/new"]').exists();
  });

  test('does not show the new appointment link to users without management permission', async function (assert) {
    this.session.logout();

    await renderPage(this);

    assert.dom('a[href="/appointments/new"]').doesNotExist();
  });
});
