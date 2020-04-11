class Base < ApplicationRecord

  
  validates :base_name, presence: true
  validates :base_number, presence: true
  validates :base_kind, presence: true
end
