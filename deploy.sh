docker build -t pushpendumanna/multi-client:latest -t pushpendumanna/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pushpendumanna/multi-server:latest -t pushpendumanna/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pushpendumanna/multi-worker:latest -t pushpendumanna/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push pushpendumanna/multi-client:latest
docker push pushpendumanna/multi-server:latest
docker push pushpendumanna/multi-worker:latest
docker push pushpendumanna/multi-client:$SHA
docker push pushpendumanna/multi-server:$SHA
docker push pushpendumanna/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pushpendumanna/multi-server:$SHA
kubectl set image deployments/client-deployment client=pushpendumanna/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pushpendumanna/multi-worker:$SHA