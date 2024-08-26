### Google Cloud Functions with Pub/Sub

Google Cloud Functions is a serverless execution environment for building and connecting cloud services. With Cloud Functions, you write simple, single-purpose functions that are attached to events emitted from your cloud infrastructure and services. Functions are written in JavaScript, Go, or Python and execute in a fully managed environment where you do not need to worry about maintaining servers.

#### Design Decisions

This module follows several design principles to simplify the delivery and management of Google Cloud Functions with integration to Pub/Sub:

- **Serverless:** The functions are executed in a serverless environment, removing the need for server management.
- **Event-Driven:** Function execution is triggered by events from Cloud Pub/Sub.
- **Configurable:** Memory allocation, runtime, and retry policies are configurable to meet a variety of use cases.
- **Dependency Management:** Dependencies such as required Google APIs are provisioned within the module to ensure all necessary services are enabled.

### Runbook

#### Function Deployment Failures

If your Google Cloud Function fails to deploy, it could be due to incorrect configurations or missing permissions.

Check the deployment logs using gcloud CLI:

```sh
gcloud functions logs read <function-name>
```

Look for specific error messages and verify the necessary APIs are enabled and the appropriate permissions are assigned.

#### Cloud Pub/Sub Message Not Triggering Function

If your cloud function is not triggered by messages published to the Cloud Pub/Sub topic, verify the following:

Check the function’s trigger:

```sh
gcloud functions describe <function-name> --format="value(eventTrigger)"
```

Ensure the `eventTrigger` configuration is set correctly to the appropriate Pub/Sub topic.

Check the subscription on the Pub/Sub topic:

```sh
gcloud pubsub topics list-subscriptions <topic-name>
```

Ensure there’s an active subscription that maps to the cloud function.

#### Memory Issues and Timeouts

If your function is running out of memory or timing out, you may need to adjust the allocated resources:

Check and update memory settings:

```sh
gcloud functions deploy <function-name> --memory <memory-size>
```

Update the function timeout setting:

```sh
gcloud functions deploy <function-name> --timeout <timeout-duration>
```

#### Connectivity to Other Google Services

If your function cannot connect to other Google services such as Cloud Storage or Datastore, ensure that the appropriate IAM roles are assigned to the service account running the function.

List roles assigned to the service account:

```sh
gcloud projects get-iam-policy <project-id> --flatten="bindings[].members" --format="table(bindings.role)"
```

Assign missing roles if necessary:

```sh
gcloud projects add-iam-policy-binding <project-id> --member="serviceAccount:<service-account-email>" --role="roles/<role>"
```

