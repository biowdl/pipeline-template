version 1.0

# Copyright (c) 2018 Sequencing Analysis Support Core - Leiden University Medical Center
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import "sample.wdl" as sampleWorkflow
import "tasks/biopet.wdl" as biopet
import "samplesheet.wdl" as sampleSheet

workflow pipeline {
    input {
        File sampleConfigFile
        String outputDir
    }
    #  Reading the samples from the sample config files
    call biopet.SampleConfig as samplesConfigs {
        input:
            inputFiles = sampleConfigFiles
    }

    # Do the jobs that should be executed per sample.
    # Modify sample.wdl to change what is happening per sample
    scatter (sampleId in samplesConfigs.keys) {
        call sampleWorkflow.sample as sample {
            input:
                sampleConfigs = sampleConfigFiles,
                sampleId = sampleId,
                outputDir = outputDir + "/sample_" + sampleId
        }
    }

    # Put the jobs that need to be done over the result of all samples
    # below this line.

    output {
        Array[String] samples = samplesConfigs.keys
    }
}

task sampleConfigFileToStruct {
    input {
        File sampleConfigFile
    }
    command {
        python3 <<CODE
        import yaml

    }
    output
}