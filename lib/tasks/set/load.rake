require 'scripts/set_loader'

namespace :fortelib do

  namespace :set do
  
    desc 'load Forte prime_form dataset'
    task :load => %w(environment fortelib:set:drop) do 
      Scripts.set_loader
    end
  
  end

end
