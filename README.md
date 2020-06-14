# *P*rimitive *L*inux *A*uditing *S*cripts *T*o *I*ndicate *C*hanges (PLASTIC)

PLASTIC is a simple, basic, and above all primitive linux toolset comprised of a collector script and a comparison script. PLASTIC is intended to be used in lightweight environments, temporary situations, or when a small footprint is needed to determine if any changes have been made to a Linux system.

## plastic_collect.sh

Run the *plastic_collect* script on the Linux host to generate a timestamped file. It is strongly recommended that the file be transferred to a central machine for comparison purposes.

## plastic_compare.sh

Use the *plastic_compare* script to identify changes to a host over time based on the contents of files generated with *plastic_collect*.
