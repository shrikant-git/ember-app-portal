import { module, test } from 'qunit';
import { setupApplicationTest } from 'appointment-operations-portal/tests/helpers';
import { currentURL, fillIn, select, visit } from '@ember/test-helpers';

module('Integration | Route | appointments', function (hooks) {
  setupApplicationTest(hooks);

  test('filter changes update the URL query params', async function (assert) {
    await visit('/appointments');

    await select('#appointment-status', 'Upcoming');
    assert.strictEqual(currentURL(), '/appointments?status=Upcoming');

    await fillIn('#appointment-search', 'Aarav');
    let queryParams = new URLSearchParams(currentURL().split('?')[1]);
    assert.strictEqual(queryParams.get('status'), 'Upcoming');
    assert.strictEqual(queryParams.get('search'), 'Aarav');
  });
});
