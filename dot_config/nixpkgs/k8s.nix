{ pkgs, ... }:
let
  packages = with pkgs; {
    k8s = [
      helmfile # Deploy Kubernetes Helm Charts
      krew # Krew is the package manager for kubectl plugins.
      kubectl # Kubernetes.io client binary
      kubernetes-helm # The Kubernetes Package Manager
      telepresence2 # Local development against a remote Kubernetes or OpenShift cluster
    ];
  };
in
{
  home.packages =
    packages.k8s;
}
