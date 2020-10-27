docker build -t chayslavko/multi-client:latest -t chayslavko/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t chayslavko/multi-server -t chayslavko/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t chayslavko/multi-worker -t chayslavko/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push chayslavko/multi-client:latest
docker push chayslavko/multi-server:latest
docker push chayslavko/multi-worker:latest

docker push chayslavko/multi-client:$SHA
docker push chayslavko/multi-server:$SHA
docker push chayslavko/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=chayslavko/multi-client:$SHA
kubectl set image deployments/server-deployment server=chayslavko/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=chayslavko/multi-worker:$SHA