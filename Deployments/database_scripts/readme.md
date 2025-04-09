#Create Deployment
kubectl apply -f 01-k8s-pre-deployment.yaml
kubectl apply -f 02-k8s-mongodb-deployment.yaml
kubectl apply -f 03-k8s-postgressql-deployment.yaml
kubectl apply -f 04-k8s-sqlserver-deployment.yaml
kubectl apply -f 05-k8s-redis-deployment.yaml
kubectl apply -f 06-k8s-rabbitmq-deployment.yaml

#Connect to Databases - Use VS Code
kubectl config set-context --current --namespace=default

kubectl port-forward <Pod-Nane> <Local-Port>:<Service-Port> #kubectl get svc
kubectl port-forward mongodb-deployment-0 27017:27017
kubectl port-forward postgress-deployment-0 5432:5432 -n default
#CREATE DATABASE discountdb

#Delete Deployment
kubectl apply -f 02-k8s-mongodb-deployment.yaml
kubectl apply -f 03-k8s-postgressql-deployment.yaml
kubectl apply -f 04-k8s-sqlserver-deployment.yaml
kubectl apply -f 05-k8s-redis-deployment.yaml
kubectl apply -f 06-k8s-rabbitmq-deployment.yaml
kubectl apply -f 01-k8s-pre-deployment.yaml

#Using below ports for Databases

|Database|Port|API Name|
|-----|-----|
|MongoDB|27017|Catalog API|
|Redis|6379|Basket API|
|SQLServer|1433|Order API|
|PostgresSQL|5432|Discount API|
|RabbitMQ|15672|Basket API & Order API|