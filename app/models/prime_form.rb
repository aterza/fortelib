class PrimeForm < ActiveRecord::Base

  attr_accessor :input_sequence
  
  def name
    [self.cardinal.to_s, self.ordinal.to_s].join('-')  
  end
  
  def sequence
    self.read_attribute('sequence').split(',').map {|s| s.to_i}  
  end
  
  class << self 
  
    def search(arg)
      seq = arg
      seq = arg.split(/\s*,\s*/).map { |s| s.to_i } if arg.is_a?(String)
      search_prime_form(seq)
    end
  
    
  private 
  
    def search_prime_form(seq) 
      card = seq.size
      perms = [seq.sort]
      
      2.upto(card) do
        l = perms.last
        lr = l.rotate
        lr[lr.size-1] = lr.last+12
        perms << lr
      end   
      nt = perms.sort {|a, b|(a.last-a.first)<=>(b.last-b.first)}.first
      nt = nt.map{|n| n-nt.first}
      if card>2 && ((nt.first-nt.second).abs > (nt.last-nt[nt.size-2]).abs)
        diffs = []
        nt[0..-2].each_index {|n, idx| diffs << (n - nt[idx+1]).abs}
        diffs.reverse!
        nt = [0]
        diffs.each_index {|n, idx| nt << (nt[idx] + n)}
      end    
			match_prime_form(nt, seq)
    end
    
    class PrimeFormNotFound < StandardError; end
    
    def match_prime_form(nf, seq)
      pf = PrimeForm.where("sequence=?", nf.map{|n| n.to_s }.join(','))
      raise PrimeFormNotFound, "prime form not found for sequence #{nf.to_s}" if pf.empty?
      pf = pf.first
      pf.input_sequence = seq
      pf
    end
  
  end
  
end
