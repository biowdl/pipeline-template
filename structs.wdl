version 1.0

struct Readgroup {
    File R1
    File? R2
}

struct Library {
    Map[String, Readgroup] readgroups
}

struct Sample {
    Map[String, Library] libraries
}

struct Root {
    Map[String, Sample] samples
}
