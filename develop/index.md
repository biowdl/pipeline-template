---
layout: default
title: Home
---

This is a pipeline template.

This pipeline is part of [BioWDL](https://biowdl.github.io/)
developed by the SASC team at [Leiden University Medical Center](https://www.lumc.nl/).

## Usage
You can run the pipeline using
[Cromwell](http://cromwell.readthedocs.io/en/stable/):
```bash
java -jar cromwell-<version>.jar run -i inputs.json pipeline.wdl
```

### Inputs
Inputs are provided through a JSON file. The minimally required inputs are
described below, but additional inputs are available.
A template containing all possible inputs can be generated using
Womtool as described in the
[WOMtool documentation](http://cromwell.readthedocs.io/en/stable/WOMtool/).

```json
{
  "pipeline.sampleConfigFile": "A sample configuration file (see below)",
  "pipeline.outputDir": "The path to the output directory",
  "peline.dockerImagesFile": "A file listing the used docker images."
}
```

#### Sample configuration
The sample configuration should be a YML file which adheres to the following
structure:
```yml
samples: #Biological replicates
  - id: <sample>
    libraries: #Technical replicates
      - id: <library>
        readgroups: #Sequencing lanes
          - id: <readgroup>
            reads:
              R1: <Path to first-end FastQ file.>
              R1_md5: <Path to MD5 checksum file of first-end FastQ file.>
              R2: <Path to second-end FastQ file.>
              R2_md5: <Path to MD5 checksum file of second-end FastQ file.>
```
Replace the text between `< >` with appropriate values. R2 values may be
omitted in the case of single-end data. Multiple samples, libraries (per
sample) and readgroups (per library) may be given.

The control value on the sample level should specify the control sample
associated with this sample. This control sample should be present in the
sample configuration as well. This is an optional field. Should it be
specified then somatic-variantcalling will be performed for the indicated
pair.

#### Example
The following is an example of what an inputs JSON might look like:
```json
{
  "pipeline.sampleConfigFiles": "/home/user/analysis/samples.yml",
  "pipeline.outputDir": "/home/user/analysis/results",
  "pipeline.dockerImages.yml": "dockerImages.yml"
}
```

And the associated sample configuration YML might look like this:
```yml
samples:
  - id: patient1
    libraries:
      - id: lib1
        readgroups:
          - id: lane1
            reads:
              R1: /home/user/data/patient1-case/R1.fq.gz
              R1_md5: /home/user/data/patient1-case/R1.fq.gz.md5
              R2: /home/user/data/patient1-case/R2.fq.gz
              R2_md5: /home/user/data/patient1-case/R2.fq.gz.md5
  - id: patient2
    libraries:
      - id: lib1
        readgroups:
          - id: lane1
            reads:
              R1: /home/user/data/patient2-control/lane1_R1.fq.gz
              R1_md5: /home/user/data/patient2-control/lane1_R1.fq.gz.md5
              R2: /home/user/data/patient2-control/lane1_R2.fq.gz
              R2_md5: /home/user/data/patient2-control/lane1_R2.fq.gz.md5
          - id: lane2
            reads:
              R1: /home/user/data/patient2-control/lane2_R1.fq.gz
              R1_md5: /home/user/data/patient2-control/lane2_R1.fq.gz.md5
              R2: /home/user/data/patient2-control/lane2_R2.fq.gz
              R2_md5: /home/user/data/patient2-control/lane2_R2.fq.gz.md5
```

### Dependency requirements and tool versions
Biowdl pipelines use docker images to ensure  reproducibility. This
means that biowdl pipelines will run on any system that has docker
installed. Alternatively they can be run with singularity.

For more advanced configuration of docker or singularity please check
the [cromwell documentation on containers](
https://cromwell.readthedocs.io/en/stable/tutorials/Containers/).

Images from [biocontainers](https://biocontainers.pro) are preferred for
biowdl pipelines. The list of default images for this pipeline can be
found in the default for the `dockerImages` input.

### Output
This pipeline produces no output.

## Contact
<p>
  <!-- Obscure e-mail address for spammers -->
For any questions about running this pipeline and feature request (such as
adding additional tools and options), please use the
<a href='https://github.com/biowdl/pipeline-template/issues'>github issue tracker</a>
or contact the SASC team directly at: 
<a href='&#109;&#97;&#105;&#108;&#116;&#111;&#58;&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;'>
&#115;&#97;&#115;&#99;&#64;&#108;&#117;&#109;&#99;&#46;&#110;&#108;</a>.
</p>
