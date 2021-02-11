class Customer < ApplicationRecord
  validates_presence_of :first_name, presence: true
  validates_presence_of :last_name, presence: true
end
