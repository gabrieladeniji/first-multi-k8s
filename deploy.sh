docker build -t gabrielade/multi-client:latest -t gabrielade/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gabrielade/multi-server:latest -t gabrielade/multi-server:$SHA -f ./server/Dockerfilr ./server
docker build -t gabrielade/multi-worker:latest -t gabrielade/multi-worker:$SHA -f ./worker/Dockerfile ./worker
# PUSH LATEST TO DOCKER.HUB
docker push gabrielade/multi-client:latest
docker push gabrielade/multi-server:latest
docker push gabrielade/multi-worker:latest
# PUSH $SHA TO DOCKER.HUB
docker push gabrielade/multi-client:$SHA
docker push gabrielade/multi-server:$SHA
docker push gabrielade/multi-worker:$SHA

# Aplly Kubenetes
kubectl apply -f k8s
kubectl set image deployment/client-deployment client=gabrielade/multi-client:$SHA
kubectl set image deployment/server-deployment server=gabrielade/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=gabrielade/multi-worker:$SHA