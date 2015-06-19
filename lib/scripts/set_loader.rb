module Scripts

  class << self
    
    SET_DATA = File.expand_path(File.join(['..']*3, 'public', 'doc', 'sets.dat'), __FILE__)
    
    def set_loader
      File.open(SET_DATA, 'r') do
        |fh| 
        while ((line = fh.gets) != fh.eof?)
          next unless line
          line.chomp!
          (first, vector) = line.split(':')
          (name, pf) = first.split(']')
          pf.sub!(/\((.*)\)/, '\1')
          pf = pf.split(',').map {|s| s.to_i}
          name.sub!('[', '')
          (card, ord) = name.split('-')
          card = card.to_i
          df = 24
          if ord.index('(')
            df = ord.sub(/\A.*\((.*)\)/, '\1').to_i  
            ord.sub!(/\(.*$/, '')
          end
          PrimeForm.create(cardinal: card, ordinal: ord, sequence: pf, vector: vector, distinct_forms: df)
        end
      end
    end
    
  end

end
