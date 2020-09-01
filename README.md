# kubeCircle

## Build from Scratch

### Environment Setup in GCP
```
$] gcloud auth login --no-launch-browser
$] gcloud projects create jenkins-x-indradip
$] gcloud config set project jenkins-x-indradip
$] gcloud alpha billing accounts list
$] gcloud alpha billing projects link jenkins-x-indradip --billing-account <>
```

### Create a Service Account and corresponding key
```
$] gcloud iam service-accounts create sa-terraform --display-name "Service Account for Terraform"
$] gcloud iam service-accounts keys create ..\..\..\.ssh\gcloudkey.json --iam-account sa-terraform@jenkins-x-indradip.iam.gserviceaccount.com
```

### Setup a gcloud_jenkinsx folder
```
$] gcloud auth application-default login
$] gcloud compute instances list
$] mkdir gcloud_jenkinsx
$] cd gcloud_jenkinsx
$] touch main.tf
$] terraform init
$] terraform plan
$] terraform apply
```
Note : After first apply below error will appear
```
Error: Error applying IAM policy for service account 'projects/jenkins-x-indradip/serviceAccounts/tf-jx-neat-owl-dn@jenkins-x-indradip.iam.gserviceaccount.com': Error setting IAM policy for service account 'projects/jenkins-x-indradip/serviceAccounts/tf-jx-neat-owl-dn@jenkins-x-indradip.iam.gserviceaccount.com': googleapi: Error 400: Workload Identity Pool does not exist (jenkins-x-indradip.svc.id.goog)., badRequest

  on .terraform\modules\jx\terraform-google-jx-1.8.0\modules\dns\main.tf line 111, in resource "google_service_account_iam_member" "cm_cert_manager_workload_identity_user":
 111: resource "google_service_account_iam_member" "cm_cert_manager_workload_identity_user" {
```
So apply one moretime
```
$] terraform apply
$] mkdir jx_boot (This directory should be created outside this git repo)
$] terraform output jx_requirements > ../../jx-boot/jx-requirements.yml
$] gcloud container clusters get-credentials <cluster-name>
```
Then move to jx_boot directory
```
$] jx boot --requirements jx-requirements.yml
```





##################################################


#] jx version
Version        2.1.138
Commit         816ddc1
Build date     2020-08-29T09:00:05Z
Go version     1.13.8
Git tree state clean


#] jx create cluster gke
? Missing required dependencies, deselect to avoid auto installing: kubectl
Installing kubectl
Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?code_challenge=1kWlyhgCa6b_ZwEzNg0v8ncxLAfL0WcvV1vXSloDJ2Q&prompt=select_account&code_challenge_method=S256&access_type=offline&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&response_type=code&client_id=32555940559.apps.googleusercontent.com&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fappengine.admin+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcompute+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth


