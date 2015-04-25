class Emergency < ActiveRecord::Base
  has_one :responder, primary_key: :code

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
    return [full_response_emergencies, total_emergencies]
  end

  def before_save(emergency)
    if emergency.fire_severity > 0 && emergency.police_severity > 0 && emergency.medical_response > 0
      emergency.full_response = true
    end
  end
end
