class Fire < Responder
  def self.capacities
    total_capacity = Fire.all.sum(:capacity)
    available_capacity = Fire.where(emergency_code: nil).sum(:capacity)
    on_duty_capacity = Fire.where(on_duty: true).sum(:capacity)
    available_on_duty_capacity = Fire.where(on_duty: true, emergency_code: nil).sum(:capacity)
    [total_capacity, available_capacity, on_duty_capacity, available_on_duty_capacity]
  end
end
