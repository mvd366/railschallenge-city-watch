json.emergency do
  json.(@emergency, :code, :fire_severity, :police_severity, :medical_severity, :full_response, :resolved_at)
end