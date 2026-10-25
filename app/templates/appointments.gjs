import { pageTitle } from 'ember-page-title';
import AppointmentsPage from '../components/appointments-page';

<template>
  {{pageTitle "Appointments"}}

  <AppointmentsPage
    @searchQuery={{@controller.search}}
    @selectedStatus={{@controller.status}}
    @onSearchChange={{@controller.updateSearch}}
    @onStatusChange={{@controller.updateStatus}}
  />
</template>
