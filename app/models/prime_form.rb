class PrimeForm < ActiveRecord::Base

  attr_accessor :input_sequence
  
  validates :sequence, uniqueness: true, strict: true
  validates :cardinal, :ordinal, :sequence, :vector, presence: true, strict: true
  validates :ordinal, uniqueness: { scope: :cardinal } # this should just invalidate the model (non-strict)
  
  #
  # +name+
  #
  # returns the name of the set, for ex.: '8-22' for cardinal: 8 and ordinal: 22
  #
  # TODO: should take into account special forms: 'Z' sets, 'B' sets, '*' sets, etc.
  #
  def name
    [self.cardinal.to_s, self.ordinal.to_s].join('-')  
  end
  
  #
  # <tt>sequence_array</tt>
  #
  # returns the sequence in numeric integer array form
  #
  def sequence_array
    self.read_attribute('sequence').split(',').map {|s| s.to_i}  
  end
    
  class PrimeFormNotFound < StandardError; end

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
      diffs = build_diffs(nt) 
      diffs = sort_diffs(diffs)
      nt = [0]
      diffs.each_index {|idx| nt << (nt[idx] + diffs[idx])}
      match_prime_form(nt, seq)
    end
    
    def build_diffs(nt)
      diffs = []
      nt.each_index do 
          |idx| 
          break if idx > nt.size-2
          diffs << (nt[idx] - nt[idx+1]).abs
      end
      diffs 
    end
    
    def sort_diffs(diffs)
      res = diffs
      if diffs.size > 1 
        if diffs.first > diffs.last
          res = diffs.reverse
        elsif diffs.first == diffs.last
          f = diffs.first
          l = diffs.last
          res = [f, sort_diffs(diffs[1..-2]), l].flatten
        end
      end
      res
    end
    
    def match_prime_form(nf, seq)
      pf = PrimeForm.where("sequence=?", nf.map{|n| n.to_s }.join(','))
      raise PrimeFormNotFound, "prime form not found for sequence #{nf.to_s}" if pf.empty?
      pf = pf.first
      pf.input_sequence = seq
      pf
    end
  
  end
  
end
