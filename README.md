# Sewing Planner

A Rails app for planning sewing projects: keep track of your patterns, the projects you make from them, the fabrics you use, and a shopping list.

Built with Ruby 4.0, Rails 8.1, PostgreSQL, Devise and Pundit. Images are stored on [Cloudinary](https://cloudinary.com). JavaScript is bundled with esbuild ([jsbundling-rails](https://github.com/rails/jsbundling-rails)) and styles are Sass compiled by the asset pipeline. Originally generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates).

## Getting started

### Prerequisites

- **Ruby 4.0.6** (see `.ruby-version`), e.g. via [rbenv](https://github.com/rbenv/rbenv): `rbenv install 4.0.6`
- **Node.js 26 and Yarn 1.x**. If you use [Volta](https://volta.sh), the versions pinned in `package.json` are picked up automatically.
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

The app runs on Heroku with Heroku Postgres. Images are stored on Cloudinary, not on Heroku. The repo's `Procfile` starts Puma for the web process and runs `rails db:migrate` in the [release phase](https://devcenter.heroku.com/articles/release-phase), so migrations run automatically on every deploy, before the new code goes live. If a migration fails, the release is aborted and the previous version keeps running.

In the commands below, `<app>` is the name of the Heroku app (see `heroku apps`).

### Deploying a change

1. **Start from a clean, up-to-date `master`:**

   ```sh
   git switch master && git pull
   git status
   ```

   `git status` must show no changes and **no untracked files**. The CLI deploy uploads every file in the folder that isn't ignored by `.gitignore`. That would include database dumps, exported config vars or old build output, which can contain secrets or user data. Move such files out of the project folder before deploying.

2. **If the change includes migrations, back up the database first:**

   ```sh
   heroku pg:backups:capture -a <app>
   ```

3. **Deploy**, using either method. Both run the same build and release phase.

   - **Heroku CLI (recommended):** uploads the current folder and builds it. It uses the Heroku CLI's login, so it works even when git authentication to Heroku doesn't. It needs the `heroku-builds` plugin, installed once:

     ```sh
     heroku plugins:install heroku-builds
     heroku builds:create -a <app>
     ```

   - **git push:** deploys the branch you push to Heroku's `master` branch:

     ```sh
     heroku git:remote -a <app>      # once per clone: adds a remote called "heroku"
     git push heroku master
     ```

     If the push fails with `fatal: protocol error: bad line length character: fata`, use the CLI method instead.

   The build log streams to your terminal. In order: the Node.js buildpack installs Node and Yarn, the Ruby buildpack installs the gems and runs `assets:precompile` (which runs `yarn build`), then the release phase runs the migrations.

4. **Check that it worked:**

   ```sh
   heroku releases -a <app>          # the new release should be at the top
   heroku logs --tail -a <app>       # look for Puma "Listening on ..." and no errors
   heroku open -a <app>
   ```

### Rolling back

- **Code or config problem:** go back to the previous release. This restores the code and config vars, but **not** the database:

  ```sh
  heroku releases:rollback -a <app>
  ```

- **A migration damaged the data:** put the app into maintenance mode and restore the backup from step 2:

  ```sh
  heroku maintenance:on -a <app>
  heroku pg:backups -a <app>                                   # find the backup ID, e.g. b012
  heroku pg:backups:restore <backup-id> DATABASE_URL -a <app>
  heroku maintenance:off -a <app>
  ```

### Testing risky changes on a staging app

For bigger changes (Rails or Ruby upgrades, a new Heroku stack, tricky migrations), test on a separate staging app with a copy of the production data first:

```sh
heroku create <app>-staging --stack heroku-24     # use the same stack as production (heroku apps:info -a <app>)
heroku buildpacks:add heroku/nodejs -a <app>-staging
heroku buildpacks:add heroku/ruby -a <app>-staging
heroku addons:create heroku-postgresql:essential-0 -a <app>-staging
heroku pg:backups:restore "$(heroku pg:backups:url -a <app>)" DATABASE_URL -a <app>-staging --confirm <app>-staging
heroku config:set SECRET_KEY_BASE=<same as production> CLOUDINARY_URL=<same as production> -a <app>-staging

git switch <branch-to-test>
heroku builds:create -a <app>-staging
```

- **Photos:** staging uses the same Cloudinary folder as production, so production images show up there. That also means deleting or replacing a photo in staging deletes it in production too. In staging, only view photos, or test uploads on records you created yourself.
- **Database:** only restore staging from a Heroku production backup, not from a local copy of the database. Locally migrated data can point images at the wrong Cloudinary folder.
- **Clean up:** delete the staging app when you're done, so it stops costing money. This also deletes its database: `heroku apps:destroy -a <app>-staging`.

### Setting up a new Heroku app

Only needed if you're creating the app from scratch:

1. Create the app and add Postgres:

   ```sh
   heroku create <app>
   heroku addons:create heroku-postgresql:essential-0 -a <app>
   ```

2. Add the Node.js buildpack **before** the Ruby buildpack. Node is needed so `assets:precompile` can run `yarn build`. The Node.js buildpack installs the versions set in `engines` in `package.json` (it ignores the `volta` section, which is only for local development):

   ```sh
   heroku buildpacks:add heroku/nodejs -a <app>
   heroku buildpacks:add heroku/ruby -a <app>
   ```

3. Set the config vars. `DATABASE_URL` is set by the Postgres add-on. The app has no committed master key, so it uses `SECRET_KEY_BASE` instead. Generate a new one only for a brand-new app; changing it on an existing app logs everyone out.

   ```sh
   heroku config:set SECRET_KEY_BASE=$(bin/rails secret) -a <app>
   heroku config:set CLOUDINARY_URL=cloudinary://<api_key>:<api_secret>@<cloud_name> -a <app>
   ```

   Production images are uploaded to the `sewing_planner_production` folder in Cloudinary.

4. Deploy as described in [Deploying a change](#deploying-a-change), then make sure a web dyno is running: `heroku ps -a <app>` (if none is listed: `heroku ps:scale web=1:basic -a <app>`).

5. The garment categories are created by migrations, so they exist after the first release. To load the sample data, run `heroku run bin/rails db:seed -a <app>`. Don't run it on a database with real data, because the seeds delete all existing patterns, projects, fabrics and shopping items.

### Production notes

- **Mailer host:** `config/environments/production.rb` still has a placeholder host (`TODO_PUT_YOUR_DOMAIN_HERE`) in `action_mailer.default_url_options`. Set it to your Heroku domain so Devise emails (such as password resets) contain working links.
- **HTTPS:** Heroku serves HTTPS, so you can turn on `config.assume_ssl` and `config.force_ssl` in `config/environments/production.rb` to redirect HTTP to HTTPS and mark cookies as secure.
- **Redis:** Action Cable is configured to use Redis (`REDIS_URL`) in production, but the app doesn't use any channels yet, so you don't need a Redis add-on.
- **Heroku stack:** Heroku retires stacks every few years, and the app can't be deployed on a retired stack. Check with `heroku stack -a <app>`. To switch, run `heroku stack:set <new-stack> -a <app>`, then deploy; the change takes effect with the next build. Test the new stack on a staging app first.
