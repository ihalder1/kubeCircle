module "jx" {
    source = "jenkins-x/jx/google"
    gcp_project = "jenkins-x-indradip"
    zone = "us-west1-b"
    cluster_name = "indra-jenkins-x-cluster"
    dev_env_approvers = "ihalder1"
    force_destroy = true
    git_owner_requirement_repos = "ihalder1"
    jenkins_x_namespace = "indra-jenkins-x"
    max_node_count = 3
    node_disk_size = 30
}

output "jx_requirements" {
    value = module.jx.jx_requirements
}