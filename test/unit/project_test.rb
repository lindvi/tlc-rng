# == Schema Information
#
# Table name: projects
#
#  id             :integer          not null, primary key
#  project_name   :string(255)
#  project_size   :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  increment_size :integer          default(0)
#  project_hash   :string(255)      default("")
#

require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
