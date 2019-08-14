# Pipeline-template

This repository contains the [Biowdl](https://github.com/biowdl) 
multisample pipeline template data.

The structure:
- A pipeline that executes jobs over all samples and starts the scatters per:
    - Sample. executes jobs per sample and starts the scatters per:
        - library. Executes jobs per library and starts the scaters per:
            - readgroup. Executes jobs per readgroup.

Then there is sampleConfig.wdl. This determines hoe samples libraries and readgroups
are related by a samples.yml file.

## Documentation

You can find the documentation [here](https://biowdl.github.io/).

## About
This pipeline is part of [Biowdl](https://github.com/biowdl),
developed by the SASC team at [Leiden University Medical Center](https://www.lumc.nl/). 

## Contact

<!-- Obscure e-mail address for spammers -->
For any question related to this pipeline, please use the
<a href='https://github.com/biowdl/pipeline-template/issues'>github issue tracker</a>
or contact the SASC team directly at: 
<a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
