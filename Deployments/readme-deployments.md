
#Using below ports for Databases

|Database|Port|API Name|
|-----|-----|
|MongoDB|27017|Catalog API|
|Redis|6379|Basket API|
|SQLServer|1433|Order API|
|PostgresSQL|5432|Discount API|
|RabbitMQ|15672|Basket API & Order API|

## Step-1: Install Databases
#### See 'database_scripts' Folder.

# Using below Ports for APIs.
|API Name|Port|
|-----|-----|
|Catalog API|30001|
|Basket API|30002|
|Discount API|30003|
|Order API|30004|
|Gateway API|32000|

## Step-2: Build & Deploy APIs
#### Install Catalog API
```
//Navigate to Project path C:\>microservices.api
//Build for docker-hub  
$docker build -t srinivasanugu/catalog-api-image -f ./Services/Catalog/Catalog.API/Dockerfile .
//Push image to docker-hub  
$docker push srinivasanugu/catalog-api-image:latest

//Deploy Kubernetes Secrets - Navigate to path 'cd Services/Catalog/Catalog.API/Deployment'
$kubectl apply -f catalog-api-screts.yaml
$kubectl apply -f catalog-api-deployment.yaml
//Test APIs
#minikube service catalog-api-service --url
//Note:Update Database connection string settings with the right Pod IP.
mongodb://admin:password@10.106.118.198:27017/CatalogDb?authSource=admin
http://localhost:9010/health```
```

#### Install Basket API
```
//Navigate to Project path C:\>microservices.api
//Build for docker-hub 
$docker build -t srinivasanugu/basket-api-image -f ./Services/Basket/Basket.API/Dockerfile .
//Push image to docker-hub
$docker push srinivasanugu/basket-api-image:latest

//Deploy Kubernetes Secrets - Navigate to path 'cd Services/Basket/Basket.API/Deployment'
#kubectl apply -f basket-api-secret.yaml
$kubectl apply -f basket-api-deployment.yaml
//Note:update connection string settings with the Pod ip.
http://localhost:9011/health```
```

#### Install Discount API
```
//Navigate to Project path C:\>MicroservicesApp
$docker build -t srinivasanugu/discount-api-image -f ./Services/Discount/Discount.API/Dockerfile .
$docker push srinivasanugu/discount-api-image:latest

//Deploy Kubernetes Secrets - Navigate to path 'cd Services/Discount/Discount.API/Deployment'
$kubectl apply -f discount-api-secret.yaml
$kubectl apply -f discount-api-deployment.yaml
//Note:update connection string settings with the Pod ip.
http://localhost:9012/health
```
#### Install Order API
```
//Navigate to Project path C:\>MicroservicesApp
$docker build -t srinivasanugu/order-api-image -f ./Services/Ordering/Ordering.API/Dockerfile .
$docker push srinivasanugu/order-api-image:latest

//Deploy Kubernetes Secrets - Navigate to path 'cd Services/Ordering/Ordering.API/Deployment'
$kubectl apply -f order-api-secret.yaml
$kubectl apply -f order-api-deployment.yaml
#kubectl port-forward order-api-deployment-7996f784fb-v44lg 9200:8080
//Note:update connection string settings with the node ip.
http://localhost:8010/health
```
#### Install API Gateway
```
//update the minikube ip as a baseurl
#minikube ip
 "BaseUrl": "http://192.168.49.2:30002",<minikubeip:nodePort>
//Navigate to Project path C:\>MicroservicesApp\ApiGateways\Ocelot.ApiGateway
$docker build -t srinivasanugu/ocelot-api-gateway-image .
$docker push srinivasanugu/ocelot-api-gateway-image:latest

#Create Config from json
#kubectl create configmap ocelot-config --from-file=ocelot.Development.json

$kubectl apply -f .\Deployment\api-gateway-deployment.yaml
$kubectl apply -f .\Deployment\ocelot-route-config.yaml

kubectl exec -it ocelot-gateway-0 -- env

$minikube service ocelot-api-gateway-service --url
http://localhost:8010/health
```

Connection Strings:

|API|DB|Conn String|
|--|--|
|Catalog API|Mongo|mongodb://admin:password@localhost:27017/CatalogDb?authSource=admin|
|Basket API|Redis|localhost:6379|



Notes:
Update BaseURL in UI - http://localhost:30002
to run Minike UI, need to port mapping for both UI and Gateway
kubectl port-forward ocelot-gateway-0 30002:30002
minikube service my-angular-app --url 

Step5:
```

kubectl create configmap ocelot-config --from-file=ocelot.Development.json
```

## Additional Info
```
kubectl get pods -o wide
kubectl exec -it catalog-api-deployment-7996f784fb-v44lg -- /bin/bash
cat <filename>
$minikube service ocelot-gateway --url
#kubectl port-forward <your-pod-name> localPort:servicePort -n <your-namespace>

kubectl describe pod catalog-api-deployment-9bb764db5-t2smt
powershell "[convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('$SQLPassword12345'))"

#kubectl port-forward ocelot-api-gateway-deployment-0 8011:8080
#kubectl port-forward ocelot-gateway-0 30001:30001
kubectl logs ocelot-gateway-0
```
