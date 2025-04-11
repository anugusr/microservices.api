#### Prerequisites:
Install Docker Desktop, Minikube
```
$minikube start
$minikube dashboard
```

|Database|Port|API Name|
|-----|-----|
|MongoDB|27017|Catalog API|
|Redis|6379|Basket API|
|SQLServer|1433|Order API|
|PostgresSQL|5432|Discount API|
|RabbitMQ|15672|Basket API & Order API|
## Step-1: Install Databases
#### Install MongoDB
```kubectl apply -f .\Deployments\database_scripts\k8s-mongodb-deployment.yaml```  
#### Install Postgres
```kubectl apply -f .\Deployments\database_scripts\k8s-postgressql-deployment.yaml```
#### Install Redis
```kubectl apply -f .\Deployments\database_scripts\k8s-redis-deployment.yaml```
#### Install SQL Server
```kubectl apply -f .\Deployments\database_scripts\k8s-sqlserver-deployment.yaml```
#### Install RabbitMQ
```kubectl apply -f .\Deployments\database_scripts\k8s-rabbitmq-deployment.yaml```

to verify local connection:  
```
kubectl port-forward <pod-name> <local-port>:<service-port>
Example: kubectl port-forward mongodb-deployment-0 27017:27017
//to delete deployment kubectl delete -f .\Deployments\database_scripts\k8s-mongodb-deployment.yaml
```

## Step-2: Build & Deploy APIs
#### Install Catalog API
```
//Navigate to Project path C:\>MicroservicesApp
//to build for docker-hub  
$docker build -t srinivasanugu/catalog-api-image -f ./Services/Catalog/Catalog.API/Dockerfile .
to push image to docker-hub
$docker login  
$docker push srinivasanugu/catalog-api-image:latest
$kubectl apply -f ./Services/Catalog/Catalog.API/Deployment/catalog-api-deployment.yaml
$kubectl apply -f ./Services/Catalog/Catalog.API/Deployment/catalog-api-screts.yaml
#kubectl port-forward catalog-api-0 9010:8080
http://localhost:9200/swagger/index.html
http://localhost:9010/health```
//Note:update connection string settings with the Pod ip to access this api from other API in kuberneties.
```

#### Install Basket API
```
//Navigate to Project path C:\>MicroservicesApp
$docker build -t srinivasanugu/basket-api-image -f ./Services/Basket/Basket.API/Dockerfile .
$docker push srinivasanugu/basket-api-image:latest
$kubectl apply -f ./Services/Basket/Basket.API/Deployment/basket-api-deployment.yaml
//Note:update connection string settings with the Pod ip.
http://localhost:9011/health```
```

#### Install Discount API
```
//Navigate to Project path C:\>MicroservicesApp
$docker build -t srinivasanugu/discount-api-image -f ./Services/Discount/Discount.API/Dockerfile .
$docker push srinivasanugu/discount-api-image:latest
$kubectl apply -f ./Services/Discount/Discount.API/Deployment/discount-api-deployment.yaml
//Note:update connection string settings with the Pod ip.
http://localhost:9012/health
```
#### Install Order API
```
//Navigate to Project path C:\>MicroservicesApp
$docker build -t srinivasanugu/order-api-image -f ./Services/Ordering/Ordering.API/Dockerfile .
$docker push srinivasanugu/order-api-image:latest
$kubectl apply -f ./Services/Ordering/Ordering.API/Deployment/order-api-deployment.yaml
#kubectl port-forward order-api-deployment-7996f784fb-v44lg 9200:8080
//Note:update connection string settings with the node ip.
http://localhost:8010/health
```

#### Install API Gateway
```
//Navigate to Project path C:\>MicroservicesApp
$docker build -t srinivasanugu/ocelot-api-gateway-image .
$docker push srinivasanugu/ocelot-api-gateway-image:latest
$kubectl apply -f api-gateway-deployment.yaml

http://localhost:8010/health
```

## Additional Info
```
kubectl get pods -o wide
kubectl exec -it catalog-api-deployment-7996f784fb-v44lg -- /bin/bash
cat <filename>
$minikube service ocelot-api-gateway-service --url
#kubectl port-forward <your-pod-name> localPort:servicePort -n <your-namespace>

kubectl describe pod catalog-api-deployment-9bb764db5-t2smt
powershell "[convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('$SQLPassword12345'))"

#kubectl port-forward ocelot-api-gateway-deployment-0 8011:8080
#kubectl port-forward catalog-api-deployment-0 8010:8080
```
