import "sample.wdl" as sample
import "sampleConfig.wdl" as sampleConfig

workflow pipeline {
    Array[File] sampleConfigFiles

    call sampleConfig.DownloadSampleConfig as downloadSampleConfig

    call sampleConfig.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigFiles,
            jar = downloadSampleConfig.jar
    }

    scatter (sampleId in samplesConfigs.keys) {
        call sample.sample {
            input:
                sampleConfigs = sampleConfigFiles,
                sampleId = sampleId
        }
    }
    output {
        Array[String] samples = samplesConfigs.keys
    }
}