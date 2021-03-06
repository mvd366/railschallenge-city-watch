json.emergency do
  json.code @emergency.code
  json.fire_severity @emergency.fire_severity
  json.police_severity @emergency.police_severity
  json.medical_severity @emergency.medical_severity
  json.resolved_at @emergency.resolved_at
  json.responders Emergency.responder_names(@emergency)
  json.full_response @emergency.full_response
end