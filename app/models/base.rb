class Base < ApplicationRecord

  
  validates :base_name, presence: false
  validates :base_number, presence: false
  validates :base_kind, presence: false
end
