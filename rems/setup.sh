export REMS_OWNER="jd123@lifescience-ri.eu"
docker exec rems_app java -Drems.config=/rems/config/config.edn -jar rems.jar grant-role owner $REMS_OWNER

export API_KEY="placeholder_key"
docker exec rems_app java -Drems.config=/rems/config/config.edn -jar rems.jar api-key add $API_KEY this is a test key

curl -X POST http://localhost:3000/api/users/create \
  -H "content-type: application/json" \
  -H "x-rems-api-key: $API_KEY" \
  -H "x-rems-user-id: $REMS_OWNER" \
  -d '{
        "userid": "robot", "name": "Permission Robot", "email": null
    }'

docker exec rems_app java -Drems.config=/rems/config/config.edn -jar rems.jar grant-role reporter robot
docker exec rems_app java -Drems.config=/rems/config/config.edn -jar rems.jar api-key add robot-key this is a test key
docker exec rems_app java -Drems.config=/rems/config/config.edn -jar rems.jar api-key set-users robot-key robot
docker exec rems_app java -Drems.config=/rems/config/config.edn -jar rems.jar api-key allow robot-key get '/api/permissions/.*'

