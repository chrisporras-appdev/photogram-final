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
end
