import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { render } from '@ember/test-helpers';
import AppHeader from 'appointment-operations-portal/components/app-header';

module('Integration | Component | app-header', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders the application title', async function (assert) {
    await render(<template><AppHeader /></template>);

    assert.dom().hasText('Appointment Operations Portal');
  });
});
