import { module, test } from 'qunit';
import { setupRenderingTest } from 'appointment-operations-portal/tests/helpers';
import { render } from '@ember/test-helpers';
import AppointmentCard from 'appointment-operations-portal/components/appointment-card';

module('Integration | Component | appointment-card', function (hooks) {
  setupRenderingTest(hooks);

  test('it renders', async function (assert) {
    // Updating values is achieved using autotracking, just like in app code. For example:
    // class State { @tracked myProperty = 0; }; const state = new State();
    // and update using state.myProperty = 1; await rerender();
    // Handle any actions with function myAction(val) { ... };

    await render(<template><AppointmentCard /></template>);

    assert.dom().hasText('');

    // Template block usage:
    await render(<template>
      <AppointmentCard>
        template block text
      </AppointmentCard>
    </template>);

    assert.dom().hasText('template block text');
  });
});
