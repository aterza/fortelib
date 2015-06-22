require 'test_helper'

class PrimeFormTest < ActiveSupport::TestCase

  def setup
    PrimeForm.delete_all
    Scripts.set_loader
  end

	test 'search' do
byebug	
		assert pf = PrimeForm.search([ 7, 5, 9, 2 ])
	end

end
