# Sewing Planner

A Rails app for planning sewing projects: keep track of your patterns, the projects you make from them, the fabrics you use, and a shopping list.

Built with Ruby 4.0, Rails 8.1, PostgreSQL, Devise and Pundit. Images are stored on [Cloudinary](https://cloudinary.com). JavaScript is bundled with esbuild ([jsbundling-rails](https://github.com/rails/jsbundling-rails)) and styles are Sass compiled by the asset pipeline. Originally generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates).

## Getting started

### Prerequisites

- **Ruby 4.0.6** (see `.ruby-version`), e.g. via [rbenv](https://github.com/rbenv/rbenv): `rbenv install 4.0.6`
- **Node.js 20+ and Yarn 1.x**. If you use [Volta](https://volta.sh), the versions pinned in `package.json` are picked up automatically.
- **PostgreSQL** running locally
- A **Cloudinary** account (the free tier is enough). Development uploads go to Cloudinary, not to disk.

> **macOS 26 with the macOS 27 SDK:** if `rbenv install` succeeds but the build dies with `Segmentation fault` while linking `miniruby`, build with:
> ```sh
> MACOSX_DEPLOYMENT_TARGET=26.0 ac_cv_func_pipe2=no ac_cv_func_dup3=no rbenv install 4.0.6
> ```

### Setup

```sh
git clone git@github.com:anneli-pixel/sewing-planner.git
cd sewing-planner
bundle install
yarn install
```

Create a `.env` file in the project root (it's git-ignored) with your Cloudinary credentials, found on the Cloudinary dashboard:

```sh
CLOUDINARY_URL=cloudinary://<api_key>:<api_secret>@<cloud_name>
```

Then create the database. Use `db:migrate` rather than `db:setup` or `db:prepare`, because the garment categories are created by a migration and the seeds depend on them:

```sh
bin/rails db:create db:migrate
bin/rails db:seed   # optional: sample user, patterns and projects (uploads sample photos to Cloudinary)
```

### Running the app

```sh
bin/dev
```

This starts the Rails server on <http://localhost:3000> and runs `yarn build --watch`, which rebuilds the JavaScript whenever you change something in `app/javascript` (see `Procfile.dev`). Sign up for a new account, or log in with the seeded user if you ran the seeds.

### Running the tests

```sh
bundle exec rspec
```

The specs are in `spec/` (model specs and Capybara feature specs) and use FactoryBot and shoulda-matchers.

### Where things live

| Path | What's there |
| --- | --- |
| `app/javascript/application.js` | JS entry point (bundled by esbuild into `app/assets/builds/`) |
| `app/javascript/components/` | Small UI behaviours, initialised on `turbolinks:load` |
| `app/assets/stylesheets/` | Sass: `config/` (fonts, colours, Bootstrap variables), `components/`, `pages/` |
| `app/policies/` | Pundit authorization policies |
| `config/storage.yml` | Active Storage services (`cloudinary` in development, `cloudinary_production` in production) |

## Deploying to Heroku

The repo includes a `Procfile` that runs Puma for the web process and `rails db:migrate` in the [release phase](https://devcenter.heroku.com/articles/release-phase), so migrations run automatically on each deploy.

1. Create the app and add Postgres:

   ```sh
   heroku create <app-name>
   heroku addons:create heroku-postgresql:essential-0
   ```

2. Add the Node.js buildpack **before** the Ruby buildpack. Node is needed so `assets:precompile` can run `yarn build`. The Node.js buildpack installs the versions set in `engines` in `package.json` (it ignores the `volta` section, which is only for local development):

   ```sh
   heroku buildpacks:add --index 1 heroku/nodejs
   heroku buildpacks:add heroku/ruby
   ```

3. Set the config vars. `DATABASE_URL` is set by the Postgres add-on. The app has no committed master key, so set a secret key base directly:

   ```sh
   heroku config:set SECRET_KEY_BASE=$(bin/rails secret)
   heroku config:set CLOUDINARY_URL=cloudinary://<api_key>:<api_secret>@<cloud_name>
   ```

   Production images are uploaded to the `sewing_planner_production` folder in Cloudinary.

4. Deploy:

   ```sh
   git push heroku master
   ```

   The garment categories are created by migrations, so they exist after the first release. To load the sample data, run `heroku run bin/rails db:seed`. Don't run it on a database with real data, because the seeds delete all existing patterns, projects, fabrics and shopping items.

5. Open the app with `heroku open`, and check the logs with `heroku logs --tail`.

### Production notes

- **Mailer host:** `config/environments/production.rb` still has a placeholder host (`TODO_PUT_YOUR_DOMAIN_HERE`) in `action_mailer.default_url_options`. Set it to your Heroku domain so Devise emails (such as password resets) contain working links.
- **HTTPS:** Heroku serves HTTPS, so you can turn on `config.assume_ssl` and `config.force_ssl` in `config/environments/production.rb` to redirect HTTP to HTTPS and mark cookies as secure.
- **Redis:** Action Cable is configured to use Redis (`REDIS_URL`) in production, but the app doesn't use any channels yet, so you don't need a Redis add-on.
