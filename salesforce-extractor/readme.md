# Readme.md
This file documents part of a larger project called salesforce-extractor, which involves exporting large amounts of data from Salesforce with a Golang script. The documentation here describes the use of the `generate.sh` and `submit.sh` bash scripts, as well as the proccess of scheduling a new topic to be run through an instance of the salesforce-extractor Docker container.

## About generate.sh and submit.sh
`generate.sh` and `submit.sh` are used when you want to update `cronworkflow` of all salesforce-extractor topics. These bash scripts, in conjunction with editing allow you to do things such as:
- Schedule repeated execution of the salesforce-extractor executable for all topics in `topics` in seperate Docker Containers.
- Modify the scheduling and fields of all `cronworkflow` topics to reflect `CronTemplate.yml`. This is done as necessary for recordkeeping.

### generate.sh
`generate.sh` overwrites the fields and values of all `/*.yml` in `cronworkflow` that are present in the `CronTemplate.yml` document, and generates `cronworkflow` objects pulling information from all objects `topics` folder.

For example, I could modify the `schedule:` field in `CronTemplate.yml` if I decide that I want to run `salesforce-extractor` for all topics once every thirty minutes by changing `schedule`'s value to `[[ or.schedule "*/30 * * * *]]`. 

Another use of `generate.sh` could be to create a new field for all `/*.yml` in cronworfklows, should the need arise.

### submit.sh
`submit.sh` is a bash script used to overwrite the `CronWorkFlow` objects stored in ARGO. `submit.sh` can be used to update the frequency that the `salesforce-extractor`
is called by updating `CronWorkFlowTemplate.yaml` as described in the section on `generate.sh`

The script calls the list of `salesforce-extractor` cronworkflows stored on Argo, specifically only grabbing their names, rather than the default of all information. It deletes those files. Then, the script uploads all `*.yml` items stored locally in `cronworkflows`


## Schedule A Docker Container to Run a new Instance of Sales-Force Extractor 

The following describes how to schedule Argo pull a new unique instance of the Salesforce-extractor Docker container from s3.

1. Create a `*.yaml.` file with the name your topic with the appropriate fields in the `.../topics` directory, and ensure that it is a valid Salesforce object type.
2. Run `generate.sh` to create `.../CronWorkFlows` objects for all objects in `.../topics` directory.
3. Run `submit.sh` to upload both the newly-generated `.../CronWorkflows` and the `.../topics` objects to Argo. Argo will create and execute a `salesforce-extractor` container at the interval indicated in the `schedule` field  of each `CronWorkFlows/*.yaml` object.
