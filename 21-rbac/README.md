# RBAC
RBAC: Role-Based Access Control

## Introduction

RBAC is a mechanism in K8s that allows us to define user privileges on Kubernetes resources. We can use RBAC to define access rights on users, by declaring who is going to access, use, modify and even delete a resource on k8s.
“Because Kubernetes RBAC is REST-based, it maps HTTP verbs to permissions. For example, POST is mapped to the create right.”
[source](https://blog.aquasec.com/kubernetes-verbs?ref=anaisurl.com)

Part of this tutorial is based on the official k8s documentation and the following blog post on [medium](https://medium.com/@HoussemDellai/rbac-with-kubernetes-in-minikube-4deed658ea7b)


RBAC is enabled in your cluster by default.
For minikube check the shell script to enable RBAC support

## Exercices

First of all we need to create a key and a certificate that are going to be used for access for the users in resources.  

Create the folder to store the certification keys for the user

```bash
mkdir .cert && cd .cert

# This command generates the RSA key using 2048 bits encryption
openssl genrsa -out user-reader.key 2048

```

The following command issues a CSR (Certificate Signing Request) using the `user-reader.key` and providing the subject information which holds the information about the entity requesting the certificate. 

- CN: Represents the primary domain value 
- O: Organization value 

```bash
openssl req -new -key user-reader.key -out user-reader.csr -subj "/CN=user-reader/O=group1"
```

The following command process a CSR and produces a signed certificate ready to be used in our example 
#### TODO Add modere details
```bash
openssl x509 -req -in user-reader.csr -CA ~/.minikube/ca.crt -CAkey ~/.minikube/ca.key -CAcreateserial -out user-reader.crt -days 500
```

#### Create User
kubectl config set-credentials user-reader --client-certificate=user-reader.crt --client-key=user-reader.key
kubectl config set-context user-context --cluster=minikube --user=user-reader


This shows the configuration of the user and the context
kubectl config view 

We now want to see the authorization issues:
kubectl config use-context user-context
// This shows the context you are in, it should be user-context
kubectl config current-context
// The following command raises error, as the user doesn't have priviliges
kubectl create namespace ns-test

Now switching back to minikube context and apply the configs about the new role and role-binding
kubectl config use-context minikube

Run the following command to check the new roles:


Remember that when you wish to change the role for a user, the name variables are immutable. You have to delete the role/rolebindings and recreate them again if you wish your actions to have an effect. 

You can use the following commands to delete your role/rolebinding:

```bash
kubectl delete role <NAME_OF_ROLE> -n <NAMESPACE>
kubectl delete rolebinding <NAME_OF_ROLEBINDING> -n <NAMESPACE>
```

```sh
kubectl get roles -n application
```


## Clean up

```sh
kubectl delete service,roles,rolebindings,pod --all
```

## Links
