docker build -t harlemmuniz/multi-client:latest -t harlemmuniz/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t harlemmuniz/multi-server:latest -t harlemmuniz/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t harlemmuniz/multi-worker:latest -t harlemmuniz/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push harlemmuniz/multi-client:latest
docker push harlemmuniz/multi-server:latest
docker push harlemmuniz/multi-worker:latest

docker push harlemmuniz/multi-client:$SHA
docker push harlemmuniz/multi-server:$SHA
docker push harlemmuniz/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=harlemmuniz/multi-client:$SHA
kubectl set image deployments/server-deployment server=harlemmuniz/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=harlemmuniz/multi-worker:$SHA