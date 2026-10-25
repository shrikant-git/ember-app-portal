import { LinkTo } from '@ember/routing';
import { pageTitle } from 'ember-page-title';

<template>
  {{pageTitle "Appointment Operations Portal"}}

  <nav aria-label="Main navigation">
    <LinkTo @route="appointments">Appointments</LinkTo>
  </nav>

  {{outlet}}
</template>
