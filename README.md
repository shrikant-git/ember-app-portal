# Appointment Operations Portal

An Ember.js application for managing appointments, built with modern Glimmer components, Vite, and Embroider. This project is also used to practise production-oriented frontend engineering, testing, and repository standards.

## Current capabilities

- View and search appointments.
- Filter appointments by status.
- Create, edit, and cancel appointments.
- Mock login and session management.
- Route protection and role-aware UI.
- Form validation, loading states, and error handling.

**Current limitations:** Authentication is mocked, and appointment data is maintained locally in memory. This application is not connected to a production backend. A real deployment requires server-side authentication, authorization, and persistent API-backed data.

## Prerequisites

- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) 22.x
- npm
- [Google Chrome](https://www.google.com/chrome/) or another supported browser

The `.nvmrc` file specifies the Node.js major version used by the project.

## Getting started

Clone the repository and enter the project directory:

```bash
git clone <repository-url>
cd appointment-operations-portal
```

Install dependencies:

```bash
npm ci
```

If you are setting up a new local clone, verify that Git hooks are installed and active after dependency installation.

## Development

Start the Vite development server:

```bash
npm run start
```

Open [http://localhost:4200/](http://localhost:4200/).

The test runner is available through:

```bash
npm run test
```

## Quality checks

Run the configured lint and formatting checks:

```bash
npm run lint
```

Apply automatic lint fixes and formatting where supported:

```bash
npm run lint:fix
```

Format files across the project:

```bash
npm run format
```

Run the test suite:

```bash
npm test
```

Create a production build:

```bash
npm run build
```

The production output is generated in `dist/`.

## Code quality and Git workflow

This repository uses:

- **ESLint** for JavaScript linting.
- **Ember Template Lint** for template checks.
- **Stylelint** for CSS linting.
- **Prettier** for consistent formatting.
- **Husky** for Git hooks.
- **lint-staged** to format matching staged files before commits.
- **Conventional Commit-style messages** enforced by the commit-message hook.

Examples of accepted commit messages:

```text
feat(appointments): add status filter
fix(auth): preserve intended route
test(appointments): cover cancellation
docs: update setup instructions
ci: run production build
```

## Continuous integration

The GitHub Actions workflow in `.github/workflows/ci.yml` is configured to run on pull requests and pushes to the configured branches.

It runs:

1. Lint and formatting checks.
2. Automated tests.
3. A production build.

The workflow must be executed in a remote GitHub repository before its remote status can be verified.

## Project structure

- `app/routes/` — route definitions and route-level behavior.
- `app/controllers/` — controller state and URL-related behavior where applicable.
- `app/components/` — reusable UI components.
- `app/templates/` — route templates and page composition.
- `app/services/` — shared application services.
- `tests/` — automated tests.
- `.husky/` — local Git hook scripts.
- `.github/workflows/` — CI configuration.

## Further reading

- [Ember.js](https://emberjs.com/)
- [Vite](https://vite.dev/)
- [Embroider](https://github.com/embroider-build/embroider)
- [Prettier](https://prettier.io/)
- [Husky](https://typicode.github.io/husky/)
