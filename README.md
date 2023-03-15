### Details
- ruby version: 3.1.3
- rails version: 7

### To contribute
1. clone the repo
2. run `$ bundle`
3. migrate database
4. run `rspec` to make sure things are up
5. hack away

### Notes
- Images are saved on google cloud
- Env vars and secrets are stored in the rails credentials. Ask for the master-key to unlock


### Deployment
- we deploy to fly.io
- to deploy, run:
  fly deploy --build-secret RAILS_MASTER_KEY=<insert master key here>
