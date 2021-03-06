#################################################################################################
###
### CURL the deployed containers healthcheck and return the status and SHA.
### check the SHA against a passed in parameter
###
### Input parameters ( not validated )
### 1 URL
### 2 APPLICATION SHA
###
### Returns
### 1 on failure
### 0 on sucess
###
#################################################################################################
URL=${1}
APP_SHA=${2}
CONTENT_SHA=${3}

#URL="get-teacher-training-adviser-service-dev"
#APP_SHA="c243708"

rval=0
FULL_URL="https://${URL}.london.cloudapps.digital/healthcheck.json"
http_status=$(curl -o /dev/null -s -w "%{http_code}"  ${FULL_URL})
if [ "${http_status}" != "200" ]
then
	echo "HTTP Status ${http_status}"
	rval=1
else
	echo "HTTP Status is Healthy"

        json=$(curl -s -X GET ${FULL_URL})

        sha=$( echo ${json} | jq -r .app_sha)
        if [ "${sha}" != "${APP_SHA}"  ]
        then
		echo "APPLICATION SHA (${sha}) is not ${APP_SHA} "
        	rval=1
        else
                echo "APPLICATION SHA is correct"
        fi

fi
exit ${rval}

