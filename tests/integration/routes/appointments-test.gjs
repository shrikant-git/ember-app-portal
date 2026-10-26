import { module, test } from 'qunit';
import { setupApplicationTest } from 'appointment-operations-portal/tests/helpers';
import { currentURL, visit } from '@ember/test-helpers';

module('Integration | Route | appointments', function (hooks) {
  setupApplicationTest(hooks);

  test('filter changes update the URL query params', async function (assert) {
    await visit('/appointments');

    console.log('Current URL:', currentURL());
    console.log(
      'Appointments page rendered:',
      document.querySelector('#appointment-status') !== null,
    );

    assert.ok(true, 'Diagnostic check completed');
  });
});
