#### Prerequisites:
Install Docker Desktop, Minikube
```
$minikube delete
$minikube start
$minikube dashboard
$minikube ip -- Check Minikube Ip and use this IP for both Gateway and APIs
1.$minikube ssh
2.$cat /etc/hosts
#minikube logs
#minikube service list
//Connect to Pod
kubectl exec -it my-angular-app-0 -- /bin/sh
ping host.minikube.internal
curl http://host.minikube.internal:30001/api/v1/Catalog/GetAllBrands
curl http://192.168.49.2:30001/api/v1/Catalog/GetAllBrands
kubectl exec -it ocelot-gateway-0 -- env
```

kubectl get nodes -o wide
kubectl describe nodes
kubectl get services
kubectl get all