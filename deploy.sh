docker build -t lukaszstolarski/multi-client:latest -t lukaszstolarski/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lukaszstolarski/multi-server:latest -t lukaszstolarski/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lukaszstolarski/multi-worker:latest -t lukaszstolarski/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push lukaszstolarski/multi-client:latest
docker push lukaszstolarski/multi-server:latest
docker push lukaszstolarski/multi-worker:latest

docker push lukaszstolarski/multi-client:$SHA
docker push lukaszstolarski/multi-server:$SHA
docker push lukaszstolarski/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lukaszstolarski/multi-server:$SHA
kubectl set image deployments/client-deployment client=lukaszstolarski/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lukaszstolarski/multi-worker:$SHA
