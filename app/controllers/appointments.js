
import Controller from '@ember/controller';
import { tracked } from '@glimmer/tracking';
import { action } from '@ember/object';

export default class AppointmentsController extends Controller {
  queryParams = ['status', 'search'];

  @tracked status = 'All';
  @tracked search = '';

  @action
  updateSearch(value) {
    this.search = value;
  }

  @action
  updateStatus(value) {
    this.status = value;
  }
}
