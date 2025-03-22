resource "helm_release" "argocd" {
  name       = "argocd"
  namespace  = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "4.1.0"
  # lint       = true
  # wait       = false

  create_namespace = true

  values = [
    file("values.yaml")
  ]

}
