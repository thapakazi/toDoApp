set :application, "toDoApp"
set :repository,  "git@github.com:zerOnepal/toDoApp.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "192.168.2.88"                          # Your HTTP server, Apache/etc
role :app, "192.168.2.88"                          # This may be the same as your `Web` server
#role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"

set :user, "ceasors"
set :deploy_to, "toDoApp"
set :use_sudo, false

