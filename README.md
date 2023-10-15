# Custom Action to build and push Docker images to GitHub Container Registry (ghcr.io), Docker Hub (docker.io), and AWS ECR

Automate your Docker image deployments effortlessly with this custom GitHub Action! 🚀💪
Configure the event using the GitHub Actions `on:` clause to determine what triggers builds.
This Action supports both public and private repositories for ghcr, docker, and ecr.
The default registry is ghcr.io.

## 💡 Benefits

✅ Streamlined workflow: Say goodbye to tedious configuration and manual image deployments.

✅ Increased efficiency: Focus on developing and let the CI/CD pipeline handle image distribution.

✅ Seamless integration: simplifies container image management.

✅ Default Image Tagging: Out-of-the-box tagging with the below elements.

* `Target Reference:` Either Branch Name or Tag, depending upon the trigger context.
* `Short SHA`
* `SHA`

## 🛠️ How to Use

For detailed usage instructions, refer to the [GlueOps Documentation](https://glueops.dev/docs/deploy-applications/deploy-hello-world-to-glueops#add-ci-to-publish-a-docker-image-to-github-container-registry).

### Example Configurations

#### **GitHub Container Registry (ghcr.io)**

```yaml
name: Build and Push Container to GitHub Container Registry

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  build_and_push:
    runs-on: ubuntu-latest
    steps:
      - name: Build and Push Container to ghcr.io
        uses: GlueOps/github-actions-build-push-containers@v0.2.0
```

#### **Docker Hub (docker.io)**

```yaml
name: Build and Push Container to Docker Hub

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  build_and_push:
    runs-on: ubuntu-latest
    steps:
      - name: Build and Push Container to docker.io
        uses: GlueOps/github-actions-build-push-containers@v0.2.0
        with:
          registry: "docker.io"
          dockerhub_username: ${{ secrets.DOCKERHUB_USERNAME }}
          dockerhub_password: ${{ secrets.DOCKERHUB_PASSWORD }}
```

#### **AWS Elastic Container Registry (.dkr.ecr.)**

```yaml
name: Build and Push Container to ECR

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  build_and_push:
    runs-on: ubuntu-latest
    steps:
      - name: Build and Push Container to ECR
        uses: GlueOps/github-actions-build-push-containers@v0.2.0
        with:
          registry: "<aws-account-id>.dkr.ecr.<aws-region>.amazonaws.com"
          aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
```