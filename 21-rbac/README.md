# RBAC
RBAC: Role-Based Access Control

## Introduction

RBAC is a mechanism in K8s that allows us to define user privileges on Kubernetes resources. We can use RBAC to define access rights on users, by declaring who is going to access, use, modify and even delete a resource on k8s.
“Because Kubernetes RBAC is REST-based, it maps HTTP verbs to permissions. For example, POST is mapped to the create right.”
[source](https://blog.aquasec.com/kubernetes-verbs?ref=anaisurl.com)

RBAC is enabled in your cluster by default.

## Exercices

Part of this tutorial is derived from the official k8s documentation

Nothing to see here.

## Clean up

```sh
kubectl delete service,deployment,pod --all
```

## Links
