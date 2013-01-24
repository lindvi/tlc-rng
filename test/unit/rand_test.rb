# == Schema Information
#
# Table name: rands
#
#  id         :integer          not null, primary key
#  part_id    :integer
#  used       :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class RandTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
