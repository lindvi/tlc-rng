class Rand < ActiveRecord::Base
  attr_accessible :part_id, :used
  belongs_to :part
end
# == Schema Information
#
# Table name: rands
#
#  id         :integer         not null, primary key
#  part_id    :integer
#  used       :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

