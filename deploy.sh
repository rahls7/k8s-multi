docker build -t rahls7/multi-client:latest -t rahls7/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rahls7/multi-server:latest -t rahls7/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rahls7/multi-worker:latest -t rahls7/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rahls7/multi-client:latest
docker push rahls7/multi-server:latest
docker push rahls7/multi-worker:latest
docker push rahls7/multi-client:$SHA
docker push rahls7/multi-server:$SHA
docker push rahls7/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rahls7/multi-server:$SHA
kubectl set image deployments/client-deployment client=rahls7/multi-client
kubectl set image deployment/worker-deployment worker=rahls7/multi-worker