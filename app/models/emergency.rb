class Emergency < ActiveRecord::Base
  has_many :responders, primary_key: :code, foreign_key: :emergency_code

  validates :code,
            presence: true,
            uniqueness: true

  validates :fire_severity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :police_severity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  validates :medical_severity,
            presence: true,
            numericality: { greater_than_or_equal_to: 0 }

  def self.full_responses
    full_response_emergencies = Emergency.where(full_response: true).count
    total_emergencies = Emergency.all.count
    [full_response_emergencies, total_emergencies]
  end

  def self.responder_names(emergency)
    emergency.responders.pluck(:name)
  end
end
