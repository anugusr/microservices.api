cd ..
docker build -t srinivasanugu/catalog-api-image -f ./Services/Catalog/Catalog.API/Dockerfile .
docker push srinivasanugu/catalog-api-image:latest

docker build -t srinivasanugu/basket-api-image -f ./Services/Basket/Basket.API/Dockerfile .
docker push srinivasanugu/basket-api-image:latest

docker build -t srinivasanugu/discount-api-image -f ./Services/Discount/Discount.API/Dockerfile .
docker push srinivasanugu/discount-api-image:latest

docker build -t srinivasanugu/order-api-image -f ./Services/Ordering/Ordering.API/Dockerfile .
docker push srinivasanugu/order-api-image:latest

docker build -t srinivasanugu/ocelot-api-gateway-image -f ./ApiGateways/Ocelot.ApiGateway/Dockerfile .
docker push srinivasanugu/ocelot-api-gateway-image:latest

kubectl apply -f ./Services/Catalog/Catalog.API/Deployment/catalog-api-screts.yaml
kubectl apply -f ./Services/Catalog/Catalog.API/Deployment/catalog-api-deployment.yaml

kubectl apply -f ./Services/Basket/Basket.API/Deployment/basket-api-secret.yaml
kubectl apply -f ./Services/Basket/Basket.API/Deployment/basket-api-deployment.yaml

kubectl apply -f ./Services/Discount/Discount.API/Deployment/discount-api-secret.yaml
kubectl apply -f ./Services/Discount/Discount.API/Deployment/discount-api-deployment.yaml

kubectl apply -f ./Services/Ordering/Ordering.API/Deployment/order-api-secret.yaml
kubectl apply -f ./Services/Ordering/Ordering.API/Deployment/order-api-deployment.yaml

kubectl create configmap ocelot-config --from-file=./ApiGateways/Ocelot.ApiGateway/Deployment/ocelot.Development.json
kubectl apply -f ./ApiGateways/Ocelot.ApiGateway/Deployment/ocelot-route-config.yaml

pause