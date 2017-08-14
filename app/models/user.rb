class User < ApplicationRecord
  has_many :books
  mount_uploader :avatar, AvartarUploader
end
