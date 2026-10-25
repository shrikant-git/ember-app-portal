import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { render } from '@ember/test-helpers';
import AppointmentsPage from 'appointment-operations-portal/components/appointments-page';

module('Integration | Component | appointments-page', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Updating values is achieved using autotracking, just like in app code. For example:
    // class State { @tracked myProperty = 0; }; const state = new State();
    // and update using state.myProperty = 1; await rerender();
    // Handle any actions with function myAction(val) { ... };

    await render(<template><AppointmentsPage /></template>);

    assert.dom().hasText('');

    // Template block usage:
    await render(<template>
      <AppointmentsPage>
        template block text
      </AppointmentsPage>
    </template>);

    assert.dom().hasText('template block text');
  });
});
