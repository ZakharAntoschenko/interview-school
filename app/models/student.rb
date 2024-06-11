class Student < ApplicationRecord
  has_many :section_students, dependent: :destroy
  has_many :sections, through: :section_students

  validates :first_name, :last_name, presence: true
end
