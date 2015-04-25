json.emergencies do
  json.array! @emergencies, :code, :fire_severity, :police_severity, :medical_severity, :full_response, :resolved_at
end
json.full_responses Emergency.full_responses