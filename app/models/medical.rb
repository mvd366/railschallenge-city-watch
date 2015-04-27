class Medical < Responder
  def self.capacities
    total_capacity = Medical.all.sum(:capacity)
    available_capacity = Medical.where(emergency_code: nil).sum(:capacity)
    on_duty_capacity = Medical.where(on_duty: true).sum(:capacity)
    available_on_duty_capacity = Medical.where(on_duty: true, emergency_code: nil).sum(:capacity)
    [total_capacity, available_capacity, on_duty_capacity, available_on_duty_capacity]
  end
end
