module "jx" {
    source = "jenkins-x/jx/google"
    gcp_project = "jenkins-x-indradip"
    zone = "us-west1-b"
    cluster_name = "indra-jenkins-x-cluster"
    force_destroy = true
    
}

output "jx_requirements" {
    value = module.jx.jx_requirements
}