# Swissborg task: K8s+ArgoCd+Keycloak+Traefik

## Prerequisites

To deploy Kubernetes through Terraform, you need to have your AWS CLI configured with your AWS account by setting up access keys in `~/.aws/credentials`.


## Deploying Kubernetes Cluster with Terraform

1. Navigate to the Terraform directory:
   ```sh
   cd terraform
   ```
2. Initialize Terraform:
   ```sh
   terraform init
   ```
3. Plan the deployment:
   ```sh
   terraform plan
   ```
4. Apply the configuration to deploy the Kubernetes cluster in auto-mode:
   ```sh
   terraform apply
   ```
5. After EKS and other resources are deployed, update your kubeconfig:
   ```sh
   aws eks update-kubeconfig --name swissborg-cluster --region us-east-1
   ```

## Deploying the Application Stack

### Deploying ArgoCD

From the root folder, deploy ArgoCD:

```sh
kubectl create namespace argo
kubectl apply -n argo -f argocd/install.yaml
```

**Note:** Room for improvement here is to have ArgoCD deploy itself automatically.

### Deploying Traefik via Helm and ArgoCD

```sh
kubectl apply -n argo -f traefik/traefik-application.yaml
```

**Notes:**

- We could host our own version of the Traefik chart.
- Customization could be improved by passing additional overriding values.

### Obtaining External IP from Traefik LoadBalancer

Once Traefik is deployed, retrieve the External IP:

```sh
kubectl get svc -n ingress
```

Replace all occurrences of `EXTERNAL_IP` in all occurences in configuration files with the obtained External IP, then push the changes to the main branch so Argo sees it.

### Deploying Storage for Keycloak Using ArgoCD

```sh
kubectl apply -f storage/storage-application.yaml
```

### Deploying Keycloak Using ArgoCD

```sh
kubectl apply -f keycloak/keycloak-application.yaml
```

This will automatically deploy Keycloak and its realm configuration, ensuring that ArgoCD is behind it.

**Note:** Some values were hardcoded in this setup.

### Configuring ArgoCD OIDC to Work with Keycloak

```sh
kubectl apply -f argocd-config/argocd-oidc-application.yaml
```

### Deploying Ingresses for Traefik

```sh
kubectl apply -f ingresses/ingresses-application.yaml
```

## Future Enhancements for Production

In a production environment, we would additionally:

- Create a **runner and a CI pipeline** to automate this entire integration and delivery process with ArgoCD.
- Store necessary values as **environment secrets**.
- Include **tests** to validate deployments.

## Conclusion

For this task, due to very limited time I had this week, the quickest solution with minimal additional configuration was chosen. I'm happy to discuss more about it.

