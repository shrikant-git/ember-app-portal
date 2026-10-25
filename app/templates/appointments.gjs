import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';

import AppointmentsPage from '../components/appointments-page';

<template>
  {{pageTitle "Appointments"}}

  <LinkTo @route="new-appointment">Create appointment</LinkTo>

  <AppointmentsPage
    @searchQuery={{@controller.search}}
    @selectedStatus={{@controller.status}}
    @onSearchChange={{@controller.updateSearch}}
    @onStatusChange={{@controller.updateStatus}}
  />
</template>
