class Responder < ActiveRecord::Base
  belongs_to :emergency, primary_key: :code, foreign_key: :emergency_code

  validates :name,
            presence: true,
            uniqueness: true

  validates :type,
            presence: true

  validates :capacity,
            presence: true,
            inclusion: (1..5)

  def self.clear(emergency)
    freed_responders = Responder.where(emergency_code: emergency.code)
    freed_responders.each do |freed_responder|
      freed_responder.emergency_code = nil
      freed_responder.save
    end
  end

  def self.dispatch(emergency)
    fire_response = dispatch_fire(emergency)
    medical_response = dispatch_medical(emergency)
    police_response = dispatch_police(emergency)

    emergency.full_response = (fire_response && medical_response && police_response) ? true : false
    emergency.save
  end

  def self.dispatch_fire(emergency)
    fire_responder = Fire.find_by(emergency_code: nil, on_duty: true, capacity: emergency.fire_severity)
    if !fire_responder.blank?
      fire_responder.update_attributes(emergency_code: emergency.code)
      return true
    else
      fire_responders = Fire.where(emergency_code: nil, on_duty: true).order(capacity: :desc)
      fire_response = 0
      return true if emergency.fire_severity == 0
      fire_responders.each do |responder|
        responder.update_attributes(emergency_code: emergency.code)
        fire_response += responder.capacity
        return true if fire_response >= emergency.fire_severity
      end
      return false
    end
  end

  def self.dispatch_medical(emergency)
    medical_responder = Medical.find_by(emergency_code: nil, on_duty: true, capacity: emergency.medical_severity)
    if !medical_responder.blank?
      medical_responder.update_attributes(emergency_code: emergency.code)
      return true
    else
      medical_responders = Medical.where(emergency_code: nil, on_duty: true).order(capacity: :desc)
      medical_response = 0
      return true if emergency.medical_severity == 0
      medical_responders.each do |responder|
        responder.update_attributes(emergency_code: emergency.code)
        medical_response += responder.capacity
        return true if medical_response >= emergency.medical_severity
      end
      return false
    end
  end

  def self.dispatch_police(emergency)
    police_responder = Police.find_by(emergency_code: nil, on_duty: true, capacity: emergency.police_severity)
    if !police_responder.blank?
      police_responder.update_attributes(emergency_code: emergency.code)
      return true
    else
      police_responders = Police.where(emergency_code: nil, on_duty: true).order(capacity: :desc)
      police_response = 0
      return true if emergency.police_severity == 0
      police_responders.each do |responder|
        responder.update_attributes(emergency_code: emergency.code)
        police_response += responder.capacity
        return true if police_response >= emergency.police_severity
      end
      return false
    end
  end
end
