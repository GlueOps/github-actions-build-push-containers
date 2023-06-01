# Custom Action to push Docker images to GitHub Container Registry
Whenever there's a push event or a release event in the repository, this action automatically pushes the Docker image to ghcr.io. 

No more manual hassle! 🚀💪

## 💡 Benefits:
✅ Streamlined workflow: Say goodbye to tedious configuration and manual image deployments.

✅ Increased efficiency: Focus on developing and let the CI/CD pipeline handle image distribution.

✅ Seamless integration: GitHub Container Registry simplifies container image management.

## 🛠️ How to Use
- Create a Personal Access Token (PAT), if you already do not have one and grant ```write``` access to your workflow under the Personal Access Token column. This is because by default, workflows have ```read``` access.

<img width="1271" alt="PAT" src="https://github.com/Mbaoma/AKS-Demo/assets/49791498/034043d1-799f-40e0-be89-8e3e775133f0">

*Generate PAT*

<img width="806" alt="image" src="https://github.com/Mbaoma/AKS-Demo/assets/49791498/06722ea6-72d3-4573-ba62-581929474666">

*Update Permissions*

- In your repository's settings, under the ```Actions``` tab, click on ```General```, scroll to the bottom and enable ```Read and write permissions``` for your ```Workflow Permissions```.
Click ```Save```.

<img width="1143" alt="image" src="https://github.com/Mbaoma/build-image/assets/49791498/92ff77e4-16a9-4798-85bd-3d0ee9a5cb11">

*Actions Tab*

<img width="1143" alt="image" src="https://github.com/Mbaoma/build-image/assets/49791498/6e8d3834-e10f-4cc1-b320-bfe58e1cfed5">

*Permission Update*

- Add this step to your workflow as follows:
```Docker
name: Build, Tag and Publish Docker image to ghcr.io
 
on: [push]

jobs:
  build_tag_push_to_ghcr:
    runs-on: ubuntu-latest
    steps:
      - name: Build and Push Docker Image
        uses: Mbaoma/build-image@v1.0.0
```

## 🔖 Image Tags
Your image is automatically tagged based on the event behind the image creation.

### Image Tagging Scenario: On Push Event 🚀
Whenever a push event occurs in the repository, this workflow automatically assigns relevant tags to your image. The tags include the ```branch slug```, ```short SHA (commit identifier)```, and ```long SHA```, providing valuable context about the image's origin and version.

For example, let's consider a scenario where you have a GitHub repository for a web application called ```MyWebApp```. Whenever a developer pushes changes to the ```develop``` branch, the workflow automatically tags the image with the following details:

```bash
Branch Slug: develop
Short SHA: abcdefg
Long SHA: abcdefghijklmnopqrstuvwxyz
```

### Image Tagging Scenario: On Release Event 🚀
Whenever a release event occurs in the repository, the action automatically assigns relevant tags to your image. The tags include the ```release version```, ```short SHA (commit identifier)```, and ```long SHA```, providing valuable context about the image's origin and version.

For example, let's consider a scenario where you have a GitHub repository for a web application called ```MyWebApp```. Whenever a developer creates a new release with version ```v1.0```, the action automatically tags the image with the following details:

```bash
Release Version: v1.0
Short SHA: abcdefg
Long SHA: abcdefghijklmnopqrstuvwxyz
```

These automated tagging processes ensures that you can easily track and identify specific versions of your application, streamlining your development and deployment workflows.

## 🏳️ Defaults
- Your ```Dockerfile``` has to be in the root directory.
- Your ```docker image``` is named after your repository.

This workflow is inspired by macbre's work.