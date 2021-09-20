# Jenkins
Jenkins instance for GKE using 'helm template' command as base for kustomization.
Dotted lines indicate inheritance:

```
jenkins
├── helm-base ╍╍╍╍╷
└── overlays      ╎
    └── gke-tom ╍╍╵
```

### How to...

* Print out applied yaml to build folder: `kubectl apply -k ./overlays/tom-gke --dry-run=client -o yaml > build/dry-run.yaml`
* Update base from helm in cloud shell
  * Set env var HELM_INSTALL_DIR to your home directory
  * Follow instructions for installing [helm from script](https://helm.sh/docs/intro/install/#from-script)
  * `helm repo add jenkins https://charts.jenkins.io`
  * `helm repo update`
  * `helm template tom jenkins/jenkins -n helm-base > helm-base/jenkins.yaml`
  * Helm-base test deployment
    * `kubectl apply -k ./helm-base`
    * `kubectl get pods -n helm-base`
    * `kubectl port-forward -n helm-base [HELM_BASE_PODNAME] 8080:8080 >> /dev/null`
    * Web preview > Preview on port 8080
