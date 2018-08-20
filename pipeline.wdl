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

version 1.0

import "sample.wdl" as sampleWorkflow
import "structs.wdl" as structs
import "tasks/biopet.wdl" as biopet

workflow pipeline {
    input {
        Array[File] sampleConfigFiles
        String outputDir
    }

    call biopet.SampleConfigCromwellArrays as configFile {
      input:
        inputFiles = sampleConfigFiles,
        outputPath = "samples.json",
        toolJar = "/home/pjvan_thof/src/biopet-root/tools/sampleconfig/target/scala-2.11/SampleConfig-assembly-0.2-SNAPSHOT.jar"
    }

    Root config = read_json(configFile.outputFile)

    # Do the jobs that should be executed per sample.
    # Modify sample.wdl to change what is happening per sample
    scatter (sample in config.samples) {
        call sampleWorkflow.sample as sampleTasks {
            input:
                sample = sample,
                outputDir = outputDir + "/samples/" + sample.id
        }
    }

    # Put the jobs that need to be done over the result of all samples
    # below this line.

    output {
        # INSERT OUTPUTS HERE
    }
}

