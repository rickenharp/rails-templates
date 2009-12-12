if yes?("Do you want to use RSpec for testing?")
  gem "rspec", :lib => false, :version => ">= 1.2.0"
  gem "rspec-rails", :lib => false, :version => ">= 1.2.0"
  use_rspec = true
end

gem 'will_paginate', :version => ">= 2.3.11"
gem 'nifty-generators', :lib => false, :version => ">= 0.3.0"

rake("gems:install", :sudo => true)

if use_rspec == true
  generate :rspec
end

generate :nifty_layout

git :init

run "echo 'TODO add readme content' > README"
run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

file ".gitignore", <<-END
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
END

rake "db:migrate"

git :add => ".", :commit => "-m 'initial commit'"
