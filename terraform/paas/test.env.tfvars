paas_space                    = "get-into-teaching-test"
paas_adviser_application_name = "get-teacher-training-adviser-service-test"
paas_adviser_route_name       = "get-teacher-training-adviser-service-test"
paas_redis_1_name             = "get-into-teaching-test-redis-svc"
paas_additional_route_name    = "staging-adviser-getintoteaching"
logging                       = 1
additional_routes             = 0


alerts = {
  gib = {
    website_name  = "Get Teacher Training Adviser Service (Test)"
    website_url   = "https://get-teacher-training-adviser-service-test.london.cloudapps.digital/healthcheck.json"
    test_type     = "HTTP"
    check_rate    = 60
    contact_group = [185037]
    trigger_rate  = 0
    custom_header = "{\"Content-Type\": \"application/x-www-form-urlencoded\"}"
  }
}
