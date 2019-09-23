docker build -t vpmaddur/multi-client:latest -t vpmaddur/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t vpmaddur/multi-worker:latest -t vpmaddur/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker build -t vpmaddur/multi-server:latest -t vpmaddur/multi-server:$SHA -f ./server/Dockerfile ./server
docker push vpmaddur/multi-client:latest
docker push vpmaddur/multi-worker:latest
docker push vpmaddur/multi-server:latest
docker push vpmaddur/multi-client:$SHA
docker push vpmaddur/multi-worker:$SHA
docker push vpmaddur/multi-server:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=vpmaddur/multi-server:$SHA
kubectl set image deployments/client-deployment client=vpmaddur/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=vpmaddur/multi-worker:$SHA
