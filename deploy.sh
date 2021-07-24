docker build -t egcircleslife/multi-client-k8s:latest -t egcircleslife/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t egcircleslife/multi-server-k8s-pgfix:latest -t egcircleslife/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t egcircleslife/multi-worker-k8s:latest -t egcircleslife/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push egcircleslife/multi-client-k8s:latest
docker push egcircleslife/multi-server-k8s-pgfix:latest
docker push egcircleslife/multi-worker-k8s:latest

docker push egcircleslife/multi-client-k8s:$SHA
docker push egcircleslife/multi-server-k8s-pgfix:$SHA
docker push egcircleslife/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=egcircleslife/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=egcircleslife/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=egcircleslife/multi-worker-k8s:$SHA