# Fus Ro Dah

Boilerplate for Roda + Sequel projects.

This boilerplate includes the things I need most when starting a new project.

- Webpack + TailwindCSS + PurgeCSS
- Simple Migration structure
- DB + Model setup
- bin/console (like `rails console`)
- Minitest setup

# Setup Database

This project uses PostgreSQL by default, to setup.

1. Create `.env.development` for development.
2. Add `DATABASE_URL=postgresql://host/mydb` and `createdb mydb` locally.

# Migration

A sample migration has been added to `migrate` folder.

# Webpack

Just run npm install to install all dependencies.

# Running the app

Fusrodah uses rerun to watch for changes and restart the app.
A foreman script has been included to run the app in `Procfile.dev`
To start webpack and rerun, run

```
foreman s -f Procfile.dev
```