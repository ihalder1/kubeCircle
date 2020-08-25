# kubeCircle

## Build from Scratch

### Environment Setup in GCP
$] gcloud auth login --no-launch-browser
$] gcloud projects create jenkins-x-indradip
$] gcloud config set project jenkins-x-indradip
$] gcloud alpha billing accounts list
$] gcloud alpha billing projects link jenkins-x-indradip --billing-account 0116D0-816F45-723D2C


### Create a Service Account and corresponding key
$] gcloud iam service-accounts create sa-terraform --display-name "Service Account for Terraform"
$] gcloud iam service-accounts keys create ..\..\..\.ssh\gcloudkey.json --iam-account sa-terraform@jenkins-x-indradip.iam.gserviceaccount.com

### Setup a gcloud_jenkinsx folder
$] gcloud auth application-default login
$] gcloud compute instances list
$] mkdir gcloud_jenkinsx
$] cd gcloud_jenkinsx
$] touch main.tf
$] terraform init
$] terraform plan
$] terraform apply
Note : After first apply below error will appear
```
Error: Error applying IAM policy for service account 'projects/jenkins-x-indradip/serviceAccounts/tf-jx-neat-owl-dn@jenkins-x-indradip.iam.gserviceaccount.com': Error setting IAM policy for service account 'projects/jenkins-x-indradip/serviceAccounts/tf-jx-neat-owl-dn@jenkins-x-indradip.iam.gserviceaccount.com': googleapi: Error 400: Workload Identity Pool does not exist (jenkins-x-indradip.svc.id.goog)., badRequest

  on .terraform\modules\jx\terraform-google-jx-1.8.0\modules\dns\main.tf line 111, in resource "google_service_account_iam_member" "cm_cert_manager_workload_identity_user":
 111: resource "google_service_account_iam_member" "cm_cert_manager_workload_identity_user" {
```
So apply one moretime
$] terraform apply
$] mkdir jx_boot (This directory should be created outside this git repo)
$] terraform output jx_requirement ../../jx-boot/jx-requirements.yml
$] gcloud container clusters get-credentials <cluster-name>

Then move to jx_boot directory

$] jx boot --requirements jx-requirements.yml















