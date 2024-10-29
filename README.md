**NOTICE: This repo/action is no longer being maintained.** At GlueOps we have migrated towards using this manifest (see below) so that we can maintain flexibility per repository/image. If you are using GHCR.io as your registry this yaml should provide a drop in replacement:


```
name: Publish to GHCR.io
 
on: [push]

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build_tag_push_to_ghcr:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
      - name: Checkout repository
        uses: actions/checkout@692973e3d937129bcbf40652eb9f2f61becf3332 # v4

          
      - name: Set up QEMU
        uses: docker/setup-qemu-action@68827325e0b33c7199eb31dd4e31fbe9023e06e3 # v3

      - name: Setup Docker buildx
        uses: docker/setup-buildx-action@d70bba72b1f3fd22344832f00baa16ece964efeb # v3.3.0

      - name: Log into registry ${{ env.REGISTRY }}
        uses: docker/login-action@0d4c9c5ea7693da7b068278f7b52bda2a190a446 # v3.2.0
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Extract Docker metadata
        id: meta
        uses: docker/metadata-action@8e5442c4ef9f78752691e2d8f8d19755c6f78e81 # v5.5.1
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch,prefix=
            type=ref,event=tag,prefix=
            type=sha,format=short,prefix=
            type=sha,format=long,prefix=

      - name: Build and push Docker image
        id: build-and-push
        uses: docker/build-push-action@ca052bb54ab0790a636c9b5f226502c73d547a25 # v5.4.0
        with:
          context: .
          push: ${{ github.event_name != 'pull_request' }}
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          provenance: false
          cache-from: type=gha
          cache-to: type=gha,mode=max




```





** END OF NOTICE **



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
        uses: GlueOps/github-actions-build-push-containers@v0.3.7
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
        uses: GlueOps/github-actions-build-push-containers@v0.3.7
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
        uses: GlueOps/github-actions-build-push-containers@v0.3.7
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
        uses: GlueOps/github-actions-build-push-containers@v0.3.7
        with:
          registry: "<aws-account-id>.dkr.ecr.<aws-region>.amazonaws.com"
          aws_role_to_assume: ${{ secrets.AWS_ECR_ROLE_ARN }}
          aws_default_region: ${{ env.AWS_REGION}}
```
