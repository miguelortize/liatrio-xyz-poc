# Build step to create an executable JAR Manually.

### Please keep in mind since version v0.0.2 of this repository this has been automated and is no longer necessary unless you want to test new features.

```
# This will create a /target folder where your .jar files will be stored.
mvn install
```

Login to GCP [prefered authentication method](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling#key)

```
# You might need to reach out to the project owner for permissions to push and pull artifacts from GCP artifact registry.

gcloud auth login

gcloud auth configure-docker us-central1-docker.pkg.dev
```

Docker step to build and tag your image.

```
# Add your image version here based on semantic versioning (major.minor.patch) 
docker build -t us-central1-docker.pkg.dev/test-project-miguel/xyz-liatrio-poc/xyz/xyz-liatrio:dev .
```

Push image to repository.

```
# Contact your system administrator if you encounter issues in this step.
docker push us-central1-docker.pkg.dev/test-project-miguel/xyz-liatrio-poc/xyz/xyz-liatrio:dev
```

[To add account roles](https://cloud.google.com/artifact-registry/docs/docker/pushing-and-pulling#required_roles)
