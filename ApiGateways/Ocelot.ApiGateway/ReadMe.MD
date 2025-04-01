Navigate to API Gateway Docker file Path:
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