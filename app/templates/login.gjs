import Component from '@glimmer/component';
import { service } from '@ember/service';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';
import { on } from '@ember/modifier';

export default class LoginPageComponent extends Component {
  @service session;
  @service router;

  @tracked email = '';
  @tracked password = '';
  @tracked errorMessage = '';

  @action
  updateEmail(event) {
    this.email = event.target.value;
  }

  @action
  updatePassword(event) {
    this.password = event.target.value;
  }

  @action
  async login(event) {
    event.preventDefault();

    if (!this.email.trim() || !this.password) {
      this.errorMessage = 'Enter both email and password.';
      return;
    }

    this.errorMessage = '';
    // this.session.login(this.email.trim());
    const role = this.email.trim().toLowerCase().startsWith('admin')
      ? 'admin'
      : 'viewer';

    this.session.login(this.email.trim(), role);
    this.password = '';

    const intendedRoute = this.session.intendedRoute;
    const intendedParams = this.session.intendedParams;

    this.session.intendedRoute = null;
    this.session.intendedParams = null;

    if (intendedRoute && intendedRoute !== 'login') {
      if (
        intendedRoute === 'appointment' ||
        intendedRoute === 'appointment-edit'
      ) {
        await this.router.transitionTo(
          intendedRoute,
          intendedParams.appointment_id,
        );
      } else {
        await this.router.transitionTo(intendedRoute);
      }
    } else {
      await this.router.transitionTo('appointments');
    }
  }

  @action
  logout() {
    this.session.logout();
    this.password = '';
    this.errorMessage = '';
  }

  <template>
    <main>
      <h1>Login</h1>
      <form {{on "submit" this.login}}>
        <div>
          <label for="email">Email</label>
          <input
            id="email"
            type="email"
            value={{this.email}}
            {{on "input" this.updateEmail}}
            required
          />
        </div>

        <div>
          <label for="password">Password</label>
          <input
            id="password"
            type="password"
            value={{this.password}}
            {{on "input" this.updatePassword}}
            required
          />
        </div>

        <button type="submit">Log in</button>
      </form>

      {{#if this.errorMessage}}
        <p role="alert">{{this.errorMessage}}</p>
      {{/if}}

      {{#if this.session.isAuthenticated}}
        <p role="status">
          Logged in as
          {{this.session.currentUser.email}}
        </p>
        <button type="button" {{on "click" this.logout}}>
          Log out
        </button>
      {{/if}}
    </main>
  </template>
}
