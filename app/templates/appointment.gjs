// import { LinkTo } from '@ember/routing';
// import { pageTitle } from 'ember-page-title';

// <template>
//   {{pageTitle "Demo Record Details"}}

//   <main>
//     <h1>Demo Record Details</h1>

//     <p>Record ID: {{@model.id}}</p>
//     <p>User ID: {{@model.userId}}</p>
//     <h2>{{@model.title}}</h2>
//     <p>{{@model.body}}</p>

//     <LinkTo @route="appointments">Back to appointments</LinkTo>
//   </main>
// </template>

import { pageTitle } from 'ember-page-title';
import { LinkTo } from '@ember/routing';

<template>
  {{pageTitle "Appointment Details"}}

  <main>
    <h1>Appointment Details</h1>

    <dl>
      <dt>Appointment ID</dt>
      <dd>{{@model.id}}</dd>

      <dt>Patient</dt>
      <dd>{{@model.patient}}</dd>

      <dt>Service</dt>
      <dd>{{@model.service}}</dd>

      <dt>Date</dt>
      <dd>{{@model.date}}</dd>

      <dt>Status</dt>
      <dd>{{@model.status}}</dd>
    </dl>

    <LinkTo @route="appointments">
      Back to appointments
    </LinkTo>
  </main>
</template>
