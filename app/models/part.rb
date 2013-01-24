# == Schema Information
#
# Table name: parts
#
#  id         :integer          not null, primary key
#  project_id :integer
#  part_name  :string(255)
#  part_size  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  used_rands :integer          default(0)
#

class Part < ActiveRecord::Base
  attr_accessible :part_name, :part_size, :project_id, :used_rands
  belongs_to :project
  has_many :rands, dependent: :destroy
end
