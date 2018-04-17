# Pipeline-template

A multisample wdl-template.

The structure:
- A pipeline that executes jobs over all samples and starts the scatters per:
    - Sample. executes jobs per sample and starts the scatters per:
        - library. Executes jobs per library and starts the scaters per:
            - readgroup. Executes jobs per readgroup.

Then there is sampleConfig.wdl. This determines hoe samples libraries and readgroups
are related by a samples.yml file.

