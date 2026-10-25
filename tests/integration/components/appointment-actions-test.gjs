import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { render } from '@ember/test-helpers';
import AppointmentActions from 'appointment-operations-portal/components/appointment-actions';

module('Integration | Component | appointment-actions', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Updating values is achieved using autotracking, just like in app code. For example:
    // class State { @tracked myProperty = 0; }; const state = new State();
    // and update using state.myProperty = 1; await rerender();
    // Handle any actions with function myAction(val) { ... };

    await render(<template><AppointmentActions /></template>);

    assert.dom().hasText('');

    // Template block usage:
    await render(<template>
      <AppointmentActions>
        template block text
      </AppointmentActions>
    </template>);

    assert.dom().hasText('template block text');
  });
});
