require 'test_helper'

class LinkHashTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'valid_link_hash' do
    user = create_user
    link_hash = LinkHash.new(:user_id => user.id, :slug => SecureRandom.uuid)
    assert link_hash.valid?
  end

  test 'invalid_link_hash' do
    link_hash = LinkHash.new(:slug => SecureRandom.uuid)
    refute link_hash.valid?
    assert_equal ["must exist"], link_hash.errors[:user]
  end
end
