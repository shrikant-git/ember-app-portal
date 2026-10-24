import { pageTitle } from 'ember-page-title';
import AppointmentCard from '../components/appointment-card';

const appointments = [
  {
    id: 1,
    patient: 'Aarav Sharma',
    service: 'General Consultation',
    date: '2026-10-25',
    status: 'Upcoming',
  },
  {
    id: 2,
    patient: 'Priya Patel',
    service: 'Dental Checkup',
    date: '2026-10-26',
    status: 'Upcoming',
  },
  {
    id: 3,
    patient: 'Rohan Deshmukh',
    service: 'Follow-up',
    date: '2026-10-23',
    status: 'Completed',
  },
];

<template>
  {{pageTitle "Appointments"}}

  <main>
    <h1>Appointments</h1>
    <p>Manage patient appointments from one place.</p>

    <section aria-label="Appointment list">
      {{#each appointments key="id" as |appointment|}}
        <AppointmentCard @appointment={{appointment}} />
      {{else}}
        <p>No appointments found.</p>
      {{/each}}
    </section>
  </main>
</template>
