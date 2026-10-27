import { LinkTo } from '@ember/routing';
import { pageTitle } from 'ember-page-title';

import AppHeader from '../components/app-header';

<template>
  {{pageTitle "Appointment Operations Portal"}}

  <AppHeader />

  <nav aria-label="Main navigation">
    <LinkTo @route="appointments">Appointments</LinkTo>
  </nav>

  {{outlet}}
</template>
