Navigate to API Gateway Services file Path:
https://hub.docker.com/repositories/srinivasanugu
```
docker login
Navigate to applicatio folder: C:\Development\github\microservices.api\
$docker build -t srinivasanugu/catalog-api-image -f ./Services/Catalog/Catalog.API/Dockerfile .
$docker push srinivasanugu/catalog-api-image:latest

--Deploy
$kubectl apply -f ./Services/Catalog/Catalog.API/Deployment/catalog-api-screts.yaml
$kubectl apply -f ./Services/Catalog/Catalog.API/Deployment/catalog-api-deployment.yaml
#kubectl port-forward catalog-api-0 9200:8080
http://localhost:9200/swagger/index.html
```

```
//Build and push Image to Docker Hub:
$docker build -t srinivasanugu/ocelot-api-gateway-image .
$docker push srinivasanugu/ocelot-api-gateway-image:latest
$minikube service ocelot-api-gateway-service --url
#kubectl port-forward <your-pod-name> localPort:servicePort -n <your-namespace>
Example: #kubectl port-forward ocelot-api-gateway-deployment-5d8897dd88-v8hv7 8010:8080
OR
#kubectl port-forward --address 0.0.0.0 ocelot-api-gateway-deployment-5d8897dd88-v8hv7 8010:8080
```
```
//run localy
$docker run -p 8010:8080 ocelot-api-gateway-image
//for additional containers
$docker container run --name [container_name] [docker_image]
$docker container run -p 8080:8010 ocelot-api-gateway-image  
```