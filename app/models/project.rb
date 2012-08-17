class Project < ActiveRecord::Base
  attr_accessible :project_name, :project_size
  has_many :parts
end
# == Schema Information
#
# Table name: projects
#
#  id           :integer         not null, primary key
#  project_name :string(255)
#  project_size :integer
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

