# Jenkins
Jenkins instance for GKE using `helm template` command as base for kustomization.  
If you are contributing, the general rule of thumb is everything through git; as-code if you can, sh script in few the instances you can't.  

Dotted lines indicate inheritance:

```
jenkins
├── helm-base ╍╍╍╍╷
└── overlays      ╎
    └── gke-tom ╍╍╵
```

### How to...

* Add webhook trigger for your github repo and job
  * Using the values in `overlays/tom-gke/smee-auth.env`, create a webhook in github for your repository:
    * Go to `Settings` > `Webhooks` > `Add webhook`
    * Payload URL: `https://smee.io/[SMEE_ID]`
    * Content type: `application/json`
    * Secret: `[API_TOKEN]`
    * Which events?
      * `Let me select individual events`
      * Check off `Pull requests` and `Pushes`
* Deploy changes: `kubectl apply -k ./overlays/tom-gke`
* Print out applied yaml to build folder: `kubectl apply -k ./overlays/tom-gke --dry-run=server -o yaml > build/dry-run.yaml`
* Update base from helm in cloud shell
  * Set env var HELM_INSTALL_DIR to your home directory (TODO: script this)
  * Follow instructions for installing [helm from script](https://helm.sh/docs/intro/install/#from-script)
  * `helm repo add jenkins https://charts.jenkins.io`
  * `helm repo update`
  * `helm template tom jenkins/jenkins -n helm-base > helm-base/jenkins.yaml`
  * Helm-base test deployment
    * `kubectl apply -k ./helm-base`
    * `kubectl get pods -n helm-base`
    * `kubectl port-forward -n helm-base [HELM_BASE_PODNAME] 8080:8080 >> /dev/null`
    * Web preview > Preview on port 8080
