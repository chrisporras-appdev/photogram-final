# == Schema Information
#
# Table name: users
#
#  id             :integer          not null, primary key
#  comments_count :integer          default("0")
#  email          :string
#  is_private     :boolean
#  likes_count    :integer          default("0")
#  password       :string
#  username       :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class User < ApplicationRecord
end
