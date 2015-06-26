require 'test_helper'

class PrimeFormTest < ActiveSupport::TestCase

  def setup
    PrimeForm.delete_all
    Scripts.set_loader
  end

  test 'search' do
    assert pf = PrimeForm.search([ 7, 5, 9, 2 ])
  end
  
  test 'uniqueness of sequence' do
    assert pf = PrimeForm.where('cardinal = 3 and ordinal = 2').first
    assert_raise(ActiveModel::StrictValidationFailed) {wrong = PrimeForm.create(cardinal: 15, ordinal: '23', sequence: pf.sequence)}
  end

end
