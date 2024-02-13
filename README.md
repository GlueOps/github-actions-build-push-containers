# Custom Action to build and push Docker images to GitHub Container Registry (ghcr.io), Docker Hub (docker.io), and AWS ECR

Automate your Docker image deployments effortlessly with this custom GitHub Action! 🚀💪
Configure the event using the GitHub Actions `on:` clause to determine what triggers builds.
This Action supports both public and private repositories for ghcr, docker, and ecr.
The default registry is ghcr.io.

## 💡 Benefits

✅ Streamlined workflow: Say goodbye to tedious configuration and manual image deployments.

✅ Increased efficiency: Focus on developing and let the CI/CD pipeline handle image distribution.

✅ Seamless integration: simplifies container image management.

✅ Default Image Tagging: Out-of-the-box tagging with the below elements.  The default tags can be overridden by passing in a comma-separated string of desired tags, e.g. "my-tag" or "my-tag-1,my-tag-2".  Tags are generated with the [create-glueops-image-tags](https://github.com/marketplace/actions/create-glueops-image-tags) action.

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
        uses: GlueOps/github-actions-build-push-containers@v0.3.6
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
        uses: GlueOps/github-actions-build-push-containers@v0.3.6
        with:
          registry: "docker.io"
          dockerhub_username: ${{ secrets.DOCKERHUB_USERNAME }}
          dockerhub_password: ${{ secrets.DOCKERHUB_PASSWORD }}
```

#### **AWS Elastic Container Registry (.dkr.ecr.) - with Access Keys**

```yaml
name: Build and Push Container to ECR using Access Keys

on:
  pull_request:
    types: [opened, synchronize, reopened]

jobs:
  build_and_push:
    runs-on: ubuntu-latest
    steps:
      - name: Build and Push Container to ECR
        uses: GlueOps/github-actions-build-push-containers@v0.3.6
        with:
          registry: "<aws-account-id>.dkr.ecr.<aws-region>.amazonaws.com"
          aws_access_key_id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws_secret_access_key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws_default_region: ${{ env.AWS_REGION}}
```

#### **AWS Elastic Container Registry (.dkr.ecr.) - IAM Role**

Note that additioanl workflow permissions are required to enable use of GitHub OIDC.  Additional Documentation for configuration is available in the [aws-actions/configure-aws-credentials](https://github.com/aws-actions/configure-aws-credentials#oidc) repository.

```yaml
name: Build and Push Container to ECR using an IAM Role

on:
  pull_request:
    types: [opened, synchronize, reopened]

permissions:
  id-token: write
  contents: read # required because configuring permissions removes all permissions not declared

jobs:
  build_and_push:
    runs-on: ubuntu-latest
    steps:
      - name: Build and Push Container to ECR
        uses: GlueOps/github-actions-build-push-containers@v0.3.6
        with:
          registry: "<aws-account-id>.dkr.ecr.<aws-region>.amazonaws.com"
          aws_role_to_assume: ${{ secrets.AWS_ECR_ROLE_ARN }}
          aws_default_region: ${{ env.AWS_REGION}}
```
