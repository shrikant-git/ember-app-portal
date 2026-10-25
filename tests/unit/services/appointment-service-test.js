import { module, test } from 'qunit';
import { setupTest } from 'appointment-operations-portal/tests/helpers';

module('Unit | Service | appointment-service', function (hooks) {
  setupTest(hooks);

  // TODO: Replace this with your real tests.
  test('it exists', function (assert) {
    let service = this.owner.lookup('service:appointment-service');
    assert.ok(service);
  });
});
