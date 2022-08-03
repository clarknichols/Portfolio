## Schedule A Docker Container to Run a new Instance of Sales-Force Extractor 

The following describes how to schedule Argo pull a new unique instance of the Salesforce-extractor Docker container from s3.

1. Create a `*.yaml.` file with the name your topic with the appropriate fields in the `.../topics` directory, and ensure that it is a valid Salesforce object type.
2. Run `generate.sh` to create `.../CronWorkFlows` objects for all objects in `.../topics` directory.
3. Run `submit.sh` to upload both the newly-generated `.../CronWorkflows` and the `.../topics` objects to Argo. Argo will create and execute a `salesforce-extractor` container at the interval indicated in the `schedule` field  of each `CronWorkFlows/*.yaml` object.
