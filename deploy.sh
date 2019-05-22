docker build -t lilisun/dance-master-client:latest -t lilisun/dance-master-client:$SHA -f ./client/Dockerfile ./client
docker build -t lilisun/dance-master-server:latest -t lilisun/dance-master-server:$SHA -f ./server/Dockerfile ./server
docker build -t lilisun/dance-master-worker:latest -t lilisun/dance-master-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lilisun/dance-master-client:latest
docker push lilisun/dance-master-server:latest
docker push lilisun/dance-master-worker:latest

docker push lilisun/dance-master-client:$SHA
docker push lilisun/dance-master-server:$SHA
docker push lilisun/dance-master-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=lilisun/dance-master-server:$SHA
kubectl set image deployments/client-deployment client=lilisun/dance-master-client:$SHA
kubectl set image deployments/worker-deployment worker=lilisun/dance-master-worker:$SHA