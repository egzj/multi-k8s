docker build -t egcircleslife/multi-client:latest -t egcircleslife/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t egcircleslife/multi-server:latest -t egcircleslife/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t egcircleslife/multi-worker:latest -t egcircleslife/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push egcircleslife/multi-client:latest
docker push egcircleslife/multi-server:latest
docker push egcircleslife/multi-worker:latest

docker push egcircleslife/multi-client:$SHA
docker push egcircleslife/multi-server:$SHA
docker push egcircleslife/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=egcircleslife/multi-server:$SHA
kubectl set image deployments/client-deployment client=egcircleslife/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=egcircleslife/multi-worker:$SHA



