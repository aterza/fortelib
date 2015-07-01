require 'scripts/set_loader'

namespace :fortelib do

  namespace :set do
  
    desc 'drop Forte prime_form dataset'
    task :drop => %w(environment) do 
      PrimeForm.delete_all
    end
  
  end

end
