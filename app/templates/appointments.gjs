import { pageTitle } from 'ember-page-title';

import AppointmentSummary from '../components/appointment-summary';

<template>
  {{pageTitle "Appointments"}}

  <main>
    <h1>Appointments</h1>
    <p>Welcome to the Appointment Operations Portal.</p>
    <p>Your appointment management workspace starts here.</p>

    <AppointmentSummary @total={{10}} @upcoming={{1}} />
  </main>
</template>
