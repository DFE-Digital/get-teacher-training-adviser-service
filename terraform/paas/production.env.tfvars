paas_space                    = "get-into-teaching-production"
paas_adviser_application_name = "get-teacher-training-adviser-service-prod"
paas_adviser_route_name       = "get-teacher-training-adviser-service-prod"
paas_redis_1_name             = "get-into-teaching-prod-redis-svc"
paas_additional_route_name    = "beta-adviser-getintoteaching"
logging                       = 1
additional_routes             = 1
instances                     = 2
alerts = {	
  GiT_TTA_Production_Healthcheck = {	
    website_name  = "Get Into Teaching Adviser (Production)"	
    website_url   = "https://beta-adviser-getintoteaching.education.gov.uk/healthcheck.json"	
    test_type     = "HTTP"	
    check_rate    = 60	
    contact_group = [185037]	
    trigger_rate  = 0	
    confirmations = 1
  }	
}
