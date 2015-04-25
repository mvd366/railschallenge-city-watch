class Responder < ActiveRecord::Base
  belongs_to :emergency, foreign_key: :emergency_code

  validates :name,
            presence: true,
            uniqueness: true

  validates :type,
            presence: true

  validates :capacity,
            presence: true,
            inclusion: (1..5)
end
