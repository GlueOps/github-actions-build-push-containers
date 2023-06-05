# Custom Action to push Docker images to GitHub Container Registry
Whenever there's a push event or a release event in the repository, this action automatically pushes the Docker image to ghcr.io. 

No more manual hassle! 🚀💪

## 💡 Benefits:
✅ Streamlined workflow: Say goodbye to tedious configuration and manual image deployments.

✅ Increased efficiency: Focus on developing and let the CI/CD pipeline handle image distribution.

✅ Seamless integration: GitHub Container Registry simplifies container image management.

## 🛠️ How to Use
- In your repository's settings, under the ```Actions``` tab, click on ```General```, scroll to the bottom and enable ```Read and write permissions``` for your ```Workflow Permissions```.
Click ```Save```.

<img width="1143" alt="image" src="https://github.com/Mbaoma/build-image/assets/49791498/92ff77e4-16a9-4798-85bd-3d0ee9a5cb11">

*Actions Tab*

<img width="1143" alt="image" src="https://github.com/Mbaoma/build-image/assets/49791498/6e8d3834-e10f-4cc1-b320-bfe58e1cfed5">

*Permission Update*

- Add this step to your workflow as follows:
```Docker
name: GlueOps Action
 
on: [push]

jobs:
  build_tag_push_to_ghcr:
    runs-on: ubuntu-latest
    steps:
      - name: Build, Tag and Push Docker Image to GHCR
        uses: GlueOps/github-actions-build-push-containers@v0.1.0
```

## 🔖 Image Tags
Your image is automatically tagged based on the event behind the image creation.

### Image Tagging Scenario: On Push Event 🚀
Whenever a push event occurs in the repository, this workflow automatically assigns relevant tags to your image. The tags include the ```branch slug```, ```short SHA (commit identifier)```, and ```long SHA```, providing valuable context about the image's origin and version.

For example, let's consider a scenario where you have a GitHub repository for a web application called ```MyWebApp```. Whenever a developer pushes changes to the ```develop``` branch, the workflow automatically tags the image with the following details:

| Key             | Value                                     |
| ---             | ---                                       |
| Branch slug     | develop                                   |
| Short SHA       | 32b5b6b                                   |
| Long SHA        | 32b5b6b7bd6e070f8f176e1423938d66072e6463  |


### Image Tagging Scenario: On Release Event 🚀
Whenever a release event occurs in the repository, the action automatically assigns relevant tags to your image. The tags include the ```release version```, ```short SHA (commit identifier)```, and ```long SHA```, providing valuable context about the image's origin and version.

For example, let's consider a scenario where you have a GitHub repository for a web application called ```MyWebApp```. Whenever a developer creates a new release with version ```v1.0.0```, the action automatically tags the image with the following details:

| Key             | Value                                     |
| ---             | ---                                       |
| Release version | v1.0.0                                    |
| Short SHA       | 32b5b6b                                   |
| Long SHA        | 32b5b6b7bd6e070f8f176e1423938d66072e6463  |

These automated tagging processes ensures that you can easily track and identify specific versions of your application, streamlining your development and deployment workflows.

## 🏳️ Defaults
- Your ```Dockerfile``` has to be in the root directory.
- Your ```docker image``` is named after your repository.

## Pushing to GitHub
```bash
$ git add .
$ git commit -m 'commit-message'
$ git tag -a -m "Description of this release" v1
$ git push --follow-tags
```

- Delete a tag remotely
```bash
$ git push --delete origin v1.0
```

- Delete a tag locally
```bash
$ git tag --delete tagname
```

This workflow is inspired by [macbre's](https://github.com/macbre/push-to-ghcr) work.