import { pageTitle } from 'ember-page-title';
import AppointmentForm from '../components/appointment-form';

<template>
  {{pageTitle "Edit Appointment"}}

  <AppointmentForm @appointment={{@model}} />
</template>
