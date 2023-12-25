resource "b2_bucket" "backup" {
  bucket_name = "backup-moi"
  bucket_type = "allPrivate"

  lifecycle_rules {
    file_name_prefix              = ""
    days_from_hiding_to_deleting  = 1
    days_from_uploading_to_hiding = 0
  }

  lifecycle {
    prevent_destroy = true
  }
}


resource "b2_application_key" "autorestic_key" {
  key_name     = "autorestic"
  capabilities = ["deleteFiles", "listBuckets", "listFiles", "readBucketEncryption", "readBucketReplications", "readBuckets", "readFiles", "shareFiles", "writeBucketEncryption", "writeBucketReplications", "writeFiles"]
  bucket_id    = b2_bucket.backup.bucket_id
}
