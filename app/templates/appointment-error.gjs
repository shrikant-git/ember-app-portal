import { LinkTo } from '@ember/routing';

<template>
  <main role="alert">
    <h1>Unable to load appointment details</h1>
    <p>
      Something went wrong while retrieving the record. Please try again.
    </p>

    <LinkTo @route="appointments">
      Back to appointments
    </LinkTo>
  </main>
</template>
