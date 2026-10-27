import Service from '@ember/service';
import { tracked } from '@glimmer/tracking';

export default class SessionService extends Service {
  @tracked authState = 'unauthenticated';
  @tracked currentUser = null;

  // Temporary navigation state for post-login redirects.
  intendedRoute = null;
  intendedParams = null;

  get isAuthenticated() {
    return this.authState === 'authenticated';
  }

  get isCheckingSession() {
    return this.authState === 'unknown';
  }

  // Mock authentication only. Replace with the DRF API later.
  login(email, role = 'viewer') {
    this.currentUser = { email, role };
    this.authState = 'authenticated';
  }

  get canManageAppointments() {
    return this.isAuthenticated && this.currentUser?.role === 'admin';
  }

  logout() {
    this.currentUser = null;
    this.authState = 'unauthenticated';
    this.intendedRoute = null;
    this.intendedParams = null;
  }
}
