echo '{"username": "testd10", "password": "testd10"}' > temp.json

ab -n 100 -c 10 -p temp.json -T application/json http://192.196.4.1:8001/api/auth/register

ab -n 100 -c 10 -p temp.json -T application/json http://192.196.4.1:8001/api/auth/login

curl -X POST -H "Content-Type: application/json" -d @temp.json http://192.196.4.1:8001/api/auth/login > token.txt

tokenTest=$(cat token.txt | jq -r '.token')

ab -n 100 -c 10 -H "Authorization: Bearer $tokenTest" http://192.196.4.1:8001/api/me