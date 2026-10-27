import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class AuthenticatedRoute extends Route {
  @service session;
  @service router;

  beforeModel(transition) {
    if (!this.session.isAuthenticated) {
      this.session.intendedRoute = transition.to.name;
      this.session.intendedParams = { ...transition.to.params };

      return this.router.transitionTo('login');
    }
  }
}