? Google Cloud Project: jenkins-x-indradip
Updated property [core/project].
? No cluster name provided so using a generated one: legebony
? Defaulting to cluster type: Zonal
? Google Cloud Zone: us-west1-b
? Defaulting to machine type: n1-standard-2
? Defaulting to minimum number of nodes: 3
? Defaulting to maximum number of nodes: 5
? Defaulting use of preemptible VMs: No
? Defaulting access to Google Cloud Storage / Google Container Registry: Yes
? Defaulting enabling Cloud Build, Container Registry & Container Analysis API's: Yes
? Defaulting enabling Kaniko for building container images: No
Creating cluster...
WARNING: Currently VPC-native is not the default mode during cluster creation. In the future, this will become the default mode and can be disabled using `--no-enable-ip-alias` flag. Use `--[no-]enable-ip-alias` flag to suppress this warning.
WARNING: Newly created clusters and node-pools will have node auto-upgrade enabled by default. This can be disabled using the `--no-enable-autoupgrade` flag.
WARNING: Starting in 1.12, default node pools in new clusters will have their legacy Compute Engine instance metadata endpoints disabled by default. To create a cluster with legacy instance metadata endpoints disabled in the default node pool, run `clusters create` with the flag `--metadata disable-legacy-endpoints=true`.
WARNING: Starting with version 1.18, clusters will have shielded GKE nodes by default.
WARNING: Your Pod address range (`--cluster-ipv4-cidr`) can accommodate at most 1008 node(s).
This will enable the autorepair feature for nodes. Please see https://cloud.google.com/kubernetes-engine/docs/node-auto-repair for more information on node autorepairs.
Creating cluster legebony in us-west1-b... Cluster is being health-checked (master is healthy)...done.
Created [https://container.googleapis.com/v1/projects/jenkins-x-indradip/zones/us-west1-b/clusters/legebony].
To inspect the contents of your cluster, go to: https://console.cloud.google.com/kubernetes/workload_/gcloud/us-west1-b/legebony?project=jenkins-x-indradip
kubeconfig entry generated for legebony.
NAME      LOCATION    MASTER_VERSION  MASTER_IP      MACHINE_TYPE   NODE_VERSION   NUM_NODES  STATUS
legebony  us-west1-b  1.15.12-gke.2   35.203.134.10  n1-standard-2  1.15.12-gke.2  3          RUNNING
Initialising cluster ...
? Configured Jenkins installation type: Serverless Jenkins X Pipelines with Tekton
Namespace jx created
? Missing required dependencies, deselect to avoid auto installing: kubectl
Installing kubectl
Context "gke_jenkins-x-indradip_us-west1-b_legebony" modified.
? Missing required dependencies, deselect to avoid auto installing: kubectl
Installing kubectl
Setting the docker registry organisation to jenkins-x-indradip in the TeamSettings
? Please enter the name you wish to use with git:  ihalder1
Git configured for user: ihalder1 and email indradip.halder4@gmail.com
Helm installed and configured
? No existing ingress controller found in the kube-system namespace, installing one: Yes

Note: this loadbalancer will fail to be provisioned if you have insufficient quotas, this can happen easily on a GKE free account.
To view quotas run: gcloud compute project-info describe
Waiting for external loadbalancer to be created and update the nginx-ingress-controller service in kube-system namespace
External loadbalancer created
Waiting to find the external host name of the ingress controller Service in namespace kube-system with name jxing-nginx-ingress-controller
You can now configure a wildcard DNS pointing to the new Load Balancer address 34.105.31.44
If you don't have a wildcard DNS setup then create a DNS (A) record and point it at: 34.105.31.44, then use the DNS domain in the next input...

If you do not have a custom domain setup yet, Ingress rules will be set for magic DNS nip.io.
Once you have a custom domain ready, you can update with the command jx upgrade ingress --cluster
? Domain 34.105.31.44.nip.io
nginx ingress controller installed and configured
? Default enabling long term logs storage: Yes
No bucket name provided for long term storage, creating a new one
The bucket gs://legebony-lts-99157003-57a9-4051-975a-de13aad1ea32 does not exist so lets create it
Set up a Git username and API token to be able to perform CI/CD
Creating a local Git user for github.com server
? github.com username: ihalder1
To be able to create a repository on github.com we need an API Token
Please click this URL and generate a token
https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo

Then COPY the token and enter it below:

? API Token: ****************************************
Select the CI/CD pipelines Git server and user
? Do you wish to use github.com as the pipelines Git server: Yes
Creating a pipelines Git user for github.com server
To be able to create a repository on github.com we need an API Token
Please click this URL and generate a token
https://github.com/settings/tokens/new?scopes=repo,read:user,read:org,user:email,write:repo_hook,delete_repo

Then COPY the token and enter it below:

? API Token: ****************************************
Setting the pipelines Git server https://github.com and user name ihalder1.
Enumerating objects: 1440, done.
Total 1440 (delta 0), reused 0 (delta 0), pack-reused 1440
? Defaulting workload build pack: Kubernetes Workloads: Automated CI+CD with GitOps Promotion
Setting the team build pack to kubernetes-workloads repo: https://github.com/jenkins-x-buildpacks/jenkins-x-kubernetes.git ref: master
Installing jx into namespace jx
Installing jenkins-x-platform version: 2.0.2387

WARNING: waiting for install to be ready, if this is the first time then it will take a while to download images

Jenkins X deployments ready in namespace jx
Configuring the TeamSettings for ImportMode Jenkinsfile
Configure Jenkins API Token
WARNING:
retrying after error:creating Jenkins Auth configuration: secrets "jenkins" not found
WARNING:
retrying after error:creating Jenkins Auth configuration: secrets "jenkins" not found
ERROR: error creating cluster configuring Jenkins: creating Jenkins API token: after 3 attempts, last error: creating Jenkins Auth configuration: secrets "jenkins" not found
error: configuring Jenkins: creating Jenkins API token: after 3 attempts, last error: creating Jenkins Auth configuration: secrets "jenkins" not found