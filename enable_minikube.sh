minikube start extra-config=apiserver.Authorization.Mode=RBAC
minikube addons enable ingress
minikube addons enable metrics-server
kubectl config current-context
