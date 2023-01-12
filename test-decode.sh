#!/bin/bash

# Demux hevc bitstream 
ffmpeg -y -i /sample-media/First-8K-Video-from-Space~orig.mp4 -c:v copy -bsf hevc_mp4toannexb -f hevc sample-media/test.hevc 

# decode hevc bitstream
./_vplinstall/bin/sample_decode h265 -i /sample-media/test.hevc
