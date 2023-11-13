provider "helm" {
  kubernetes {
    host = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

    exec {
        api_version = "client.authentication.k8s.io/v1beta1"
        command = "aws"
        args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

resource "helm_release" "osmcha-ingress-nginx" {
  name = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  version = "4.8.3"
  namespace = "ingress-nginx"
  create_namespace = true
}

resource "helm_release" "osmcha-cert-manager" {
  name = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  version = "v1.13.2"
  namespace = "cert-manager"
  create_namespace = true

  set {
    name  = "installCRDs"
    value = true
  }
}

resource "helm_release" "osmcha-redis" {
  name = "redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart = "redis"
  version = "18.3.2"
  namespace = "default"

  set {
    name = "architecture"
    value = "standalone"
  }

  set {
    name = "auth.enabled"
    value = "false"
  }
}