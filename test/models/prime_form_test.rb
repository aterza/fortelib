require 'test_helper'

class PrimeFormTest < ActiveSupport::TestCase

  def setup
    PrimeForm.delete_all
    Scripts.set_loader
  end

  test 'search' do
    #
    # TODO: serious testing needs to be done here
    #
    assert pf = PrimeForm.search([ 7, 5, 9, 2 ])
  end
  
  test 'uniqueness of sequence' do
    assert pf = PrimeForm.where('cardinal = 3 and ordinal = 2').first
    assert_raise(ActiveModel::StrictValidationFailed) { PrimeForm.create(cardinal: 15, ordinal: '23', sequence: pf.sequence, vector: pf.vector) }
  end

  test 'uniqueness of card/ord sequence' do
    assert pf = PrimeForm.where('cardinal = 8 and ordinal = 22').first
    assert wrong = PrimeForm.create(cardinal: 8, ordinal: '22', sequence: 'dummy', vector: 'dummy')
    assert !wrong.valid?
    assert_equal 'Cardinal duplicates set name 8-22, Ordinal duplicates set name 8-22', wrong.errors.full_messages.join(', ')
  end

end
