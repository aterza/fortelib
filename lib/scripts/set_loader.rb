module Scripts

  class << self
    
    SET_DATA = File.expand_path(File.join(['..']*3, 'public', 'doc', 'sets.dat'), __FILE__)
    
    #
    # <tt>set_loader</tt>
    #
    # splits a line in the form <tt>[<card>-<ord>[(df)]](sequence):[vector]</tt>
    # into its components.
    #
    # Examples:
    #
    # [3-11](0,3,7):[001110] => cardinal: 3, ordinal: 11, sequence: [0, 3, 7], vector: [001110], distinct_forms: 24
    # [6-20(4)](0,1,4,5,8,9):[303630] => cardinal: 6, ordinal: 20, sequence: [0, 1, 4, 5, 8, 9], vector: [303630], distinct_forms: 4
    #
    def set_loader
      File.open(SET_DATA, 'r') do
        |fh| 
        while (fh.eof?)
          line = fh.gets
          next unless line
          line.chomp!
          (first, vector) = line.split(':')             # split vector from first part
          (name, pf) = first.split(']')                 # split first part into name and normal form
          pf.sub!(/\((.*)\)/, '\1')                     # remove parenthesis from normal form
          pf = pf.split(',').map {|s| s.to_i}           # convert normal form into array
          name.sub!('[', '')                            # remove starting square bracket from name
          (card, ord) = name.split('-')                 # split name into cardinal and ordinal
          card = card.to_i                              # convert cardinal into integer
          df = 24                                       # by default we have 24 distinct forms...
          if ord.index('(')                             # but if the ordinal contains a parenthesized number
            df = ord.sub(/\A.*\((.*)\)/, '\1').to_i     # then separate the number of distinct forms
            ord.sub!(/\(.*$/, '')                       # from the ordinal number
          end
          PrimeForm.create(cardinal: card, ordinal: ord, sequence: pf, vector: vector, distinct_forms: df)
        end
      end
    end
    
  end

end
