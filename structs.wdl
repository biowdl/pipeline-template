version 1.0

struct Readgroup {
    String id
    File R1
    File? R2
}

struct Library {
    String id
    Array[Readgroup] readgroups
}

struct Sample {
    String id
    Array[Library] libraries
}

struct Root {
    Array[Sample] samples
}
