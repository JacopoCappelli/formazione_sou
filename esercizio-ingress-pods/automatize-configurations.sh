kind create cluster --name pods-ingress-cluster --config cluster-config.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

sleep 90

kubectl apply -f pods-config.yaml
kubectl apply -f ingress.yaml 
kubectl config set-context --current --namespace=my-app


