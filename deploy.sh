#!bin/bash
docker build -t ardintelai/multi-client:latest -t ardintelai/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t ardintelai/multi-server:latest -t ardintelai/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t ardintelai/multi-worker:latest -t ardintelai/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push ardintelai/multi-client:latest
docker push ardintelai/multi-server:latest
docker push ardintelai/multi-worker:latest

docker push ardintelai/multi-client:$SHA
docker push ardintelai/multi-server:$SHA
docker push ardintelai/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=ardintelai/multi-server:$SHA
kubectl set image deployments/client-deployment client=ardintelai/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=ardintelai/multi-worker:$SHA
