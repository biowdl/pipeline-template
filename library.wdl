import "readgroup.wdl" as readgroup
import "sampleConfig.wdl" as sampleConfig

workflow library {
    Array[File] sampleConfigs
    String sampleId
    String libraryId

    call sampleConfig.SampleConfig as readgroups {
        input:
            inputFiles = sampleConfigs,
            sample = sampleId,
            library = libraryId,
            tsvOutputPath = "samples/" + sampleId + "/libs/" + libraryId + "/" + libraryId + ".config.tsv"
    }

    scatter (readgroupId in readgroups.keys) {
        if (readgroupId != "") {
            call readgroup.readgroup {
                input:
                    sampleConfigs = sampleConfigs,
                    readgroupId = readgroupId,
                    libraryId = libraryId,
                    sampleId = sampleId
            }
        }
    }
}
