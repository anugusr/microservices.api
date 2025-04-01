#### Prerequisites:
Install Docker Desktop, Minikube
```
$minikube delete
$minikube start
$minikube dashboard
$minikube ip -- Check Minikube Ip and use this IP for both Gateway and APIs
$minikube ssh
cat /etc/hosts
#minikube logs
#minikube service list

kubectl exec -it my-angular-app-0 -- /bin/sh
ping host.minikube.internal
curl http://host.minikube.internal:30001/api/v1/Catalog/GetAllBrands
curl http://192.168.49.2:30001/api/v1/Catalog/GetAllBrands
curl http://192.168.49.2:30002/health
curl http://192.168.49.2:30002/Catalog/GetAllBrands
kubectl exec -it ocelot-gateway-0 -- env
http://192.168.49.2:30002

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
|API Name|Port|
|-----|-----|
|Catalog API|30001|
|Basket API|30003|
|Discount API|30004|
|Order API|30005|

## Step-2: Build & Deploy APIs
#### Install Catalog API
```
//Navigate to Project path C:\>MicroservicesApp
//to build for docker-hub  
$docker build -t srinivasanugu/catalog-api-image -f ./Services/Catalog/Catalog.API/Dockerfile .
to push image to docker-hub  
$docker push srinivasanugu/catalog-api-image:latest
$kubectl apply -f ./Services/Catalog/Catalog.API/Deployment/catalog-api-screts.yaml
$kubectl apply -f catalog-api-deployment.yaml
#minikube service catalog-api-service --url
//Note:update connection string settings with the Pod ip.
http://localhost:9010/health```
```
#### Install API Gateway
```
//update the minikube ip as a baseurl
#minikube ip
 "BaseUrl": "http://192.168.49.2:30002",<minikubeip:nodePort>
//Navigate to Project path C:\>MicroservicesApp\ApiGateways\Ocelot.ApiGateway
$docker build -t srinivasanugu/ocelot-api-gateway-image .
$docker push srinivasanugu/ocelot-api-gateway-image:latest
$kubectl apply -f .\Deployment\api-gateway-deployment.yaml
$kubectl apply -f .\Deployment\ocelot-route-config.yaml

$minikube service ocelot-api-gateway-service --url
http://localhost:8010/health
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
