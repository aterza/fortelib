require 'test_helper'

class PrimeFormTest < ActiveSupport::TestCase

	test 'search' do
		assert pf = PrimeForm.search([ 7, 5, 9, 2 ])
	end

end
