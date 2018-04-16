import "sample.wdl" as sample
import "sampleConfig.wdl" as sampleConfig

workflow pipeline {
    Array[File] sampleConfigs

    call sampleConfig.DownloadSampleConfig as downloadSampleConfig

    call sampleConfig.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigs,
            jar = downloadSampleConfig.jar
    }

    scatter (sampleId in samplesConfigs.keys) {
        call sample.sample {
            input:
                sampleConfigs = sampleConfigs,
                sampleId = sampleId
        }
    }
    output {
        Array[String] samples = samplesConfigs.keys
    }
}