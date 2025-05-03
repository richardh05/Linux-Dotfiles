git filter-repo --force --commit-callback '
import datetime

weeks_offset = 5
seconds_offset = weeks_offset * 7 * 24 * 60 * 60  # Convert weeks to seconds

# Convert timestamps from bytes to string, extract the integer timestamp
author_timestamp = int(commit.author_date.split()[0].decode("utf-8"))
committer_timestamp = int(commit.committer_date.split()[0].decode("utf-8"))

# Subtract 5 weeks from both timestamps
new_author_timestamp = author_timestamp - seconds_offset
new_committer_timestamp = committer_timestamp - seconds_offset

# Format as "unix_timestamp +0000"
new_author_date = f"{new_author_timestamp} +0000".encode("utf-8")
new_committer_date = f"{new_committer_timestamp} +0000".encode("utf-8")

# Assign new dates
commit.author_date = new_author_date
commit.committer_date = new_committer_date
'

