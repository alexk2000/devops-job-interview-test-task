# Test task

## Demo
On demand.

## Tools
- K3S (Kubernetes distro)
- Terraform instead of Vagrant
- Ansible
- Gitlab CI instead of Argo CI
- GitOps, Flux CD instead of Argo CD

## How it works
Terraform creates AWS EC2 instance and runs [ansible playbook](ansible/test-task.yaml) (through provisioner "local-exec") which installs K3S and Flux CD. Flux CD polls every 20 seconds directory [flux](flux) in this repositry for any Kubernetes manifests and applies them in Kubernetes (aka deploy). Docker image is built on any commit to master and pushed to Gitlab registry. Flux CD monitors docker registry for new image, if found - does commits to the repository to update image tag in [deployment.yaml](flux/deployment.yaml#L22) ([example](https://gitlab.com/alexk2000/test-task/-/commit/db455ff8d3a96d29911073fe9e142f19b38183e3)). Once it's done Flux CD deploys the application using new image.

# CI
CI includes test and build steps. Build step creates docker image and pushes to Gitlab registry, the image used in [deployment manifest](flux/deployment.yaml#L22). CI pipeline is [.gitlab-ci.yml](.gitlab-ci.yml), triggered on each commit to master.

# CD
Any change in [deployment.yaml](flux/deployment.yaml) means redeploy performed by Flux CD. Also Flux CD monitors docker registry for new images and if appeared - updates image tag in [deployment.yaml](flux/deployment.yaml#L22) by new commit and thus triggers new deploy.

