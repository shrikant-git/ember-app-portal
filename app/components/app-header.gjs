import Component from '@glimmer/component';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { on } from '@ember/modifier';

export default class AppHeaderComponent extends Component {
  @service session;
  @service router;

  @action
  async logout() {
    this.session.logout();
    await this.router.transitionTo('login');
  }

  <template>
    <header>
      <nav aria-label="Main navigation">
        <span>Appointment Operations Portal</span>

        {{#if this.session.isAuthenticated}}
          <span>
            {{this.session.currentUser.email}}
          </span>

          <button type="button" {{on "click" this.logout}}>
            Log out
          </button>
        {{/if}}
      </nav>
    </header>
  </template>
}
