paas_space                    = "get-into-teaching-production"
paas_adviser_application_name = "get-teacher-training-adviser-service-prod"
paas_adviser_route_name       = "get-teacher-training-adviser-service-prod"
paas_redis_1_name             = "get-into-teaching-prod-redis-svc"
paas_additional_route_name    = "beta-adviser-getintoteaching"
logging                       = 1
additional_routes             = 1
instances                     = 2


alerts = {
  git = {
    website_name  = "Get Teacher Training Adviser Service (Production)"
    website_url   = "https://beta-adviser-getintoteaching.education.gov.uk/healthcheck.json"
    test_type     = "HTTP"
    check_rate    = 60
    contact_group = [185037]
    trigger_rate  = 0
    custom_header = "{\"Content-Type\": \"application/x-www-form-urlencoded\"}"
    status_codes  = "204, 205, 206, 303, 400, 401, 403, 404, 405, 406, 408, 410, 413, 444, 429, 494, 495, 496, 499, 500, 501, 502, 503, 504, 505, 506, 507, 508, 509, 510, 511, 521, 522, 523, 524, 520, 598, 599"
  }
}
