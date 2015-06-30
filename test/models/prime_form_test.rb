require 'test_helper'

class PrimeFormTest < ActiveSupport::TestCase

  def setup
    assert PrimeForm.delete_all
    assert_nil Scripts.set_loader
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
    assert PrimeForm.delete_all
    assert args = { cardinal: 8, ordinal: 22, sequence: '0,1,2,3,5,6,8,10', vector: '465562' }
		assert pf = PrimeForm.create(args)
		assert pf.valid?
		#
		# same cardinal, same ordinal (should fail)
		#
		assert args.update(sequence: 'dummy') # change sequence otherwise this will fail because of that
    assert wrong = PrimeForm.create(args)
    assert !wrong.valid?
    assert_equal 'Ordinal has already been taken', wrong.errors.full_messages.join(', ')
		#
		# different cardinal, same ordinal (should succeed)
		#
    assert args2 = { cardinal: 7, ordinal: 22, sequence: '0,1,2,5,6,8,9', vector: '424542' }
		assert rigth = PrimeForm.create(args2)
		assert rigth.valid?
  end

  test 'presence validations' do
    assert PrimeForm.delete_all # to make sure that we don't raise other exceptions
    assert args = { cardinal: 8, ordinal: 22, sequence: '0,1,2,3,5,6,8,10', vector: '465562' }
    #
    # this should not create problems
    #
    assert pf = PrimeForm.create(args)
    assert pf.valid?, pf.errors.full_messages.join(', ')
    assert pf.destroy
    assert pf.frozen?
    #
    # now we check for presences
    #
    args.keys.each do
      |key|
      assert cur_args = args.dup
      assert cur_args.delete(key)
      assert_raise(ActiveModel::StrictValidationFailed) { PrimeForm.create(cur_args) }
    end
  end

end
