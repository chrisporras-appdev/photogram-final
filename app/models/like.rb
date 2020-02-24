# == Schema Information
#
# Table name: likes
#
#  id               :integer          not null, primary key
#  photo_id_integer :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  fan_id           :integer
#
class Like < ApplicationRecord
  
  
  # def fan
  #   return User.where({:id => self.fan_id}).at(0)
  # end

  belongs_to(:fan, { :class_name => "Photo", :foreign_key => "fan_id"})

  belongs_to(:photo)
end
