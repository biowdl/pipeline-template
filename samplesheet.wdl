version 1.0
struct ReadGroup {
    String id
    File R1
    File? R2
}

struct Library {
    String id
    Array[ReadGroup]+ readgroups
}

struct Sample {
    String id
    Array[Library]+ libraries
}
