require 'scripts/set_loader'

namespace :fortelib do

  desc 'load Forte prime_form dataset'
  task :set_load => %w(environment db:drop db:migrate) do 
    Scripts.set_loader
  end
  
end
