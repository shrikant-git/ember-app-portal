import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { render } from '@ember/test-helpers';
import AppointmentForm from 'appointment-operations-portal/components/appointment-form';

module('Integration | Component | appointment-form', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Updating values is achieved using autotracking, just like in app code. For example:
    // class State { @tracked myProperty = 0; }; const state = new State();
    // and update using state.myProperty = 1; await rerender();
    // Handle any actions with function myAction(val) { ... };

    await render(<template><AppointmentForm /></template>);

    assert.dom().hasText('');

    // Template block usage:
    await render(<template>
      <AppointmentForm>
        template block text
      </AppointmentForm>
    </template>);

    assert.dom().hasText('template block text');
  });
});
