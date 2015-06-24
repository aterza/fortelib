require 'scripts/set_loader'

namespace :fortelib do

  namespace :set do
  
    desc 'load Forte prime_form dataset'
    task :load => %w(environment db:drop db:migrate) do 
      Scripts.set_loader
    end
  
  end

end
