class PrimeForm < ActiveRecord::Base

  class << self 
  
    def search(arg)
      seq = arg
      seq = arg.split(/\s*,\s*/).map { |s| s.to_i } if arg.is_a?(String)
      search_prime_form(seq)
    end
    
  private 
  
    def search_prime_form(seq) 
    
    end
  
  end
  
end
