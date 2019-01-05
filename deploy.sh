docker build -t momosh/multi-client:latest -t momosh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t momosh/multi-server:latest -t momosh/multi-server:$SHA  -f ./server/Dockerfile ./server
docker build -t momosh/multi-worker:latest -t momosh/multi-worker:$SHA  -f ./worker/Dockerfile ./worker

docker push momosh/multi-client:latest
docker push momosh/multi-server:latest
docker push momosh/multi-worker:latest

docker push momosh/multi-client:$SHA
docker push momosh/multi-server:$SHA
docker push momosh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=momosh/multi-server:$SHA
kubectl set image deployments/client-deployment client=momosh/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=momosh/multi-worker:$SHA